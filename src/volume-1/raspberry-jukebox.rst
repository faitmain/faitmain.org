Un Juke Box avec le Raspberry-Pi
================================

:date: 2012-12-12
:category: electronique,informatique
:level: découverte
:author: Tarek Ziadé


.. figure:: raspberry-jukebox.jpg

   Le Raspberry-PI Jukebox


Après trois mois d'attente interminable , j'ai finalement reçu mon
`Raspberry Pi <http://www.raspberrypi.org/>`_ (R-Pi), accompagné
d'un joli T-shirt *Element 14*.

J'ai plusieurs projets en tête avec un peu d'électronique, mais
pour me familiariser avec la bête, j'ai décidé de commencer par un projet
simple qui marcherait avec un R-PI nu.

Le projet est un Juke-Box sans fil que je peux trimballer chez moi, qui
se connecte à mon réseau local en wifi - et qui fournit une application web
où tout le monde peut se connecter pour ajouter des morceaux de musique
dans une file d'attente.

Le projet final est une petite boite qui contient le R-PI et:

- une clé USB pour stocker de la musique. J'ai choisi la
  `PNY 16G <http://www.amazon.fr/dp/B0052QT6BQ>`_ qui est vraiment toute petite.

- un dongle USB  wifi. J'ai choisi l'`Airlink Nano <http://www.amazon.fr/gp/product/B003X26PMO>`_
  pour les mêmes raisons: il dépasse à peine du port USB.

- Une batterie USB pour ne pas avoir à brancher le R-PI sur le courant ou sur
  mon ordinateur. J'ai choisi `celui-ci <http://www.amazon.fr/gp/product/B006LR6N3O>`_
  qui s'avère être beaucoup plus volumineux que le R-PI, mais qui fournit jusqu'à
  1 ampère de courant - ce qui couvre les besoins et devrait permettre d'éviter
  à avoir recours à un Hub USB alimenté.

- Un mini-speaker. J'ai commandé le `X-Mini II <http://www.amazon.fr/gp/product/B001UEBN42>`_
  qui est tout simplement incroyable. Ce petit speaker sort un très bon son
  vu sa taille, est auto-alimenté et on peut en brancher plusieurs à la suite.
  J'en ai acheté un deuxième pour mon fils et je le recommande chaudement.
  Dans tous les cas, le Juke-Box peut toujours être branché sur de vraies enceintes.

Petit détail agréable: Le speaker et la batterie USB ont été tous les deux livrés
pré-chargés.



La carte SD
:::::::::::

.. figure:: http://ecx.images-amazon.com/images/I/41t75bYmx4L._SL500_AA300_.jpg
   :scale: 25
   :figclass: pull-right margin-left
   :target: http://www.amazon.fr/dp/B000WQKOQM/
   :align: right

   Carte SD 4 Gigas


A réception du R-PI, j'ai branché une carte SD qui traînait chez moi et elle
ne marchait pas du tout. J'ai contrôlé que la carte était bien alimentée
avec un multimètre et j'ai testé trois autres cartes SD glanées dans
les appareils photos de la famille en me disant que quelque chose clochait
à ce niveau là.

Avec la dernière carte que j'ai testé, le R-PI bootait mais freezait au
bout d'un moment avec une **-101 error**.

Il s'avère que le R-PI est très sensible au type de carte SD qu'il reçoit.
Rien à voir avec la marque ou le prix de la carte, ou sa classe. Certaines
marchent, certaines de marchent pas...

Le plus simple est de prendre une carte qui est listée ici:
http://elinux.org/RPi_VerifiedPeripherals#SD_cards

Je suis allé au supermarché du coin et j'ai pris une
`SanDisk SDHC 4G class 4 <http://www.amazon.fr/dp/B000WQKOQM/>`_ à
7 euros - et tout a fonctionné.

Préparer la carte SD pour le R-PI sous Mac OS X est très simple.
Il y a même un script Python : `RasPiWrite <http://exaviorn.com/raspiwrite>`_
qui automatise la tâche.

J'ai eu quelques bugs avec pour ma part alors j'ai utilisé
quelques commandes shell.

J'ai d'abord téléchargé l'image **Raspbian** officielle. C'est une
Debian optimisée pour le R-PI::

    cd /tmp
    wget http://ftp.snt.utwente.nl/pub/software/rpi/images/raspbian/2012-10-28-wheezy-raspbian/2012-10-28-wheezy-raspbian.zip
    unzip 2012-10-28-wheezy-raspbian.zip

Vous pouvez regarder sur http://www.raspberrypi.org/downloads s'il
n'y en a pas une plus récente.

Une fois que l'image est téléchargée et dézippée, il convient de la transférer
sur la carte SD avec la commande **dd**.

Sous **Mac OS X**, la commande **diskutil list** m'a permis de trouver le
disque correspondant à la carte : **/dev/disk3**

Puis le transfert s'opère en démontant la carte et en utilisant **dd**::

    $ diskutil umountDisk /dev/disk3
    Unmount of all volumes on disk3 was successful

    $ sudo dd bs=1m if=/tmp/2012-10-28-wheezy-raspbian.img of=/dev/rdisk3
    [... 5-10 minutes ...]
    1850+0 records in
    1850+0 records out
    1939865600 bytes transferred in 388.257496 secs (4996338 bytes/sec)

    $ diskutil eject /dev/disk3
    Disk /dev/disk3 ejected

Notez que la commande **dd** prend beaucoup de temps à s'exécuter. La copie
peut durer de 5 à 10 minutes.

.. note::

   La notation **rdisk3** est spécifique à Mac OS X. Elle permet d'accélerer
   la procédure. Sous Linux, il faut enlever le *"r"*.

Une fois que la carte est prête, il suffit de la plugguer dans R-PI et de
le démarrer avec un écran & un clavier branchés.


Configuration de base et wifi
:::::::::::::::::::::::::::::

Vous devriez voir défiler la séquence de boot puis obtenir un écran
de configuration.

- étendez la partition sur toute la carte SD grâce à **expand_rootds**,
- overclockez votre R-PI dans le menu **overclock**. J'ai mis le mien
  en **medium**
- activez le serveur SSH dans **ssh**
- désactivez le desktop dans **boot_behavior**

Je n'ai pas reconfiguré le clavier car j'utilise un QWERTY.

Une fois la configuration effectuée, branchez le dongle Wifi et
relancez le R-PI via **Finish**, Raspbian va appliquer au redémarrage
la configuration, et un prompt de login doit apparaître.

Pour se logguer le user est **pi** et le mot de passe **raspberry**.

Une fois loggué, éditez le fichier **/etc/network/interfaces**
pour que le dongle s'autoconnecte au réseau. J'ai branché le dongle sur
le port USB du bas, ce qui correspond selon **iwconfig** à l'interface
**wlan0**.

Voici ma configuration pour  *wlan0*::

    auto wlan0

    iface wlan0 inet dhcp
        wpa-ssid Villa_Des_Mouches
        wpa-psk motdepasse


**Villa_Des_Mouches** est le ESSID de mon réseau wifi. Une fois le fichier
modifié, relancer le réseau::

    $ sudo /etc/init.d/networking restart


Votre R-PI va obtenir une addresse IP sur le réseau sur laquelle
on pourra se connecter en SSH pour la suite.

Eteignez le R-PI avec **sudo halt**, puis débranchez l'écran et le clavier.
Branchez la clef USB à la place du clavier et relancer le R-PI.

Au bout d'un moment il devrait réapparaitre dans le réseau et être
accessible en SSH. Le seul défaut de cette technique est que l'addresse
IP peut changer. Une addresse IP statique peut être préferée mais
dans mon cas ce n'est pas très grave car je retrouve facilement le R-PI
en scannant le réseau avec *nmap 192.168.1.**.

::

    $ ssh pi@192.168.1.96
    Linux raspberrypi 3.2.27+ #250 PREEMPT Thu Oct 18 19:03:02 BST 2012 armv6l
    ...

    Last login: Sun Oct 28 23:10:12 2012
    pi@raspberrypi ~ $


Pour la suite, il est plus simple de tout faire en SSH car à moins d'avoir
un écran adapté, la résolution du mode console du R-PI sur un écran
moderne va vous brûler les yeux en 5 minutes.

Testez que le son fonctionne en branchant une enceinte amplifiée sur le R-PI et
en téléchargeant un **WAV** et en le jouant avec **aplay**::

    $ wget http://www.freespecialeffects.co.uk/soundfx/sirens/police_s.wav
    $ aplay police_s.wav
    Playing WAVE 'police_s.wav' : Unsigned 8 bit, Rate 22000 Hz, Mono
    ^CAborted by signal Interrupt...

Vous devriez entendre une sirène.

Installez maintenant **mpg123** pour jouer des MP3 présents sur la clef
USB. Il a fallu monter le disque manuellement par contre::

    $ sudo mkdir /media/usbstick
    $ sudo mount -t vfat  -o uid=pi,gid=pi /dev/sda1 /media/usbstick

    $ mpg123 "/media/usbstick/01 Hidden Orchestra - Flight Mixtape.mp3"
    High Performance MPEG 1.0/2.0/2.5 Audio Player for Layers 1, 2 and 3
        version 1.14.4; written and copyright by Michael Hipp and others
        free software (LGPL/GPL) without any warranty but with best wishes

    Directory: /media/usbstick/
    Playing MPEG stream 1 of 1: 01 Hidden Orchestra - Flight Mixtape.mp3 ...

    MPEG 1.0 layer III, 320 kbit/s, 44100 Hz joint-stereo
    Title:   Hidden Orchestra - Flight Mixtape
    Artist:  Hidden Orchestra (Joe Acheson)
    Comment: Exclusive mix for http://www.parisdjs.com
    Album:   Paris DJs Podcast
    Year:    2012                            Genre:  Podcast


Victoire ! Et un super mix de `ParisDjs <http://parisdjs.com>`_ avec un son
propre.

**mpg123** utilise environ 6% de CPU, ce qui est plus qu'acceptable.


Application JukeBox
:::::::::::::::::::

Pour la partie JukeBox, je comptais écrire une petite application web
au dessus de **mpg123** et je le ferais peut-être un jour, mais
il en existe déja plusieurs.

`Jukebox <https://github.com/lociii/jukebox>`_ est écrite en Python
avec Django et fournit les fonctionnalitée de base d'un JukeBox,
à savoir un affichage des morceaux présents et un moyen pour les
utilisateurs du réseau d'ajouter des morceaux dans la playlist.

.. image:: http://a248.e.akamai.net/camo.github.com/bb66587466563ff4b89af700ba14d0f31caabff0/687474703a2f2f7374617469632e6a656e736e6973746c65722e64652f6a756b65626f782e706e67
   :alt: L'application Django Jukebox

Pour installer JukeBox, il faut un environement Python/Virtualenv mais aussi
la librairie **libshout3** qui est utilisée par l'application::

    $ sudo apt-get install python-virtualenv libshout3 libshout3-dev pkg-config python-dev

Une fois les paquets systèmes installés, il faut créer un virtualenv et y installer
**ez_setup** puis JukeBox::

    $ virtualenv --no-site-packages jukebox
    $ cd jukebox
    $ bin/easy_install -U distribute
    $ bin/pip install ez_setup
    $ bin/pip install jukebox


Pour la configuration de Jukebox, tout est expliqué ici: https://github.com/lociii/jukebox

Le gros défaut de cette application est qu'elle force les utilisateurs
à utiliser un compte social comme Twitter - et je n'ai pas eu le temps
de plugger un système d'authentification plus simple.

Quoi qu'il en soit je suis ravi du résultat - ce petit juke box peut se brancher
sur de bonnes enceintes et rivaliser avec les systèmes sans fils hors de prix
du marché, comme les *Sonos*.

