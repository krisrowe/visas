// Assuming 'targetResponse' is your input JSON
var targetResponse = context.proxyResponse.content.asJSON;

// Extract prediction values and round to nearest integer
var lowerBound = Math.round(targetResponse.predictions[0].lower_bound);
var estimated = Math.round(targetResponse.predictions[0].value);
var upperBound = Math.round(targetResponse.predictions[0].upper_bound);

// Construct the new response object
var transformedData = {
  "days": {
    "estimated": estimated,
    "min": lowerBound,
    "max": upperBound
  }
};

// Set the transformed data as the new proxy response body
context.proxyResponse.content.asJSON = transformedData;