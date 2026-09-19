#!/bin/bash

NOM="Debian1"
VBOXMANAGE="/mnt/c/Program Files/Oracle/VirtualBox/VBoxManage.exe"
# Vérifier si la VM existe déjà, et la supprimer le cas échéant
if "$VBOXMANAGE" list vms | grep -q "\"$NOM\""; then
    echo "La VM $NOM existe déjà, suppression..."
    "$VBOXMANAGE" unregistervm "$NOM" --delete
fi

"$VBOXMANAGE" createvm --name "$NOM" --ostype "Debian_64" --register
"$VBOXMANAGE" modifyvm "$NOM" --memory 4096 --nic1 nat
"$VBOXMANAGE" createmedium disk --filename "$NOM.vdi" --size 65536
"$VBOXMANAGE" storagectl "$NOM" --name "SATA" --add sata --controller IntelAhci
"$VBOXMANAGE" storageattach "$NOM" --storagectl "SATA" --port 0 --device 0 --type hdd --medium "$NOM.vdi"
echo "VM $NOM créée avec succès."
