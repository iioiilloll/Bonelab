# 연구실 학생 상호학습(Peer-Teaching) 리딩 리스트

**대상**: 학부 인턴 ~ 대학원생 ~ 임상 전공의
**목표**: 임상 데이터(EMR) / Bioinformatics / Medical AI / Optical Imaging AI(PAM·OCT) / Micro & Millifluidics 다섯 축의 **공통 언어**를 만든 뒤, 학생들이 서로 가르치며 기본을 다진다.
**원칙**: 트랙마다 (1) 진입 리뷰 1~2편 → (2) 핵심 리뷰 2~4편 → (3) 실습형 자료 → (4) 우리 실험실 주제와의 접점.

표기: 🟢 무료/오픈액세스 · 🟡 기관 구독 필요 · 📖 교재(책) · 🧪 실습/도구/데이터셋
난이도: ★ 입문 · ★★ 중급 · ★★★ 심화

---

## 0. 시작하기 전에 (전원 공통, 1주차)

| 자료 | 왜 |
|---|---|
| S. Keshav, *How to Read a Paper*, ACM SIGCOMM CCR 37(3), 2007 — [PDF](https://web.stanford.edu/class/ee384m/Handouts/HowtoReadPaper.pdf) 🟢 ★ | 3-pass 논문 읽기법. 첫 세미나 전에 전원이 읽고 이 방식으로 발표 준비 |
| W. S. Noble, *A Quick Guide to Organizing Computational Biology Projects*, PLoS Comput Biol 2009 — [doi:10.1371/journal.pcbi.1000424](https://doi.org/10.1371/journal.pcbi.1000424) 🟢 ★ | 데이터/코드/결과 폴더 구조. 재현성의 최소 규칙 |
| *Ten simple rules for getting started with command-line bioinformatics*, PLoS Comput Biol 2021 — [doi:10.1371/journal.pcbi.1008645](https://doi.org/10.1371/journal.pcbi.1008645) 🟢 ★ | 터미널/셸 공포 제거. 다섯 트랙 전부에서 쓰임 |

**공통 딥러닝 기초 (택 1, 자습용)** 📖 🟢
- *Dive into Deep Learning* — https://d2l.ai (PDF: https://d2l.ai/d2l-en.pdf) · 코드 실행 가능, 실습 중심
- S. Prince, *Understanding Deep Learning*, MIT Press — https://udlbook.github.io/udlbook/ · 그림 설명 탁월, 수식 최소
- K. Murphy, *Probabilistic Machine Learning: An Introduction* — https://probml.github.io/pml-book/book1.html · 통계 백그라운드 보강용

> 권장: 1~4장(선형/최적화/MLP)과 CNN 장만 먼저 읽고 각 트랙으로 진입. 전부 읽고 시작하려 하면 진도가 안 나갑니다.

---

## 1. Track E — 임상 데이터와 EMR: 현장에서 데이터는 어떻게 생기는가

> **담당: 손정호 선생님 (내과 레지던트 2년차)**
> 이 트랙만은 논문보다 **현장 워크스루가 먼저**입니다. 데이터가 어떻게 태어나는지를 모른 채 분석부터 배우면, 나머지 네 트랙 전부가 잘못된 전제 위에 쌓입니다.
> 순서상 A~D보다 **앞에** 배치했습니다.

### E0. 첫 세션: EMR 화면 워크스루 (읽을 자료 없음, 손정호 선생님 진행)

한 환자의 입원부터 퇴원까지를 실제 화면으로 따라가며, **각 화면이 데이터베이스의 어떤 행(row)이 되는지**를 짚습니다.
(반드시 테스트 계정 또는 마스킹된 화면으로 진행. 실제 환자 식별정보 노출 금지)

```
입원 → 초기평가 → 오더(처방) → 간호기록/V/S → 랩 오더 → 랩 결과(LIS)
     → 영상 오더 → 판독문(PACS/RIS) → 경과기록 → 협진 → 투약(MAR) → 퇴원요약 → 청구코드
```

각 단계에서 학생들에게 물을 것: **이 값은 누가, 언제, 왜 입력했는가?**

### E1. 손정호 선생님이 다른 학생에게 반드시 짚어줘야 할 다섯 가지

임상 현장을 아는 사람만 가르칠 수 있는 내용입니다. 이게 이 트랙의 실제 가치입니다.

1. **V/S가 자동 수집인지 수기 입력인지** — 중환자실 모니터 자동 기록과 일반 병동 수기 입력은 완전히 다른 데이터입니다. 빈도, 결측 패턴, 반올림 습관이 다릅니다.
2. **결측은 랜덤이 아니다** — 안 낸 검사는 "정상일 것 같아서 안 낸 것"입니다. 결측 자체가 임상적 판단의 기록입니다.
3. **측정 빈도가 곧 중증도** — 하루 3번 ABGA를 낸 환자와 한 번도 안 낸 환자는 이미 다른 환자입니다. 값보다 빈도가 더 강한 예측변수가 되는 이유.
4. **진단코드(KCD/ICD)는 청구용** — 임상적 사실과 다를 수 있습니다. R/O 진단, 청구를 위한 코드, 삭제되지 않은 과거 진단이 섞여 있습니다.
5. **시간(timestamp)의 의미가 필드마다 다르다** — 오더 시각 / 채혈 시각 / 검체 접수 시각 / 결과 보고 시각은 모두 다릅니다. 어느 것을 쓰느냐로 결과가 뒤집힙니다.

### 진입 — 왜 임상 데이터는 연구용 데이터가 아닌가

1. **Biases in electronic health record data due to processes within the healthcare system** — Agniel, Kohane & Weber, *BMJ* 361:k1479 (2018) — [PMC5925441](https://pmc.ncbi.nlm.nih.gov/articles/PMC5925441/) 🟢 ★★
   **이 트랙의 핵심 논문.** 검사를 "언제 냈는가"가 검사 결과값보다 사망을 더 잘 예측했다. 위 5가지 중 3번을 데이터로 증명한 연구.
2. **Methods and dimensions of electronic health record data quality assessment** — Weiskopf & Weng, *JAMIA* 20:144–151 (2013) — [열람](https://academic.oup.com/jamia/article/20/1/144/2909176) 🟡 ★★
   완전성·정확성·일치성·타당성·최신성 5차원. 데이터 품질을 말로 하지 않고 항목으로 점검하게 해줍니다.
3. **A Harmonized Data Quality Assessment Terminology and Framework** — Kahn et al., *eGEMs* 4(1):18 (2016) — [doi:10.13063/2327-9214.1244](https://doi.org/10.13063/2327-9214.1244) 🟢 ★★
   위 논문의 표준화판. 연구 프로토콜의 "데이터 품질 관리" 항목을 이 용어로 씁니다.

### 핵심 — 2차 활용 실무

4. **Secondary Analysis of Electronic Health Records** — MIT Critical Data, Springer 2016 — [NCBI Bookshelf 전문 무료](https://www.ncbi.nlm.nih.gov/books/NBK543630/) 🟢 📖 ★★
   연구질문 설정 → 데이터 추출 → 탐색 → 분석 → 검증까지의 "Cookbook". 임상의가 첫 데이터 연구를 설계할 때 가장 실용적인 한 권.
5. **Opportunities and challenges in developing risk prediction models with EHR data: a systematic review** — Goldstein, Navar, Pencina & Ioannidis, *JAMIA* 24:198–208 (2017) — [PMC5201180](https://pmc.ncbi.nlm.nih.gov/articles/PMC5201180/) 🟢 ★★
   코호트 정의, 관찰 창(observation window), 결측 처리의 실제 함정. Track B의 TRIPOD+AI와 짝으로 읽습니다.
6. **The Book of OHDSI** — OHDSI 커뮤니티 — https://ohdsi.github.io/TheBookOfOhdsi/ 🟢 📖 ★★
   OMOP 공통데이터모델(CDM) 표준. **한국어판이 공식 제공됩니다.** 4장(Common Data Model)과 데이터 품질 장을 먼저.
7. **MIMIC-IV, a freely accessible electronic health record dataset** — Johnson et al., *Sci Data* 10:1 (2023) — [doi:10.1038/s41597-022-01899-x](https://doi.org/10.1038/s41597-022-01899-x) 🟢 🧪 ★★
   중환자실 EHR 공개 데이터. PhysioNet에서 CITI 교육 이수 후 무료. **우리 병원 데이터를 못 쓰는 동안 연습할 유일한 현실적 대안입니다.**

### 한국 실무 — IRB 제출 전 필독

8. **「보건의료데이터 활용 가이드라인」(2024.12)** — 개인정보보호위원회·보건복지부 — [PDF](https://www.pipc.go.kr/np/cop/bbs/selectBoardArticle.do?bbsId=BS217&mCode=D010030000&nttId=9901) 🟢 ★★
   가명처리 기준과 동의 면제 요건. 국내에서 EMR 데이터로 연구하려면 이 문서가 출발점입니다.
9. **K-CURE 임상 라이브러리** — 보건복지부 — https://k-cure.mohw.go.kr 🟢 ★
   OMOP CDM 기반 국가 암 임상데이터. 데이터제공심의 → IRB → 의료데이터 안심활용센터 절차를 미리 익혀 두면 좋습니다.

### 🧪 이 트랙의 실습 과제

- **과제 1**: 관심 있는 임상 질문 하나를 고르고, 코호트 정의를 **문장이 아니라 조건식**으로 쓴다. (예: "패혈증 환자" → 어떤 코드? 어떤 시점? 어떤 제외기준?)
- **과제 2**: 그 조건식을 OMOP CDM 개념(concept)으로 번역해 본다. 번역이 안 되는 항목이 어디인지가 우리 데이터의 한계다.
- **과제 3**: MIMIC-IV에서 같은 질문을 던져 보고, 우리 병원 데이터와 무엇이 다른지 한 쪽으로 정리한다.

---

## 2. Track A — Bioinformatics

### 진입
1. **A survey of best practices for RNA-seq data analysis** — Conesa et al., *Genome Biol* 17:13 (2016) — [doi:10.1186/s13059-016-0881-8](https://doi.org/10.1186/s13059-016-0881-8) 🟢 ★
   QC→정렬→정량→DE 전체 파이프라인의 표준 지도. bulk RNA-seq를 다룰 학생의 1순위.
2. **Deep learning: new computational modelling techniques for genomics** — Eraslan, Avsec, Gagneur & Theis, *Nat Rev Genet* 20:389–403 (2019) — [doi:10.1038/s41576-019-0122-6](https://doi.org/10.1038/s41576-019-0122-6) 🟡 ★★
   유전체 데이터에 CNN/RNN이 어떻게 매핑되는지 가장 깔끔하게 정리한 리뷰.

### 핵심
3. **Current best practices in single-cell RNA-seq analysis: a tutorial** — Luecken & Theis, *Mol Syst Biol* 15:e8746 (2019) — [doi:10.15252/msb.20188746](https://doi.org/10.15252/msb.20188746) 🟢 ★★
   scRNA-seq 각 단계의 "무엇을 왜 고르는가". 실습 코드: https://github.com/theislab/single-cell-tutorial
4. **Best practices for single-cell analysis across modalities** — Heumos, Schaar, Lance et al., *Nat Rev Genet* 24:550–572 (2023) — [doi:10.1038/s41576-023-00586-w](https://doi.org/10.1038/s41576-023-00586-w) 🟡 ★★★
   최신 확장판(멀티오믹, 공간전사체 포함). 온라인 무료판: https://www.sc-best-practices.org 🟢
5. **Ten simple rules for using public biological data for your research** — PLoS Comput Biol 2023 — [doi:10.1371/journal.pcbi.1010749](https://doi.org/10.1371/journal.pcbi.1010749) 🟢 ★
   GEO/TCGA/recount3 등 공개 데이터로 첫 프로젝트를 설계할 때.

### 실습 교재 📖 🟢
- **Orchestrating Single-Cell Analysis with Bioconductor (OSCA)** — https://bioconductor.org/books/release/OSCA/
- **Computational Genomics with R** — https://compgenomr.github.io/book/
- **Modern Statistics for Modern Biology** (Holmes & Huber) — https://www.huber.embl.de/msmb/

---

## 3. Track B — Medical AI

### 진입
1. **High-performance medicine: the convergence of human and artificial intelligence** — Topol, *Nat Med* 25:44–56 (2019) — [doi:10.1038/s41591-018-0300-7](https://doi.org/10.1038/s41591-018-0300-7) 🟡 ★
2. **AI in health and medicine** — Rajpurkar, Chen, Banerjee & Topol, *Nat Med* 28:31–38 (2022) — [doi:10.1038/s41591-021-01614-0](https://doi.org/10.1038/s41591-021-01614-0) 🟡 ★★

### 핵심
3. **Foundation models for generalist medical artificial intelligence** — Moor et al., *Nature* 616:259–265 (2023) — [doi:10.1038/s41586-023-05881-4](https://doi.org/10.1038/s41586-023-05881-4) 🟡 ★★
4. **Key challenges for delivering clinical impact with artificial intelligence** — Kelly et al., *BMC Med* 17:195 (2019) — [doi:10.1186/s12916-019-1426-2](https://doi.org/10.1186/s12916-019-1426-2) 🟢 ★★
   왜 AUC 0.95 모델이 병원에서 안 쓰이는가. **Track E의 데이터 품질 논의와 직결됩니다.**
5. **The false hope of current approaches to explainable AI in health care** — Ghassemi, Oakden-Rayner & Beam, *Lancet Digit Health* 3:e745 (2021) — [doi:10.1016/S2589-7500(21)00208-9](https://doi.org/10.1016/S2589-7500(21)00208-9) 🟡 ★★

### 방법론 체크리스트 (프로토콜 작성 시 필수) 🟢
- **TRIPOD+AI statement** (BMJ 2024) — https://pmc.ncbi.nlm.nih.gov/articles/PMC11019967/ · 예측모델 보고 27항목
- **CLAIM: Checklist for AI in Medical Imaging, 2024 Update** — [doi:10.1148/ryai.240300](https://doi.org/10.1148/ryai.240300)

---

## 4. Track C — Optical Imaging based AI: 광음향 현미경(PAM)과 OCT

> 형광 현미경 중심에서 **PAM·OCT 중심으로 재구성**했습니다.
> 두 모달리티의 공통점: 둘 다 **원시 신호에서 영상을 재구성**해야 하고, 그 재구성 단계가 딥러닝이 들어가는 자리입니다.
> 그래서 이 트랙은 "이미지 분류"가 아니라 **역문제(inverse problem)** 로 시작합니다.

### 진입 — 모달리티 원리부터

1. **Optical Coherence Tomography (OCT): Principle and Technical Realization** — Aumann, Donner, Fischer & Müller, in *High Resolution Imaging in Microscopy and Ophthalmology* (Springer, 2019), pp. 59–85 — [오픈액세스 전문](https://www.ncbi.nlm.nih.gov/books/NBK554044/) 🟢 ★
   TD-OCT / SD-OCT / SS-OCT의 차이, 축·횡 해상도가 무엇으로 결정되는지. **무료이고 그림이 좋아 첫 자료로 최적.**
2. **The Development, Commercialization, and Impact of Optical Coherence Tomography** — Fujimoto & Swanson, *IOVS* 57:OCT1–OCT13 (2016) — [doi:10.1167/iovs.16-19963](https://doi.org/10.1167/iovs.16-19963) 🟢 ★
   1991년 Huang et al.(*Science* 254:1178)의 원논문에서 임상 표준이 되기까지. 기술이 어떻게 임상에 안착하는지의 교과서적 사례.
3. **A practical guide to photoacoustic tomography in the life sciences** — Wang & Yao, *Nat Methods* 13:627–638 (2016) — [doi:10.1038/nmeth.3925](https://doi.org/10.1038/nmeth.3925) 🟡 ★★
   광음향의 원리와 시스템 선택 가이드. "무엇을 보고 싶은가"에서 장비 사양으로 내려가는 길을 알려줍니다.
4. **Photoacoustic microscopy** — Yao & Wang, *Laser Photonics Rev* 7(5) (2013) — [doi:10.1002/lpor.201200060](https://doi.org/10.1002/lpor.201200060) 🟡 ★★
   OR-PAM과 AR-PAM의 구분, 해상도–침투깊이 트레이드오프. PAM을 직접 다룰 학생의 필독.

### 핵심 — OCT + AI

5. **Clinically applicable deep learning for diagnosis and referral in retinal disease** — De Fauw et al., *Nat Med* 24:1342–1350 (2018) — [doi:10.1038/s41591-018-0107-6](https://doi.org/10.1038/s41591-018-0107-6) 🟡 ★★
   3D OCT에 대한 **분할 → 분류 2단 구조**. 장비가 바뀌어도 성능이 유지되게 만든 설계가 핵심. 임상 배포를 염두에 둔 모델 설계의 모범 사례.
6. **Identifying Medical Diagnoses and Treatable Diseases by Image-Based Deep Learning** — Kermany et al., *Cell* 172:1122–1131 (2018) — [doi:10.1016/j.cell.2018.02.010](https://doi.org/10.1016/j.cell.2018.02.010) 🟡 ★
   전이학습으로 OCT 분류. 무엇보다 **데이터셋(OCT2017, 84,484장)이 CC BY 4.0으로 공개**되어 있어 실습 자료가 됩니다.
7. **Deep learning in optical coherence tomography: Where are the gaps?** — Li et al., *Clin Exp Ophthalmol* (2023) — [doi:10.1111/ceo.14258](https://doi.org/10.1111/ceo.14258) 🟡 ★★
   현재 OCT 딥러닝이 무엇을 못 하는지. 연구 주제를 고를 때 읽습니다.
8. **Unraveling the complexity of OCT image segmentation using machine and deep learning techniques: A review** — *Comput Med Imaging Graph* (2023) — [열람](https://www.sciencedirect.com/science/article/abs/pii/S0895611123000873) 🟡 ★★
   층 분할(layer segmentation) 태스크의 방법론 정리.
9. **Deep Learning in OCT Angiography: Current Progress, Challenges, and Future Directions** — [PMC9857993](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9857993/) 🟢 ★★
   OCTA(혈관조영) 쪽. 미세혈류를 보는 관점이라 광음향과 자연스럽게 이어집니다.

### 핵심 — PAM / PAT + AI

10. **Deep learning for biomedical photoacoustic imaging: A review** — Gröhl, Schellenberg, Dreher & Maier-Hein, *Photoacoustics* (2021) — [ScienceDirect](https://www.sciencedirect.com/science/article/pii/S2213597921000033) · [arXiv 무료본](https://arxiv.org/abs/2011.02744) 🟢 ★★
    광음향 딥러닝의 표준 리뷰. 재구성·정량화·분할 태스크별로 나눠 설명합니다.
11. **Deep learning in photoacoustic tomography: current approaches and future directions** — Hauptmann & Cox, *J Biomed Opt* 25(11):112903 (2020) — [doi:10.1117/1.JBO.25.11.112903](https://doi.org/10.1117/1.JBO.25.11.112903) · [arXiv](https://arxiv.org/abs/2009.07608) 🟢 ★★★
    학습 기반 재구성을 **고전 재구성 기법의 확장**으로 위치시킨 리뷰. 물리 모델을 버리지 않는 접근을 배웁니다.
12. **Deep learning in photoacoustic imaging: a review** — Deng et al., *J Biomed Opt* 26(4):040901 (2021) — [SPIE 무료 PDF](https://www.spiedigitallibrary.org/journals/journal-of-biomedical-optics/volume-26/issue-4/040901/Deep-learning-in-photoacoustic-imaging-a-review/10.1117/1.JBO.26.4.040901.pdf) 🟢 ★★
    **데이터셋을 어떻게 만들고 네트워크를 어떻게 고를지**에 초점. 실제로 모델을 짜야 하는 학생에게 가장 실용적.
13. **Reconstructing undersampled photoacoustic microscopy images using deep learning** — DiSpirito et al., *IEEE TMI* 40:562–570 (2021) — [doi:10.1109/TMI.2020.3031541](https://doi.org/10.1109/TMI.2020.3031541) · [arXiv](https://arxiv.org/abs/2006.00251) 🟡 ★★
    PAM의 근본 문제인 **스캔 속도 vs 해상도**를 딥러닝으로 푼 대표 사례. 언더샘플링 후 복원.

### 공통 경고 — 반드시 함께 읽을 것

14. **Applications, promises, and pitfalls of deep learning for fluorescence image reconstruction** — Belthangady & Royer, *Nat Methods* 16:1215–1225 (2019) — [doi:10.1038/s41592-019-0458-z](https://doi.org/10.1038/s41592-019-0458-z) 🟡 ★★
    형광 기반 논문이지만 경고는 그대로 적용됩니다: **복원된 픽셀은 측정값이 아니라 추정값이고, 없는 구조를 만들어낼 수 있습니다.** PAT 재구성·OCT denoising 모두 같은 위험을 안고 있습니다.
15. **On the use of deep learning for computational imaging** — Barbastathis, Ozcan & Situ, *Optica* 6:921–943 (2019) — [무료 열람](https://opg.optica.org/optica/fulltext.cfm?uri=optica-6-8-921) 🟢 ★★★
    역문제 관점의 통합 프레임. 10·11번 논문을 읽기 전에 이걸 보면 훨씬 잘 읽힙니다.

### 🧪 실습 도구 · 데이터

- **k-Wave** — Treeby & Cox, *J Biomed Opt* 15:021314 (2010) · http://www.k-wave.org 🟢
  광음향 파동 시뮬레이션·재구성 MATLAB 툴박스. 이 분야에서 가장 널리 쓰입니다. **장비 없이도 순방향 시뮬레이션 → 재구성 실습이 가능합니다.**
- **SIMPA** — *J Biomed Opt* 27(8):083010 (2022) · https://github.com/IMSY-DKFZ/simpa 🟢
  파이썬 기반 광음향 시뮬레이션/처리 툴킷. 딥러닝 학습용 합성 데이터 생성에 적합.
- **OCT2017 데이터셋** — https://data.mendeley.com/datasets/rscbjbr9sj/2 (CC BY 4.0) 🟢
  라벨링된 망막 OCT 84,484장. 첫 분류 모델 실습용.

> **첫 실습 순서 권장**: OCT2017로 분류 모델 한 번 돌려 감을 잡고 → k-Wave로 광음향 순방향 신호를 만들어 보고 → 그 신호를 언더샘플링해 복원해 본다(13번 논문 재현). 장비 접근 전에 여기까지는 노트북으로 가능합니다.

---

## 5. Track D — Micro & Millifluidics

### 진입
1. **The origins and the future of microfluidics** — Whitesides, *Nature* 442:368–373 (2006) — [doi:10.1038/nature05058](https://doi.org/10.1038/nature05058) 🟡 ★
2. **30 years of microfluidics** — Convery & Gadegaard, *Micro and Nano Engineering* 2:76–91 (2019) — [doi:10.1016/j.mne.2019.01.003](https://doi.org/10.1016/j.mne.2019.01.003) 🟢 ★

### 핵심 (물리 → 응용)
3. **Microfluidics: Fluid physics at the nanoliter scale** — Squires & Quake, *Rev Mod Phys* 77:977 (2005) — [doi:10.1103/RevModPhys.77.977](https://doi.org/10.1103/RevModPhys.77.977) 🟡 ★★★
4. **The present and future role of microfluidics in biomedical research** — Sackmann, Fulton & Beebe, *Nature* 507:181–189 (2014) — [doi:10.1038/nature13118](https://doi.org/10.1038/nature13118) 🟡 ★★
5. **A guide to the organ-on-a-chip** — Leung, de Haan, Ronaldson-Bouchard et al., *Nat Rev Methods Primers* 2:33 (2022) — [doi:10.1038/s43586-022-00118-6](https://doi.org/10.1038/s43586-022-00118-6) 🟡 ★★
6. **Human organs-on-chips for disease modelling, drug development and personalized medicine** — Ingber, *Nat Rev Genet* 23:467–491 (2022) — [doi:10.1038/s41576-022-00466-9](https://doi.org/10.1038/s41576-022-00466-9) 🟡 ★★★

### 교재 📖 🟡
- B. J. Kirby, *Micro- and Nanoscale Fluid Mechanics*, Cambridge — 정량적 설계용. (도서관)
- H. Bruus, *Theoretical Microfluidics*, Oxford — 이론 중심. (도서관)

> 예산이 없다면 2·3번 리뷰만으로도 첫 칩 설계는 충분합니다.

---

## 6. 우리 연구실 주제와의 접점 (교차 세미나용)

| 주제 | 자료 |
|---|---|
| **광음향 + 뼈** | **Photoacoustic Imaging and Characterization of Bone in Medicine: Overview, Applications, and Outlook**, *Annu Rev Biomed Eng* (2023) — [열람](https://www.annualreviews.org/content/journals/10.1146/annurev-bioeng-081622-025405) 🟡 ★★ · 골암·관절·척추·골다공증·수술 가이드까지 총정리. **C·D 트랙과 우리 주제의 최대 접점** |
| **광음향 + 골다공증** | **Functional Photoacoustic and Ultrasonic Assessment of Osteoporosis: A Clinical Feasibility Study**, *BME Frontiers* (2020) — [doi:10.34133/2020/1081540](https://doi.org/10.34133/2020/1081540) 🟢 ★★ · 방사선 없이 골 대사 정보를 얻는 임상 실현가능성 연구 |
| **광음향 + 골 조성** | **Photoacoustic characterization of bone physico-chemical information** — [PMC9203098](https://pmc.ncbi.nlm.nih.gov/articles/PMC9203098/) 🟢 ★★ · 다파장 측정으로 무기질·지질·헤모글로빈 상대량 추정 |
| **OCT + 연골/관절** | **High-resolution optical coherence tomographic imaging of osteoarthritic cartilage during open knee surgery** — [PMC1065329](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1065329/) 🟢 ★★ · 관절경 OCT로 초기 골관절염의 콜라겐 배열 변화 관찰 |
| **골 대사 + AI** | **AI and ML in the Diagnosis and Management of Osteoporosis: A Comprehensive Review**, *Medicina* — https://www.mdpi.com/1648-9144/62/1/27 🟢 ★★ |
| **근골격 영상 AI** | **AI in musculoskeletal radiology: practical aspects and latest perspectives**, *BJR Open* 7 (2025) — https://academic.oup.com/bjro/article/7/1/tzaf029/8317543 🟢 ★★ |
| **뼈 + 미세유체** | **Bone-on-a-Chip: Biomimetic Models Based on Microfluidic Technologies**, *ACS Biomater Sci Eng* 9:3058 (2023) — [doi:10.1021/acsbiomaterials.3c00066](https://doi.org/10.1021/acsbiomaterials.3c00066) 🟡 ★★ |
| **뼈 + 미세유체 (최신)** | **Advances in the Construction and Application of Bone-on-a-Chip**, *J Biomed Mater Res B* (2024) — [doi:10.1002/jbm.b.35502](https://doi.org/10.1002/jbm.b.35502) 🟡 ★★ |
| **미세유체 + AI** | **Microfluidics with Machine Learning for Biophysical Characterization of Cells**, *Annu Rev Anal Chem* — [열람](https://www.annualreviews.org/content/journals/10.1146/annurev-anchem-061622-025021) 🟡 ★★★ |

---

## 7. 14주 상호학습 운영안

한 주 90분. **발표자 2명(서로 다른 트랙)** + 전원 사전 읽기. 발표자는 매주 로테이션.
**Track E를 맨 앞에 둔 이유**: 데이터가 어디서 오는지를 먼저 공유해야 이후 분석 논의가 헛돌지 않습니다.

| 주 | 트랙 | 자료 | 산출물 |
|---|---|---|---|
| 1 | 공통 | How to Read a Paper + Noble 2009 + 커맨드라인 10 rules | 각자 프로젝트 폴더 구조 만들어 오기 |
| 2 | **E** | **손정호 선생님 EMR 화면 워크스루** + Agniel 2018 | 한 환자의 데이터 생성 경로 다이어그램 1장 |
| 3 | **E** | Weiskopf & Weng 2013 + Kahn 2016 + 보건의료데이터 활용 가이드라인 | 관심 코호트의 **조건식** 초안 + 가명처리 계획 |
| 4 | **E** | Goldstein 2017 + The Book of OHDSI (4장) + MIMIC-IV | PhysioNet 계정 신청, MIMIC-IV 첫 쿼리 |
| 5 | A | Conesa 2016 | 파이프라인 다이어그램 1장 |
| 6 | A | Luecken & Theis 2019 | 공개 데이터 1건으로 QC까지 재현 |
| 7 | A | Eraslan 2019 | "우리 데이터에 DL을 쓴다면" 1쪽 제안 |
| 8 | B | Topol 2019 + Rajpurkar 2022 | 임상 문제 후보 3개 도출 (E트랙 코호트와 연결) |
| 9 | B | Kelly 2019 + Ghassemi 2021 | 찬반 토론 (2팀) |
| 10 | B | Moor 2023 + TRIPOD+AI / CLAIM | 우리 과제를 체크리스트로 자가 점검 |
| 11 | C | Aumann 2019 (OCT 원리) + De Fauw 2018 | 우리가 접근 가능한 광학 장비의 해상도·침투깊이 표 |
| 12 | C | Wang & Yao 2016 + Deng 2021 + Barbastathis 2019 | k-Wave로 순방향 시뮬레이션 → 재구성 비교 |
| 13 | D | Whitesides 2006 + Convery 2019 + Squires & Quake | 채널 설계 스케치 + Re·확산시간 계산 |
| 14 | 교차 | 광음향 + 뼈 (Annu Rev 2023) + Bone-on-a-Chip 2023 | **5트랙 융합 과제 제안서 1쪽** |

### 발표 형식 (10분 규칙)
1. 이 논문이 없앤 문제는 무엇인가 (1분)
2. 핵심 방법 — 그림 1개로 (3분)
3. 가장 중요한 결과 그림 1개와 그 한계 (3분)
4. 우리 실험실에 적용한다면 (2분)
5. 내가 이해 못 한 것 1가지 — 반드시 말하기 (1분)

### 평가 체크리스트
- [ ] 방법의 가정을 한 문장으로 말할 수 있는가
- [ ] 대조군/검증셋이 무엇인지 지적할 수 있는가
- [ ] **이 데이터가 어떻게 생성되었는지 말할 수 있는가** ← Track E 이후 추가
- [ ] 결과가 뒤집히려면 무엇이 사실이어야 하는지 말할 수 있는가
- [ ] 다른 트랙 학생이 알아듣게 설명했는가 ← **상호학습의 실제 목표**

---

## 8. 접근이 막힐 때
- 대학 도서관 프록시(고려대) 경유 → 대부분의 🟡 논문 열람 가능
- PubMed Central: https://www.ncbi.nlm.nih.gov/pmc/ (PMC 무료본 확인)
- Unpaywall / Europe PMC로 저자 공개본(arXiv, bioRxiv) 탐색 — C트랙 10·11·13번은 arXiv에 무료본이 있습니다
- 그래도 없으면 교신저자에게 메일 — 학생 신분이면 회신율이 높습니다
