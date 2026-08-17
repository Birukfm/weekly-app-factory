#!/usr/bin/env bash
set -euo pipefail

PROJECT="${FIREBASE_PROJECT:-nojic-factory}"
TOKEN="$(gcloud auth print-access-token)"
BASE="https://firestore.googleapis.com/v1/projects/${PROJECT}/databases/(default)/documents"

put_doc() {
  local collection="$1"
  local id="$2"
  local body="$3"
  curl -sS -X PATCH \
    "${BASE}/${collection}/${id}" \
    -H "Authorization: Bearer ${TOKEN}" \
    -H "Content-Type: application/json" \
    -d "${body}" >/dev/null
  echo "wrote ${collection}/${id}"
}

public_body() {
  local email="$1"
  local role="$2"
  local required="$3"
  local used_json="$4"
  cat <<EOF
{"fields":{
  "email":{"stringValue":"${email}"},
  "role":{"stringValue":"${role}"},
  "requiredThisWeek":{"booleanValue":${required}},
  "usedBy":{"arrayValue":{"values":${used_json}}}
}}
EOF
}

mailbox_body() {
  local email="$1"
  local role="$2"
  local required="$3"
  local used_json="$4"
  cat <<EOF
{"fields":{
  "email":{"stringValue":"${email}"},
  "role":{"stringValue":"${role}"},
  "requiredThisWeek":{"booleanValue":${required}},
  "forwardTo":{"stringValue":"REPLACE_WITH_INBOX"},
  "usedBy":{"arrayValue":{"values":${used_json}}}
}}
EOF
}

seed() {
  local id="$1"
  local email="$2"
  local role="$3"
  local required="$4"
  local used_json="$5"
  put_doc "public_contacts" "${id}" "$(public_body "${email}" "${role}" "${required}" "${used_json}")"
  put_doc "nojic_mailboxes" "${id}" "$(mailbox_body "${email}" "${role}" "${required}" "${used_json}")"
}

used() {
  python3 -c 'import json,sys; print(json.dumps([{"stringValue": x} for x in sys.argv[1:]]))' "$@"
}

seed apps apps@nojic.net store_developer_contact true "$(used app-store-connect play-console)"
seed support support@nojic.net in_app_and_store_support true "$(used tattoo-meaning-settings app-store-connect play-console)"
seed privacy privacy@nojic.net privacy_and_data_requests true "$(used tattoo-meaning-privacy-html play-data-safety)"
seed legal legal@nojic.net terms true "$(used tattoo-meaning-terms-html)"
seed billing billing@nojic.net iap_and_refunds true "$(used tattoo-meaning-terms-html play-payments-profile)"
seed hello hello@nojic.net general_contact false "$(used company-website)"
seed dpo dpo@nojic.net data_protection_officer false "$(used ethiopia-pdpa gdpr-if-eu-users)"
seed tattoomeaning tattoomeaning@nojic.net per_app_filter false "$(used tattoo-meaning)"

echo "seeded public_contacts + nojic_mailboxes on ${PROJECT}"
