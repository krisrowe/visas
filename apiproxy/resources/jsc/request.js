// Get the JSON object from the service response.
var requestData = context.proxyRequest.body.asJSON;

var defaultInstance = { 
    "class_of_admission": "H-1B", 
    "naics_us_code": "541511",
    "naics_us_title": "Custom Computer Programming Services",
    "fw_info_rel_occup_exp": "Y",
    "wage_offer_from_9089": 128831,
    "country_of_citizenship": "INDIA",
    "employer_country": "UNITED STATES OF AMERICA",
    "employer_state": "CA",
    "foreign_worker_info_education": "Bachelor's",
    "foreign_worker_info_state": "CA",
    "fw_info_birth_country": "INDIA",
    "fw_info_req_experience": "Y",
    "job_info_education": "Master's",
    "job_info_experience": "Y",
    "job_info_work_state": "CA",
    "pw_amount_9089": "101,088.00",
    "pw_level_9089": "Level II",
    "pw_soc_code": "15-1132",
    "pw_soc_title": "Software Developers, Applications"
};

// Create anInstance by copying properties from requestData
var anInstance = {};
for (var prop in requestData) {
    anInstance[prop] = requestData[prop];
}

// Update anInstance to set otherwise missing properties using defaultInstance
for (var prop in defaultInstance) {
    if (typeof anInstance[prop] === 'undefined') {
        anInstance[prop] = defaultInstance[prop];
    }
}

// Set the transformed data as the new request body
context.targetRequest.body.asJSON = { "instances": [ anInstance ] };