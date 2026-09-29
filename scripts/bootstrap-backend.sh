#!/usr/bin/env bash
# Creates the Azure resources Terraform needs for remote state (one-time).
set -euo pipefail

LOCATION="${LOCATION:-eastus}"
RG_NAME="${RG_NAME:-rg-lab-tfstate}"
# Must be 3–24 chars, lowercase letters and numbers only, globally unique
SA_NAME="${SA_NAME:-stlabtfstatedev01}"
CONTAINER="${CONTAINER:-tfstate}"

echo "Creating resource group: ${RG_NAME}"
az group create --name "${RG_NAME}" --location "${LOCATION}" --output none

echo "Creating storage account: ${SA_NAME}"
az storage account create \
  --name "${SA_NAME}" \
  --resource-group "${RG_NAME}" \
  --location "${LOCATION}" \
  --sku Standard_LRS \
  --encryption-services blob \
  --output none

echo "Creating blob container: ${CONTAINER}"
az storage container create \
  --name "${CONTAINER}" \
  --account-name "${SA_NAME}" \
  --auth-mode login \
  --output none

echo "Backend ready. Init with:"
echo "  terraform init -backend-config=backends/dev.hcl"
