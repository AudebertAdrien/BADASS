FROM alpine:latest

RUN apk update && \
    apk add --no-cache frr frr-pythontools tini iproute2 bridge-utils tcpdump

RUN sed -i \
    -e 's/bgpd=no/bgpd=yes/g' \
    -e 's/ospfd=no/ospfd=yes/g' \
    -e 's/isisd=no/isisd=yes/g' \
    /etc/frr/daemons

RUN touch /etc/frr/frr.conf && \
    chown frr:frr /etc/frr/frr.conf && \
    chmod 640 /etc/frr/frr.conf

RUN touch /etc/frr/vtysh.conf && \
    chown frr:frrvty /etc/frr/vtysh.conf && \
    chmod 660 /etc/frr/vtysh.conf

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]
