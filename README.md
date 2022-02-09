# Description
Repository containing the .sql files of a semi-updated database
used in [CVEScannerV2](https://github.com/scmanjarrez/CVEScannerV2).

# Database generation
## Automatic
We created a bash script to automate the database creation process.
Run **build.sh** script.

```bash
$ ./build.sh
```

## Manual
If you want to create the database manually, we recommend to use
_sqlite3_ and the built-in command **.read**:

```bash
$ sqlite3 cve.db < schema.sql
$ sqlite3 cve.db
SQLite version 3.35.4 2021-04-02 15:20:15
Enter ".help" for usage hints.
sqlite> .read data_0.sql
sqlite> .read data_1.sql
sqlite> .read data_2.sql
# <repeat for every data_*.sql>
```

# License
    CVEScannerV2DB  Copyright (C) 2022 Sergio Chica Manjarrez @ pervasive.it.uc3m.es.
    Universidad Carlos III de Madrid.
    This program comes with ABSOLUTELY NO WARRANTY; for details check below.
    This is free software, and you are welcome to redistribute it
    under certain conditions; check below for details.

[LICENSE](LICENSE)
