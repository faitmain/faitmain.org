Valise Ghetto Blaster
=====================

:date: 2013-08-01
:category: électronique,informatique
:level: vulgarisation, moyen
:author: Tarek Ziadé

Après le `Juke Box du premier numéro <http://faitmain.org/volume-1/raspberry-jukebox.html>`_,
j'avais envie de pousser un peu plus le projet pour faire un `Ghetto Blaster
<https://fr.wikipedia.org/wiki/Radiocassette>`_ qui puisse streamer de la musique
via le wifi de la maison, avec un son digne de ce nom.

Il existe des solutions commerciales comme le Bose Soundlink ou le Jawbone JAMBOX -
mais il faut compter un budget de 400 euros - et franchement, quand on sait
ce qu'il y a à l'intérieur de ces enceintes, on paye surtout le design et
la marque. De plus, une enceinte amplifiée à base de Raspberry-PI offre
beaucoup plus de possibilitées vu que c'est programmable.

Enceintes & ampli
-----------------


En fouillant dans ma cave, j'ai trouvé deux enceintes trois voies Panasonic
de 100 Watts (en vrai 25W) qui étaient dans mon ancienne voiture, et
une valise en aluminium qui contenait des outils. C'est la valise
générique qui est souvent vendu avec une perceuse ou des outils.
Elle en jette mais elle est en carton et a juste une mince couche
d'aluminium par dessus. La caisse de résonnance parfaite pour
un prix avoisinant les 10 euros...

Ni une, ni deux, j'ai vidé la valise et retiré sa doublure
plastique et percé deux trous pour les enceintes à l'aide
d'un gros cutter.

Pour l'amplification j'ai opté pour un petit amplificateur
25 Watts 2 voies qui permet quelques réglages basses/medium/aigues,
et dont le panneau frontal se dévisse - Payé 27 euros
sur Amazon. XXX

Ca m'a permis de remettre ce panneau sur la valise et de revisser
le corps de l'ampli à l'intérieur. Bien sûr, le top du top
aurait été de fabriquer mon propre ampli, mais je n'en suis
pas encore à ce niveau là.

Après deux points de soudures, les enceintes et l'amplificateur
étaient fonctionels et là, le choc: **un son excellent, dépassant
de loin la qualité de mes enceintes de salon**.

Alimentation
------------


XXX regul etc


.. figure:: ghetto/Voltage-Regulator.png

   Schéma du circuit de régulation de tension.




Logiciels
---------

XXX

Wifi
----

XXX

Conclusion
----------

XXX





he next steps were to plug a Raspberry-Pi with an USB sound card and a wifi
dongle and run Mopidy on it. That allowed me to stream music from my Spotify
account.

When the Raspberry starts, it starts Mopidy, connects to the home Wifi and
speaks out using espeak:

    "I am ready to play music, my IP address is 192.168.0.16"

From there I can start a MPD client like MPDroid and connect to that IP and
queue some music. Powering

Of course the big challenge was to power up the amplifier & the Raspberry so I
could actually walk around freely. I did not want to use lead acid, so I bought
this 12v lipo battery for $20. It comes pre-charged and has a small on/off
button.

Now this battery delivers 12v but I still need 5v for my Raspberry. You can use
a voltage regulator for this, like the LM1117.

I built a small board you can see in the video. It takes the 12v from the
battery and outputs 5v for the Raspberry. It has the LM1117 with a sink, and a
few capacitors for stability.

It's exactly the same design as this one
https://www.youtube.com/watch?v=CKS6zHo5T9k except they use a L7805 in there -
which has a different wiring.

That's it - my 12v LiPO powers up the amplifier & the Raspberry. It's been
playing for hours and the battery still has some juice. Issues & next steps

The wifi dongle loses the signal if I close the suitcase and I am too far from
the wifi router. I need to set up an external antenna.

I am also going to add a battery level indicator, using this schematic

One issue I have yet to solve is the ability to reconfigure the network setup
in case I use the Ghetto blaster in someone else's house. Right now I have to
plug a screen and a keyboard or to plug a network cable and ssh on the
Raspberry to change the network config.

Maybe one way to solve this would be to have a second wifi dongle set as an
access point, and a small web interface to configure the network.

Raspberry-Pis are so fun.


