    "logConfiguration": {
      "logDriver": "splunk",
      "options": {
        "splunk-url" : "${ssm_splunk_url}"
      },
      "secretOptions": [
         {
            "name": "splunk-token",
            "valueFrom": "${ssm_splunk_token}"
         } 
        ]
    }