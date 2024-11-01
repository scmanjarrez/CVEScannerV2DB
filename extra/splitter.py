#!/usr/bin/env python3

# SPDX-License-Identifier: GPL-3.0-or-later

# splitter - Database splitter.

# Copyright (C) 2021-2024 Sergio Chica Manjarrez @ pervasive.it.uc3m.es.
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

from pathlib import Path
from math import log10
import argparse


def generate_splits(args):
    inp = args.input
    pad = int(log10(inp.stat().st_size / 1024 / 1024 / args.size))+1
    idx = 0
    empty = False
    with inp.open() as data:
        while not empty:
            out = Path(f'{args.output}/{inp.stem}_{idx:0{pad}d}{inp.suffix}')
            with out.open('w') as ff:
                while (out.stat().st_size / 1024 / 1024) < args.size:
                    nxt = data.readline()
                    if not nxt:
                        empty = True
                        break
                    ff.write(nxt)
                idx += 1


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Split big sqlite dump into small chunks")

    parser.add_argument('-s', '--size', type=int,
                        default=25,
                        help="Size (MiB). Default: 25")
    parser.add_argument('-i', '--input',
                        type=Path,
                        required=True,
                        help="Input sql to be splitted.")
    parser.add_argument('-o', '--output',
                        default='.',
                        type=Path,
                        help="Output directory. Default: $CWD")
    args = parser.parse_args()

    generate_splits(args)
