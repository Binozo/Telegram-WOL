# Telegram-Wol 🔥

Boot your devices from anywhere through a Telegram Bot

## Setup

### 1. Setup Docker Compose
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
          telegram-token: [YOUR TOKEN]
        network_mode: host
```

### 2. Add your `devices.json` file:
Example `devices.json` file:
```json
[
  {
    "ip" : "192.168.171.1",
    "mac" : "AA:AA:AA:AA:AA:AA",
    "name" : "Battlestation downstairs"
  },
  {
    "ip" : "192.168.171.2",
    "mac" : "BB:BB:BB:BB:BB:BB",
    "name" : "Potato PC"
  }
]
```