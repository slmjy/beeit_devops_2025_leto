FROM ubuntu

# update aktualizuje balicky z ubuntu a instaluje (y-yes), ip prikazy, sitove utilky, 
# zk nastroje linuxu 
RUN apt update && apt install -y iproute2 net-tools sudo coreutils

COPY linux_cli.sh .

RUN chmod +x linux_cli.sh 

ENTRYPOINT ["./linux_cli.sh"]

