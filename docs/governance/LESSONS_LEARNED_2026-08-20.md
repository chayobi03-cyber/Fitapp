# Lessons Learned — 2026-08-20

## Session Scope
Fitapp 프로젝트를 새로 시작하고 Project Constitution v1.1 및 초기 운영 규칙을 정의했다.

## 잘한 것
- Canonical repository를 `https://github.com/chayobi03-cyber/Fitapp.git`로 명시해 다른 프로젝트와의 경계를 고정했다.
- 목표 기기를 Samsung Galaxy Fit3로 명확히 고정했다.
- Android companion app과 Fit3 자체 기능/연계 영역을 분리하도록 규칙화했다.
- Official API First와 UNKNOWN 상태를 명시해 기능 지원을 추정하지 않도록 했다.
- Harness Engineering, Evidence First, Risk Based Autonomy, OPRO/GEPA를 프로젝트 목적에 맞게 적용하도록 정리했다.
- 프로젝트 지침은 ChatGPT용 Compact 규칙과 Git에 보관할 상세 Constitution으로 분리할 수 있는 구조를 확립했다.

## 못한 것 / 제한
- repository가 완전한 empty 상태여서 기존 source, CI, build 환경, 실제 개발 구조를 아직 검증하지 못했다.
- 실기기 검증은 아직 시작하지 않았다.
- MVP 기능은 아직 선정하지 않았다.
- Fit3 기능별 공식 지원 여부에 대한 상세 feasibility matrix는 다음 세션 과제다.

## 자동화 가능한 것
- 세션 시작 Git baseline audit
- repository/branch/remote 검증
- secret scan
- build/lint/test
- CI 기반 evidence 생성
- feature feasibility matrix의 일부 machine-check
- session state / milestone 상태 검증

## Workflow에 반드시 남길 것
- Canonical repository 확인
- Fit3 Scope Lock
- 공식 문서 우선 조사
- UNKNOWN 유지 규칙
- Acceptance Criteria 선행
- Evidence 없는 GREEN 금지
- Device Test와 User Validation 분리
- Commit 전 변경범위 검토

## ROI 높은 개선사항
1. M0에서 공식 API/SDK와 Fit3 데이터 접근 범위를 확정
2. MVP를 고가치/저복잡도 기능으로 제한
3. 최소 Harness를 먼저 구축
4. 실기기 검증 경로를 조기에 확보

## 핵심 Lesson
이번 세션의 가장 중요한 교훈은 "Galaxy Fit에서 가능한 기능"을 일반 Android/Galaxy Watch 지식으로 추정해서는 안 된다는 것이다. Fit3의 실제 지원 여부를 별도 evidence로 검증하고, 모르면 UNKNOWN으로 남겨야 한다.

## Next Session Priority
- Fit3 공식 개발 가능 범위 조사
- Samsung Health Data SDK/API 조사
- Fit3에서 얻을 수 있는 데이터 및 제약 정리
- Fit3 직접 제어/연계 가능 범위 확인
- 오픈소스/논문 조사
- Feature Feasibility Matrix 작성
- MVP 후보 선정
