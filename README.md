# mise-a-l-heure

Synchronisation sur un serveur NTP, et mise à joru de l'horodatage système.
Serveur NTP publics internet de strate 2

### Dépendances 

Cette recette doit être exécutée sur une machine:
* sur laquelle CentOS 7 est le système d'exploitation, 
* sur laquelle GIT a été installé,
* sur laquellle le système CentOS a été synchronisé sur un serveur NTP


Cette recette a donc pour dépendances:

* Le système CentOS 7,
* un serveur NTP
* GIT 


# Utilisation

```
# export URI_REPO_RECETTE=https://github.com/Jean-Baptiste-Lasselle/provision-hote-docker-sur-centos
export URI_REPO_RECETTE=git@github.com:Jean-Baptiste-Lasselle/provision-k8s-bis.git
export PROVISONING_HOME=$HOME/horodatage-systeme
export GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa"
rm -rf $PROVISONING_HOME
mkdir -p $PROVISONING_HOME
cd $PROVISONING_HOME
git clone "$URI_REPO_RECETTE" .
sudo chmod +x operations.sh
./operations.sh
```

Soit en une seule ligne:

```
# export URI_REPO_RECETTE=https://github.com/Jean-Baptiste-Lasselle/provision-hote-docker-sur-centos && export URI_REPO_RECETTE=git@github.com:Jean-Baptiste-Lasselle/provision-k8s-bis.git && export PROVISONING_HOME=$HOME/horodatage-systeme && export GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa" && rm -rf $PROVISONING_HOME && mkdir -p $PROVISONING_HOME && cd $PROVISONING_HOME && git clone "$URI_REPO_RECETTE" . && sudo chmod +x operations.sh && ./operations.sh
```
