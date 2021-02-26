sudo apt update
sudo apt install python3
sudo apt install python3-pip
sudo pip3 install toml
sudo apt install docker.io
sudo apt install docker-compose

cd /srv
git clone https://github.com/FindoraNetwork/node-setup.git

# init the tendermint
sudo mkdir -p /mnt/data/tendermint
sudo mkdir -p /mnt/data/ledger/
sudo chown 100 /mnt/data/tendermint
sudo chmod 0770 /mnt/data/tendermint
sudo docker run -it --rm -v "/mnt/data/tendermint:/tendermint" tendermint/tendermint:v0.33.1 testnet --o mainnet --n 1 --v 0

echo Please enter the name of the node:
read node_name
toml set --toml-path config.toml moniker node_name
cp config.toml /mnt/data/tendermint/mainnet/node0/config/config.toml
cp genesis.json /mnt/data/tendermint/mainnet/node0/config/genesis.json
cp priv_validator_state.json /mnt/data/tendermint/mainnet/node0/data/priv_validator_state.json