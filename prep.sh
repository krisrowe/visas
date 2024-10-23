gcloud iam service-accounts create visasproxy --display-name "Visas Proxy Service Account" --project=gen-ai-stuff

gcloud projects add-iam-policy-binding gen-ai-stuff \
    --member "serviceAccount:visasproxy@gen-ai-stuff.iam.gserviceaccount.com" \
    --role "roles/aiplatform.user"
