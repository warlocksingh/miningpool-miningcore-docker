#!/bin/bash
set -e

echo "Creating necessary directories..."
mkdir -p ./coins/bch
chmod -R 755 ./coins

echo "Setting up BCH node configuration..."
if [ ! -f ./coins/bch/bch.conf ]; then
    cp ./coins/bch/bch.conf ./coins/bch/bch.conf
    chmod 644 ./coins/bch/bch.conf
fi

echo "Setting up nginx configuration..."
mkdir -p ./nginx/config
if [ ! -f ./nginx/config/default.conf ]; then
    cp ./nginx/config/default.conf ./nginx/config/default.conf
fi

echo "Setting up miningcore configurations..."
mkdir -p ./miningcore
[ -f ./miningcore/config.json ] || touch ./miningcore/config.json
[ -f ./miningcore/coins.json ] || touch ./miningcore/coins.json

echo "Cloning Miningcore WebUI..."
mkdir -p ./webui
if [ ! -d "./webui/Miningcore.WebUI" ]; then
    git clone https://github.com/btclinux/Miningcore.WebUI.git ./webui
fi

echo "Setting file permissions..."
chown -R $USER:$USER .
chmod -R 755 ./webui
chmod -R 755 ./nginx
chmod +x *.sh

echo "Setup complete!"
echo "You can now start the services with:"
echo "docker-compose up -d"
