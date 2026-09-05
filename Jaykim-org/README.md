# Jaykim-org — 3D 프린팅 기반 유체소자(Fluidics) 진단 연구 아카이브

고려대학교 안산병원 김재영 교수 연구실(B-ONE Lab)의 **3D 프린팅 기반 미세/서브밀리 유체소자 → 질병 진단 → 임상 연계** 연구를 위한 논문 수집·분석·주간 주제 제안 저장소입니다.

## 목적
1. 3D 프린팅 유체소자(droplet, POCT 카트리지, organ-on-chip 등) 관련 논문을 수집하고 구조화된 형식으로 분석한다.
2. 글로벌 연구 동향(FDA/EMA/MFDS 규제, NAM·동물실험 대체 흐름, 임상 검증 사례)을 매주 조사한다.
3. 동물실험 → 임상 연계까지 고려한 **주간 연구 주제 제안서**를 작성한다.

## 폴더 구조
```
Jaykim-org/
├── README.md                  # 이 문서
├── papers/                    # 원문 PDF + 추출 텍스트
│   └── index.json             # 논문 메타데이터 인덱스 (ingest_paper.py가 갱신)
├── analysis/                  # 논문별 구조화 분석 노트 (Markdown)
├── weekly-proposals/          # 주간 주제 제안서 (YYYY-Www_*.md)
└── tools/
    ├── ingest_paper.py        # PDF → 텍스트 추출 + index.json 등록
    └── weekly_search_protocol.md  # 주간 검색 프로토콜(검색어·평가 기준·템플릿)
```

## 파일 명명 규칙
- PDF: `YYYY_FirstAuthor_LastAuthor_Journal_Vol-Page_short-title.pdf`
- 분석: `analysis/YYYY_FirstAuthor_Journal_short-title.md`
- 주간 제안: `weekly-proposals/YYYY-Www_proposal.md` (ISO week)

## 논문 등록 방법
```bash
python -m venv .venv && . .venv/bin/activate && pip install pypdf
python Jaykim-org/tools/ingest_paper.py path/to/paper.pdf \
    --title "..." --authors "Hong S, Han B, Nam J" --journal "J Biomed Eng Res" \
    --year 2026 --doi 10.9718/JBER.2026.47.4.268 --tags 3d-printing,PCL,droplet
```
등록 후 `analysis/`에 `tools/weekly_search_protocol.md`의 분석 템플릿을 사용해 노트를 작성한다.

## 주간 자동화
매주 월요일 09:00 KST에 Claude Code Routine이 새 세션을 열어 `tools/weekly_search_protocol.md`에 따라
글로벌 문헌·규제·동물실험 정보를 검색하고 `weekly-proposals/`에 제안서를 추가한 뒤 커밋·푸시한다.

## 분석 문서 목록
| 날짜 | 논문 | 분석 노트 |
|---|---|---|
| 2026-09-05 | Hong S, Han B, Nam J. *J Biomed Eng Res* 47:268-276 (2026) — 3D 프린팅 스탬프 + PCL 서브밀리 액적 소자 | [analysis/2026_Hong_JBER_PCL-3Dprinted-stamp-droplet.md](analysis/2026_Hong_JBER_PCL-3Dprinted-stamp-droplet.md) |

## 주간 제안서 목록
| 주차 | 제안서 | 최우선 제안 |
|---|---|---|
| 2026-W36 | [weekly-proposals/2026-W36_proposal.md](weekly-proposals/2026-W36_proposal.md) | PHMG 폐독성 랫 모델 종단 사이토카인 모니터링용 3D 프린팅 미량혈액 디지털 면역분석 카트리지 |
