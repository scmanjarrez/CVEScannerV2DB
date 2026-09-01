FROM scmanjarrez/cvescanner:nodb
COPY cve.db /CVEScannerV2
WORKDIR /CVEScannerV2
ENTRYPOINT ["nmap", "--script", "cvescannerv2", "-sV"]
