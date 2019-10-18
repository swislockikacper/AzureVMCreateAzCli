#Login to Azure Subscription
az login --subscription "SubscriptionId"

#Create Resource Group
az group create --name "vm-test-rg" --location "westeurope"

#List Resource Groups
az group list -o table

#Create Virtual Network and Subnet
az network vnet create --resource-group "vm-test-rg" --name "vnet-to-vm" --address-prefix "10.10.0.0/16" --subnet-name "subnet-to-vm" --subnet-prefix "10.10.1.0/24"

#List Virtual Networks
az network vnet list --o table

#Create public Ip address
az network public-ip create --resource-group "vm-test-rg" --name "vm-test-linux-ip"

#List public Ip addresses
az network public-ip list --o table

#Create Network Security Group
az network nsg create --resource-group "vm-test-rg" --name "vm-test-linux-nsg"

#List Network Security Groups
az network nsg list -o table

#Create Virtual Network Interface and associate with public Ip Address and Network Security Group
az network nic create --resource-group "vm-test-rg" --name "vm-test-linux-nic" --vnet-name "vnet-to-vm" --subnet "subnet-to-vm" --network-security-group "vm-test-linux-nsg" --public-ip-address "vm-test-linux-ip"

#List Virtual Network Interface
az network nic list --o table

#Create Virtual Machine 
az vm create --resource-group "vm-test-rg" --location "westeurope" --name "test-vm" --nics "vm-test-linux-nic" --image "rhel" --admin-username "testadmin" --authentication-type "ssh" --generate-ssh-keys

#List Virtual Machines 
az vm list --o table

#Open port 22 to allow SSH traffic to host
az vm open-port --resource-group "vm-test-rg" --name  "test-vm" --port "22"

#Grab the public Ip of the Virtual Machine
az vm list-ip-addresses --name "test-vm" --o table

#Connect to Virtual Machine
ssh -l testadmin *.*.*.*

#Delete Resource Group
az group delete --name "vm-test-rg" 