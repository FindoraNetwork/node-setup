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
