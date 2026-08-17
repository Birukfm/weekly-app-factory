# Tattoo Meaning

Week 1 factory app. Keyword: **tattoo meaning**. Flutter shell cloned from `app-boilerplate/`.

You run `flutter run` and archive. Agent does not.

## Locked

See [store/WEEK.md](store/WEEK.md).

## Submit timeline (Mon 17 Aug → live target Mon 24 Aug)

Apple and Google often take a few days. The app needs to be **functioning and reviewable today**, submitted **Tuesday or Wednesday**, so review can finish this week.

### Today (Monday) — store + scan are both due now

1. App Store Connect: create app **Tattoo Meaning**, bundle `com.weeklyfactory.tattoomeaning`.
2. IAP: `tattoomeaning_weekly` (weekly auto-renewable + intro trial), `tattoomeaning_yearly`.
3. Play Console: same application id, same product IDs.
4. GitHub Pages: Settings → Pages → Deploy from branch `main`, folder `/docs`. Confirm:
   - https://birukfm.github.io/weekly-app-factory/tattoo-meaning/privacy.html
   - https://birukfm.github.io/weekly-app-factory/tattoo-meaning/terms.html
5. Put a real support email in `lib/config/app_config.dart` (`support@example.com` will get rejected).
6. Archive with a Gemini key so reviewers get a live photo read:
   `flutter build ipa --dart-define=GEMINI_API_KEY=YOUR_KEY`
   Same `--dart-define` for the Play app bundle.
7. Upload TestFlight + Play internal. Paste [store/REVIEW_NOTES.md](store/REVIEW_NOTES.md) into both consoles.

### Tuesday

Device-check the scan → result → history → collection path. Screenshots. Submit for review if the build is on TestFlight.

### Wednesday (hard)

App must be in review. If anything is still broken, fix and resubmit the same day.

## What the binary already does

Onboarding → paywall → Scan (camera or library) → meaning → history → collection. Three free reads, then paywall. IAP uses StoreKit / Play Billing. If Gemini is missing at compile time, reviewers still get an on-device symbolism guide labeled as not a custom photo read.
