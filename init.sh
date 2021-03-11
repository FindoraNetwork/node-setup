#!/bin/sh


if [ $# -eq 0 ]
  then
    echo "Please add Moniker . Use command : ./init [Moniker]"
    exit
fi

if [ -z "$1" ]
  then
    echo "Cannot us empty string as moniker"
    exit
fi

moniker=$1
rm -rf ~/.Findora-Node
docker-compose down

# init the tendermint
mkdir -p ~/.Findora-Node/data/tendermint/
mkdir -p  ~/.Findora-Node/data/ledger/
# shellcheck disable=SC2164
cd ~
# shellcheck disable=SC2154
docker run -it --rm -v $PWD/.Findora-Node/data/tendermint/:/tendermint tendermint/tendermint:v0.33.1 testnet --o mainnet --n 1 --v 0
#
# shellcheck disable=SC2164
# shellcheck disable=SC2103
cd -
# shellcheck disable=SC2016
sed -i'.original' -e "s/CHANGE_NODE_NAME/${moniker}/g" config/config.toml
cp config/config.toml ~/.Findora-Node/data/tendermint/mainnet/node0/config/config.toml

cp config/genesis.json ~/.Findora-Node/data/tendermint/mainnet/node0/config/genesis.json

cp config/priv_validator_state.json ~/.Findora-Node/data/tendermint/mainnet/node0/data/priv_validator_state.json

cp config/config.toml.original config/config.toml
rm config/config.toml.original

docker-compose up -d

