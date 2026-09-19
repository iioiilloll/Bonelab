#!/usr/bin/env bash
#
# backup-claude-local.sh — 로컬 머신의 Claude Code 설정·자산을 이전용 아카이브로 묶습니다.
#
# 대상: 계정을 바꿔도 그대로 재사용할 수 있는 "파일 기반" 자산만 수집합니다.
#   포함 - settings.json, CLAUDE.md, skills/, plugins/, agents/, commands/, hooks,
#          MCP 서버 정의(~/.claude.json 의 mcpServers 섹션), 로컬 세션 트랜스크립트(projects/)
#   제외 - .credentials.json, oauthAccount, statsig/ 등 계정 자격증명·텔레메트리
#          (자격증명은 계정에 묶여 있어 복사하면 안 되며, 새 계정에서 /login 으로 새로 발급받습니다)
#
# 사용법:
#   ./backup-claude-local.sh [출력디렉터리]      # 기본값: ~/claude-migration
#   INCLUDE_TRANSCRIPTS=0 ./backup-claude-local.sh   # 대화 트랜스크립트 제외(용량 절감)
#
set -euo pipefail

readonly CLAUDE_HOME="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
readonly CLAUDE_JSON="$HOME/.claude.json"
readonly OUT_DIR="${1:-$HOME/claude-migration}"
readonly STAMP="$(date +%Y%m%d-%H%M%S)"
readonly STAGE="$OUT_DIR/stage-$STAMP"
readonly ARCHIVE="$OUT_DIR/claude-local-backup-$STAMP.tar.gz"
readonly INCLUDE_TRANSCRIPTS="${INCLUDE_TRANSCRIPTS:-1}"

log() { printf '[backup] %s\n' "$*" >&2; }
die() { printf '[backup] 오류: %s\n' "$*" >&2; exit 1; }

[[ -d "$CLAUDE_HOME" ]] || die "Claude 설정 디렉터리를 찾을 수 없습니다: $CLAUDE_HOME"
command -v tar >/dev/null 2>&1 || die "tar 명령이 필요합니다."

mkdir -p "$STAGE"
trap 'rm -rf "$STAGE"' EXIT

# 1) 설정 디렉터리 — 자격증명과 캐시성 데이터를 제외하고 복사
log "설정 디렉터리 수집: $CLAUDE_HOME"
# 자격증명·세션키·계정 스냅샷은 절대 포함하지 않습니다(새 계정에서 재발급되는 값들).
EXCLUDES=(
  --exclude='.credentials.json'
  --exclude='backups'          # ~/.claude.json 스냅샷 = 계정 식별자 포함
  --exclude='sessions'         # 세션 키(*.key) 포함
  --exclude='session-env'
  --exclude='environment-manager'
  --exclude='statsig'
  --exclude='shell-snapshots'
  --exclude='tool-results'
  --exclude='todos'
  --exclude='file-history'
  --exclude='.last-cleanup'
  --exclude='mcp-needs-auth-cache.json'
)
if [[ "$INCLUDE_TRANSCRIPTS" != "1" ]]; then
  EXCLUDES+=(--exclude='projects')
  log "대화 트랜스크립트(projects/) 제외"
fi
mkdir -p "$STAGE/claude-home"
tar -cf - -C "$CLAUDE_HOME" "${EXCLUDES[@]}" . | tar -xf - -C "$STAGE/claude-home"

# 2) MCP 서버 정의만 추출 — ~/.claude.json 전체는 계정 식별자를 포함하므로 복사 금지
if [[ -f "$CLAUDE_JSON" ]]; then
  if command -v jq >/dev/null 2>&1; then
    log "MCP 서버 정의 추출: ~/.claude.json"
    jq '{mcpServers: (.mcpServers // {})}' "$CLAUDE_JSON" > "$STAGE/mcp-servers.json"
    jq -r '(.projects // {}) | keys[]' "$CLAUDE_JSON" 2>/dev/null > "$STAGE/project-paths.txt" || true
  else
    log "경고: jq 미설치 — MCP 정의를 자동 추출하지 못했습니다. 수동으로 mcpServers 섹션을 옮기십시오."
  fi
fi

# 3) 인벤토리 기록 — 복원 시 무엇이 들어 있는지 확인용
{
  echo "# Claude Code 로컬 백업"
  echo "생성일시: $(date -Iseconds)"
  echo "호스트: $(hostname)"
  echo "원본: $CLAUDE_HOME"
  echo "트랜스크립트 포함: $INCLUDE_TRANSCRIPTS"
  echo
  echo "## 수집된 항목"
  (cd "$STAGE" && find . -maxdepth 3 -type d | sort)
} > "$STAGE/INVENTORY.txt"

mkdir -p "$OUT_DIR"
tar -czf "$ARCHIVE" -C "$STAGE" .
log "완료: $ARCHIVE ($(du -h "$ARCHIVE" | cut -f1))"

# 4) 자격증명 유출 방어 — 아카이브에 민감 파일이 섞이지 않았는지 검증
LEAKS="$(tar -tzf "$ARCHIVE" | grep -E '(\.credentials\.json|\.key|/backups/|/sessions/)' || true)"
if [[ -n "$LEAKS" ]]; then
  rm -f "$ARCHIVE"
  printf '%s\n' "$LEAKS" >&2
  die "아카이브에 민감 파일이 포함되어 삭제했습니다. 위 목록을 제외 규칙에 추가하십시오."
fi
log "검증 통과: 자격증명·세션키 미포함"
