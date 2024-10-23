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

