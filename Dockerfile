FROM ubuntu:latest AS base

# update aktualizuje balicky z ubuntu a instaluje (y-yes), ip prikazy, sitove utilky, 
# zk nastroje linuxu 
RUN apt update && apt install -y iproute2 net-tools sudo coreutils 

COPY linux_cli.sh .

RUN chmod +x linux_cli.sh 

#  test
FROM base AS test

RUN apt-get update \
    && apt-get install -y bats 

    #  spusti unit testy z linux_cli.sh
RUN bats linux_cli.sh
# prod
FROM ubuntu:latest AS prod

# zkopiruju z base do /usr/local/bin

COPY --from=base /linux_cli.sh /usr/local/bin/linux_cli.sh
# prava pro spusteni
RUN chmod +x /usr/local/bin/linux_cli.sh

# pri startu kontejneru se spusti linux_cli.sh
ENTRYPOINT ["./linux_cli.sh"]

# spustim testy: docker-compose build app-test (napr, takhle pojmenuji test)
# prod image: docker-compose build app
# kontejner testy: docker-compose run --rm app-test
# kontejner prod: docker-compose up -d app (d na pozadi)