# Broke stack

Do not pay for tools until $100/month exists. User already has Cursor plus Apple and Google developer accounts.

| Job | Max used | This factory |
|-----|----------|--------------|
| IDE | Cursor + Claude | Cursor |
| ASO | Astro (paid) | Local clone [`tools/respectaso`](../../../tools/respectaso) + `./tools/.venv/bin/python tools/research_keyword.py`. Optional Mac .dmg or Docker. Fallback: App Store / Play search screenshots |
| Backend | Supabase | None, or Firebase Spark / Supabase free. Prefer on-device + store IAP |
| Paywall | Superwall | RevenueCat Spark (free) or `in_app_purchase` |
| Analytics | Mixpanel | Store dashboards + RevenueCat only |
| AI API | OpenAI / Gemini | Gemini Flash free tier, daily cap, paywall before the call |
| Icon | Gemini + Figma | Gemini + 1024 frame (Figma or Penpot) |
| Ads | Meta after UGC hits | $0. Film 5 TikToks/Reels/Shorts on Sunday |

## Week-1 idea filter

Prefer: identifier, converter, tracker, generator, local utility.

Avoid: chatbots, anything that calls an LLM on every keystroke, marketplaces, social, hardware.

## API spend guard

If the app uses Gemini:

- Entitlement check first
- One image or one short prompt per identify
- Cache by hash of the input
- Hard-fail to a friendly error; never retry storms
- Log count in debug so Wednesday does not burn the free quota

## Free assets every app must have

- Privacy policy + terms on GitHub Pages
- Support email
- Camera / photo usage strings if those permissions exist
- Restore purchases
- Account deletion path only if you create accounts (default: do not create accounts)
