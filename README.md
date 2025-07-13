# MiningCore Docker Setup

## Quick Start
1. Clone this repository
2. Run: `./setup.sh`
3. Start services: `docker-compose up -d`

## Access Points
- WebUI: http://your-ip:3000
- API: http://your-ip:4000
- Dozzle (Logs): http://your-ip:8080

## To update all components in the future:
RUN bash:
CopyInsert
cd /path/to/miningcore-docker
git pull
./update.sh

## Defaul password: P@ssw0rd


## DOCKER Images used:
MiningCore: https://github.com/TheRetroMike/rmt-miningcore.git

Miningcore.WebUI: https://github.com/btclinux/Miningcore.WebUI.git (Docker image not available, created mannualy in yml)
(UPDATE: here is Docker image:https://github.com/warlocksingh/Miningcore.WebUI.git)

webui image: warlocksingh/miningcore.webui

dozzle image: amir20/dozzle

nginx image: nginx:alpine

watchtower image: containrrr/watchtower

Postgres image: postgres

bch-node image: zquestz/bitcoin-cash-node
