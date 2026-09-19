#!/bin/bash

VBOXMANAGE="/mnt/c/Program Files/Oracle/VirtualBox/VBoxManage.exe"
RAM=4096
TAILLE_DISQUE=65536

ACTION="$1"
NOM="$2"

if [ -z "$ACTION" ]; then
    echo "Erreur : aucun argument fourni."
    echo "Usage : $0 [L|N|S|D|A] [nom_vm]"
    exit 1
fi

case "$ACTION" in
    L)
        "$VBOXMANAGE" list vms | tr -d '\r' > /tmp/liste_vms.txt
        while read -r ligne; do
            nom_vm=$(echo "$ligne" | awk '{print $1}' | tr -d '"')
            createdby=$("$VBOXMANAGE" getextradata "$nom_vm" "createdby" < /dev/null 2>/dev/null | tr -d '\r' | sed 's/^Value: //')
            createdon=$("$VBOXMANAGE" getextradata "$nom_vm" "createdon" < /dev/null 2>/dev/null | tr -d '\r' | sed 's/^Value: //')
            echo "$ligne  (creee par: $createdby le: $createdon)"
        done < /tmp/liste_vms.txt
        ;;
    N)
        if [ -z "$NOM" ]; then
            echo "Erreur : nom de VM manquant pour la creation."
            exit 1
        fi
        if "$VBOXMANAGE" list vms | grep -q "\"$NOM\""; then
            echo "La VM $NOM existe deja, suppression..."
            "$VBOXMANAGE" unregistervm "$NOM" --delete
        fi
        "$VBOXMANAGE" createvm --name "$NOM" --ostype "Debian_64" --register
        "$VBOXMANAGE" modifyvm "$NOM" --memory "$RAM" --nic1 nat
        "$VBOXMANAGE" createmedium disk --filename "$NOM.vdi" --size "$TAILLE_DISQUE"
        "$VBOXMANAGE" storagectl "$NOM" --name "SATA" --add sata --controller IntelAhci
        "$VBOXMANAGE" storageattach "$NOM" --storagectl "SATA" --port 0 --device 0 --type hdd --medium "$NOM.vdi"
        "$VBOXMANAGE" setextradata "$NOM" "createdby" "$USER"
        "$VBOXMANAGE" setextradata "$NOM" "createdon" "$(date +%F)"
        echo "VM $NOM creee avec succes."
        ;;
    S)
        if [ -z "$NOM" ]; then
            echo "Erreur : nom de VM manquant pour la suppression."
            exit 1
        fi
        "$VBOXMANAGE" unregistervm "$NOM" --delete
        if [ $? -ne 0 ]; then
            echo "Erreur lors de la suppression de $NOM."
            exit 1
        fi
        echo "VM $NOM supprimee."
        ;;
    D)
        if [ -z "$NOM" ]; then
            echo "Erreur : nom de VM manquant pour le demarrage."
            exit 1
        fi
        "$VBOXMANAGE" startvm "$NOM" --type headless
        if [ $? -ne 0 ]; then
            echo "Erreur lors du demarrage de $NOM."
            exit 1
        fi
        echo "VM $NOM demarree."
        ;;
    A)
        if [ -z "$NOM" ]; then
            echo "Erreur : nom de VM manquant pour l'arret."
            exit 1
        fi
        "$VBOXMANAGE" controlvm "$NOM" poweroff
        if [ $? -ne 0 ]; then
            echo "Erreur lors de l'arret de $NOM."
            exit 1
        fi
        echo "VM $NOM arretee."
        ;;
    *)
        echo "Erreur : action inconnue '$ACTION'."
        echo "Usage : $0 [L|N|S|D|A] [nom_vm]"
        exit 1
        ;;
esac
