#!/usr/bin/env bash
# build_and_export.sh
# Usage: ./build_and_export.sh <EXT_VERSION> <MODEL_NAME> <EXPORT_DIR>
set -e

EXT_VERSION="${1:?Twinny extension version required}"
MODEL_NAME="${2:-gemma3:1b}"
EXPORT_DIR="${3:-./exported}"
IMAGE_NAME="twinny-ollama"

# Prepare export directory
mkdir -p "${EXPORT_DIR}"

# Build Docker image (preloads the model)
docker build \
  --build-arg MODEL_NAME="${MODEL_NAME}" \
  -t "${IMAGE_NAME}" .

# Save image to tarball
docker save "${IMAGE_NAME}" -o "${EXPORT_DIR}/${IMAGE_NAME}.tar"

# Download Twinny VSIX using Visual Studio Gallery API
VSIX_URL="https://rjmacarthy.gallery.vsassets.io/_apis/public/gallery/publisher/rjmacarthy/extension/twinny/${EXT_VERSION}/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage"
curl -L -fSL -o "${EXPORT_DIR}/twinny.vsix" "${VSIX_URL}"

echo "✔ Exported:"
echo "  • Docker image → ${EXPORT_DIR}/${IMAGE_NAME}.tar"
echo "  • Twinny VSIX     → ${EXPORT_DIR}/twinny.vsix"
