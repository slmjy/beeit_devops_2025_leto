### BASE stage
FROM ubuntu:latest AS base

RUN apt-get update && apt-get install -y bash iproute2 procps coreutils && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY linux_cli.sh .
RUN chmod +x linux_cli.sh

### TEST stage
FROM base AS tests

### PRODUCTION stage
FROM base AS production

# Spusť skript
RUN ./linux_cli.sh -p
