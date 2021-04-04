## Setup the full node and connect to the Findora Alpha/Mainnet network

### Introduction
Build a full node in your server and connect to the Findora Alpha/Mainnet network.
Alpha is for the integration and test only.

One instance jusy can deploy one full node now.

### System requirement

#### OS
Linux(Ubuntu), if you use different distribution of Linux, you can change ``` apt install```
 to another package management tools.

#### Application (will install/ by the init.sh script)
Docker 
Docker-compose

### Install
```
# switch to sudo user
sudo su

cd /srv
git clone https://github.com/FindoraNetwork/node-setup.git
cd node-setup
```


Run init.sh
```
. init.sh
```
Follow the isntruction, the script will automaticlly create a full node and connect to the Findora Network.

### Network
The node should open the port 8667, 8668, 8669 and 26657 to puclib with Security Group in AWS or fire work in GCP

### Troubleshooting
The image now located in AWS North America so the downloading speed in China will be a little bit slow and sometime it will have the handshake issue. If the script get some error in image download, you can just run the script again. 

You can also create a temporary user for the vm and ask our engineer to access the VM for trobleshooting.

### Update
This repo will keep updating so run git pull before you run the code.

We will send a notification when the new version release.

The version number located in docker-compose.yml
```
image: "public.ecr.aws/k6m5b6e2/demo/tendermint:latest"
```
The image tag can change to latest for the latest version or a specific version number.

The system can update with the code:
```
cd /srv/node-setup/config/{network-name}
docker-compose down
docker-compose up -d
```