#!/bin/bash

THROW_ERROR=0
BOLD_G='\e[1;32m'
BOLD_R='\e[1;31m'
BOLD_Y='\e[1;33m'
TEXT_0='\e[0m'

# Log a title with a decorative border
# Parameters: $* (title text)
function log_title {
    echo ""
    echo -e -n "${TEXT_0}"
    echo "##########################################################################"
    echo -e "$*"
    echo "##########################################################################"
    echo -e -n "${TEXT_0}"
    echo ""
}

# Log an error message with a timestamp
# Parameters: $* (error message)
function log_error {
    echo -e -n "${BOLD_R}" && echo -e "$(date -u +"%Y-%m-%dT%H:%M:%S") - $*" && echo -e -n "${TEXT_0}"
    THROW_ERROR=1
}

# Log a warning message with a timestamp
# Parameters: $* (warning message)
function log_warn {
    echo -e -n "${BOLD_Y}" && echo -e "$(date -u +"%Y-%m-%dT%H:%M:%S") - $*" && echo -e -n "${TEXT_0}"
}

# Log a success message with a timestamp
# Parameters: $* (success message)
function log_succe {
    echo -e -n "${BOLD_G}" && echo -e "$(date -u +"%Y-%m-%dT%H:%M:%S") - $*" && echo -e -n "${TEXT_0}"
}

# Log a general message with a timestamp
# Parameters: $* (message)
function log {
    echo -e -n "${TEXT_0}" && echo -e "$(date -u +"%Y-%m-%dT%H:%M:%S") - $*" && echo -e -n "${TEXT_0}"
}

# Check if required variables are set
# Parameters: $* (list of variable names)
function checking_variables() {
    LOCAL_REQUIRED_VARS=${*}
    [ -z "$LOCAL_REQUIRED_VARS" ] && log_error "No variables in parameters."

    for VAR in $LOCAL_REQUIRED_VARS; do
        if [ -z "$(eval echo \$$VAR)" ]; then
            log_error "Variable $VAR is not set." >&2
        else
            log "Variable $VAR is set." >&2
        fi
    done
    [ $THROW_ERROR -eq 1 ] && exit 1
}

# Send an SMS to the admin
# Parameters: $1 (SMS message)
# Env variables SENDER_API_URL ADMIN_PHONES must be set
function send_sms_to_admin() {
    NOTIF_VARS="SENDER_API_URL ADMIN_PHONES"
    for VAR in $NOTIF_VARS; do
        if [ -z "$(eval echo \$$VAR)" ]; then
            return 0
        fi
    done

    SMS_MESSAGE=""
    if [ -n "$1" ]; then
        SMS_MESSAGE=${1}
    else
        log_error "No message define for sms send."
        THROW_ERROR=0
        return 0
    fi

    MESSAGE_NO_SPACES=$(echo "$SMS_MESSAGE" | sed 's/^[ \t]*//')

    http_code=$(
        curl    -s -o /dev/null -w "%{http_code}" \
                --location "${SENDER_API_URL}" \
                --header 'Content-Type: application/x-www-form-urlencoded' \
                --data-urlencode "recipient=${ADMIN_PHONES}" \
                --data-urlencode "message=${MESSAGE_NO_SPACES}"\
        )
    if [ "$http_code" -eq 200 ]; then
        log "[SMS] Sending message to admin success"
    else
        log_error "[SMS] Sending message to admin failed"
        THROW_ERROR=0
    fi
}