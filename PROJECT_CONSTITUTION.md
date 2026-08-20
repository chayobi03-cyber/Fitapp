# Galaxy Fit3 개인용 앱 프로젝트
## Project Constitution / Master Operating Prompt v1.1

## 0. PROJECT IDENTITY
- Project: Galaxy Fit3 개인용 앱 개발 프로젝트
- Canonical Repository: `chayobi03-cyber/Fitapp`
- Canonical Git URL: https://github.com/chayobi03-cyber/Fitapp.git
- Default Branch: `main`
- Target Device: Samsung Galaxy Fit3
- Target Host: Android Smartphone

목표는 Galaxy Fit3를 활용하는 개인용 앱을 기획 → 조사 → 설계 → 개발 → 검증 → 실제 사용 → 개선하는 End-to-End 프로젝트를 수행하는 것이다.

## 1. DEVICE SCOPE LOCK
Galaxy Fit3를 목표 기기로 고정한다. 다른 Galaxy Fit/Watch의 기능을 Fit3에 추정 적용하지 않는다.
기능 상태는 `SUPPORTED / NOT_SUPPORTED / UNKNOWN / UNVERIFIED / REQUIRES_UNOFFICIAL_METHOD`로 관리한다.

## 2. APPLICATION SCOPE
모든 기능을 Fit3 자체 기능, Android Companion App, Samsung Health 연계, Galaxy Wearable 연계, Fit3↔Android 통신 중 어느 영역인지 구분한다.
"Android에서 가능"과 "Fit3에서 직접 실행 가능"을 동일하게 취급하지 않는다.

## 3. PROJECT SCOPE BOUNDARY
Agent Factory/Investment 등 다른 프로젝트의 목표를 Fitapp에 전이하지 않는다. 다른 프로젝트의 방법론은 Fitapp 목표 달성에 실제 도움이 되는 범위에서만 재사용한다.

## 4. SOURCE OF TRUTH
Git repository, commit history, CI evidence, governance docs, source, tests/artifacts, 실제 Fit3/Android 검증, 외부 자료, AI 추론 순으로 신뢰한다. 추론만으로 완료 판정하지 않는다.

## 5. GIT SAFETY
모든 세션 시작 시 repository/branch/HEAD/remote/status/recent commits/changed files/upstream을 확인하고 canonical URL을 검증한다. Commit 전 `git status`, `git diff`, 변경범위, 목적, 테스트, secret 여부를 확인한다. 작은 단위의 검증 가능한 commit을 기본으로 한다.

HIGH RISK: force push, reset --hard, rebase, branch 삭제, git clean, remote 변경, history rewrite, secret/credential 변경, destructive operation. 이러한 작업은 HUMAN-IN-THE-LOOP로 처리한다.

## 6. WORKFLOW
RESEARCH → REQUIREMENTS → PLAN → METHODOLOGY → DESIGN → IMPLEMENT → VALIDATE → RCA → FIX → RE-VALIDATE → DEVICE TEST → USER TEST → LESSON LEARNED → IMPROVEMENT

문제 발생 시 원인분석→대책→수정→재검증을 기본으로 하며 중요한 문제는 최소 3회 iteration을 수행한다. 형식적인 반복은 금지한다.

## 7. HARNESS ENGINEERING
중요한 작업은 `Input → Expected Behavior → Test → Execution → Evidence → Decision` 구조로 검증한다. 가능한 경우 unit/integration/UI/static/lint/build/emulator/device/regression/performance/battery/connectivity/installation 검증을 자동화한다.

## 8. OPRO / GEPA
복잡한 과제, 반복 실패, prompt/test/설계 최적화에 선택적으로 적용한다.
`Baseline → Execute → Evaluate → Failure Analysis → Prompt/Method Improvement → Re-run → Compare`
Prompt는 목표, context, acceptance criteria, failure condition, hallucination 방지, evidence, 재현성을 검토한다. 단순 작업에는 과도하게 적용하지 않는다.

## 9. RISK-BASED AUTONOMY
LOW RISK는 Human Over The Loop, MEDIUM RISK는 변경범위/evidence 관리, HIGH RISK는 Human In The Loop이다.
건강 관련 고위험 판단, 실제 배포, 개인정보, secret, 비용, hardware 위험, destructive 작업도 HIGH RISK로 취급한다.

## 10. RESEARCH FIRST / OFFICIAL API FIRST
우선순위: Samsung 공식 문서 → Android/Google 공식 문서 → Samsung SDK/API → 공식 샘플 → 검증된 GitHub → 논문 → 기술자료/커뮤니티.
Fit3 기능은 공식 API/SDK를 최우선으로 한다. 비공식 구현/reverse engineering은 공식 방법으로 불가능한 경우에만 검토하며 유지보수/firmware/보안/라이선스/실사용 위험을 별도 평가한다.

중요 기술결정은 가능하면 `공식 문서 + 실제 구현 사례 + 실행/실기기 검증`의 3-way validation으로 판정한다.

## 11. COMPATIBILITY
Galaxy Fit3 firmware, Android, Samsung Health, SDK/API, permissions, BLE/communication, background execution, battery, display, sensor 제약을 별도로 추적한다. 모르는 것은 UNKNOWN으로 유지한다.

## 12. FEATURE FEASIBILITY
주요 기능은 구현 전에 User Value, Fit3 Compatibility, Official API, Android API, Open Source, Reverse Engineering 필요 여부, Complexity, Maintenance/Security Risk, Validation Difficulty, ROI를 평가한다.
GREEN=공식지원+검증가능, YELLOW=제한/추가검증, ORANGE=비공식 필요, RED=불가능 또는 위험대비 가치 부족.

## 13. ACCEPTANCE / VALIDATION
주요 기능은 구현 전에 Given/When/Then 또는 Input/Expected Output/Failure Condition/Evidence로 Acceptance Criteria를 정의한다.
Validation은 Static → Unit → Integration → Build → Emulator(가능한 경우) → Real Device → Real Usage로 구분한다.
`BUILD ≠ TESTED ≠ DEVICE_TESTED ≠ USER_VALIDATED`

## 14. EVIDENCE / NO FALSE GREEN
중요 판단에는 Git SHA, CI run, test result, log, screenshot, device test, performance/battery measurement, source citation 등의 evidence를 남긴다.
다음 상태를 구분한다: `IMPLEMENTED / TESTED / DEVICE_TESTED / USER_VALIDATED / PARTIAL / BLOCKED / UNKNOWN / UNVERIFIED / NOT_SUPPORTED`.
Evidence가 없으면 COMPLETE/GREEN/STABLE/PRODUCTION READY라고 표현하지 않는다.

## 15. HEALTH DATA / PRIVACY
Samsung Health/Fit3 데이터는 timestamp, timezone, unit, source device, granularity, duplicate/missing, sync delay, aggregation, derived formula를 추적한다.
파생지표는 `Raw Data → Transformation → Formula → Result → Evidence`로 추적한다.
개인정보 최소수집, 데이터 최소저장, local-first 검토, permission 최소화, secret 보호, debug logging 정리를 기본으로 한다.

## 16. BATTERY / RESOURCE GUARD
센서 polling, BLE, background service, periodic sync, notification, location, network, 빈번한 DB 접근은 배터리/리소스 영향과 함께 설계한다. 정확도 향상을 위해 과도한 배터리 소모를 허용하지 않는다.

## 17. ROI / PERSONAL UTILITY
기능은 User Value vs Development Cost vs Maintenance Cost vs Risk로 우선순위를 정한다. 최종 사용자는 프로젝트 소유자 본인이며 실제 반복 사용 가능성이 높은 기능을 우선한다.

## 18. MILESTONES
M0 Foundation
M1 Product Definition
M2 Technical Feasibility
M3 Architecture
M4 MVP
M5 Automated Validation
M6 Real Device Validation
M7 Personal Use Pilot
M8 Optimization
M9 Stable Release
M10 Continuous Improvement

각 milestone은 Goal, Entry Criteria, Tasks, Deliverables, Acceptance Criteria, Evidence, Risks, Exit Criteria를 가진다. 완료는 Exit Criteria 충족으로 판단한다.

## 19. SESSION START
Git 상태 → Project State → Milestone → 이전 결과 → Action Item → Risk/Blocker → Entry/Exit Criteria → 우선순위 → 조사 → 계획 → 실행 → 검증 → RCA/수정/재검증 → evidence → Git review/commit → Lesson Learned → Next Session Prompt 순으로 진행한다.

## 20. SESSION CLOSE
수행한 작업, 완료 task/milestone, evidence, 문제/RCA, 수정/재검증, 잘한 점, 못한 점, 자동화 가능 항목, workflow에 남길 항목, ROI 개선사항, 기술부채, risk, 남은 action item, 다음 milestone 상태, 다음 세션 우선순위를 정리하고 다음 세션용 실행 프롬프트를 생성한다.

## 21. DECISION LOG
중요한 기술 결정은 Decision ID, Date, Problem, Alternatives, Evidence, Chosen Option, Rejected Options, Reason, Risk, Revisit Condition을 기록한다.

## MASTER PRINCIPLE
Research First
Evidence First
Official API First
Fit3 Scope Lock
UNKNOWN is a Valid State
Risk Based Autonomy
Harness Driven Development
Iterative Validation
Real Device Validation
Real User Validation
Continuous Improvement
