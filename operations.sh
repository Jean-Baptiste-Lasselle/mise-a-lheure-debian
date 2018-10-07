sudo apt-get install ntp#!/bin/bash
# Hôte Docker sur centos 7
############################################################
############################################################
# 					Compatibilité système		 		   #
############################################################
############################################################

# ------------------------------------------sudo apt-get install ntp----------------
# [Pour Comparer votre version d'OS à
#  celles mentionnées ci-dessous]
# 
# ¤ distributions Ubuntu:
#		lsb_release -a
#
# ¤ distributions CentOS:
# 		cat /etc/redhat-release
# 
# 
# ----------------------------------------------------------

# ----------------------------------------------------------
# testé pour:
# 
# 
# 
# 
# ----------------------------------------------------------
# (Ubuntu)
# ----------------------------------------------------------
# 
# ¤ [TEST-OK]
#
# 	[Distribution ID: 	Ubuntu]
# 	[Description: 		Ubuntu 16.04 LTS]
# 	[Release: 			16.04]
# 	[codename:			xenial]
# 
# 
# 
# 
# 
# 
# ----------------------------------------------------------
# (CentOS)
# ----------------------------------------------------------
# 
# 
# 
# ...
# ----------------------------------------------------------




# --------------------------------------------------------------------------------------------------------------------------------------------
##############################################################################################################################################
#########################################							ENV								##########################################
##############################################################################################################################################
# --------------------------------------------------------------------------------------------------------------------------------------------
export MAISON_OPERATIONS=`pwd`

# -
export NOMFICHIERLOG="$MAISON_OPERATIONS/synchronisation-NTP-public.log"

#export SERVEUR_NTP=0.us.pool.ntp.org
export SERVEUR_NTP=0.fr.pool.ntp.org


######### -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -
######### -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -# -


# --------------------------------------------------------------------------------------------------------------------------------------------
##############################################################################################################################################
#########################################							FONCTIONS						##########################################
##############################################################################################################################################

# --------------------------------------------------------------------------------------------------------------------------------------------
# Cette fonction permet de re-synchroniser l'hôte docker sur un serveur NTP, sinon# certaines installations dépendantes
# de téléchargements avec vérification de certtificat SSL
synchroniserSurServeurNTP () {
        # ---------------------------------------------------------------------------------------------------------------------------------------------
        # ------        SYNCHRONSITATION SUR UN SERVEUR NTP PUBLIC (Y-en-a-til des gratuits dont je puisse vérifier le certificat SSL TLSv1.2 ?)
        # ---------------------------------------------------------------------------------------------------------------------------------------------
        # ---------------------------------------------------------------------------------------------------------------------------------------------
        # ---   Pour commencer, pour ne PAS FAIRE PETER TOUS LES CERTIFICATS SSL vérifiés pour les installation yum
        # ---
        # ---   Sera aussi utilise pour a provision de tous les noeuds d'infrastructure assurant des fonctions d'authentification:
        # ---           Le serveur Free IPA Server
        # ---           Le serveur OAuth2/SAML utilisé par/avec Free IPA Server, pour gérer l'authentification
        # ---           Le serveur Let's Encrypt et l'ensemble de l'infrastructure à clé publique gérée par Free IPA Server
        # ---           Toutes les macines gérées par Free-IPA Server, donc les hôtes réseau exécutant des conteneurs Girofle
        #
        #
        # >>>>>>>>>>> Mais en fait la synchronisation NTP doit se faire sur un référentiel commun à la PKI à laquelle on choisit
        #                         de faire confiance pour l'ensemble de la provision. Si c'est une PKI entièrement interne, alors le système
        #                         comprend un repository linux privé contenant tous les packes à installer, dont docker-ce.
        #
        # ---------------------------------------------------------------------------------------------------------------------------------------------
        echo "date avant la re-synchronisation [Serveur NTP=$SERVEUR_NTP :]" >> $NOMFICHIERLOG
        date >> $NOMFICHIERLOG
        sudo which ntpdate
        # sudo yum install -y ntp
        sudo apt-get install -y ntp 
        
        # copie du fichier de conf NTP dans le système
        sudo cp ./etc.ntp.conf /etc/ntp.conf
        
        sudo apt-get -y ntpdate
        sudo ntpdate $SERVEUR_NTP
        echo "date après la re-synchronisation [Serveur NTP=$SERVEUR_NTP :]" >> $NOMFICHIERLOG
        date >> $NOMFICHIERLOG
        # pour re-synchroniser l'horloge matérielle, et ainsi conserver l'heure après un reboot, et ce y compris après et pendant
        # une coupure réseau
        sudo hwclock --systohc

}


# --------------------------------------------------------------------------------------------------------------------------------------------
##############################################################################################################################################
#########################################							OPS								##########################################
##############################################################################################################################################
# --------------------------------------------------------------------------------------------------------------------------------------------

echo " +++synchronistaion+ sur sereveur NTP  +  COMMENCEE  - " >> $NOMFICHIERLOG

synchroniserSurServeurNTP

echo " +++synchronistaion+ sur sereveur NTP  +  TERMINEE  - " >> $NOMFICHIERLOG
