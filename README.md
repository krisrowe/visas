# Purpose

Offers a reference implementation and setup guide for integrating Apigee with Vertex AI, aimed at creating a user-friendly, domain-specific API for efficiently embedding AI models into user-facing applications. It includes the Apigee proxy configuration, which facilitates secure access to the model beyond an organization’s GCP environment, allowing for interactions across organizational boundaries. The API features a simplified interface and provides clear, intuitive request and response structures that align with public sector use cases rather than just technology platforms. Additionally, this repository includes the dataset used to train the AI regression model, along with scripts for environment setup and API testing. It serves as a template that works out of the box, ready to be adapted for other use cases, allowing developers to leverage Apigee for managing and customizing APIs for AI models deployed on Vertex AI or to rapidly demonstrate these Google Cloud products for public sector applications.

# U.S. Visa Application Decision Prediction

Employs a regression model to predict how many days it will take to get a decision on a U.S. immigration visa application.

# Command-Line Demo

1. Clone this repo
2. Deploy the proxy (see zip file) to Apigee
3. Edit `test.sh` and change `LB_EXTERNAL_IP` env var for your Apigee environment
3. Edit `test.sh` and change `ENDPOINT_ID` and `PROJECT_ID` for your Vertex AI environment
3. Run `chmod +x test.sh`
4. Run `./test.sh` 

# Postman Demo

1. Import the .json workspace into Postman 
2. Get an auth token to go direct to Vertex AI: `gcloud auth print-access-token`
3. Update the bearer token in Postman
4. Show the direct call to Vertex AI and its input and output complexity
5. Show the direct call to Apigee and its input and output simplicity

