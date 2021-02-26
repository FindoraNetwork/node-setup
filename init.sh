#!/bin/sh


sudo apt update
sudo apt install docker.io
sudo apt install docker-compose

cd /srv
git clone https://github.com/FindoraNetwork/node-setup.git
cd /node-setup
# init the tendermint
sudo mkdir -p /mnt/data/tendermint
sudo mkdir -p /mnt/data/ledger/
sudo chown 100 /mnt/data/tendermint
sudo chmod 0770 /mnt/data/tendermint
sudo docker run -it --rm -v "/mnt/data/tendermint:/tendermint" tendermint/tendermint:v0.33.1 testnet --o mainnet --n 1 --v 0

# rm /mnt/data/tendermint/mainnet/node0/config/config.toml
sudo cp config.toml /mnt/data/tendermint/mainnet/node0/config/config.toml

# rm /mnt/data/tendermint/mainnet/node0/config/genesis.json
sudo cp genesis.json /mnt/data/tendermint/mainnet/node0/config/genesis.json

# rm /mnt/data/tendermint/mainnet/node0/data/priv_validator_state.json
sudo cp priv_validator_state.json /mnt/data/tendermint/mainnet/node0/data/priv_validator_state.json

docker-compose up -d