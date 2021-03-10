#!/bin/sh

rm -rf ~/.Findora-Node
# init the tendermint
mkdir -p ~/.Findora-Node/data/tendermint/
mkdir -p  ~/.Findora-Node/data/ledger/
# shellcheck disable=SC2164
cd ~
# shellcheck disable=SC2154
docker run -it --rm -v $PWD/.Findora-Node/data/tendermint/:/tendermint tendermint/tendermint:v0.33.1 testnet --o mainnet --n 1 --v 0
#
cd -
#sed -i 's/CHANGE_NODE_NAME/New-Local/g' config/config.toml
cp config/config.toml ~/.Findora-Node/data/tendermint/mainnet/node0/config/config.toml

cp config/genesis.json ~/.Findora-Node/data/tendermint/mainnet/node0/config/genesis.json

cp config/priv_validator_state.json ~/.Findora-Node/data/tendermint/mainnet/node0/data/priv_validator_state.json



docker-compose down
docker-compose up -d