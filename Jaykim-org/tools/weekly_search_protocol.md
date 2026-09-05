# 주간 검색 프로토콜 (Weekly Search Protocol)

매주 실행되는 Claude Code Routine과 수동 검색 모두 이 프로토콜을 따른다.

## 1. 검색어 세트 (영문, 최근 12개월 필터)
| 축 | 검색어 |
|---|---|
| 제작 기술 | `3D printed microfluidic` / `DLP microfluidic` / `SLA microfluidic` / `PCL microfluidic` / `hot embossing 3D printed stamp` / `droplet generator 3D printed` |
| 진단 응용 | `point-of-care diagnostic 3D printed` / `digital ELISA droplet` / `ddLAMP smartphone` / `electrochemical 3D printed cartridge` / `extracellular vesicle microfluidic isolation` |
| 동물실험 | `microfluidic "mouse model" biomarker whole blood` / `rat longitudinal cytokine microfluidic` / `organ-on-chip NAM FDA` / `ARRIVE microfluidic` |
| 임상 연계 | `clinical validation 3D printed microfluidic` / `MFDS 체외진단 3D 프린팅` / `FDA 510(k) microfluidic cartridge` / `IVDR microfluidic` |
| 연구실 특화 | `PHMG lung injury biomarker` / `KL-6 SP-D point-of-care` / `synovial fluid POCT` / `OCT microfluidic` |

## 2. 검색 소스 우선순위
1. PubMed / PMC (임상·동물 데이터 검증 용이)
2. RSC Lab on a Chip, ACS Sensors, Biosensors & Bioelectronics, Sensors and Actuators B
3. bioRxiv / medRxiv (최신 동향, 단 사전출판 표시)
4. FDA, EMA, MFDS 공지 (규제)
5. ClinicalTrials.gov, CRIS(한국) (임상시험 등록)

## 3. 논문 선별 기준 (각 1점, ≥3점 수집)
- [ ] 3D 프린팅이 소자 제작의 핵심(몰드 포함)
- [ ] 정량 성능 지표 제시(LOD, CV, 민감도/특이도)
- [ ] 동물 또는 임상 시료 검증
- [ ] 저비용/자원제한 환경 언급
- [ ] 연구실 보유 역량(광학영상, 독성모델, AI)과 결합 가능

## 4. 논문 분석 템플릿 (`analysis/*.md`)
```
# 논문 분석: <제목>
| 서지 | 소속 | 원문 경로 | 태그 |
1. 한 줄 요약
2. 문제 정의와 기여
3. 제작 공정 (재현용 파라미터 표)
4. 핵심 결과 (표)
5. 저자가 밝힌 한계
6. 비판적 검토 (우리 연구실 관점)
7. 우리 연구실 연계 포인트
8. 후속 연구 아이디어
9. 핵심 참고문헌
```

## 5. 주간 제안서 템플릿 (`weekly-proposals/YYYY-Www_proposal.md`)
```
1. 글로벌 연구 동향 스냅샷 (표: 영역 / 핵심 동향 / 근거)
2. 동물실험 연계 정보 (모델, 채혈 제한, 규제, 대체법)
3. 이번 주 제안 주제 3–5개 (가설 / 차별점 / 동물실험 / 임상 연계 / 첫 실험 / 예상 학술지)
4. 추천 및 다음 단계 (최우선 1개 + 다음 주 검색 초점)
5. 출처 (번호, 서지, URL)
```

## 6. 품질 규칙
- 모든 주장에 출처 번호를 붙인다. 출처 없는 수치 금지.
- 사전출판·초록만 확인한 자료는 명시한다.
- 이전 주 제안과 중복되는 주제는 "진전 사항"으로만 갱신하고 새 주제를 최소 2개 추가한다.
- README의 목록 표를 갱신한다.
