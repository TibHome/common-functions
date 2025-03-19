# common-functions
Common BASH functions for HomeLab TibHome

## Installation

```bash
export FUNCTION_VERSION=main

sudo curl -o /usr/local/bin/tibhome_common_functions \
    -L https://raw.githubusercontent.com/TibHome/common-functions/refs/heads/${FUNCTION_VERSION}/tibhome_functions.sh
sudo chmod -X /usr/local/bin/tibhome_common_functions
```

## Quick start

Include this block in top of your bash script.
```bash
source /usr/local/bin/tibhome_common_functions
```

## Capabilities

List of all functions:

- log_title : Standard print for title
- log_error : Red print for error and set `THROW_ERROR` to 1
- log_warn : Yellow print for ward
- log_succe : Green print for success
- log : Standard print

- checking_variables : Check if required variables are set (need variabes list as parameter)
- send_sms_to_admin : Send SMS via **sms-sender-api** (variables needs: `SENDER_API_URL`, `SMS_MESSAGE` and `ADMIN_PHONES`)