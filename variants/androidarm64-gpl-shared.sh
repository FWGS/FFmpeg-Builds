#!/bin/bash
source "$(dirname "$BASH_SOURCE")"/android-install-shared.sh
source "$(dirname "$BASH_SOURCE")"/defaults-gpl-shared.sh
FF_CONFIGURE+=" --disable-programs"
