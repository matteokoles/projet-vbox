#!/bin/bash


NOM="Debian1"

VBoxManage createvm --name "$NOM" --ostype "Debian_64" --register

VBoxManage modifyvm "$NOM" --memory 4096 --nic1 nat

VBoxManage createmedium disk --filename "$NOM.vdi" --size 65536
VBoxManage storagectl "$NOM" --name "SATA" --add sata --controller IntelAhci
VBoxManage storageattach "$NOM" --storagectl "SATA" --port 0 --device 0 --type hdd --medium "$NOM.vdi"

echo "VM $NOM créée. Vérifiez dans l'interface VirtualBox."
read -p "Appuyez sur Entrée pour détruire la VM..."

# Destruction de la VM
VBoxManage unregistervm "$NOM" --delete
echo "VM $NOM détruite."
