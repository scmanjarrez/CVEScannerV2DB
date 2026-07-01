#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later

# build - Database builder.

# Copyright (C) 2021-2025 Sergio Chica Manjarrez @ pervasive.it.uc3m.es.
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
# along with this program.  If not, see <https://www.gnu.org/licenses/>.


OUTPUT="cve.db"

usage ()
{
    echo "Usage: $0 [OPTS]"
    echo "OPTS:"
    echo "    -h, --help          Show this help."
    echo "    -o, --output FILE   Output database. Default: $OUTPUT"
    echo "    --remove            Remove database if present"
    exit
}


while [ $# -gt 0 ]; do
    key=$1
    case "$key" in
        --remove)
            REM=1
            shift
            ;;
        -o|--output)
            OUTPUT="$2"
            shift
            shift
            ;;
        *) usage ;;
    esac
done


echo "Checking packages..."
command -v sqlite3 > /dev/null 2>&1
[ $? -eq 0 ] \
    || { echo "Error: package sqlite3 missing" && exit 1; }

echo "Building database $OUTPUT..."

[ -n "$REM" ] && rm -f "$OUTPUT"

TMP=.dump.sql
# Merge dump parts
cat dump.p* > $TMP
# Import the dump
sqlite3 "$OUTPUT" ".read $TMP"

rm -f $TMP
