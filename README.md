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

- log_error : Red print for error and exit program
- log_warn : Yellow print for ward
- log_succe : Green print for success
- log : Standard print

- showUsage
- stop_container
- restart_container
- remove_container
- logs_container
- main