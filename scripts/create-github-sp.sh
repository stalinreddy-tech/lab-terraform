#!/usr/bin/env bash
# Creates an Azure AD app + service principal for GitHub Actions (client secret auth).
# Prerequisites: az login, Owner/User Access Administrator on the subscription.
set -euo pipefail

SP_NAME="${SP_NAME:-sp-lab-terraform-github}"
SUBSCRIPTION_ID="${SUBSCRIPTION_ID:-$(az account show --query id -o tsv)}"
STATE_RG="${STATE_RG:-rg-lab-tfstate}"
SCOPE="/subscriptions/${SUBSCRIPTION_ID}"

echo "Subscription: ${SUBSCRIPTION_ID}"
echo "Creating service principal: ${SP_NAME}"

# Contributor on subscription is enough for this lab (RG + resources).
# Narrow later (e.g. only state RG + app RGs) for better security.
RESULT=$(az ad sp create-for-rbac \
  --name "${SP_NAME}" \
  --role Contributor \
  --scopes "${SCOPE}" \
  --sdk-auth)

CLIENT_ID=$(echo "${RESULT}" | python3 -c "import sys,json; print(json.load(sys.stdin)['clientId'])")
CLIENT_SECRET=$(echo "${RESULT}" | python3 -c "import sys,json; print(json.load(sys.stdin)['clientSecret'])")
TENANT_ID=$(echo "${RESULT}" | python3 -c "import sys,json; print(json.load(sys.stdin)['tenantId'])")

echo
echo "Add these GitHub repo secrets (Settings → Secrets and variables → Actions):"
echo "  AZURE_CLIENT_ID         = ${CLIENT_ID}"
echo "  AZURE_CLIENT_SECRET     = ${CLIENT_SECRET}"
echo "  AZURE_TENANT_ID         = ${TENANT_ID}"
echo "  AZURE_SUBSCRIPTION_ID   = ${SUBSCRIPTION_ID}"
echo
echo "Or with gh CLI:"
echo "  gh secret set AZURE_CLIENT_ID --body '${CLIENT_ID}'"
echo "  gh secret set AZURE_CLIENT_SECRET --body '${CLIENT_SECRET}'"
echo "  gh secret set AZURE_TENANT_ID --body '${TENANT_ID}'"
echo "  gh secret set AZURE_SUBSCRIPTION_ID --body '${SUBSCRIPTION_ID}'"
echo
echo "Ensure state storage exists first: ./scripts/bootstrap-backend.sh"
