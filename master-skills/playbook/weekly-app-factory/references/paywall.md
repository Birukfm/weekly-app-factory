# Paywall

Most paid conversions happen immediately after onboarding. Do not hide the paywall in settings.

## Default offer (multi-use apps)

- Weekly subscription with free trial
- Yearly subscription (no trial, or a shorter trial)
- Close/skip is allowed → limited free mode (1–3 uses, or watermarked/result-capped)
- Restore purchases in settings and on the paywall

## One-shot tools

If people use the app once or twice (identifier they may not reopen), use **lifetime** instead of yearly. Still keep weekly+trial for people who want to try.

## Placement

1. Cold start → onboarding (3 steps) → paywall
2. Core action that needs premium → paywall again if not entitled
3. AI/API calls: check entitlement **before** the network request

## Review dialog

Show native in-app review only after a **successful** aha (result rendered). Never on error, never on first launch, never from the paywall close button.

## Implementation notes (Flutter boilerplate)

- `PremiumController` is the single entitlement source.
- RevenueCat `Purchases` if API keys are present; otherwise a debug override `kDebugPremium` so Wednesday work is not blocked.
- Product IDs live in `lib/config/app_config.dart` and must match App Store Connect + Play Console (created Tuesday).
- Paywall copy: icon, PRO badge, four benefit lines from the ASO note (edited, not pasted), weekly price, yearly/lifetime price, trial callout, restore, legal links.

## What not to do in month 1

- Superwall A/B
- Hard paywall with no skip if it will fail review for the category
- Consumables, credits, gacha
- Different product IDs per platform that the code does not map
