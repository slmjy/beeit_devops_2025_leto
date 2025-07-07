FROM ubuntu:latest

# Nainstaluj bash a dalsie baliky
RUN apt-get update && apt-get install -y bash iproute2 procps coreutils && rm -rf /var/lib/apt/lists/*

# Zkopíruj skript do kontejneru
COPY linux_cli.sh .

# Spustitelná práva
RUN chmod +x linux_cli.sh

# Spusť skript
RUN ./linux_cli.sh -p
