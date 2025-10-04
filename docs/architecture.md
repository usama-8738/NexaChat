# NexaChat Architecture Overview

## Project Layout

```
lib/
  src/
    app/            # App bootstrap, routing, dependency graph
    config/         # Environment specific configuration & theming
    core/           # Cross-cutting concerns (constants, errors, logging, network helpers)
    data/           # DTOs, remote/local data sources
    domain/         # Business rules (entities, repositories contracts, use cases)
    features/       # Feature-first presentation layers (widgets, controllers)
    services/       # Platform services (analytics, push, storage, monitoring)
```

## Dependency Flow

- **Presentation (features)** depends on **domain** via use-cases.
- **Domain** depends on repository contracts only.
- **Data** implements repository contracts and talks to remote/local sources.
- **Core/Services** supply cross-cutting utilities consumed by all layers.
- **App/DI** wires everything using Riverpod providers.

```
Presentation -> Domain -> Data -> (Remote | Local)
                  ^
                  │
                Services/Core
```

## Initialization

1. `bootstrap.dart` resolves the runtime `AppConfig`.
2. `initializeApp` prepares storage (Hive) and shared services.
3. `ProviderScope` seeds global providers (`AppConfig`, `Dio`, `NetworkInfo`, etc.).
4. `NexaChatApp` builds the widget tree, reading providers for environment-aware settings.

## Service Registry

| Provider | Responsibility |
|----------|----------------|
| `appConfigProvider` | Runtime configuration (API base, Neon URL, WS endpoints). |
| `networkInfoProvider` | Connectivity status stream. |
| `dioProvider` | Configured HTTP client with logging. |
| `apiClientProvider` | Simple REST wrapper (GET/POST/PUT/DELETE). |
| `secureStoreProvider` | Encrypted key/value storage for secrets & tokens. |
| `analyticsServiceProvider` | Abstraction for analytics sinks (noop for now). |
| `errorReportingServiceProvider` | Error reporting/sentry hook. |
| `pushNotificationServiceProvider` | Push subscription handling. |
| `cloudStorageServiceProvider` | File uploads/downloads. |

## TODO Roadmap

- Implement concrete repository classes in `data/repositories` once backend contracts are finalised.
- Integrate persistence adapters (Hive boxes, Drift tables) to back local caches.
- Hook analytics/push/error services to Firebase, OneSignal, Sentry, etc.
- Flesh out Riverpod feature controllers (`StateNotifier` / `AsyncNotifier`) per screen.
- Define Neon/PostgreSQL schema and migrate via backend service layer.
- Replace noop services with production implementations and expand tests (unit, widget, e2e).

