#!/bin/bash

NOM="Debian1"
VBOXMANAGE="/mnt/c/Program Files/Oracle/VirtualBox/VBoxManage.exe"

"$VBOXMANAGE" createvm --name "$NOM" --ostype "Debian_64" --register
"$VBOXMANAGE" modifyvm "$NOM" --memory 4096 --nic1 nat
"$VBOXMANAGE" createmedium disk --filename "$NOM.vdi" --size 65536
"$VBOXMANAGE" storagectl "$NOM" --name "SATA" --add sata --controller IntelAhci
"$VBOXMANAGE" storageattach "$NOM" --storagectl "SATA" --port 0 --device 0 --type hdd --medium "$NOM.vdi"

echo "VM $NOM créée. Vérifiez dans l'interface VirtualBox."
read -p "Appuyez sur Entrée pour détruire la VM..."

"$VBOXMANAGE" unregistervm "$NOM" --delete
echo "VM $NOM détruite."
