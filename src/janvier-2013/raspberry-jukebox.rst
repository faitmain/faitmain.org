Un Juke Box avec le Raspberry-Pi
================================

:date: 2012-12-12
:category: electronique,informatique
:level: découverte
:author: Tarek Ziadé

.. note::

   **Article en cours de traduction**

Après trois mois d'attente interminable , j'ai finalement reçu mon
`Raspberry Pi <http://www.raspberrypi.org/>`_ (R-Pi), accompagné
d'un joli T-shirt *Element 14*.

J'ai plusieurs projets en tête avec un peu d'électronique, mais
pour me familiariser avec la bête, j'ai décidé de commencer par un projet
simple qui marcherait avec un R-PI nu.


.. figure:: http://www.raspberrypi.org/wp-content/uploads/2011/07/raspi_blue_white.png
   :scale: 50

   Le Raspberry-PI

Le projet est un Juke-Box sans fil que je peux trimballer chez moi, qui
se connecte à mon réseau local en wifi - et qui fournit une application web
où tout le monde peux se connecter pour ajouter des morceaux de musique
dans une file d'attente.

Le projet final est une petite boite qui contient le R-PI et:

- une clé USB pour stocker de la musique. J'ai choisi la
  `PNY 16G <http://www.amazon.fr/dp/B0052QT6BQ>`_ qui est vraiment toute petit.

- un dongle USB  wifi. J'ai choisi l'`Airlink Nano <http://www.amazon.fr/gp/product/B003X26PMO>`_
  pour les mêmes raisons: il dépasse à peine du port USB.

- Une batterie USB pour ne pas avoir à brancher le R-PI sur le courant ou sur
  mon ordinateur. J'ai choisi `celui-ci <http://www.amazon.fr/gp/product/B006LR6N3O>`_
  qui s'avère être beaucoup plus volumineux que le R-PI, mais qui fourni jusqu'à
  1 ampère de courant - ce qui couvre les besoins et devrait permettre d'éviter
  à avoir recours à un Hub USB alimenté.

- Un mini-speaker. J'ai commandé le `X-Mini II <http://www.amazon.fr/gp/product/B001UEBN42>`_
  qui est tout simplement incroyable. Ce petit speaker sort un très bon son
  vu sa taille, est auto-alimenté et on peut en brancher plusieurs à la suite.
  J'en ai acheté un deuxième pour mon fils et je le recommande chaudement.
  Dans tous les cas, le Juke-Box peut toujours être branché sur de vrais enceintes.



La carte SD
:::::::::::

.. figure:: http://ecx.images-amazon.com/images/I/41t75bYmx4L._SL500_AA300_.jpg
   :scale: 25
   :target: http://www.amazon.fr/dp/B000WQKOQM/

   Carte SD 4 Gigas

A réception du R-PI, j'ai branché une carte SD qui traînait chez moi et elle
ne marchait pas du tout. J'ai controllé que la carte était bien alimenté
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

J'ai d'abord téléchargé l'image officielle::

    cd /tmp
    wget http://files.velocix.com/c1410/images/debian/6/debian6-19-04-2012/debian6-19-04-2012.zip
    unzip debian6-19-04-2012.zip

Once you have the image on your disk, just plug the SD card to your computer,
unmount any partition that gets mounted and create the disk::

    diskutil umount /dev/disk2s1
    sudo dd bs=1m if=debian6-19-04-2012.img of=/dev/disk2
    diskutil eject /dev/disk2s1

My first attempt failed because I was calling *dd* on **/dev/disk2s1**, not
on the root - **/dev/disk2**. It was copying the image but the R-Pi was not
booting of course.

Once you have it right, plug it and run your R-Pi. You should get a prompt
to log in. The R-Pi user is **pi** and the password **raspberry**.

.. note::

   My Pi restarted automatically several times. Looks like the normal
   behavior the first time you run the Debian image

The next issue I had was about the partition sizes. Playing in the R-PI
I ended up out of space really quickly and realized I had only 2G instead
of the 4 gigs my card has. The Debian system is around 1.7G so it's not
really usable if you don't resize the partition.

To do so, you can just
follow this *excellent* `blog post <https://projects.drogon.net/raspberry-pi/initial-setup1>`_,
and apply everything the author proposes.


Mise à jour du système
::::::::::::::::::::::


Once your R-Pi happily runs, it's time to update your system so you have all the
required packages.

If you applied all Gordons tips, you should be able to access to your R-Pi from
your computer via SSH by plugging it to your local network. Booting the Pi with the
network cable plugged will DHCP for you. The IP is displayed somewhere in the
startup screen. Or just *nmap 192.168.1.** on your network.

I highly recommend working via SSH because the video output resolution is
really bad by default and will burn your eyes. Maybe there's a simple way
to change the resolution but I failed to do so.

Now for the update::

    sudo apt-get update
    sudo apt-get install alsa-utils ntpdate mpg123 python-virtualenv libshout3 libshout3-dev pkg-config python-dev

This is the minimal setup to my knowledge to run the Jukebox app.

Son
:::

By default the sound is not activated, and once activated it plays
via the HDMI port. If you want it on the jack, you need to change
the settings with *amixer*.

::

    sudo modprobe snd_bcm2835
    sudo amixer cset numid=3 1

If you want to go back to the HDMI output, just do::

    sudo amixer cset numid=3 2

Then try a WAV file to check that it works::

    wget http://www.freespecialeffects.co.uk/soundfx/sirens/police_s.wav
    aplay police_s.wav

I found these tips `here <http://www.raspberrypi-spy.co.uk/2012/06/raspberry-pi-speakers-analog-sound-test/>`_.
Not sure why the author use sudo. It works with your *pi* user of course.

Disque USB
::::::::::

I had to manually mount my disk::

    sudo mkdir /media/usbstick
    sudo mount -t vfat  -o uid=pi,gid=pi /dev/sda1 /media/usbstick/

I then tried to play a MP3 file::

    mpg123 "/media/usbstick/Renegades Of Jazz - Go Jazz Not Ape! Vol.2.mp3"

Great success |thumbsup| -- and great mix from `ParisDjs <http://parisdjs.com>`_.


JukeBox
:::::::

The initial plan was to write a web app my self, on the top of
`gst-python <http://gstreamer.freedesktop.org/modules/gst-python.html>`_, by
installing Gstreamer.

But after 3 hours of trying to make it work, installing many packages, and
trying to understand why this #%*! alsasink failed with gstreamer, I just
wiped my image and went for a simpler solution on the top of *mpeg123*,
which works really well and don't have all those dependencies like GTK.;

And then I found `Jukebox <https://github.com/lociii/jukebox>`_ which is
*exactly* what I wanted to write. And it works with *mpeg123* so why
bother :)

.. image:: http://a248.e.akamai.net/camo.github.com/bb66587466563ff4b89af700ba14d0f31caabff0/687474703a2f2f7374617469632e6a656e736e6973746c65722e64652f6a756b65626f782e706e67
   :alt: L'application Django Jukebox



To install Jukebox, simply create a new virtualenv with a fresh Distribute::

    virtualenv --no-site-packages jukebox
    cd jukebox
    bin/easy_install -U distribute

Then just follow the instructions on the `Jukebox github <https://github.com/lociii/jukebox>`_.
everything should go smoothly with the libraries installed previously.

Yay, I have a R-Pi Jukebox  |thumbsup|

It sucks almost 100% of the CPU - Maybe I should profile the Python app, because
it's the one sucking the CPU, not the mp3 player.


La suite
::::::::

I received the hardware and built a lego case: http://blog.ziade.org/2012/07/04/my-raspberry-pi-juke-box-follow-up
I love this small computer.


.. |smile| image:: http://blog.ziade.org/smile.gif

----

.. image:: http://blog.ziade.org/rpi-jukebox-mini.jpg
   :target: http://blog.ziade.org/rpi-jukebox.jpg
   :alt: Le jukebox final.


.. image:: http://blog.ziade.org/rpi-lego-mini.jpg
   :target: http://blog.ziade.org/rpi-lego.jpg
   :alt: Le jukebox dans le boitier Lego.


Just a follow-up on my `Raspberry Pi Juke Box project <http://blog.ziade.org/2012/07/01/a-raspberry-pi-juke-box-how-to/>`_.

I have received all the peripherals by mail today so I could finish the
project.

A few remarks:

- The `XMI Speaker <http://www.amazon.fr/gp/product/B001UEBN42/>`_ is amazing.
  You unfold it like an accordion and it has a really good sound.
  It's hard to give you an idea, but if you have a MBP or a MBA, the
  sound coming out of this tiny speaker is much better.

- The `USB Battery <http://www.amazon.fr/gp/product/B006LR6N3O>`_ delivers
  1A or 500ma, so is working perfectly well for the R-Pi.

Both peripherals were fully charged when I got them, so I could go ahead
and plug them.

The `AirLink 101 <http://www.amazon.fr/gp/product/B003X26PMO>`_ wifi dongle
on the other hand was a bit tedious to install. It's a Realtek 8188CUS but
a 8191SU driver seems to work well.

Don't plug it, it will freeze your R-PI. Edit the **etc/modprobe.d/blacklist.conf**
file and add::

    blacklist rtl8192cu

Then, before you plug it::

    $ wget http://www.electrictea.co.uk/rpi/8192cu.tar.gz
    $ tar -xzvf 8192cu.tar.gz
    $ sudo install -p -m 644 8192cu.ko /lib/modules/3.1.9+/kernel/drivers/net/wireless/
    $ sudo depmod -a
    $ sudo apt-get install firmware-realtek dhcpcd wpasupplicant

Now you can plug it and reboot your R-Pi. Things should work fine.

Tweak your **/etc/network/interfaces** if you want the dongle to autoconnect
to your wifi. Here's my relevant section for *wlan0*::


    auto wlan0

    iface wlan0 inet dhcp
        wpa-ssid Villa_Des_Mouches
        wpa-psk MyPassWord


That's all. Now when I reboot the R-Pi via the hardware, it gets an IP via the WIfi
Dongle and I can happily ssh it or get into the Juke box app.

I am really happy I did not have to add a powered USB Hub.
