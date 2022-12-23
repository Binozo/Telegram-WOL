# Telegram-Wol 🔥

Boot your devices from anywhere through a Telegram Bot

## Setup

### Using Docker compose:
`docker-compose.yaml:`
```yaml
version: "3.9"
services:
    telegram-wol:
        image: ghcr.io/binozo/telegram-wol:latest
        restart: always
        volumes:
          - [YOUR-HOST-PATH]/devices.json:/bin/devices.json
        environment:
          TELEGRAM-TOKEN: [YOUR TOKEN]
        network_mode: host
```