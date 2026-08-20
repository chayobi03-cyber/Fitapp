# M0-1/M0-2 Fit3 Technical Feasibility

Date: 2026-08-20
Target: Samsung Galaxy Fit3
Status: M0 / PARTIAL

## Architecture decision
Primary product path: Android smartphone companion app reading data stored in Samsung Health.

This is not equivalent to a standalone app installed on Galaxy Fit3.

## Official evidence summary
- Samsung Health Data SDK v1.1.0 supports Android 10+ and Java 17+ and requires Samsung Health 6.30.2+.
- Emulator is not supported.
- Health data access requires explicit user consent.
- Samsung Health data can originate from connected wearables including Galaxy Fit.
- Steps data explicitly lists Galaxy Fit as a possible source device.
- DeviceManager exposes source device metadata including device type, manufacturer, model and name; DeviceGroup includes BAND.
- Samsung Health Sensor SDK targets Wear OS Galaxy Watch4+ and is therefore not a Fit3 implementation path.

## Feature feasibility matrix

| Feature | Status | Evidence | Notes |
|---|---|---|---|
| Read Samsung Health steps on Android | SUPPORTED | Samsung Health Data SDK + Steps Code Lab | Primary POC |
| Galaxy Fit source contributes to Samsung Health steps | SUPPORTED | StepsType documentation | Does not prove direct live Fit3 sensor access |
| Identify source device category | SUPPORTED | DeviceManager / DeviceGroup | BAND exists in SDK |
| Inspect source manufacturer/model/name | SUPPORTED | Device API | Verify on real Fit3 data |
| Read sleep/heart-rate data | SUPPORTED | SDK data types | Actual Fit3 provenance still requires device test |
| Direct Fit3 realtime sensor stream from Android | UNKNOWN | No official Fit3 realtime API identified | Do not infer from Watch SDK |
| Install standalone third-party app on Fit3 | NOT_SUPPORTED | No official application model identified for Fit3 | Product scope excludes this path |
| Samsung Health Sensor SDK on Fit3 | NOT_SUPPORTED | Official Sensor SDK target is Wear OS Galaxy Watch4+ | Not a Fit3 route |
| BLE reverse-engineering access | REQUIRES_UNOFFICIAL_METHOD | No official API path identified | Deferred |

## M0-3 POC acceptance criteria
Given Samsung Health is installed and developer mode is enabled,
When the Android POC starts and requests READ permission for STEPS,
Then the permission state is visible and the app can query today's aggregated steps.

Given Samsung Health contains data from a Galaxy Fit3,
When the POC enumerates BAND source devices,
Then manufacturer/model/name are captured as evidence when exposed by Samsung Health.

Failure conditions:
- Samsung Health missing/outdated
- SDK authorization failure
- permission denied
- no Fit3-originated data available
- device metadata unavailable

Evidence to capture:
- Git SHA
- Android build result
- package name + debug SHA-256
- Samsung Health version
- Android version/device model
- permission result
- queried local start/end timestamps
- step count
- BAND device metadata
- Logcat excerpt

## M0-4/M0-5 decision
Do not claim Fit3 compatibility GREEN until a real Fit3 -> Samsung Health -> POC path is executed on hardware.
