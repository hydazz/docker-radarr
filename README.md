## docker-radarr

[![docker hub](https://img.shields.io/badge/docker_hub-link-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/r/vcxpz/radarr) ![docker image size](https://img.shields.io/docker/image-size/vcxpz/radarr?style=for-the-badge&logo=docker) [![auto build](https://img.shields.io/badge/docker_builds-automated-blue?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-radarr/actions?query=workflow%3A"Auto+Builder+CI") [![codacy branch grade](https://img.shields.io/codacy/grade/f0bc44e57131401490bc22ca08aa8629/main?style=for-the-badge&logo=codacy)](https://app.codacy.com/gh/hydazz/docker-radarr)

Fork of [linuxserver/docker-radarr](https://github.com/linuxserver/docker-radarr/)

[Radarr](https://radarr.video/) - A fork of Sonarr to work with movies à la Couchpotato.

## Version Information

![alpine](https://img.shields.io/badge/alpine-edge-0D597F?style=for-the-badge&logo=alpine-linux) ![radarr](https://img.shields.io/badge/radarr-3.0.2.4446-blue?style=for-the-badge)

See [package_versions.txt](package_versions.txt) for a full list of the packages and package versions used in this image

## Usage

    docker run -d \
      --name=radarr \
      -e PUID=1000 \
      -e PGID=1000 \
      -e TZ=Australia/Melbourne \
      -e UMASK_SET=022 `#optional` \
      -e DEBUG=true/false `#optional` \
      -p 7878:7878 \
      -v <path to appdata>:/config \
      -v <path to movies>:/movies \
      -v <path to downloads>:/downloads \
      --restart unless-stopped \
      vcxpz/radarr

[![template](https://img.shields.io/badge/unraid_template-ff8c2f?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-templates/blob/main/hydaz/radarr.xml)

## New Environment Variables

### Debug

| Name    | Description                                                                                              | Default Value |
| ------- | -------------------------------------------------------------------------------------------------------- | ------------- |
| `DEBUG` | set `true` to display errors in the Docker logs. When set to `false` the Docker log is completely muted. | `false`       |

**See other variables on the official [README](https://github.com/linuxserver/docker-radarr/)**

## Upgrading Radarr

To upgrade, all you have to do is pull our latest Docker image. We automatically check for Radarr updates daily so there may be some delay when an update is released to when the image is updated.

## Credits

-   [spritsail/radarr](https://github.com/spritsail/radarr) for the `HEALTHCHECK` command
-   [hotio](https://github.com/hotio) for the `redirect_cmd` function
