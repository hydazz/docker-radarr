FROM vcxpz/baseimage-alpine-arr:latest

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Radarr version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="hydaz"

# environment settings
ARG BRANCH
ENV XDG_CONFIG_HOME="/config/xdg"

RUN \
   echo "**** install build packages ****" && \
   apk add --no-cache --virtual=build-dependencies \
     curl && \
   echo "**** install radarr ****" && \
   mkdir -p /app/radarr/bin && \
   ARCH=$(curl -sSL https://raw.githubusercontent.com/hydazz/scripts/main/docker/archer.sh | bash) && \
   curl --silent -o \
     /tmp/radarr.tar.gz -L \
     "https://radarr.servarr.com/v1/update/${BRANCH}/updatefile?version=${VERSION}&os=linuxmusl&runtime=netcore&arch=${ARCH}" && \
   tar xzf \
     /tmp/radarr.tar.gz -C \
     /app/radarr/bin --strip-components=1 && \
   printf "UpdateMethod=docker\nBranch=${BRANCH}\n" > /app/radarr/package_info && \
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
