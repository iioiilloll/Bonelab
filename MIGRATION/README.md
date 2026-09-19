# Claude Code 계정 이전 런북

**출처 계정** jaykim830 (jaykim830@gmail.com) → **대상 계정** iioiilloll@korea.ac.kr
조사일 2026-09-19 · 대상 GitHub 계정 `iioiilloll` (JaeyoungKim_Pro, Korea University)

---

## 0. 먼저 알아야 할 것

계정 이전에서 가장 중요한 두 가지 사실입니다.

**① GitHub 저장소는 옮길 필요가 없습니다.**
4개 저장소(`Bonelab`, `adsense-blog`, `kumc-imaging-lab`, `Statlab`)가 모두 이미 GitHub 계정
`iioiilloll` 소유입니다. 즉 이전 대상은 *Claude 계정 하나*뿐이며, 새 Claude 계정에서
같은 GitHub 계정을 연결하면 저장소는 그대로 보입니다. 소유권 이전 절차는 불필요합니다.

**② 대화 기록(세션)은 계정 경계를 넘을 수 없습니다.**
claude.ai/code 의 세션 히스토리는 계정에 귀속되며, 내보내기/가져오기 수단이 존재하지 않습니다.
따라서 "옮긴다"는 것은 실무적으로 **자산을 파일로 고정하고, 설정을 재생성하는 것**을 의미합니다.
이 디렉터리는 그 작업을 위한 도구 모음입니다.

> **볼트를 쓰고 있다면 `vault/README.md` 를 먼저 읽으십시오.**
> 옵시디언 볼트가 지식의 영속 저장소라면 계정 이전의 성격이 바뀝니다 —
> 볼트를 git으로 올려 계정과 분리하는 것이 가장 확실한 방향입니다.
> 2026-09-19 기준 4개 저장소를 전수 확인했으나 볼트는 어디에도 없었습니다(로컬 전용).

## 1. 이전 가능성 구분

| 자산 | 수량 | 이전 방식 | 자동화 |
|---|---|---|---|
| GitHub 저장소 | 4개 | 이전 불필요 (이미 `iioiilloll` 소유) | — |
| 저장소 내 지침 (`CLAUDE.md`, `.claude/`) | — | 커밋되어 있으면 자동 동행 | ✅ |
| 로컬 설정 (skills, MCP, hooks, settings) | — | `scripts/` 백업·복원 스크립트 | ✅ |
| 로컬 대화 트랜스크립트 (`~/.claude/projects/`) | — | 백업 스크립트에 포함 (파일로만 보존) | ✅ |
| Routine (스케줄 트리거) | 1개 | `routines/*.json` 으로 재생성 | 반자동 |
| 원격 Environment | 1개 (`Jaykim`) | 새 계정에서 수동 재생성 | ❌ |
| 옵시디언 볼트 | 로컬 전용 | git 전환 후 계정과 분리 (`vault/`) | 반자동 |
| 웹 세션 히스토리 | 67개 | **이전 불가** — 결론만 문서로 고정 | ❌ |
| 구독·사용량 | — | 계정별 별도 | ❌ |

## 2. 이전 전 반드시 처리할 것 — 미병합 브랜치

`Bonelab` 저장소의 실제 연구 자산이 **`main` 이 아닌 브랜치에만** 존재합니다.
계정을 바꾸면 이 브랜치의 맥락을 아는 세션이 사라지므로, 이전 **전에** 병합을 권장합니다.

| 브랜치 | 내용 | 위험 |
|---|---|---|
| `claude/resume-tmf6n0` | `Jaykim-org/` 연구 아카이브 (논문 분석, 주간 제안서, 수집 도구) | 주간 Routine이 이 브랜치에 의존 |
| `claude/student-learning-papers-kifozl` | `docs/student-reading-list.md` | 단독 문서 |

```bash
git fetch origin
git checkout main
git merge --no-ff origin/claude/resume-tmf6n0
git merge --no-ff origin/claude/student-learning-papers-kifozl
git push origin main
```

병합 후에는 `routines/weekly-bonelab-proposal.json` 의 프롬프트에서 브랜치 분기 로직이
자동으로 `main` 을 선택하므로 수정이 필요 없습니다.

## 3. 절차

### 3-1. 로컬 머신 설정 백업 — 사용자가 각 머신에서 실행

세션 목록상 최소 3대(`jaykimui-macbookpro`, `desktop-9i26g6r`, 학교 Mac mini)에서
Claude Code를 사용한 이력이 있습니다. **머신마다** 실행하십시오.

```bash
./scripts/backup-claude-local.sh                      # ~/claude-migration/ 에 아카이브 생성
INCLUDE_TRANSCRIPTS=0 ./scripts/backup-claude-local.sh   # 대화 기록 제외(용량 절감)
```

자격증명(`.credentials.json`), 세션 키, 계정 스냅샷은 자동 제외되며,
아카이브 생성 직후 검증까지 수행합니다. 검증 실패 시 아카이브를 삭제하고 중단합니다.

### 3-2. 새 계정으로 전환 — 사용자만 가능

```bash
claude
/logout
/login          # iioiilloll@korea.ac.kr 로 로그인
```

웹에서는 <https://claude.ai/connect-github> 에서 GitHub 계정 `iioiilloll` 를 연결하고,
<https://github.com/apps/claude/installations/select_target> 에서 대상 저장소에
Claude GitHub App 을 설치합니다.

### 3-3. 설정 복원

```bash
DRY_RUN=1 ./scripts/restore-claude-local.sh ~/claude-migration/claude-local-backup-*.tar.gz  # 계획 확인
./scripts/restore-claude-local.sh ~/claude-migration/claude-local-backup-*.tar.gz            # 실제 복원
```

복원 후 `claude` 안에서 `/mcp` 로 각 MCP 서버를 **재인증**해야 합니다.
MCP 토큰은 계정별로 발급되므로 정의만 옮겨지고 인증은 새로 받습니다.

### 3-4. 원격 Environment 재생성 — 사용자만 가능

출처 계정의 환경 설정:

| 항목 | 값 |
|---|---|
| 이름 | `Jaykim` |
| 설명 | Jaykim - full network access |
| 종류 | anthropic_cloud |
| 네트워크 정책 | full network access |

<https://claude.ai/code> → Environments → 위 설정으로 새로 생성합니다.
출처 환경에 환경변수(API 키 등)를 넣어 두었다면 **그 값은 조회할 수 없으므로**
원본 출처(비밀번호 관리자, 발급 기관)에서 다시 가져와 입력해야 합니다.

### 3-5. Routine 재생성

새 계정의 Claude Code 세션에서 다음과 같이 요청하십시오:

> `MIGRATION/routines/weekly-bonelab-proposal.json` 의 정의대로 Routine을 새로 만들어줘.
> environment_id 는 이번에 만든 환경 ID를 써줘.

`cron_expression` 은 `0 0 * * 1` (UTC) = **한국시간 월요일 09:00** 입니다.
알림은 push·email 양쪽 모두 켜져 있었습니다.
재생성 후 출처 계정의 기존 Routine(`trig_012jS7WirWEbrAUcrEH5rLjQ`)은
**중복 실행을 막기 위해 반드시 비활성화**하십시오.

## 4. 체크리스트

- [ ] 볼트 진단 실행 (`vault/inspect-vault.sh`) 및 충돌 사본·민감정보 정리
- [ ] 볼트를 비공개 GitHub 저장소로 전환 (`vault/init-vault-repo.sh`)
- [ ] 미병합 브랜치 2개를 `main` 에 병합·푸시 (§2)
- [ ] 머신별 로컬 설정 백업 — macbookpro / desktop / 학교 Mac mini (§3-1)
- [ ] 진행 중이던 작업의 결론을 각 저장소의 `CLAUDE.md` 에 기록
- [ ] 새 계정 로그인 + GitHub 연결 + App 설치 (§3-2)
- [ ] 설정 복원 및 MCP 재인증 (§3-3)
- [ ] Environment 재생성 + 환경변수 재입력 (§3-4)
- [ ] Routine 재생성 (§3-5)
- [ ] 출처 계정의 기존 Routine 비활성화
- [ ] 새 계정에서 4개 저장소 접근 및 푸시 동작 확인
- [ ] 출처 계정 구독 정리 여부 결정

## 5. 파일 구성

```
MIGRATION/
├── README.md                              이 문서
├── vault/                                 옵시디언 볼트 전환 (전략 + 진단·초기화 스크립트)
├── routines/
│   └── weekly-bonelab-proposal.json       Routine 재생성 정의 (프롬프트 원문 포함)
└── scripts/
    ├── backup-claude-local.sh             로컬 설정 백업 (자격증명 제외 + 유출 검증)
    └── restore-claude-local.sh            새 계정 환경에 복원 (DRY_RUN 지원)
```

> 세션 67건의 제목 색인은 개인·업무 주제명을 포함하므로 **공개 저장소인 이 repo에 커밋하지 않았습니다.**
> 별도 파일로 전달되었으며, 필요하면 비공개 저장소(`Statlab`, `adsense-blog`)에 보관하십시오.
