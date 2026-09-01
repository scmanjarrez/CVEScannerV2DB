# Description
Repository containing .sql files to build a database compatible with
[CVEScannerV2](https://github.com/scmanjarrez/CVEScannerV2)

> This repository is force-updated every two weeks, so if you want to keep an
> updated version, you must fetch and force reset, a pull won't be enough
> ```bash
> git fetch
> git reset --hard origin/master
> ```

# Database creation
## Manual
We recommend the usage of `sqlite3` and the built-in command `.read`

```bash
$ cat dump.p* > dump.sql
$ sqlite3 cve.db
SQLite version 3.44.1 2023-11-02 11:14:43
Enter ".help" for usage hints.
sqlite> .read dump.sql
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

# Docker container
There is an action that automatically updates the database, builds and uploads a container
with the database embedded to dockerhub. In addition, the updated database is uploaded
as an artifact ready to be downloaded in the `Actions` tab (check the artifacts section
in the last workflow summary).

The container with the database can be found in DockerHub: `scmanjarrez/cvescanner:db` or `scmanjarrez/cvescanner:latest`

```bash
docker run -v /tmp/cvslogs:/tmp/cvslogs scmanjarrez/cvescanner --script-args log=/tmp/cvslogs/scan.log,json=/tmp/cvslogs/scan.json <TARGET>

docker run -v ./cve.db:/CVEScannerV2/cve.db -v /tmp/cvslogs:/tmp/cvslogs scmanjarrez/cvescanner:nodb --script-args log=/tmp/cvslogs/cvescannerv2.log,json=/tmp/cvslogs/cvescannerv2.json <TARGET>
```

# License
    CVEScannerV2DB  Copyright (C) 2021-2025 Sergio Chica Manjarrez @ pervasive.it.uc3m.es.
    Universidad Carlos III de Madrid.
    This program comes with ABSOLUTELY NO WARRANTY; for details check below.
    This is free software, and you are welcome to redistribute it
    under certain conditions; check below for details.

[LICENSE](LICENSE)
