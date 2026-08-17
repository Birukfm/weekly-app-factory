# Store listing

Name, subtitle, and keyword field are manual. Description may be AI. Do not duplicate a keyword across name, subtitle, and the keyword field.

## App Store

| Field | Rule |
|-------|------|
| Name (30 chars) | Primary keyword. This is what makes ASO work. |
| Subtitle (30 chars) | Second keyword. No words already in the name. |
| Keywords (100 chars, comma-separated) | Remaining relevant terms. No repeats of name/subtitle. Do not pad to 100 with junk. Close-related terms are fine if the category is thin (`appraisal,antique` for a stamp app). |
| Description | Natural sentences, keywords included, not a keyword dump. Store algorithm cares less about this than name/subtitle/keywords. |
| Screenshots | iPhone 6.7" required. First screenshot is the aha. Headline matches a value, not a feature dump. |
| Privacy policy | Public HTTPS URL. Required. |
| IAP | Products attached to the version. Missing IAP is a common Friday fail. |
| Review notes | Test account if you have auth; otherwise explain the aha path in one paragraph. |

## Play Store

| Field | Rule |
|-------|------|
| Title (30 chars) | Same primary keyword. |
| Short description (80 chars) | Subtitle equivalent. |
| Full description | Same as iOS description, plus Play-specific line if needed. |
| Screenshots | Phone, 1080x1920 or similar portrait. |
| Data safety | Be honest: photos, identifiers, purchase history, crash logs. |
| Content rating questionnaire | Complete Tuesday or Friday morning, not at 11pm. |

## Required legal pages (every app)

Clone from `app-boilerplate/store/`:

- Privacy policy (what data, photos/camera, IAP, third parties: RevenueCat, Gemini if used)
- Terms
- Support email
- Account deletion statement if you collect accounts (Apple)

Host on GitHub Pages. One URL per app, or one studio page with an app dropdown. HTTPS only.

## Friday submit blockers (fix same day)

- Encryption / ITSAppUsesNonExemptEncryption
- Missing usage strings: `NSCameraUsageDescription`, `NSPhotoLibraryUsageDescription`
- Privacy nutrition labels vs actual SDKs
- IAP not cleared for sale
- Incomplete Play Data safety
- Screenshots wrong size
