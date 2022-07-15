#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later

# build - Database builder.

# Copyright (C) 2021-2022 Sergio Chica Manjarrez @ pervasive.it.uc3m.es.
# Universidad Carlos III de Madrid.

# This file is part of CVEScannerV2DB.

# CVEScannerV2DB is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# CVEScannerV2DB is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with GNU Emacs.  If not, see <https://www.gnu.org/licenses/>.


NC="\033[0m"
RED="\033[0;91m"
GREEN="\033[0;92m"
BLUE="\033[94m"
YELLOW="\033[0;33m"

ERROR="$RED[!]$NC"
SUCC="$GREEN[+]$NC"
INFO="$BLUE[*]$NC"
WARN="$YELLOW[-]$NC"

OUTPUT="cve.db"
REM=0


disable_colors ()
{
    NC="" RED="" GREEN="" BLUE="" YELLOW=""
    ERROR="$RED[!]$NC"
    SUCC="$GREEN[+]$NC"
    INFO="$BLUE[*]$NC"
    WARN="$YELLOW[-]$NC"
}


pkg_info ()
{
    if [ $# -eq 1 ]; then
        echo -ne "$INFO $1... \r"
    else
        if [ $2 -eq 0 ]; then
            echo -e "$SUCC $1...$GREEN installed$NC"
        else
            echo -e "$ERROR $1...$RED missing$NC"
        fi
    fi
}



check_packages ()
{
    echo -e "$INFO Checking packages."
    installed=0

    pkg=sqlite3
    command -v $pkg > /dev/null 2>&1
    [[ $? -eq 0 ]] \
        && pkg_info $pkg 0 \
            || { pkg_info $pkg 1; installed=1; }

    if [ $installed -ne 0 ]; then
        echo -e "$ERROR Mandatory package is missing."
        exit 1
    fi
}

build ()
{
    echo -e "$INFO Building database $OUTPUT."

    if [ $REM -eq 1 ]; then
        rm $OUTPUT > /dev/null 2>&1
    fi
    sqlite3 $OUTPUT < schema.sql

    suffix=_reading

    for i in $(ls data_*.sql); do
        sed '1s/^/PRAGMA journal_mode = OFF;\nPRAGMA synchronous = OFF;\n/' $i > $i$suffix
        sqlite3 $OUTPUT ".read $i$suffix" > /dev/null
        rm $i$suffix
    done
}


usage ()
{
    echo "Usage: $0 [FLAG] [-o|--output output_name]"
    echo "    -h, --help          Show this help."
    echo "    -o, --output        Output database. Default: cve.db."
    echo "FLAGS:"
    echo "    --no-color     Disable colors."
    echo "    --remove       Remove database if present."
    echo
    exit
}


while [[ $# -gt 0 ]]; do
    key=$1
    case "$key" in
        --no-color)
            disable_colors
            shift
            ;;
        --remove)
            REM=1
            shift
            ;;
        -o|--output)
            OUTPUT=$2
            shift
            shift
            ;;
        *) usage ;;
    esac
done

check_packages
build
