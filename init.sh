sudo apt update 
cd /srv

sudo mkdir -p /mnt/data/tendermint
sudo mkdir -p /mnt/data/ledger/
sudo chown 100 /mnt/data/tendermint
sudo chmod 0770 /mnt/data/tendermint
sudo docker run -it --rm -v "/mnt/data/tendermint:/tendermint" tendermint/tendermint:v0.33.1 testnet --o mainnet --n 1 --v 0
    