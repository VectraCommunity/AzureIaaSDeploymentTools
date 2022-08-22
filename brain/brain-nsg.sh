#!/bin/bash

rg="<Brain Resource Group>"
ip="<external-ip>"
nsg="<baseName-sg>"
#ip=$(curl ifconfig.co)

az network nsg rule create \
  --resource-group $rg \
  --source-address-prefixes $ip \
  --nsg-name $nsg \
  --protocol tcp \
  --name Alllow22-443 \
  --priority 1000 \
  --destination-address-prefixes VirtualNetwork \
  --destination-port-range 22 443
