## Setup the full node and connect to the Findora Alpha network

### Introduction
Build a full node in your server and connect to the Findora Alpha network.

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

**IMPORTANT**

**Change the node name in config.toml**

config/config.toml 

line 15-16
```
# A custom human readable name for this node
moniker = "CHANGE_NODE_NAME"
```
Run init.sh
```
. init.sh
```
This script will automaticlly create a full node and connect to the Findora Alpha Network.

### Network
The node should open the port 8667, 8668, 8669 and 26657 to puclib with Security Group in AWS or fire work in GCP

### Troubleshooting
The image now located in AWS north america so the downloading speed in China will be a little bit slow and sometime it will have the handshake issue. If the script get some error in image download, you can just run the script again. 

### Update
This repo will keep updating so run git pull before you run the code.
