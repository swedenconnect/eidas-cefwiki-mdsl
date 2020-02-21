FROM debian:stable
RUN apt-get -y update && apt-get -y install libxml2-utils xsltproc wget make
RUN mkdir -p /var/run/mdsl
COPY . /var/run/mdsl
WORKDIR /var/run/mdsl
CMD ["make"]
