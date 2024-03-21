# Description
Repository containing .sql files to build a database compatible with
[CVEScannerV2](https://github.com/scmanjarrez/CVEScannerV2)

# Database creation
## Manual
We recommend the usage of `sqlite3` and the built-in command `.read`

```bash
$ sqlite3 cve.db < extra/schema.sql
$ sqlite3 cve.db
SQLite version 3.44.1 2023-11-02 11:14:43
Enter ".help" for usage hints.
sqlite> .read data_0.sql
sqlite> .read data_1.sql
sqlite> .read data_2.sql
# <repeat for every data_*.sql>
```

## Automated
For your convenience, a shell script `build.sh` is provided automating this process

```bash
$ ./build.sh -h
Usage: ./build.sh [OPTS]
OPTS:
    -h, --help          Show this help.
    -o, --output FILE   Output database. Default: cve.db
    --remove            Remove database if present
```

# License
    CVEScannerV2DB  Copyright (C) 2021-2024 Sergio Chica Manjarrez @ pervasive.it.uc3m.es.
    Universidad Carlos III de Madrid.
    This program comes with ABSOLUTELY NO WARRANTY; for details check below.
    This is free software, and you are welcome to redistribute it
    under certain conditions; check below for details.

[LICENSE](LICENSE)
