#!/bin/bash
source "$(dirname "$BASH_SOURCE")"/androidarm64-gpl-shared.sh
FF_CONFIGURE="--enable-nonfree $FF_CONFIGURE"
