ARG SPARK_VERSION=2.1.0
ARG HADOOP_VERSION=2.7
FROM dockerframework/core-base-consul:latest

# ================================================================================================
#  Inspiration: Docker Alpine (https://github.com/bhuisgen/docker-alpine)
#               Boris HUISGEN <bhuisgen@hbis.fr>
# ================================================================================================
#  Core Contributors:
#   - Mahmoud Zalt @mahmoudz
#   - Bo-Yi Wu @appleboy
#   - Philippe Trépanier @philtrep
#   - Mike Erickson @mikeerickson
#   - Dwi Fahni Denni @zeroc0d3
#   - Thor Erik @thorerik
#   - Winfried van Loon @winfried-van-loon
#   - TJ Miller @sixlive
#   - Yu-Lung Shao (Allen) @bestlong
#   - Milan Urukalo @urukalo
#   - Vince Chu @vwchu
#   - Huadong Zuo @zuohuadong
# ================================================================================================

MAINTAINER "Laradock Team <mahmoud@zalt.me>"

ENV SPARK_VERSION=${SPARK_VERSION} \
    HADOOP_VERSION=${HADOOP_VERSION} \
    SPARK_HOME=/usr/local/spark

RUN mkdir -p ${SPARK_HOME} && \
    addgroup -S spark && \
    adduser -S -D -g "" -G spark -s /bin/sh -h ${SPARK_HOME} spark && \
    chown -R spark:spark ${SPARK_HOME}

RUN apk add openjdk8-jre tar && \
    curl -sSL http://d3kbcqa49mib13.cloudfront.net/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz | tar -xzo -C ${SPARK_HOME} --strip-components 1 && \
    apk del tar && \
    rm -rf /var/cache/apk/*

COPY rootfs /

ENTRYPOINT ["/init"]
CMD []
