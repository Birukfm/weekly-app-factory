# App boilerplate

Flutter shell for the Weekly App Factory. Clone this folder on Tuesday. Do not start from `flutter create` again.

Flow: 3-step onboarding → paywall (weekly + yearly, skip allowed) → Scan / History / Collection / Settings.

## Tuesday clone

1. Copy this folder to `apps/<kebab-name>/` or a sibling repo.
2. Change `AppConfig` in `lib/config/app_config.dart` (name, URLs, product IDs, seed color, RevenueCat keys).
3. Rename iOS display name, bundle id (`com.weeklyfactory.app_boilerplate`), Android application id and label.
4. Create IAP products in App Store Connect and Play Console with the same IDs.
5. Host `store/privacy.md` and `store/terms.md` on GitHub Pages. Paste the HTTPS URLs into `AppConfig`.
6. Replace Wednesday stubs in `lib/screens/home_shell.dart` with the one feature.

IAP is stubbed: purchases set premium locally so Wednesday is not blocked. Wire RevenueCat when keys exist.

## Debug

Set `AppConfig.debugPremium` to `true` to skip the paywall entitlement check.

## Do not run from the agent

You run `flutter run` / TestFlight / Play yourself.

## Permissions

Add camera and photo usage strings only when Wednesday actually uses them. Unused permissions can fail Play review.
