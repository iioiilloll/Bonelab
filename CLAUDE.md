# Bonelab — 프로젝트 맥락

고려대학교 안산병원 김재영 교수 연구실(B-ONE Lab) 저장소입니다.

## 구성

| 경로 | 내용 |
|---|---|
| `index.html` | 연구실 홈페이지. 빌드 과정 없는 단일 정적 파일 (HTML + 인라인 CSS/JS) |
| `Jaykim-org/` | 연구 아카이브 — 논문 분석, 주간 연구 주제 제안서, 수집 도구. 현재 `claude/resume-tmf6n0` 브랜치에만 존재하며 `main` 병합이 필요합니다 |
| `MIGRATION/` | Claude 계정 이전 런북 및 도구 |

## 작업 규칙

- `index.html` 은 의존성·번들러 없이 브라우저에서 바로 열리는 상태를 유지합니다.
  외부 CDN 추가나 빌드 도구 도입은 별도 합의 없이 하지 않습니다.
- 페이지 언어는 한국어(`lang="ko"`)이며, 학술 용어는 국문·영문 병기를 따릅니다.
- `Jaykim-org/` 아래 문서는 `Jaykim-org/tools/weekly_search_protocol.md` 의 템플릿을 따릅니다.
  모든 수치에는 번호 매긴 출처를 붙입니다.
- 커밋 메시지는 한국어로 작성합니다.
- Pull request 는 명시적으로 요청받았을 때만 만듭니다.

## 연구실 맥락

김재영 교수는 translational medical device scientist로 다음 분야를 다룹니다:
비침습 진단(적외선 열영상, OCT, 형광영상), 미세유체 기반 체외진단,
3D 프린팅 유체소자, AI 의료기술, PHMG 기관내 주입 폐독성 동물모델.
연구 주제 제안은 이 역량과 결합 가능한 것을 우선합니다.

## 배포

GitHub Pages(`main` 브랜치 루트)로 서비스됩니다. `index.html` 수정은 즉시 반영됩니다.
