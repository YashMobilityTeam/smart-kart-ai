# SmartKartAI

Flutter prototype setup for an internal-team e-commerce application.

## Selected Configuration

- Platforms: Android, iOS, Web
- State management / DI: Riverpod
- Architecture: Clean Architecture
- API: REST (`https://api.escuelajs.co/api/v1`)
- Auth: JWT + `flutter_secure_storage`
- Env flavors: Dev / QA / Prod
- Testing: Unit tests with `mockito + flutter_test`
- CI: GitHub Actions (partial CI)
- Optional features: image handling + keyboard helpers

## Folder Structure

```text
lib/
  core/
    constants/
    errors/
    network/
    router/
    theme/
    utils/
  features/
    auth/
      data/
      domain/
      presentation/
    products/
      data/
      domain/
      presentation/
    cart/
      domain/
      presentation/
  l10n/
  shared/
    providers/
    widgets/
  main.dart
  main_dev.dart
  main_qa.dart
  main_prod.dart
```

## Environment Files

- `.env.dev`
- `.env.qa`
- `.env.prod`

Each includes:

- `API_BASE_URL`
- `APP_NAME`
- `APP_ENV`
- `ENABLE_LOGGING`

## Setup Checklist

1. Install Flutter stable SDK.
2. From the project root, fetch packages:

```bash
flutter pub get
```

3. If this folder does not yet contain generated platform folders, create them in-place:

```bash
flutter create --platforms=android,ios,web .
```

4. Run the dev flavor:

```bash
flutter run -t lib/main_dev.dart
```

5. Run analysis and tests:

```bash
flutter analyze
flutter test
```

## Flavor Commands

```bash
flutter run -t lib/main_dev.dart
flutter run -t lib/main_qa.dart
flutter run -t lib/main_prod.dart
```

## Notes

- The login screen is prefilled with common EscuelaJS prototype credentials for convenience.
- Product loading includes a lightweight SharedPreferences cache fallback for offline reads.
- `lib/l10n/l10n.dart` is intentionally lightweight and compile-safe for this prototype.

## Next Recommended Steps

- Add cart and checkout feature modules
- Expand unit tests to widget tests when the UI stabilizes
- Replace prototype auth defaults with your internal API credentials flow
- Add app icons, splash screens, and brand theme tokens

