## Alpine Edge fork of [linuxserver/docker-radarr](https://github.com/linuxserver/docker-radarr/)
[Radarr](https://radarr.video/) - A fork of Sonarr to work with movies à la Couchpotato.

[![Docker hub](https://img.shields.io/badge/docker%20hub-link-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/repository/docker/vcxpz/radarr) ![Docker Image Size](https://img.shields.io/docker/image-size/vcxpz/radarr?style=for-the-badge&logo=docker) [![Autobuild](https://img.shields.io/badge/auto%20build-daily-blue?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-radarr/actions?query=workflow%3A%22Docker+Update+CI%22)

## Version Information
![alpine](https://img.shields.io/badge/alpine-edge-0D597F?style=for-the-badge&logo=alpine-linux) ![s6overlay](https://img.shields.io/badge/s6--overlay-2.1.0.2-blue?style=for-the-badge) ![radarr](https://img.shields.io/badge/radarr-3.0.1.4284-blue?style=for-the-badge) [![moredetail](https://img.shields.io/badge/more-detail-blue?style=for-the-badge)](https://github.com/hydazz/docker-radarr/blob/main/package_versions.txt)

## Usage
```
docker run -d \
  --name=radarr \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Australia/Melbourne \
  -e UMASK_SET=022 `#optional` \
  -p 7878:7878 \
  -v <path to appdata>:/config \
  -v <path to movies>:/movies \
  -v <path to downloads>:/downloads \
  --restart unless-stopped \
  vcxpz/radarr
```
## Credits
* [spritsail/radarr](https://github.com/spritsail/radarr) for the `HEALTHCHECK` command

## Todo
* Nothing, everything works 🙂
