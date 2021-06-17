    node_name="tPublic"

    echo "Installing the docker and docker-compose."
    sudo apt update
    sudo apt -y install docker.io
    sudo apt -y install docker-compose
    echo "Docker compose install done."


    # init the tendermint
    sudo mkdir -p /mnt/findora-qa01/data/tendermint
    sudo mkdir -p /mnt/findora-qa01/data/ledger/
    sudo chown 100 /mnt/findora-qa01/data/tendermint
    sudo chmod 0770 /mnt/findora-qa01/data/tendermint
    sudo docker run -it --rm -v "/mnt/findora-qa01/data/tendermint:/tendermint" tendermint/tendermint:v0.33.1 testnet --o mainnet --n 1 --v 0

    sudo cp config/qa01/config.toml /mnt/findora-qa01/data/tendermint/mainnet/node0/config/config.toml
    # sed -i'.original' -e "s/CHANGE_NODE_NAME/${node_name}/g" /mnt/findora-qa01/data/tendermint/mainnet/node0/config/config.toml

    sudo cp config/qa01/genesis.json /mnt/findora-qa01/data/tendermint/mainnet/node0/config/genesis.json

    sudo cp config/qa01/priv_validator_state.json /mnt/findora-qa01/data/tendermint/mainnet/node0/data/priv_validator_state.json
    cd config/qa01
    sudo docker-compose down
    sudo docker-compose up -d
    echo "Full node for qa01 setup done. "
    echo "Ledger data: /mnt/findora-qa01/data/ledger/"
    echo "Tendermint data: /mnt/findora-qa01/data/tendermint"