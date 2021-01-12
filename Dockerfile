FROM vcxpz/baseimage-alpine-arr

# set version label
ARG BUILD_DATE
ARG RADARR_RELEASE
LABEL build_version="Radarr version:- ${RADARR_RELEASE} Build-date:- ${BUILD_DATE}"
LABEL maintainer="hydaz"

# environment settings
ARG RADARR_BRANCH
ENV XDG_CONFIG_HOME="/config/xdg"

RUN set -xe && \
   echo "**** install build packages ****" && \
   apk add --no-cache --virtual=build-dependencies \
      curl && \
   echo "**** install radarr ****" && \
   mkdir -p /app/radarr/bin && \
   curl -sSL https://raw.githubusercontent.com/hydazz/scripts/main/docker/archer.sh | bash && \
   curl -o \
      /tmp/radarr.tar.gz -L \
      "https://radarr.servarr.com/v1/update/${RADARR_BRANCH}/updatefile?version=${RADARR_RELEASE}&os=linuxmusl&runtime=netcore&arch=${IMGARCH}" && \
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
