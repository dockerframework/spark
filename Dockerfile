FROM openjdk:8-alpine

# ================================================================================================
#  Inspiration: Docker Spark (https://github.com/twang2218/docker-spark)
#               Tao Wang <twang2218@gmail.com>
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

ENV SPARK_VERSION=2.1.0 \
    HADOOP_VERSION=2.7 \
    SPARK_HOME="/usr/local/share/spark"

ENV SPARK_NO_DAEMONIZE=true

RUN set -xe \
  && cd tmp \
  && curl -sSL http://d3kbcqa49mib13.cloudfront.net/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
  && tar -zxvf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
  && rm *.tgz \
  && mkdir -p `dirname ${SPARK_HOME}` \
  && mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} ${SPARK_HOME}


ENV PATH=$PATH:${SPARK_HOME}/sbin:${SPARK_HOME}/bin

WORKDIR ${SPARK_HOME}

# SPARK_MASTER_PORT
EXPOSE 7077
# SPARK_MASTER_WEBUI_PORT
EXPOSE 8080

CMD ["spark-shell"]