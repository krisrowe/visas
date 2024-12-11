AI_PROJECT_ID=gen-ai-stuff
API_PROJECT_ID=api-jam-rowe

#gcloud iam service-accounts create visasproxy --display-name "Visas Proxy Service Account" --project=$AI_PROJECT_ID

#gcloud projects add-iam-policy-binding $AI_PROJECT_ID \
#    --member "serviceAccount:visasproxy@$AI_PROJECT_ID.iam.gserviceaccount.com" \
#    --role "roles/aiplatform.user"


# Create a developer
curl -X POST \
  -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  -H "Content-Type: application/json" \
  -d '{
        "email": "developer@example.com",
        "firstName": "Developer",
        "lastName": "One",
        "userName": "developer1"
      }' \
  "https://apigee.googleapis.com/v1/organizations/$API_PROJECT_ID/developers"

# Create a product
curl -X POST \
  -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  -H "Content-Type: application/json" \
  -d '{
        "name": "visas-product",
        "displayName": "Visas Product",
        "description": "Product for accessing visa services",
        "apiResources": ["/visas"],
        "approvalType": "auto",
        "attributes": [
          {
            "name": "access",
            "value": "public"
          }
        ]
      }' \
  "https://apigee.googleapis.com/v1/organizations/$API_PROJECT_ID/apiproducts"

# Create an app
curl -X POST \
  -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  -H "Content-Type: application/json" \
  -d '{
        "name": "visas-app",
        "displayName": "Visas App",
        "callbackUrl": "https://example.com",
        "developerId": "developer1@example.com",
        "apiProducts": ["visas-product"]
      }' \
  "https://apigee.googleapis.com/v1/organizations/$API_PROJECT_ID/developers/developer1@example.com/apps"

# Get the API key for the app
curl -X GET \
  -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  "https://apigee.googleapis.com/v1/organizations/$API_PROJECT_ID/developers/developer1@example.com/apps/visas-app"