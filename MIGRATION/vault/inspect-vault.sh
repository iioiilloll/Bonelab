#!/usr/bin/env bash
#
# inspect-vault.sh — 옵시디언 볼트를 git 저장소로 올리기 전 안전 진단.
#
# 확인 항목:
#   1. 볼트 위치와 규모          2. 클라우드 동기화 충돌 사본
#   3. GitHub 용량 한도 초과 파일  4. 민감정보 후보 (개인정보·자격증명)
#   5. git 관리 여부              6. 이중 동기화 위험 (iCloud/Dropbox 경로)
#
# 읽기 전용입니다 — 파일을 수정하거나 삭제하지 않습니다.
#
# 사용법:
#   ./inspect-vault.sh                 # 볼트 자동 탐색
#   ./inspect-vault.sh ~/path/to/Vault # 경로 직접 지정
#
set -uo pipefail

readonly RED=$'\033[31m' YEL=$'\033[33m' GRN=$'\033[32m' DIM=$'\033[2m' OFF=$'\033[0m'
WARNINGS=0

hdr()  { printf '\n%s== %s ==%s\n' "$DIM" "$*" "$OFF"; }
ok()   { printf '  %s✓%s %s\n' "$GRN" "$OFF" "$*"; }
warn() { printf '  %s!%s %s\n' "$YEL" "$OFF" "$*"; WARNINGS=$((WARNINGS+1)); }
bad()  { printf '  %s✗%s %s\n' "$RED" "$OFF" "$*"; WARNINGS=$((WARNINGS+1)); }
die()  { printf '%s오류:%s %s\n' "$RED" "$OFF" "$*" >&2; exit 1; }

# ---------- 1. 볼트 탐색 ----------
VAULT="${1:-}"
if [[ -z "$VAULT" ]]; then
  echo "볼트를 탐색합니다 (.obsidian 디렉터리 기준)..." >&2
  # 홈 + 일반적인 클라우드 동기화 경로를 깊이 제한하여 탐색
  VAULT="$(find "$HOME" -maxdepth 6 -type d -name '.obsidian' \
             -not -path '*/node_modules/*' -not -path '*/.Trash/*' 2>/dev/null \
           | head -1 | xargs -I{} dirname {} 2>/dev/null)"
  [[ -n "$VAULT" ]] || die "볼트를 찾지 못했습니다. 경로를 인자로 지정하십시오: $0 <볼트경로>"
fi
[[ -d "$VAULT" ]] || die "디렉터리가 아닙니다: $VAULT"
[[ -d "$VAULT/.obsidian" ]] || warn "$VAULT 에 .obsidian 이 없습니다 — 옵시디언 볼트가 아닐 수 있습니다."

hdr "볼트"
echo "  경로: $VAULT"
TOTAL_FILES=$(find "$VAULT" -type f -not -path '*/.git/*' 2>/dev/null | wc -l | tr -d ' ')
MD_FILES=$(find "$VAULT" -type f -name '*.md' -not -path '*/.git/*' 2>/dev/null | wc -l | tr -d ' ')
SIZE=$(du -sh "$VAULT" 2>/dev/null | cut -f1)
echo "  전체 파일 $TOTAL_FILES개 · 노트(.md) $MD_FILES개 · 용량 $SIZE"

# ---------- 2. 동기화 충돌 사본 ----------
hdr "동기화 충돌 사본"
CONFLICTS=$(find "$VAULT" -type f \( \
    -name '*conflicted copy*' -o -name '*충돌된 사본*' -o \
    -name '*(conflict)*'      -o -name '*-conflict-*'   -o \
    -name '*sync-conflict*' \) -not -path '*/.git/*' 2>/dev/null)
if [[ -n "$CONFLICTS" ]]; then
  N=$(printf '%s\n' "$CONFLICTS" | wc -l | tr -d ' ')
  bad "충돌 사본 ${N}건 — git 전환 전에 정리하십시오 (원본과 diff 후 병합/삭제)"
  printf '%s\n' "$CONFLICTS" | head -10 | sed "s|$VAULT/|    |"
  [[ "$N" -gt 10 ]] && echo "    ... 외 $((N-10))건"
else
  ok "충돌 사본 없음"
fi

# ---------- 3. 용량 한도 ----------
hdr "파일 용량 (GitHub 한도: 100MB 차단 / 50MB 경고)"
BIG=$(find "$VAULT" -type f -size +50M -not -path '*/.git/*' 2>/dev/null)
if [[ -n "$BIG" ]]; then
  warn "50MB 초과 파일 발견 — Git LFS 또는 .gitignore 제외 대상"
  printf '%s\n' "$BIG" | while read -r f; do
    printf '    %s  %s\n' "$(du -h "$f" 2>/dev/null | cut -f1)" "${f#$VAULT/}"
  done
else
  ok "50MB 초과 파일 없음"
fi
ATTACH=$(find "$VAULT" -type f \( -name '*.pdf' -o -name '*.png' -o -name '*.jpg' \
         -o -name '*.mov' -o -name '*.mp4' -o -name '*.tif' -o -name '*.tiff' \) \
         -not -path '*/.git/*' 2>/dev/null | wc -l | tr -d ' ')
echo "  첨부 파일(PDF/이미지/영상) ${ATTACH}개"
[[ "$ATTACH" -gt 500 ]] && warn "첨부가 많습니다 — 저장소 비대화를 막으려면 Git LFS 검토"

# ---------- 4. 민감정보 후보 ----------
hdr "민감정보 후보 스캔 (노트 본문)"
scan() {  # $1=라벨  $2=정규식
  local hits
  hits=$(grep -rlE "$2" "$VAULT" --include='*.md' --include='*.txt' --include='*.json' \
         --exclude-dir='.git' 2>/dev/null | head -5)
  if [[ -n "$hits" ]]; then
    bad "$1"
    printf '%s\n' "$hits" | sed "s|$VAULT/|    |"
  fi
}
scan "주민등록번호 형식"        '[0-9]{6}-[1-4][0-9]{6}'
scan "OpenAI/Anthropic API 키"  '(sk-[A-Za-z0-9_-]{20,}|sk-ant-[A-Za-z0-9_-]{20,})'
scan "GitHub 토큰"              'gh[pousr]_[A-Za-z0-9]{36}'
scan "AWS 액세스 키"            'AKIA[0-9A-Z]{16}'
scan "비밀번호 평문 표기"        '(password|비밀번호|passwd)[[:space:]]*[:=][[:space:]]*[^[:space:]]{6,}'
echo "  ${DIM}※ 환자 식별정보(이름·등록번호)는 자동 탐지가 어렵습니다. 임상 노트는 직접 확인하십시오.${OFF}"

# ---------- 5. git 관리 여부 ----------
hdr "버전 관리"
if git -C "$VAULT" rev-parse --git-dir >/dev/null 2>&1; then
  ok "이미 git 저장소입니다"
  echo "    원격: $(git -C "$VAULT" remote get-url origin 2>/dev/null || echo '(없음)')"
  echo "    커밋: $(git -C "$VAULT" rev-list --count HEAD 2>/dev/null || echo 0)개"
  echo "    미커밋 변경: $(git -C "$VAULT" status --porcelain 2>/dev/null | wc -l | tr -d ' ')건"
else
  warn "git 미적용 — 계정 이전 시 안전망이 없습니다. init-vault-repo.sh 실행을 권장합니다."
fi

# ---------- 6. 이중 동기화 위험 ----------
hdr "저장 위치"
case "$VAULT" in
  *"Library/Mobile Documents"*|*"iCloud"*)
    warn "iCloud Drive 안에 있습니다 — git과 iCloud가 .git 을 동시에 건드리면 저장소가 손상될 수 있습니다" ;;
  *Dropbox*)  warn "Dropbox 안에 있습니다 — 충돌 사본의 주원인입니다" ;;
  *OneDrive*) warn "OneDrive 안에 있습니다 — 충돌 사본의 주원인입니다" ;;
  *"Google Drive"*) warn "Google Drive 안에 있습니다 — 충돌 사본의 주원인입니다" ;;
  *) ok "클라우드 동기화 폴더 밖입니다" ;;
esac

# ---------- 결과 ----------
hdr "결과"
if [[ "$WARNINGS" -eq 0 ]]; then
  printf '  %s문제 없음 — init-vault-repo.sh 로 진행하십시오.%s\n\n' "$GRN" "$OFF"
else
  printf '  %s확인 필요 항목 %d건 — 위 표시를 해소한 뒤 git 전환을 진행하십시오.%s\n\n' "$YEL" "$WARNINGS" "$OFF"
fi
