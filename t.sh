    node_name="tPublic"

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