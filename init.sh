#!/bin/sh


function alpha()
{
    read -p "Please name the full node:" node_name

    echo "Installing the docker and docker-compose."
    sudo apt update
    sudo apt -y install docker.io
    sudo apt -y install docker-compose
    echo "Docker compose install done."


    # init the tendermint
    sudo mkdir -p /mnt/findora-alpha/data/tendermint
    sudo mkdir -p /mnt/findora-alpha/data/ledger/
    sudo chown 100 /mnt/findora-alpha/data/tendermint
    sudo chmod 0770 /mnt/findora-alpha/data/tendermint
    sudo docker run -it --rm -v "/mnt/findora-alpha/data/tendermint:/tendermint" tendermint/tendermint:v0.33.1 testnet --o mainnet --n 1 --v 0

    sudo cp config/alpha/config.toml /mnt/findora-alpha/data/tendermint/mainnet/node0/config/config.toml
    sed -i'.original' -e "s/CHANGE_NODE_NAME/${node_name}/g" /mnt/findora-alpha/data/tendermint/mainnet/node0/config/config.toml

    sudo cp config/alpha/genesis.json /mnt/findora-alpha/data/tendermint/mainnet/node0/config/genesis.json

    sudo cp config/alpha/priv_validator_state.json /mnt/findora-alpha/data/tendermint/mainnet/node0/data/priv_validator_state.json
    cd config/alpha
    sudo docker-compose down
    sudo docker-compose up -d
    echo "Full node for Alpha setup done. "
    echo "Ledger data: /mnt/findora-alpha/data/ledger/"
    echo "Tendermint data: /mnt/findora-alpha/data/tendermint"
}

function mainnet()
{
    read -p "Please name the full node:" node_name

    echo "Installing the docker and docker-compose."
    sudo apt update
    sudo apt -y install docker.io
    sudo apt -y install docker-compose
    echo "Docker compose install done."

    # init the tendermint
    sudo mkdir -p /mnt/findora-mainnet/data/tendermint
    sudo mkdir -p /mnt/findora-mainnet/data/ledger/
    sudo chown 100 /mnt/findora-mainnet/data/tendermint
    sudo chmod 0770 /mnt/findora-mainnet/data/tendermint
    sudo docker run -it --rm -v "/mnt/findora-mainnet/data/tendermint:/tendermint" tendermint/tendermint:v0.33.1 testnet --o mainnet --n 1 --v 0
    
    
    sudo cp config/mainnet/config.toml /mnt/findora-mainnet/data/tendermint/mainnet/node0/config/config.toml
    sed -i'.original' -e "s/CHANGE_NODE_NAME/${moniker}/g" /mnt/findora-mainnet/data/tendermint/mainnet/node0/config/config.toml

    sudo cp config/mainnet/genesis.json /mnt/findora-mainnet/data/tendermint/mainnet/node0/config/genesis.json

    sudo cp config/mainnet/priv_validator_state.json /mnt/findora-mainnet/data/tendermint/mainnet/node0/data/priv_validator_state.json
    cd config/mainnet
    sudo docker-compose down
    sudo docker-compose up -d
    echo "Full node for Mainnet setup done. "
    echo "Ledger data: /mnt/findora-mainnet/data/ledger/"
    echo "Tendermint data: /mnt/findora-mainnet/data/tendermint"
}

PS3='Welcome to Findora full node setup tool. Please selet the network: '
options=("Alpha" "Mainnet" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Alpha")
            echo "Setup a full node for Alpha"
            alpha
            ;;
        "Mainnet")
            echo "Setup a full node for Mainnet"
            mainnet
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
    break
done


