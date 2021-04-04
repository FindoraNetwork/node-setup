#!/bin/sh

echo "Installing docker and docker-compose"
# sudo apt update
# sudo apt -y install docker.io
# sudo apt -y install docker-compose



PS3='Welcome to Findora full node setup tool. Please selet the network: '
options=("Alpha" "Mainnet" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Option 1")
            alpha
            ;;
        "Option 2")
            echo "you chose choice 2"
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done


function alpha()
{
    read -p "Please name the full node:" node_name
    read -p "The path you want to setup the full node(Use absolute path, default /mnt, do not add '/' at the end of the path):" node_path
    if [ -z "$node_path" ];then
        node_path="/mnt"
    fi
    echo "Installing the docker and docker-compose."
    sudo apt update
    sudo apt -y install docker.io
    sudo apt -y install docker-compose
    echo "Docker compose install done."


    # init the tendermint
    sudo mkdir -p $node_path/data/tendermint
    sudo mkdir -p $node_path/data/ledger/
    sudo chown 100 $node_path/data/tendermint
    sudo chmod 0770 $node_path/data/tendermint
    sudo docker run -it --rm -v "$node_path/data/tendermint:/tendermint" tendermint/tendermint:v0.33.1 testnet --o mainnet --n 1 --v 0

    sudo cp config/alpha/config.toml $node_path/data/tendermint/mainnet/node0/config/config.toml
    sed -i'.original' -e "s/CHANGE_NODE_NAME/${moniker}/g" $node_path/data/tendermint/mainnet/node0/config/config.toml

    sudo cp config/alpha/genesis.json $node_path/data/tendermint/mainnet/node0/config/genesis.json

    sudo cp config/alpha/priv_validator_state.json $node_path/data/tendermint/mainnet/node0/data/priv_validator_state.json
    sudo cd config
    sudo docker-compose down
    sudo docker-compose up -d
    echo "Full node for Alpha setup done. "
    echo "Ledger data: /mnt/data/ledger/"
    echo "Tendermint data: /mnt/data/tendermint"
}

function mainnet()
{
    read -p "Please name the full node:" node_name
    read -p "The path you want to setup the full node(Use absolute path, default /mnt, do not add '/' at the end of the path):" node_path
    if [ -z "$node_path" ];then
        node_path="/mnt"
    fi
    echo "Installing the docker and docker-compose."
    sudo apt update
    sudo apt -y install docker.io
    sudo apt -y install docker-compose
    echo "Docker compose install done."

    # init the tendermint
    sudo mkdir -p $node_path/data/tendermint
    sudo mkdir -p $node_path/data/ledger/
    sudo chown 100 $node_path/data/tendermint
    sudo chmod 0770 $node_path/data/tendermint
    sudo docker run -it --rm -v "$node_path/data/tendermint:/tendermint" tendermint/tendermint:v0.33.1 testnet --o mainnet --n 1 --v 0
    
    
    sudo cp config/mainnet/config.toml $node_path/data/tendermint/mainnet/node0/config/config.toml
    sed -i'.original' -e "s/CHANGE_NODE_NAME/${moniker}/g" $node_path/data/tendermint/mainnet/node0/config/config.toml

    sudo cp config/mainnet/genesis.json $node_path/data/tendermint/mainnet/node0/config/genesis.json

    sudo cp config/mainnet/priv_validator_state.json $node_path/data/tendermint/mainnet/node0/data/priv_validator_state.json
    sudo cd config
    sudo docker-compose down
    sudo docker-compose up -d
    echo "Full node for Alpha setup done. "
    echo "Ledger data: /mnt/data/ledger/"
    echo "Tendermint data: /mnt/data/tendermint"
}