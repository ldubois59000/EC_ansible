# EC_ansible
Déploiment de différent service sur une raspberry Pi 3 via à ansible dans le but de sécurisé le point d'entrée sur un réseau domestique.

Chose à faire pour utiliser Ansible : 
# Machine Master (Control node)
- installer ansible : sudo apt install ansible
- Générer une clé SSH : ssh-keygen -t ecdsa -d 521
  courte explication : le binaire ssh-keygen permet de générer la clé. les options rsa / dsa / ecdsa représente le type de clé / l'algoritme qui est derrière. Nous utilisons l'ecdsa (qui est le plus poussé). L'option -d indique la longueur de la clé.
- Injecter la clé publique sur la rapsberry : ssh-copy-id -i /root/.ssh/id_ecdsa ec@raspberrypi
- Pour se connecter sur machine distante : ssh -i /root/.ssh/id_ecdsa ec@raspberrypi
- OU création d"un agent ssh : ssh-add -l (s'assurer qu'aucun agent ne tourne), eval `ssh-agent` (lancement de l'agent), ssh-add (ajout de la clé à l'agent), ssh-add -l (pour vérifier)
- Ce qui permet de se connecter "plus facilement" ssh ec@raspberrypi

# Machine cible (Managed node)
- autoriser SSH : sudo raspi-config (puis interfaces options, enable ssh)

# Description du projet réalisé
![alt text](https://github.com/ldubois59000/EC_ansible/blob/main/image.jpg?raw=true)
