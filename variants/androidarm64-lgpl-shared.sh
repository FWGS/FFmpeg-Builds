#!/bin/bash
source "$(dirname "$BASH_SOURCE")"/android-install-shared.sh
source "$(dirname "$BASH_SOURCE")"/defaults-lgpl-shared.sh
FF_CONFIGURE+=" --disable-programs"
