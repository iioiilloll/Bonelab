# 연구실 학생 상호학습(Peer-Teaching) 리딩 리스트

**대상**: 학부 인턴 ~ 대학원 신입생
**목표**: Bioinformatics / Medical AI / Optical Imaging + AI / Micro & Millifluidics 네 축의 **공통 언어**를 만든 뒤, 학생들이 서로 가르치며 기본을 다진다.
**원칙**: 트랙마다 (1) 진입 리뷰 1편 → (2) 핵심 리뷰 2~3편 → (3) 실습형 교재/튜토리얼 1개 → (4) 우리 실험실 주제와의 접점 1편.

표기: 🟢 무료/오픈액세스 · 🟡 기관 구독 필요 · 📖 교재(책)
난이도: ★ 입문 · ★★ 중급 · ★★★ 심화

---

## 0. 시작하기 전에 (전원 공통, 1주차)

| 자료 | 왜 |
|---|---|
| S. Keshav, *How to Read a Paper*, ACM SIGCOMM CCR 37(3), 2007 — [PDF](https://web.stanford.edu/class/ee384m/Handouts/HowtoReadPaper.pdf) 🟢 ★ | 3-pass 논문 읽기법. 첫 세미나 전에 전원이 읽고 이 방식으로 발표 준비 |
| W. S. Noble, *A Quick Guide to Organizing Computational Biology Projects*, PLoS Comput Biol 2009 — [doi:10.1371/journal.pcbi.1000424](https://doi.org/10.1371/journal.pcbi.1000424) 🟢 ★ | 데이터/코드/결과 폴더 구조. 재현성의 최소 규칙 |
| *Ten simple rules for getting started with command-line bioinformatics*, PLoS Comput Biol 2021 — [doi:10.1371/journal.pcbi.1008645](https://doi.org/10.1371/journal.pcbi.1008645) 🟢 ★ | 터미널/셸 공포 제거. 4개 트랙 전부에서 쓰임 |

**공통 딥러닝 기초 (택 1, 자습용)** 📖 🟢
- *Dive into Deep Learning* — https://d2l.ai (PDF: https://d2l.ai/d2l-en.pdf) · 코드 실행 가능, 실습 중심
- S. Prince, *Understanding Deep Learning*, MIT Press — https://udlbook.github.io/udlbook/ · 그림 설명 탁월, 수식 최소, 이론 중심
- K. Murphy, *Probabilistic Machine Learning: An Introduction* — https://probml.github.io/pml-book/book1.html · 통계 백그라운드 보강용

> 권장: 1~4장(선형/최적화/MLP)과 CNN 장(7~8장)만 먼저 읽고 각 트랙으로 진입. 전부 읽고 시작하려 하면 진도가 안 나갑니다.

---

## 1. Track A — Bioinformatics

### 진입
1. **Deep learning: new computational modelling techniques for genomics** — Eraslan, Avsec, Gagneur & Theis, *Nat Rev Genet* 20:389–403 (2019) — [doi:10.1038/s41576-019-0122-6](https://doi.org/10.1038/s41576-019-0122-6) 🟡 ★★
   유전체 데이터에 CNN/RNN이 어떻게 매핑되는지 가장 깔끔하게 정리한 리뷰. Track A와 B를 잇는 다리.
2. **A survey of best practices for RNA-seq data analysis** — Conesa et al., *Genome Biol* 17:13 (2016) — [doi:10.1186/s13059-016-0881-8](https://doi.org/10.1186/s13059-016-0881-8) 🟢 ★
   QC→정렬→정량→DE 전체 파이프라인의 표준 지도. bulk RNA-seq를 다룰 학생의 1순위.

### 핵심
3. **Current best practices in single-cell RNA-seq analysis: a tutorial** — Luecken & Theis, *Mol Syst Biol* 15:e8746 (2019) — [doi:10.15252/msb.20188746](https://doi.org/10.15252/msb.20188746) 🟢 ★★
   scRNA-seq 각 단계의 "무엇을 왜 고르는가". 실습 코드: https://github.com/theislab/single-cell-tutorial
4. **Best practices for single-cell analysis across modalities** — Heumos, Schaar, Lance et al., *Nat Rev Genet* 24:550–572 (2023) — [doi:10.1038/s41576-023-00586-w](https://doi.org/10.1038/s41576-023-00586-w) 🟡 ★★★
   위 튜토리얼의 최신 확장판(멀티오믹, 공간전사체 포함). 온라인 무료판: https://www.sc-best-practices.org 🟢
5. **Ten simple rules for using public biological data for your research** — PLoS Comput Biol 2023 — [doi:10.1371/journal.pcbi.1010749](https://doi.org/10.1371/journal.pcbi.1010749) 🟢 ★
   GEO/TCGA/recount3 등 공개 데이터로 첫 프로젝트를 설계할 때.

### 실습 교재 📖 🟢
- **Orchestrating Single-Cell Analysis with Bioconductor (OSCA)** — https://bioconductor.org/books/release/OSCA/ · R/Bioconductor 단일세포 워크플로 표준
- **Computational Genomics with R** — https://compgenomr.github.io/book/ · R 기초부터 유전체 분석까지 한 권
- **Modern Statistics for Modern Biology** (Holmes & Huber) — https://www.huber.embl.de/msmb/ · 생물 데이터 통계의 직관을 잡아주는 책. Track A~D 전부에 도움

---

## 2. Track B — Medical AI

### 진입
1. **High-performance medicine: the convergence of human and artificial intelligence** — Topol, *Nat Med* 25:44–56 (2019) — [doi:10.1038/s41591-018-0300-7](https://doi.org/10.1038/s41591-018-0300-7) 🟡 ★
   임상의/영상/병원 시스템 관점에서 의료 AI 전경을 한 번에. 이 분야의 공통 어휘를 만들어 줌.
2. **AI in health and medicine** — Rajpurkar, Chen, Banerjee & Topol, *Nat Med* 28:31–38 (2022) — [doi:10.1038/s41591-021-01614-0](https://doi.org/10.1038/s41591-021-01614-0) 🟡 ★★
   연구→배포 사이의 간극, 전향적 연구, human–AI 협업. 위 논문의 후속 업데이트.

### 핵심
3. **Foundation models for generalist medical artificial intelligence** — Moor et al., *Nature* 616:259–265 (2023) — [doi:10.1038/s41586-023-05881-4](https://doi.org/10.1038/s41586-023-05881-4) 🟡 ★★
   멀티모달 파운데이션 모델(GMAI)의 개념과 한계. 지금 학생들이 반드시 알아야 할 현재형 패러다임.
4. **Key challenges for delivering clinical impact with artificial intelligence** — Kelly et al., *BMC Med* 17:195 (2019) — [doi:10.1186/s12916-019-1426-2](https://doi.org/10.1186/s12916-019-1426-2) 🟢 ★★
   왜 AUC 0.95 모델이 병원에서 안 쓰이는가. 데이터셋 시프트, 검증, 규제.
5. **The false hope of current approaches to explainable AI in health care** — Ghassemi, Oakden-Rayner & Beam, *Lancet Digit Health* 3:e745 (2021) — [doi:10.1016/S2589-7500(21)00208-9](https://doi.org/10.1016/S2589-7500(21)00208-9) 🟡 ★★
   XAI에 대한 비판적 시각. 반대 입장 토론용으로 세미나에서 특히 잘 작동.

### 방법론 체크리스트 (프로토콜 작성 시 필수) 🟢
- **TRIPOD+AI statement** (BMJ 2024) — https://pmc.ncbi.nlm.nih.gov/articles/PMC11019967/ · 예측모델 보고 27항목
- **CLAIM: Checklist for AI in Medical Imaging, 2024 Update** — [doi:10.1148/ryai.240300](https://doi.org/10.1148/ryai.240300) · 의료영상 AI 논문/리뷰 표준

---

## 3. Track C — Optical Imaging based AI

### 진입
1. **Deep learning for cellular image analysis** — Moen, Bannon, Kudo, Graf, Covert & Van Valen, *Nat Methods* 16:1233–1246 (2019) — [doi:10.1038/s41592-019-0403-1](https://doi.org/10.1038/s41592-019-0403-1) 🟡 ★★
   분류/분할/추적/augmented microscopy 4개 축으로 정리. 이 트랙의 표준 출발점.
2. **Applications, promises, and pitfalls of deep learning for fluorescence image reconstruction** — Belthangady & Royer, *Nat Methods* 16:1215–1225 (2019) — [doi:10.1038/s41592-019-0458-z](https://doi.org/10.1038/s41592-019-0458-z) 🟡 ★★
   denoising/deconvolution/super-resolution의 원리와 **환각(hallucination) 위험**. 반드시 같이 읽을 것.

### 핵심
3. **On the use of deep learning for computational imaging** — Barbastathis, Ozcan & Situ, *Optica* 6:921–943 (2019) — [열람](https://opg.optica.org/optica/fulltext.cfm?uri=optica-6-8-921) 🟢 ★★★
   역문제(inverse problem) 관점에서 광학 이미징 + DL을 통합 설명. 물리 기반 사고를 심어주는 리뷰.
4. **Deep learning-enabled virtual histological staining of biological samples** — Bai, Yang, Li, Zhang, Pillar & Ozcan, *Light Sci Appl* 12:57 (2023) — [doi:10.1038/s41377-023-01104-7](https://doi.org/10.1038/s41377-023-01104-7) 🟢 ★★
   무염색 조직 → 가상 H&E. 병리·정형외과 조직 분석과 직접 연결되는 주제.
5. **Content-aware image restoration (CARE)** — Weigert et al., *Nat Methods* 15:1090–1097 (2018) — [doi:10.1038/s41592-018-0216-7](https://doi.org/10.1038/s41592-018-0216-7) 🟡 ★★
   저광량·저해상 이미지 복원의 원형 논문. 실제 현미경 데이터에 바로 적용 가능.

### 실습 (코딩 부담 최소)
6. **Democratising deep learning for microscopy with ZeroCostDL4Mic** — von Chamier et al., *Nat Commun* 12:2276 (2021) — [doi:10.1038/s41467-021-22518-0](https://doi.org/10.1038/s41467-021-22518-0) 🟢 ★
   Google Colab만으로 분할/검출/denoising 학습. **학생 첫 실습 과제로 최적.**
7. **Cellpose: a generalist algorithm for cellular segmentation** — Stringer et al., *Nat Methods* 18:100–106 (2021) — [doi:10.1038/s41592-020-01018-x](https://doi.org/10.1038/s41592-020-01018-x) 🟡 ★
   즉시 쓰는 세포 분할 도구. https://cellpose.readthedocs.io

---

## 4. Track D — Micro & Millifluidics

### 진입
1. **The origins and the future of microfluidics** — Whitesides, *Nature* 442:368–373 (2006) — [doi:10.1038/nature05058](https://doi.org/10.1038/nature05058) 🟡 ★
   이 분야의 고전. 10페이지로 "왜 마이크로인가"를 설득한다.
2. **30 years of microfluidics** — Convery & Gadegaard, *Micro and Nano Engineering* 2:76–91 (2019) — [doi:10.1016/j.mne.2019.01.003](https://doi.org/10.1016/j.mne.2019.01.003) 🟢 ★
   오픈액세스. 재료·제작법(PDMS, 사출, 3D 프린팅)과 응용의 역사 정리. 위 논문의 현대판.

### 핵심 (물리 → 응용)
3. **Microfluidics: Fluid physics at the nanoliter scale** — Squires & Quake, *Rev Mod Phys* 77:977 (2005) — [doi:10.1103/RevModPhys.77.977](https://doi.org/10.1103/RevModPhys.77.977) 🟡 ★★★
   저Re 유동, 확산 혼합, 전기동역학. 채널 설계를 "감"이 아니라 수로 하게 만드는 리뷰.
4. **The present and future role of microfluidics in biomedical research** — Sackmann, Fulton & Beebe, *Nature* 507:181–189 (2014) — [doi:10.1038/nature13118](https://doi.org/10.1038/nature13118) 🟡 ★★
   진단·세포생물학에서 실제로 임팩트를 낸 지점과 실패한 지점.
5. **A guide to the organ-on-a-chip** — Leung, de Haan, Ronaldson-Bouchard et al., *Nat Rev Methods Primers* 2:33 (2022) — [doi:10.1038/s43586-022-00118-6](https://doi.org/10.1038/s43586-022-00118-6) 🟡 ★★
   Primer 형식이라 설계–제작–운전–분석 순서가 그대로 실험 프로토콜이 됨.
6. **Human organs-on-chips for disease modelling, drug development and personalized medicine** — Ingber, *Nat Rev Genet* 23:467–491 (2022) — [doi:10.1038/s41576-022-00466-9](https://doi.org/10.1038/s41576-022-00466-9) 🟡 ★★★
   OoC의 임상·신약 적용 현황. Track B/D 교차 토론에 좋음.

### 교재 📖 🟡
- B. J. Kirby, *Micro- and Nanoscale Fluid Mechanics: Transport in Microfluidic Devices*, Cambridge — 정량적 설계를 배울 때. (도서관/구독)
- H. Bruus, *Theoretical Microfluidics*, Oxford — 이론 중심. (도서관/구독)

> 두 책 모두 무료가 아닙니다. 예산 없이 시작하려면 3·4번 리뷰 + 30 years of microfluidics로 충분합니다.

---

## 5. 우리 연구실 주제와의 접점 (교차 세미나용)

| 주제 | 자료 |
|---|---|
| 골 대사 + AI | **Artificial Intelligence and Machine Learning in the Diagnosis and Management of Osteoporosis: A Comprehensive Review**, *Medicina* (2026) — https://www.mdpi.com/1648-9144/62/1/27 🟢 ★★ · DXA 없이 일반 X-ray로 BMD 추정하는 흐름 정리 |
| 근골격 영상 AI 실무 | **Artificial intelligence in musculoskeletal radiology: practical aspects and latest perspectives**, *BJR Open* 7 (2025) — https://academic.oup.com/bjro/article/7/1/tzaf029/8317543 🟢 ★★ |
| 뼈 + 미세유체 | **Bone-on-a-Chip: Biomimetic Models Based on Microfluidic Technologies for Biomedical Applications**, *ACS Biomater Sci Eng* 9:3058 (2023) — [doi:10.1021/acsbiomaterials.3c00066](https://doi.org/10.1021/acsbiomaterials.3c00066) 🟡 ★★ |
| 뼈 + 미세유체 (최신) | **Advances in the Construction and Application of Bone-on-a-Chip Based on Microfluidic Technologies**, *J Biomed Mater Res B* (2024) — [doi:10.1002/jbm.b.35502](https://doi.org/10.1002/jbm.b.35502) 🟡 ★★ |
| 미세유체 + AI | **Microfluidics with Machine Learning for Biophysical Characterization of Cells**, *Annu Rev Anal Chem* — https://www.annualreviews.org/content/journals/10.1146/annurev-anchem-061622-025021 🟡 ★★★ |
| 미세유체 + AI (단일세포) | **Enhancing single-cell biology through advanced AI-powered microfluidics**, *Biomicrofluidics* 17:051301 (2023) — https://pubs.aip.org/aip/bmf/article/17/5/051301/2914114 🟡 ★★ |

---

## 6. 12주 상호학습 운영안

한 주 90분. **발표자 2명(서로 다른 트랙)** + 전원 사전 읽기. 발표자는 매주 로테이션.

| 주 | 트랙 | 자료 | 산출물 |
|---|---|---|---|
| 1 | 공통 | How to Read a Paper + Noble 2009 + 커맨드라인 10 rules | 각자 프로젝트 폴더 구조 만들어 오기 |
| 2 | A | Conesa 2016 (RNA-seq best practices) | 파이프라인 다이어그램 1장 |
| 3 | A | Luecken & Theis 2019 | 공개 데이터 1개로 QC까지 재현 |
| 4 | A | Eraslan 2019 | "우리 데이터에 DL을 쓴다면" 1페이지 제안 |
| 5 | B | Topol 2019 + Rajpurkar 2022 | 임상 문제 3개 후보 도출 |
| 6 | B | Kelly 2019 + Ghassemi 2021 | 찬반 토론(2팀) |
| 7 | B | Moor 2023 + CLAIM 2024 | 우리 과제를 CLAIM 항목으로 자가 점검 |
| 8 | C | Moen 2019 + Belthangady & Royer 2019 | 현미경 이미지 1세트 라벨링 |
| 9 | C | ZeroCostDL4Mic 실습 | Colab에서 분할 모델 1개 학습 |
| 10 | C | Bai 2023 (virtual staining) + Barbastathis 2019 | 가상염색 적용 아이디어 발표 |
| 11 | D | Whitesides 2006 + Convery 2019 + Squires & Quake (1~3장) | 채널 설계 스케치 + Re/확산시간 계산 |
| 12 | D + 교차 | Leung 2022 (OoC Primer) + Bone-on-a-Chip 2023 | **4트랙 융합 과제 제안서 1장** |

### 발표 형식 (10분 규칙)
1. 이 논문이 없앤 문제는 무엇인가 (1분)
2. 핵심 방법 — 그림 1개로 (3분)
3. 가장 중요한 결과 그림 1개와 그 한계 (3분)
4. 우리 실험실에 적용한다면 (2분)
5. 내가 이해 못 한 것 1가지 — 반드시 말하기 (1분)

### 평가 체크리스트
- [ ] 방법의 가정을 한 문장으로 말할 수 있는가
- [ ] 대조군/검증셋이 무엇인지 지적할 수 있는가
- [ ] 결과가 뒤집히려면 무엇이 사실이어야 하는지 말할 수 있는가
- [ ] 다른 트랙 학생이 알아듣게 설명했는가 ← **상호학습의 실제 목표**

---

## 7. 접근이 막힐 때
- 대학 도서관 프록시(고려대) 경유 → 대부분의 🟡 논문 열람 가능
- PubMed Central: https://www.ncbi.nlm.nih.gov/pmc/ (PMC 무료본 존재 여부 확인)
- Unpaywall / Europe PMC로 저자 공개본(arXiv, bioRxiv) 탐색
- 그래도 없으면 교신저자에게 메일 — 학생 신분이면 회신율이 높습니다
