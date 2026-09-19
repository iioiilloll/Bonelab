#!/usr/bin/env bash
#
# init-vault-repo.sh — 옵시디언 볼트를 비공개 git 저장소로 전환합니다.
#
# 전제: inspect-vault.sh 를 먼저 실행해 충돌 사본과 민감정보를 정리했을 것.
# 이 스크립트는 원격 저장소를 생성하지 않습니다 — GitHub에서 **비공개**로 먼저 만든 뒤
# 그 URL을 인자로 넘기십시오.
#
# 사용법:
#   ./init-vault-repo.sh <볼트경로> [원격URL]
#   DRY_RUN=1 ./init-vault-repo.sh ~/Vault            # 변경 없이 계획만 출력
#
set -euo pipefail

readonly VAULT="${1:-}"
readonly REMOTE="${2:-}"
readonly DRY_RUN="${DRY_RUN:-0}"
readonly HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log() { printf '[vault] %s\n' "$*" >&2; }
die() { printf '[vault] 오류: %s\n' "$*" >&2; exit 1; }
run() { if [[ "$DRY_RUN" == "1" ]]; then printf '[dry-run] %s\n' "$*" >&2; else "$@"; fi; }

[[ -n "$VAULT" ]] || die "사용법: $0 <볼트경로> [원격URL]"
[[ -d "$VAULT" ]] || die "디렉터리가 아닙니다: $VAULT"
[[ -f "$HERE/gitignore-template" ]] || die "gitignore-template 을 찾을 수 없습니다: $HERE"

# --- 안전장치 1: 공개 저장소 차단 ---
if [[ -n "$REMOTE" ]]; then
  case "$REMOTE" in
    *github.com*) : ;;
    *) log "경고: GitHub 이외의 원격입니다 — 비공개 여부를 직접 확인하십시오." ;;
  esac
  log "원격: $REMOTE"
  log "※ 이 저장소가 GitHub에서 Private 으로 생성되었는지 반드시 확인하십시오."
  log "   볼트에는 연구·임상 메모가 포함될 수 있어 공개 시 되돌릴 수 없습니다."
fi

# --- 안전장치 2: 남은 충돌 사본 차단 ---
CONFLICTS=$(find "$VAULT" -type f \( -name '*conflicted copy*' -o -name '*충돌된 사본*' \
            -o -name '*sync-conflict*' \) -not -path '*/.git/*' 2>/dev/null | wc -l | tr -d ' ')
[[ "$CONFLICTS" -eq 0 ]] || die "충돌 사본 ${CONFLICTS}건이 남아 있습니다. inspect-vault.sh 결과를 먼저 정리하십시오."

# --- 안전장치 3: 100MB 초과 파일 차단 (GitHub 거부 대상) ---
OVERSIZE=$(find "$VAULT" -type f -size +100M -not -path '*/.git/*' 2>/dev/null || true)
if [[ -n "$OVERSIZE" ]]; then
  printf '%s\n' "$OVERSIZE" >&2
  die "100MB 초과 파일이 있습니다. GitHub가 푸시를 거부합니다 — .gitignore 제외 또는 Git LFS 를 적용하십시오."
fi

# --- 안전장치 4: 민감정보 차단 ---
# git 히스토리에 한 번 들어간 개인정보·자격증명은 사실상 회수할 수 없습니다.
# 의도적으로 포함해야 한다면 ALLOW_SENSITIVE=1 로 명시적으로 해제하십시오.
if [[ "${ALLOW_SENSITIVE:-0}" != "1" ]]; then
  SENSITIVE=""
  for pat in \
    '[0-9]{6}-[1-4][0-9]{6}' \
    '(sk-[A-Za-z0-9_-]{20,}|sk-ant-[A-Za-z0-9_-]{20,})' \
    'gh[pousr]_[A-Za-z0-9]{36}' \
    'AKIA[0-9A-Z]{16}'
  do
    hits=$(grep -rlE "$pat" "$VAULT" --include='*.md' --include='*.txt' --include='*.json' \
           --exclude-dir='.git' 2>/dev/null || true)
    [[ -n "$hits" ]] && SENSITIVE="${SENSITIVE}${hits}"$'\n'
  done
  if [[ -n "${SENSITIVE// /}" ]]; then
    printf '%s\n' "$SENSITIVE" | sort -u | grep . >&2
    die "위 파일에서 개인정보·자격증명 패턴이 검출되었습니다. 해당 내용을 제거하거나 .gitignore 로 제외한 뒤 다시 실행하십시오 (의도적이라면 ALLOW_SENSITIVE=1)."
  fi
  log "민감정보 스캔 통과"
fi

# --- .gitignore 배치 (기존 파일은 덮어쓰지 않고 병합) ---
if [[ -f "$VAULT/.gitignore" ]]; then
  log "기존 .gitignore 발견 — 템플릿 내용을 뒤에 덧붙입니다 (중복 줄은 제거)."
  if [[ "$DRY_RUN" != "1" ]]; then
    cat "$VAULT/.gitignore" "$HERE/gitignore-template" \
      | awk '!seen[$0]++ || /^$/ || /^#/' > "$VAULT/.gitignore.new"
    mv "$VAULT/.gitignore.new" "$VAULT/.gitignore"
  fi
else
  log ".gitignore 생성"
  run cp "$HERE/gitignore-template" "$VAULT/.gitignore"
fi

# --- git 초기화 ---
if git -C "$VAULT" rev-parse --git-dir >/dev/null 2>&1; then
  log "이미 git 저장소입니다 — 초기화를 건너뜁니다."
else
  log "git 저장소 초기화"
  run git -C "$VAULT" init -b main
fi

# --- 커밋 ---
log "스테이징 및 커밋"
run git -C "$VAULT" add -A
if [[ "$DRY_RUN" == "1" ]]; then
  # 아직 git 저장소가 아니면 status 가 128로 실패하므로 pipefail 에 걸리지 않게 감쌉니다.
  log "[dry-run] 추적 예정 파일 수:"
  { git -C "$VAULT" status --porcelain 2>/dev/null || true; } | wc -l | sed 's/^/[dry-run]   /' >&2
else
  if git -C "$VAULT" diff --cached --quiet; then
    log "커밋할 변경이 없습니다."
  else
    git -C "$VAULT" commit -q -m "볼트 초기 커밋 — 계정 이전 대비 버전 관리 도입"
    log "커밋 완료: $(git -C "$VAULT" rev-list --count HEAD)개"
  fi
fi

# --- 원격 연결 ---
if [[ -n "$REMOTE" ]]; then
  if git -C "$VAULT" remote get-url origin >/dev/null 2>&1; then
    log "origin 이 이미 설정되어 있습니다: $(git -C "$VAULT" remote get-url origin)"
  else
    run git -C "$VAULT" remote add origin "$REMOTE"
  fi
  log "푸시하려면: git -C \"$VAULT\" push -u origin main"
fi

cat >&2 <<'NEXT'

다음 단계:
  1. GitHub에서 저장소가 Private 인지 재확인
  2. git -C <볼트> push -u origin main
  3. 옵시디언 → 설정 → 커뮤니티 플러그인 → "Obsidian Git" 설치
     - Auto backup after file change: 10분 간격 권장
     - Auto pull on startup: 켜기 (기기 간 충돌 예방)
  4. 다른 기기에서는 clone 후 볼트로 열기 (클라우드 동기화는 해제)
NEXT
