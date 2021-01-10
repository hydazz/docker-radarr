FROM vcxpz/baseimage-alpine

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Radarr version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="hydaz"

# environment settings
ARG RADARR_BRANCH
ENV XDG_CONFIG_HOME="/config/xdg"

RUN set -xe && \
   echo "**** install build packages ****" && \
   apk add --no-cache --virtual=build-dependencies \
      curl && \
   echo "**** install runtime packages ****" && \
   apk add --no-cache --upgrade \
      icu-libs \
      libintl \
      libmediainfo \
      sqlite-libs \
      xmlstarlet && \
   echo "**** install radarr ****" && \
   mkdir -p /app/radarr/bin && \
   curl -o \
      /tmp/radarr.tar.gz -L \
      "https://radarr.servarr.com/v1/update/${RADARR_BRANCH}/updatefile?version=${VERSION}&os=linuxmusl&runtime=netcore&arch=x64" && \
   tar xzf \
      /tmp/radarr.tar.gz -C \
      /app/radarr/bin --strip-components=1 && \
   printf "UpdateMethod=docker\nBranch=${RADARR_BRANCH}\n" > /app/radarr/package_info && \
   echo "**** cleanup ****" && \
   apk del --purge \
      build-dependencies && \
   rm -rf \
      /app/radarr/bin/Radarr.Update \
      /tmp/*

# copy local files
COPY root/ /

# radarr healthcheck
HEALTHCHECK --start-period=10s --timeout=5s \
   CMD wget -qO /dev/null 'http://localhost:7878/api/system/status' \
      --header "x-api-key: $(xmlstarlet sel -t -v '/Config/ApiKey' /config/config.xml)"

# ports and volumes
EXPOSE 7878
VOLUME /config
