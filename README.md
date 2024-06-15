# EC_ansible
Déploiment de différents services sur une raspberry Pi 3 via à ansible dans le but de sécurisé le point d'entrée sur un réseau domestique.

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
Voici un schéma résumant le fonctionnement et l'interaction entre les services déployer : 
![alt text](https://github.com/ldubois59000/EC_ansible/blob/main/image.png?raw=true)

Description : 
- Le firewall (qui est le point d'entrée), à l'aide de règle iptables va autorisé les flux entrants et sortants uniquement sur les ports qui nous intéresse (SSH, HTTP, HTTPS, ICMP ...).

- Le reverse proxy ainsi que certaines règles iptables vont permettre la redirection de port (notamment les 8081,8082) vers les ports 80 de différents contenair docker respectif. Dans ces contenair vont tourner différents service comme un serveur web Nginx ainsi que Pi-hole et son DNS, permettant de filtrer les pubs sur le réseaux. 

- Sur la machine cible, d'autres services fonctionnent également comme rkhunter, logwatch et fail2ban. Au préalable, Postfix et mailutils ont également été déployés afin d'obtenir des rapports des check des service rkhunter et logwatch. Ceci a été rendu possible avec une messagerie personnel gmail grâce à la double authentification activée et en désactivant la protection renforcée.

Vous trouverez dans role un ReadMe expliquant les actions réalisées et pour plus de visibilé, dans chaque role un ReadMe sur le service. 
Il y a deux branches "dev_france" m'ayant servit à sauvegarder progressivement mes avancées durant l'EC et la branche dev_suede, puisque les deux premiers mois de l'EC j'étais en mobilité international, sans matériel mais j'ai essayé de faire quelques petites choses. 

Mes sources pour réaliser ce projet : 

https://github.com/maxlareo/ansible-rkhunter/tree/master 

https://github.com/shaderecker/ansible-pihole 

https://github.com/robertdebock/ansible-role-logwatch 

https://github.com/geerlingguy/ansible-role-postfix/tree/master 

https://xavki.blog/iptables-tutoriaux-francais/

Pour lancer le playbook : sudo ansible-playbook -i inventory.yml playbook.yml

ping ma raspi : ansible machine -i inventory.yml -m ping

sudo fail2ban-client set sshd unbanip IP_ADDRESS  => très pratique quand on se fait ban par fail2ban après 3 mots de passes erronés.


