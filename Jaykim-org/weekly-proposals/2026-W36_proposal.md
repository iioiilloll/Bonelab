# 주간 연구 주제 제안서 — 2026-W36 (2026-09-05)

**주제 축**: 3D 프린팅 기반 유체소자(fluidics) → 질병 진단 → 동물실험 → 임상 연계
**이번 주 기준 논문**: Hong, Han, Nam. *J Biomed Eng Res* 47:268 (2026) — PCL + DLP 스탬프 서브밀리 액적 소자 ([분석 노트](../analysis/2026_Hong_JBER_PCL-3Dprinted-stamp-droplet.md))

---

## 1. 글로벌 연구 동향 스냅샷 (2025-09 ~ 2026-09)

| 영역 | 핵심 동향 | 근거 |
|---|---|---|
| 3D 프린팅 액적 유체소자 | 비평면 액적 생성기·매립 분배기를 일체형으로 인쇄, 젖음 제어·병렬화·AI/디지털트윈 설계가 2026 리뷰의 핵심 의제 | Lab Chip 2026, d5lc01011j [1] |
| 3D 프린팅 POCT 전반 | FDM(100–300 µm, $1–5/소자) vs SLA(<50 µm) 비교, 전도성 PLA 전극·바이오메드 레진 재료. 표준화·규제 지역차·QA가 전환 장벽 | Biosensors 2025;15:340 [2] |
| 임상 검증 사례 | FDM 인쇄 전기화학 카트리지로 허혈성 뇌졸중 환자 혈청 transferrin saturation 60 min 측정(n = 5, r = 0.87) | ACS Sensors 2025 [3] |
| 감염병 POCT | 3D 프린팅 self-driven 칩 + RT-RPA-CRISPR 노로바이러스 LOD ~60 copies; 3D 프린팅 카트리지 + IoT SARS-CoV-2 (n = 19 임상) | Biosens Bioelectron 2025 [4], Sens Actuators B 2024 [5] |
| 소동물 종단 모니터링 | 마우스 전혈 3.5 µL로 사이토카인 멀티플렉스 digital ELISA, 2 h 회전, 패혈증 모델에서 초기 사이토카인–간손상 마커 상관 | bioRxiv 2025.05.11 [6] |
| 패혈증 | 3D 프린팅 친화칩(CD69/CD64/CD25) 임상 n = 125; 3D 프린팅 모듈형 소자로 전혈 세균 10 CFU/mL 농축·DNA 정제 | Biosens Bioelectron 2024 [7], [8] |
| 세포외소포(EV) | 디지털 마이크로플루이딕 일체형 EV 분리·검출(2026); 3D herringbone 나노패턴 칩 2 µL 혈장 난소암 EV 아형 검출 | [9] |
| 규제/동물실험 대체 | FDA Modernization Act 2.0(2022) → 2025-04 FDA 비동물시험 우선 로드맵(OoC·오가노이드·계산모델). ISO/WD 25693 OoC 표준화. 동물+NAM 하이브리드 자료 제출 추세 | IJMS 2025;26:10753 [10], PMC10617761 [11] |
| 정형외과 진단 | 활액 이중 바이오마커 알고리즘으로 OA vs 염증성 관절염 감별(2025); PJI용 α-defensin/IL-6/calprotectin 멀티플렉스 micro-ELISA POCT, 2025 ICM 합의 | J Orthop Res 2025 [12], Bone Joint Res 2025 [13] |

**해석**: 글로벌 흐름은 (a) 저비용 3D 프린팅 카트리지 + 스마트폰/전기화학 판독, (b) 미량 시료 절대정량(digital), (c) 동물모델 → 인체 검증의 "하이브리드 근거" 구축, (d) 표준화·QA 문서화로 수렴한다. 기준 논문(PCL 서브밀리 소자)은 (a)의 극단적 저비용 버전으로, (b)(c)와 결합하면 차별화된 연구가 된다.

---

## 2. 동물실험 연계 정보

| 항목 | 내용 |
|---|---|
| 연구실 보유 모델 | PHMG 기관내 주입(intratracheal instillation) 폐독성 랫 모델 (김재영 교수 연구 분야 "독성 평가") |
| 채혈 제한 | 마우스: 1회 ≤10% 순환혈액량(~0.1 mL/10 g), 2주 회복. 랫: 1회 ≤1.5 mL/250 g. → **µL급 소자 필수** |
| 종단 설계 | 3.5 µL 전혈 digital ELISA [6]는 동일 개체 반복 측정으로 개체수 감축(3R Reduction) 입증 |
| 규제 문서 | IACUC 승인, ARRIVE 2.0 보고, 한국 실험동물법·동물보호법. 임상 전환 시 FDA NAM 하이브리드(동물 + OoC) 자료 인정 [10, 11] |
| 대체법 | 3D 프린팅 몰드(SLA/PµSL 2 µm) 기반 lung-on-chip으로 PHMG 노출 재현 → 동물 수 감축 근거 |

---

## 3. 이번 주 제안 주제 (우선순위 순)

### ★ 제안 1. PHMG 폐손상 랫 모델 종단 사이토카인 모니터링용 3D 프린팅 미량혈액 액적 면역분석 카트리지
- **가설**: PCL/레진 3D 프린팅 T-junction 액적 소자에서 항체 코팅 비드를 액적에 캡슐화하면, 랫 꼬리정맥 혈액 5 µL로 IL-6·TNF-α·KL-6(폐상피 손상) 절대정량이 가능하며, 조직병리(폐섬유화 점수)와 상관된다.
- **차별점**: 기준 논문의 저비용 공정 + [6]의 소동물 digital ELISA 개념. 3D 프린팅 액적 소자로 동물 종단 모니터링을 수행한 보고는 검색 범위 내 없음.
- **동물실험**: 랫 PHMG 단회 기관내 주입, 0/1/3/7/14/28일 채혈(≤200 µL/회), 종료 시 BALF·폐조직. 개체수: 군당 8, 4군(대조/저/중/고) = 32.
- **임상 연계**: 가습기살균제 피해자·간질성폐질환(ILD) 환자 혈청 KL-6/SP-D POCT → 안산병원 호흡기내과 협력. 국내 특이 질환군으로 글로벌 차별성.
- **첫 실험(4주)**: 액적 내 비드 캡슐화율, 형광 판독 대안(PCL 광학 한계 → 투명 바이오메드 레진 SLA 비교), spiked 랫 혈장 LOD.
- **예상 학술지**: Lab Chip / Biosens Bioelectron / Sens Actuators B.

### 제안 2. 인공관절 주위 감염(PJI) 활액 멀티플렉스 3D 프린팅 POCT 카트리지
- **가설**: 활액 20 µL를 3D 프린팅 카트리지에서 희석·분주하여 α-defensin·calprotectin·IL-6를 15 min 내 측정, 2025 ICM 기준 대비 민감도/특이도 ≥90%.
- **근거**: micro-ELISA POCT 성능 [13], 2025 ICM 합의. 기존 lateral flow는 단일 마커.
- **동물실험**: 랫 대퇴골 K-wire *S. aureus* 삽입물 감염 모델(활액 채취 가능 토끼 무릎 모델 대안). 활액 바이오마커 시간경과.
- **임상 연계**: 정형외과 관절치환술 재수술 환자 활액(수술 중 채취) 전향적 등록. 안산병원 정형외과 협력.
- **위험**: 활액 점도(히알루론산) → 3D 프린팅 채널 막힘. 채널 폭 ≥400 µm인 기준 공정이 오히려 유리.

### 제안 3. 3D 프린팅 dd-LAMP + 스마트폰 판독 저비용 절대정량 감염병 진단
- **가설**: PCL 서브밀리 액적(~70 nL) 수천 개에 LAMP 반응을 분할하여 스마트폰 카메라 계수로 병원체 절대정량(LOD ≤100 copies/µL).
- **근거**: 3D 프린팅 액적 칩 + 스마트폰 ddLAMP [14], RT-RPA-CRISPR 3D 칩 [4].
- **동물실험**: 최소. 마우스 요로감염/폐렴 모델의 소변·BALF로 검증 가능.
- **임상 연계**: 응급실·요양시설 POCT, 자원제한 환경(글로벌헬스 과제). PCL 생분해성으로 폐기물 이슈 해결 → 차별 논거.

### 제안 4. FDM 전도성 PLA 전기화학 카트리지 확장 — 뇌졸중/철대사 → 골대사 마커
- **가설**: [3]의 FDM 하이브리드(PETG + 탄소 PLA 전극) 방식을 골표지자(CTX-I, P1NP) 또는 비타민 D로 확장.
- **동물실험**: 난소절제(OVX) 랫 골다공증 모델 혈청.
- **임상 연계**: 골다공증 치료 반응 모니터링 외래 POCT.

### 제안 5. 3D 프린팅 몰드 기반 lung-on-chip을 이용한 PHMG 독성 NAM 하이브리드 근거
- 랫 모델 데이터와 칩 데이터를 병렬 생성해 FDA 2025 로드맵·ISO/WD 25693 형식으로 문서화. 규제과학 논문 가능. 제안 1과 동물군 공유.

---

## 4. 추천 및 다음 단계
1. **제안 1**을 최우선으로 권고한다. 이유: 연구실 보유 동물모델·독성평가 경험을 즉시 활용하고, 국내 특이 질환군(가습기살균제 폐손상)으로 글로벌 차별성이 확보되며, 기준 논문 공정의 단점(형광 광학)을 재료 비교 실험으로 자연스럽게 해결한다.
2. 다음 주 검색 초점: (i) 액적 내 비드 캡슐화 digital immunoassay 3D 프린팅 사례, (ii) KL-6/SP-D POCT 문헌, (iii) 투명 바이오메드 레진 자가형광 데이터.
3. 정형외과 협력 가능 여부 확인 시 제안 2를 병행 트랙으로 승격.

---

## 5. 출처
1. 3D printing of droplet microfluidic devices: principles, wetting control, scale-up, and beyond. *Lab Chip* 2026. https://pubs.rsc.org/en/content/articlehtml/2026/lc/d5lc01011j
2. Kulkarni AS et al. A Review on 3D-Printed Miniaturized Devices for Point-of-Care-Testing Applications. *Biosensors* 2025;15(6):340. https://pmc.ncbi.nlm.nih.gov/articles/PMC12191180/
3. Integrated 3D-Printed Microfluidic Device for Immunocapture and Electrochemical Assessment of Transferrin Saturation in Point-of-Care Stroke Diagnostics. *ACS Sensors* 2025. https://pmc.ncbi.nlm.nih.gov/articles/PMC12836336/
4. A 3D-printed, self-driven microfluidic sensor chip for POCT of norovirus. *Biosens Bioelectron* 2025. https://www.sciencedirect.com/science/article/abs/pii/S0956566325009248
5. Point-of-care SARS-CoV-2 platform with all-in-one 3D-printed cartridge and IoT. *Sens Actuators B* 2024. https://www.sciencedirect.com/science/article/abs/pii/S0925400524003617
6. High-temporal-resolution point-of-care multiplex biomarker monitoring in small animals using microfluidic digital ELISA. *bioRxiv* 2025. https://www.biorxiv.org/content/10.1101/2025.05.11.653356v1.full.pdf
7. Affinity-based 3D-printed microfluidic chip for clinical sepsis detection with CD69, CD64, and CD25. *Biosens Bioelectron* 2024. https://www.sciencedirect.com/science/article/abs/pii/S0731708524005429
8. 3D-Printed Modular Microfluidic Device Enabling Preconcentrating Bacteria and Purifying Bacterial DNA in Blood. https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7070462/
9. An off-the-shelf digital microfluidic platform for integrated extracellular vesicle isolation and detection. 2026. https://www.sciencedirect.com/science/article/pii/S2590137026000816
10. Surina et al. Organ-on-a-Chip: A Roadmap for Translational Research in Human and Veterinary Medicine. *Int J Mol Sci* 2025;26(21):10753. https://pmc.ncbi.nlm.nih.gov/articles/PMC12610883/
11. FDA Modernization Act 2.0: transitioning beyond animal models. https://pmc.ncbi.nlm.nih.gov/articles/PMC10617761/
12. Keter et al. Synovial fluid dual-biomarker algorithm accurately differentiates osteoarthritis from inflammatory arthritis. *J Orthop Res* 2025. https://onlinelibrary.wiley.com/doi/10.1002/jor.26005
13. Rapid multiplex micro-ELISA assay for simultaneous measurement of synovial biomarkers (PJI). *Bone Joint Res* 2025. https://pmc.ncbi.nlm.nih.gov/articles/PMC11874355/
14. A Smartphone-Enabled Continuous Flow Digital Droplet LAMP Platform. https://www.ncbi.nlm.nih.gov/pmc/articles/PMC10575248/
15. FDA's shift from animal testing opens doors for organoid makers. *C&EN* 2025-04. https://cen.acs.org/pharmaceuticals/drug-development/FDAs-shift-animal-testing-opens/103/web/2025/04
