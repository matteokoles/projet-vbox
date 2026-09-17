# Journal de bord

(remplacer les items en majuscule)

* TITRE PROJET
* NOM CHEF DE PROJET
* NOMS AUTRE MEMBRES EQUIPE
* DATE DEBUT


Séance n° 1
16/09/2026 - de 13h jusqua 16h
Travail effectué : mise en place du journal de bord ; organisation de l'équipe et répartition des tâches :
Setup environnement (VirtualBox, WSL, dépôt GitHub) : Matteo et Maxime ensemble
Étapes 1-2 (création/destruction VM, vérification existence) : Matteo (chef de projet)
Étape 3 (gestion des arguments L/N/S/D/A) : Maxime
Étape 4 (métadonnées + parsing) : en binôme
Étape 5 (boot PXE/TFTP) : en binôme
Rédaction du rapport usage.md : à tour de rôle, section par section, au fil des séances
Côté Matteo : installation et configuration de l'environnement de travail (VirtualBox déjà présent, WSL/Ubuntu installé et débuggé). Environnement fonctionnel en fin de séance : VBoxManage.exe --version répond (VirtualBox 7.1.4r165100) via un alias bash.
Maxime :installation et configuration de l'environnement de travail (VirtualBox déjà présent, WSL/Ubuntu installé et débuggé) mais petit probleme rencontree lors de la virtualisation non autoriser dans le bios 
creation du git hub
A faire à la prochaine séance : tester genmv_1.sh de bout en bout (vérifier la VM dans la GUI VirtualBox pendant la pause, puis vérifier sa suppression) ; démarrer l'étape 2 (vérification d'existence avant création, suppression automatique si la VM existe déjà)

WSL installé mais aucune distribution Linux présente au départ → lancement de l'icône Ubuntu qui s'ouvrait et se fermait immédiatement sans message visible.
Diagnostic via wsl --status puis wsl en ligne de commande (plus lisible qu'un lancement par icône) : message "Sous-système Windows pour Linux n'a aucune distribution installée".
Résolu avec wsl --install -d Ubuntu.
Une fois Ubuntu opérationnel, VBoxManage.exe non reconnu directement (command not found) car le dossier d'installation de VirtualBox n'est pas dans le PATH propagé à WSL.
Contournement : appel via le chemin complet /mnt/c/Program Files/Oracle/VirtualBox/VBoxManage.exe, puis création d'un alias bash dans ~/.bashrc pour simplifier l'usage.
Remarques sur la séance : séance à dominante organisation + mise en place de l'environnement de travail (pas encore de script écrit). Choix fait de scripter en bash via WSL plutôt qu'en .bat.


## Séance n° 2

* date - heure
* Travail effectué
* A faire à la prochaine séance
* Difficultés rencontrées
* Remarques sur la séances (membre absent, pbe technique, ...)


## Séance n° 3

* date - heure
* Travail effectué
* A faire à la prochaine séance
* Difficultés rencontrées
* Remarques sur la séances (membre absent, pbe technique, ...)



...


