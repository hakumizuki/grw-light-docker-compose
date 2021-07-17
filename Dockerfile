FROM weseek/growi:4
# LABEL maintainer Yuki Takei <yuki@weseek.co.jp>
LABEL modified_by Taichi Masuyama <montanha.masu536@gmail.com>

ENV APP_DIR /opt/growi

# install dockerize
ENV DOCKERIZE_VERSION v0.6.1
USER root

RUN set -ex \
    && COMMANDS=" \
    wget \
    " \
    && apt-get update && apt-get install -y --no-install-recommends $COMMANDS \
    && wget --no-check-certificate https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $COMMANDS \
    && rm -rf /var/lib/apt/lists/*

WORKDIR ${APP_DIR}

# install plugins if necessary
# ;;
# ;; NOTE: In GROWI v3 and later,
# ;;       2 of official plugins (growi-plugin-lsx and growi-plugin-pukiwiki-like-linker)
# ;;       are now included in the 'weseek/growi' image.
# ;;       Therefore you will not need following lines except when you install third-party plugins.
# ;;
#RUN echo "install plugins" \
#  && yarn add \
#      growi-plugin-XXX \
#      growi-plugin-YYY \
#  && echo "done."
# you must rebuild if install plugin at least one
# RUN npm run build:prod
