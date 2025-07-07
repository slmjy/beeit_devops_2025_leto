
FROM ubuntu:latest

COPY linux_cli.sh .

RUN chmod +x linux_cli.sh && ./linux_cli.sh processinfo

CMD [...] – spustí skript processinfo při docker run


