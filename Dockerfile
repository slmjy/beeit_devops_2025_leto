FROM ubuntu

RUN apt update && apt install -y iproute2 net-tools sudo coreutils

COPY linux_cli.sh .

RUN chmod +x linux_cli.sh && ./linux_cli.sh
