# Next Session Prompt — M0 Foundation / Fit3 Technical Feasibility

Fitapp 다음 세션 시작.

Repository:
https://github.com/chayobi03-cyber/Fitapp.git

Target Device:
Samsung Galaxy Fit3

## Session Purpose
M0 Foundation을 진행하고, M1 Product Definition 진입에 필요한 기술 feasibility를 확보한다.

## 0. Git Gate
먼저 다음을 확인한다.
- Repository가 canonical URL과 일치하는가
- Branch / HEAD / remote / working tree
- 최근 commit
- 현재 변경 파일
- upstream 관계

현재 기본 branch에 직접 작업하지 않고 feature branch를 사용하는 것을 기본으로 한다.

## 1. Project State
- Project Constitution v1.1 확인
- 현재 milestone 확인
- 이전 Lesson Learned 확인
- 미완료 Action Item 확인

## 2. Research
Samsung 공식 문서를 우선하여 다음을 조사한다.
- Galaxy Fit3 공식 개발/연계 가능 범위
- Samsung Health Data SDK 지원 범위
- Fit3에서 수집 가능한 데이터
- 데이터 접근 권한과 제약
- Android 요구 버전 및 Samsung Health 요구사항
- Fit3 직접 제어 가능 범위
- Galaxy Wearable 연계 가능 범위
- BLE/비공식 접근의 필요성 여부

그 다음 실제 구현 사례, GitHub 오픈소스, 논문/기술자료를 조사한다.

## 3. Evidence Rule
각 기능은 반드시 다음 중 하나로 판정한다.
SUPPORTED / NOT_SUPPORTED / UNKNOWN / UNVERIFIED / REQUIRES_UNOFFICIAL_METHOD

다른 Galaxy Watch/Fit 기기의 기능을 Fit3 지원 근거로 사용하지 않는다.

## 4. Deliverables
- Project State
- Git State
- Research Findings
- Fit3 Technical Constraints
- Feature Feasibility Matrix
- MVP 후보
- Risk Register
- M0 Entry/Exit Criteria
- M1 Entry Criteria
- 초기 Acceptance Criteria
- 최소 Harness Plan
- Decision Log

## 5. Implementation Rule
기술 feasibility가 충분히 확인되기 전에는 대규모 구현을 시작하지 않는다.

구현이 필요한 경우에도 최소 proof-of-concept부터 시작하고,
BUILD / TESTED / DEVICE_TESTED / USER_VALIDATED를 구분한다.

## 6. Session Close
세션 종료 시 결과, evidence, 문제/RCA, 재검증, Lesson Learned, 자동화 가능 항목, ROI 개선사항, Risk, Action Item을 정리하고 다음 Session Prompt를 갱신한다.
