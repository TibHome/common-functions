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