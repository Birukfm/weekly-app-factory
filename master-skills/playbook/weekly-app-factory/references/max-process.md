# Max's process (Starter Story)

Source: [How I Build — Max](https://www.youtube.com/watch?v=COblC3XvuZo). ~40 apps, ~$36k/month combined. Keyword-first, not product-first. 75% of App Store downloads start from search.

## The 8 steps

1. **Keyword research.** ASO tool. Add the seed phrase. Open competitors. Pull their keywords. Filter out low popularity and high difficulty (~60+). Discard keywords that are already an app's exact name (App Store will not give you that title). Prefer demand where few apps have 100+ ratings and many listings are new.

2. **Boilerplate.** Do not start from a blank project. Reuse onboarding, paywall, settings, premium flag, IAP. Max's SDK is the reason a build takes hours, not weeks.

3. **One short prompt for the core feature.** Example: main screens for camera, gallery, identification, collection, history; wire into the main tab bar; make it compile. Stop. No extra features.

4. **Onboarding then paywall.** Three simple onboarding steps with a changing illustration. Then paywall. Most subscriptions come from this moment. Weekly + yearly. Free trial on weekly. Lifetime instead of yearly for one-shot tools.

5. **Aha → review.** After a successful result (successful API call), show the native review dialog. Never show it on failure.

6. **Visuals.** Small palette. One accent color (ask AI what color fits the category). 1024 icon that depicts the job. Screenshots: study 2–4 top competitors for the **values they highlight**, then use your own style and correct store sizes.

7. **ASO research doc (inspiration only).** During boilerplate, generate: onboarding titles, four paywall feature lines, screenshot headlines. Do not blindly copy. Name, subtitle, and keyword list are **manual**. Description may be AI, natural, keyword-rich. App Store pays little attention to description vs name/subtitle/keywords.

8. **Submit, then fuel.** ASO is the basement. Growth fuel is ads or TikTok/Instagram. Ship to validate. "Make sure your AI slop is just better."

## What we change for this factory

- Flutter, not native Swift-only.
- Local RespectASO at `tools/respectaso/` (`python3 tools/research_keyword.py`) instead of paid Astro.
- RevenueCat Spark / `in_app_purchase` instead of Superwall.
- $0 ads in month 1. Self-filmed UGC on Sunday.
- Gemini Flash with a cap instead of unbounded OpenAI.
- Both App Store and Play Store every Friday.
