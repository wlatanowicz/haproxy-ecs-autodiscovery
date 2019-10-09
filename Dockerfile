FROM haproxy:1.9-alpine

RUN apk add python3
RUN pip3 install jinja2==2.10.3

COPY run.sh /run.sh
COPY config.j2 /config.j2
COPY config.py /config.py

RUN chmod 0744 /run.sh

WORKDIR /
CMD ["/run.sh"]
