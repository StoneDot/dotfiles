function gimages() {
  local region=$1
  if [ -z "${region}" ]; then
    local region=asia
  fi
  gcloud container images list "--repository=${region}.gcr.io/$(gcloud config get-value project)" | tail +2
}

