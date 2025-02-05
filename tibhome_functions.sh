#!/bin/bash

DOCKER_PATH="/usr/bin/docker"

THROW_ERROR=""
BOLD_GREEN='\e[1;32m'
BOLD_RED='\e[1;31m'
BOLD_YELLOW='\e[1;33m'
TXT_RESET='\e[0m'

function log_error {
    echo -e -n "${BOLD_RED}" && echo -e "$*" && echo -e -n "${TXT_RESET}"
    exit 1
}
function log_warn {
    echo -e -n "${BOLD_YELLOW}" && echo -e "$*" && echo -e -n "${TXT_RESET}"
}
function log_succe {
    echo -e -n "${BOLD_GREEN}" && echo -e "$*" && echo -e -n "${TXT_RESET}"
}
function log {
    echo -e -n "${TXT_RESET}" && echo -e "$*" && echo -e -n "${TXT_RESET}"
}

showUsage(){
cat << EOF

DESCRIPTION:
  This script permits to deploy docker component.

USAGE:
  $(basename "$0") [start|stop|restart|remove|log]

OPTIONS:
  --help                        Show this help message and exit.
  --start                       Start container.
  --stop                        Stop container.
  --restart                     Restart container.
  --remove                      Remove container.
  --log                         Logs container.

EOF
}

stop_container(){
    ${DOCKER_PATH} stop ${SERVICE_NAME}

    log_succe "Container ${SERVICE_NAME} stopped"
}

restart_container(){
    stop_container
    remove_container
    start_container
}

remove_container(){
    ${DOCKER_PATH} rm --force ${SERVICE_NAME}

    log_succe "Container ${SERVICE_NAME} removed"
}

logs_container(){
    ${DOCKER_PATH} logs ${SERVICE_NAME} || \
    log_error "Logs container ${SERVICE_NAME} failed"
}

main(){

######################
### MAIN
######################
if [[ -z $1 ]]; then
    echo "[ERROR] No parameters find."
    showUsage
    exit 1
fi
case $1 in
    --help)
    showUsage
    exit 0
    ;;
    --start)
    start_container
    ;;
    --stop)
    stop_container
    ;;
    --restart)
    restart_container
    ;;
    --remove)
    remove_container
    ;;
    --log)
    logs_container
    ;;
    *)
    echo "[ERROR] No such option: '$1'"
    showUsage
    exit 1
    ;;
esac
shift

}