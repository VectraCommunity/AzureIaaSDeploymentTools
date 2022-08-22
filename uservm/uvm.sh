#!/bin/bash

# Do not modify
key=$(cat ../keys/key.pub)
rg=($(jq -r '.parameters.virtualNetwork.value.resourceGroup' ../shared/params.json))
vnet=($(jq -r '.parameters.virtualNetwork.value.name' ../shared/params.json))

# Create User VMs.  Subnets and names hard coded for lab
az deployment group create --resource-group $rg --template-file ../uservm/simplevm.json --parameters projectName=User-A adminUsername=user adminPublicKey="$key" vnet="$vnet" subnet=SubnetA
az deployment group create --resource-group $rg --template-file ../uservm/simplevm.json --parameters projectName=User-B adminUsername=user adminPublicKey="$key" vnet="$vnet" subnet=SubnetB

# Show Public IPs
echo "Public IP of UVM A"
az vm show --resource-group $rg --name "User-A-vm" --show-details --query publicIps --output tsv
echo "Public IP of UVM B"
az vm show --resource-group $rg --name "User-B-vm" --show-details --query publicIps --output tsv
