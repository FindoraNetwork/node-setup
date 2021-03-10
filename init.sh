#!/bin/sh


sudo apt update
sudo apt -y install docker.io
sudo apt -y install docker-compose


sudo rm -r /mnt/data/tendermint
sudo rm -r /mnt/data/ledger
# init the tendermint
sudo mkdir -p /mnt/data/tendermint
sudo mkdir -p /mnt/data/ledger/
sudo chown 100 /mnt/data/tendermint
sudo chmod 0770 /mnt/data/tendermint
sudo docker run -it --rm -v "/mnt/data/tendermint:/tendermint" tendermint/tendermint:v0.33.1 testnet --o mainnet --n 1 --v 0

sudo cp config/config.toml /mnt/data/tendermint/mainnet/node0/config/config.toml

sudo cp config/genesis.json /mnt/data/tendermint/mainnet/node0/config/genesis.json

sudo cp config/priv_validator_state.json /mnt/data/tendermint/mainnet/node0/data/priv_validator_state.json

sudo docker-compose down
sudo docker-compose up -d