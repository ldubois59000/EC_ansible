# EC_ansible
Déploiment de différent service sur une raspberry Pi 3 via à ansible dans le but de sécurisé le point d'entrée sur un réseau domestique.

#machine et le raspbbery pi dpoivent etre sur le meme réseaux, pour checker

#depuis ma machine tape la commande ping ip_addresse_rasbppery pi

####Configuration  M######

####sur Rasbperry pi en tant que root:

apt update 

yes "" | apt install openssh-server

yes "" | apt install python3

systemctl start ssh

sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config

sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

systemctl restart ssh 


#### sur machine master en tant que root:####

echo "ip_addresse_rasbppery  rasbppery" >> /etc/hosts   # remplace ip_addresse_rasbppery par ip 

echo " ip_addresse_rasbppery  www.lisa.dubois" >> /etc/hosts # remplace ip_addresse_rasbppery par ip

yes "" |apt install openssh-client 

yes "" |apt-install shhpass

 
######### sur machine master en tant que user:#######

yes "" |ssh-keygen -t rsa

sshpass -p "mot_de_passe_root_rasbppery" ssh-copy-id root@rasbppery


######### Etape 1 : Fin configuration SSH ############# 

##depuis la machine master essaye ssh root@rasbppery on est connect" en tant que root sur rasbperry

########################################### 


######## installation rkhunter sur rasbppery  interactif appuyer sur entrer  en tant que root########

yes "" |apt install rkhunter 

rkhunter -c   ###### lancer le check ou scan khunter #########


###install ansible sur la machine ######

yes "" | apt install ansible


######pour lancer le playbook en tant que user: 

ansible-playbook playbook.yml -i inventaire.ini -e "server=rasbppery"

#####pour accéder au site depuis la machine maitre c est via l url www.lisa.dubois ou bien l ip du rasbppery
