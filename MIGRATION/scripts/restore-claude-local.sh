#!/usr/bin/env bash
#
# restore-claude-local.sh — backup-claude-local.sh 아카이브를 새 계정 환경에 복원합니다.
#
# 복원 후에는 반드시 `claude` 실행 → `/login` 으로 새 계정(iioiilloll@korea.ac.kr)에 로그인하십시오.
# 이 스크립트는 자격증명을 건드리지 않으며, 기존 설정은 타임스탬프 백업 후 병합합니다.
#
# 사용법:
#   ./restore-claude-local.sh <아카이브.tar.gz>
#   DRY_RUN=1 ./restore-claude-local.sh <아카이브.tar.gz>   # 변경 없이 계획만 출력
#
set -euo pipefail

readonly ARCHIVE="${1:-}"
readonly CLAUDE_HOME="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
readonly CLAUDE_JSON="$HOME/.claude.json"
readonly STAMP="$(date +%Y%m%d-%H%M%S)"
readonly DRY_RUN="${DRY_RUN:-0}"
readonly TMP="$(mktemp -d)"

log() { printf '[restore] %s\n' "$*" >&2; }
die() { printf '[restore] 오류: %s\n' "$*" >&2; exit 1; }
run() { if [[ "$DRY_RUN" == "1" ]]; then printf '[dry-run] %s\n' "$*" >&2; else "$@"; fi; }

trap 'rm -rf "$TMP"' EXIT

[[ -n "$ARCHIVE" ]] || die "사용법: $0 <아카이브.tar.gz>"
[[ -f "$ARCHIVE" ]] || die "아카이브를 찾을 수 없습니다: $ARCHIVE"

tar -xzf "$ARCHIVE" -C "$TMP"
[[ -d "$TMP/claude-home" ]] || die "아카이브 구조가 올바르지 않습니다 (claude-home 없음)."

# 1) 기존 설정 백업
if [[ -d "$CLAUDE_HOME" ]]; then
  log "기존 설정 백업: ${CLAUDE_HOME}.pre-migration-$STAMP"
  run cp -a "$CLAUDE_HOME" "${CLAUDE_HOME}.pre-migration-$STAMP"
fi

# 2) 설정 병합 — 자격증명은 덮어쓰지 않음
log "설정 복원: $CLAUDE_HOME"
run mkdir -p "$CLAUDE_HOME"
if [[ "$DRY_RUN" == "1" ]]; then
  (cd "$TMP/claude-home" && find . -maxdepth 2 | sed 's/^/[dry-run] 복원 대상: /')
else
  tar -cf - -C "$TMP/claude-home" . | tar -xf - -C "$CLAUDE_HOME"
fi

# 3) MCP 서버 정의 병합 — 기존 ~/.claude.json 의 계정 정보는 보존
if [[ -f "$TMP/mcp-servers.json" ]]; then
  if ! command -v jq >/dev/null 2>&1; then
    log "경고: jq 미설치 — $TMP/mcp-servers.json 을 수동으로 ~/.claude.json 에 병합하십시오."
  elif [[ -f "$CLAUDE_JSON" ]]; then
    log "MCP 서버 정의 병합: ~/.claude.json"
    if [[ "$DRY_RUN" == "1" ]]; then
      jq -r '.mcpServers | keys[]' "$TMP/mcp-servers.json" | sed 's/^/[dry-run] 추가될 MCP 서버: /'
    else
      cp -a "$CLAUDE_JSON" "${CLAUDE_JSON}.pre-migration-$STAMP"
      jq -s '.[0] * {mcpServers: ((.[0].mcpServers // {}) * (.[1].mcpServers // {}))}' \
         "$CLAUDE_JSON" "$TMP/mcp-servers.json" > "${CLAUDE_JSON}.merged"
      mv "${CLAUDE_JSON}.merged" "$CLAUDE_JSON"
    fi
  else
    run cp "$TMP/mcp-servers.json" "$CLAUDE_JSON"
  fi
fi

log "복원 완료."
log "다음 단계: claude 실행 → /logout → /login (iioiilloll@korea.ac.kr) → /mcp 로 서버 인증 재수행"
