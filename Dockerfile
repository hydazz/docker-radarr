FROM vcxpz/baseimage-alpine

# set version label
ARG BUILD_DATE
ARG VERSION
ARG RADARR_RELEASE
LABEL build_version="Split of Linuxserver.io version: ${VERSION} Build-date: ${BUILD_DATE}"
LABEL maintainer="hydazz"

# environment settings
ARG RADARR_BRANCH
ARG RADARR_VERSION
ENV XDG_CONFIG_HOME="/config/xdg"

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache \
  curl \
	icu-libs \
  libintl \
	libmediainfo \
  sqlite-libs && \
 echo "**** install radarr ****" && \
 mkdir -p /app/radarr/bin && \
 curl -o \
 /tmp/radarr.tar.gz -L \
  "https://radarr.servarr.com/v1/update/${RADARR_BRANCH}/updatefile?version=${RADARR_RELEASE}&os=linuxmusl&runtime=netcore&arch=x64" && \
 tar xzf \
 /tmp/radarr.tar.gz -C \
  /app/radarr/bin --strip-components=1 && \
 echo "UpdateMethod=docker\nBranch=${RADARR_BRANCH}\nPackageVersion=${VERSION}\nPackageAuthor=linuxserver.io" > /app/radarr/package_info && \
 echo "**** cleanup ****" && \
 rm -rf \
  /app/radarr/bin/Radarr.Update \
  /tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 7878
VOLUME /config
