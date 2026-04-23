# SmartKartAI Setup Checklist

## 1. Bootstrap the Flutter workspace

```bash
flutter pub get
```

If platform folders are still missing in this repository, generate them once:

```bash
flutter create --platforms=android,ios,web .
```

## 2. Verify environment files

- `.env.dev`
- `.env.qa`
- `.env.prod`

Update the API URLs if your internal backend changes.

## 3. Run the app by flavor

```bash
flutter run -t lib/main_dev.dart
flutter run -t lib/main_qa.dart
flutter run -t lib/main_prod.dart
```

## 4. Validate quality gates

```bash
flutter analyze
flutter test
```

## 5. Immediate next implementation steps

- Connect real JWT refresh contract to your backend if it differs from EscuelaJS
- Add cart, checkout, and order-history modules
- Expand SharedPreferences product cache to cart/session persistence
- Add widget tests after the login and product UI stabilizes
- Add branded theming, icons, and splash assets

