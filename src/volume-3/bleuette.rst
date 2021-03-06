L'hexapode Bleuette
===================

:date: 2013-08-01
:category: informatique,électronique
:level: vulgarisation
:author: Charles Rincheval
:licence: By-Sa-3.0

Introduction
::::::::::::

Bleuette est un robot hexapode (6 pattes) entièrement libre, c'est à dire
que tous les plans, programmes, informations permettant de le fabriquer sont
libres : jouez avec, modifiez les, redistribuez les comme bon vous semble…

Il est encore en stade de développement mais est déjà parfaitement fonctionnel
en terme de déplacement. Son développement se poursuit activement afin de le
rendre plus autonome grâce à des capteurs divers.

Histoire
::::::::

Pour certain d'entre vous, le nom « Bleuette » vous est peut-être familier,
en fait, c'est une féminisation de Bleuet, le robot de la série
FX, Effets spéciaux, nous nous sommes dit que le pauvre Bleuet devait se sentir seul
et qu'il faudrait lui fabriquer un congénère et puis tant qu'à faire femelle… :)

Dans ses premières versions, Bleuette était réalisée en Plexiglas,
découpé à la scie sauteuse, un vrai boulot, long et pénible avant de nous
rendre compte des limites de cette matière : elle est cassante et se raye
trop facilement.
Une seconde version a été faite en Lexan, une matière avec des propriétés déjà
plus intéressantes…

.. image:: bleuette/plexi_0.jpg
   :width: 300px
   :alt: Vue globale de Bleuette en Plexiglass (les 6 pattes en plexiglass
         montées sur une plaque en plexiglass, reliées à des servo-moteurs avec
         pleins de fils).
   :target: bleuette/plexi_0.jpg

.. image:: bleuette/plexi_1.jpg
   :width: 300px
   :alt: Vue de près d'une patte de Bleuette en Plexiglass avec ses visses et son servo-moteur.
   :target: bleuette/plexi_1.jpg

Quelques années se sont écoulées et, depuis, l'impression 3D s'est
considérablement développée, au point d'être devenue attractive pour
les particuliers et intéressante pour un projet comme Bleuette, l'achat
d'une l'Ultimaker a été guidé par l'arrière-pensée de faire Bleuette
entièrement en plastique.

- les `tout premiers pas de Bleuette en Plexiglas <http://vimeo.com/1912189>`_ ;
- quelques années plus tard, `Bleuette imprimée en 3D <http://vimeo.com/58307246>`_.

Tous les plans de Bleuette ont été refaits à l'aide de `OpenSCAD <http://openscad.org/>`_, un logiciel permettant de modéliser des pièces de
manière paramétrique, un dépôt GitHub a été créé à l'occasion pour partager
`tous les documents inérants à la fabrication du robot <//github.com/hugokernel/Bleuette/>`_.

Construction
::::::::::::

Toute la mécanique de Bleuette est entièrement faite en plastique réalisable
avec une imprimante 3D, vous n'avez besoin que de très peu d'éléments autres
(vis, écrous, tiges métal).

*Il est même parfaitement envisageable avec quelques légères adaptations de
découper les pièces avec une fraiseuse ou une découpe laser.*

Le corps
--------

Le corps de Bleuette étant trop grand pour être imprimé en une seule fois, il
est fait en plusieurs parties assemblées par des queues d'arondes,
`une librairie OpenSCAD a été créée pour l'occasion <//github.com/hugokernel/OpenSCAD_Dovetail>`_

.. image:: bleuette/openscad_2.png
   :width: 300px
   :alt: Figure de pièces du corps de Bleuette à encastrer (comme un puzzle) via OpenSCAD.
   :target: bleuette/openscad_2.png

.. image:: bleuette/impression.jpeg
   :width: 300px
   :alt: Pièce du corps de Bleuette en cours d’impression avec une imprimante
         3D à extrusion de thermofilament avec axe mobile sur les axes X et Y et
         plateau mobile sur l’axe Z.
   :target: bleuette/impression.jpeg

.. image:: bleuette/openscad_1.png
   :width: 300px
   :alt: Vue d’autres pièces du corps de Bleuette via OpenSCAD.
   :target: bleuette/openscad_1.png

Une fois les différentes parties imprimées, il suffit des les emboiter en force, les jeux étant très
faibles, c'est très rigide.

Les pattes
----------

Bleuette possède 6 pattes animées chacune par 2 servos standards (Futaba S3003),
un qui permet de lever la patte et un autre qui permet de faire pivoter horizontalement
la patte.

Voici une patte montée sur une structure de test pendant la conception :

.. image:: bleuette/patte_1.jpg
   :width: 300px
   :alt: Une patte montée pour test faite de pièces en plastique imprimées en 3D avec leur servo-moteur.
   :target: bleuette/patte_1.jpg

Détail d'une liaison de patte et vue de l'assemblage : on emboite l'entretoise, on la
pivote de 90 degrés et ça ne bouge plus, aussi simple que des Lego !

.. image:: bleuette/patte_0.jpg
   :height: 254px
   :alt: Entretoise d'une patte
   :target: bleuette/patte_0.jpg

.. image:: bleuette/spacer_anim.gif
   :alt: Animation de l'encastrage de l'entretoise d'une patte (on la glisse dans le trou, l’abaisse et la tourne).
   :target: bleuette/spaces_anim.gif

Une patte entière :

.. image:: bleuette/patte.png
   :width: 300px
   :alt: Vue d'une patte complètement assemblée via OpenSCAD.
   :target: bleuette/patte.png

Les palonniers
--------------

Les palonniers de servos, une pièce relativement complexe à imprimer car
nécessitant une grande précision est aussi réalisée grâce à l'Ultimaker et
`une librairie OpenSCAD à été créée à l'occasion <//www.thingiverse.com/thing:28566>`_,
grâce à elle, on peut créer des palonniers à 1, 2, 4 bras, voir plus et de
tailles diverses.

.. image:: bleuette/palonnier.jpg
   :width: 300px
   :alt: Un palonnier imprimé
   :target: bleuette/palonnier.jpg

Les capteurs de sol
-------------------

Le bout de chaque patte de Bleuette est équipé d'un capteur capable de détecter
via un interrupteur une pression verticale correspondant au contact de la patte
avec le sol, ainsi, notre hexapode est capable de détecter une absence de sol
et donc, par exemple, d'éviter de tomber dans un escalier…

La surface du capteur en contact avec le sol est imprimée en PLA Flex, qui comme
son nom l'indique très bien est en PLA mais avec la particularité d'être flexible.

.. image:: bleuette/capteur_sol.png
   :width: 300px
   :alt: Un capteur de sol : une sorte de piston avec un bas de sphère tronqué en bas.
   :target: bleuette/capteur_sol.png

Sur la première photo ci-dessous, nous voyons la différence entre la pièce brute
et la pièce trempée dans du PlastiDip pour obtenir plus de grip et meilleure finition.

Sur la seconde photo de droite, on peut voir tous les éléments d'un capteur de sol :

.. image:: bleuette/capteur_sol_plastidip.jpg
   :width: 300px
   :alt: Un capteur de sol après impression avec le bas de la sorte de piston et le bas de sphère tronqué posés à plat.
   :target: bleuette/capteur_sol_plastidip.jpg

.. image:: bleuette/capteur_sol_contenu.jpg
   :width: 300px
   :alt: Le contenu d'un bout de patte : autres cylindres composant la sorte de piston + un détecteur de poussée relié à un fil.
   :target: bleuette/capteur_sol_contenu.jpg

Tous les éléments du capteur sont assemblés :

.. image:: bleuette/capteur_sol_assemble.jpg
   :width: 300px
   :alt: Un des 6 capteurs de sol assemblé avec le fil sortant par le trou des cylindres creux.
   :target: bleuette/capteur_sol_assemble.jpg

Bleuette et ses capteurs :

.. image:: bleuette/bleuette.jpeg
   :width: 300px
   :alt: Bleuette l’hexapode complètement monté.
   :target: bleuette/bleuette.jpeg

Le cerveau
::::::::::

Version Arduino
---------------

Le cerveau de Bleuette est une carte Arduino avec `une shield spécialement
conçue pour Bleuette <//github.com/hugokernel/Bleuette/wiki/Bleuette-Shield>`_
qui sert, entre autres, à piloter les 12 servos des pattes.

.. image:: bleuette/bleuette_shield.png
   :width: 300px
   :alt: Circuit imprimé de la Bleuette Shield pour Arduino avec ses composants.
   :target: bleuette/bleuette_shield.png

Cette carte possède les caractéristiques suivantes :

- génération de la tension de 5V pour l'Arduino ;
- mesure du courant consommé par les servos ;
- surveillance de la tension de la batterie ;
- gestion synchrone de la commande des 12 servos des pattes
  + 2 servos optionnels (basé sur un PIC18F452 et `Pic24Servos <//github.com/hugokernel/Pic24Servos>`_).

Voici son schéma de principe :

.. image:: bleuette/elec_schema.png
   :width: 300px
   :alt: Schéma de principe de la carte Bleuette Shield
   :target: bleuette/elec_schema.png

`Plus d'informations sur la Bleuette Shield <//github.com/hugokernel/Bleuette/wiki/Bleuette-Shield>`_.

Une autre carte fille (shield) pour Arduino a été créée, il s'agit
de Bleuette Sensor Shield qui dispose des caractéristiques suivantes :

- 8 entrées supplémentaires multiplexées utilisant que 4 entrées/sorties (3 d'adressage et une sortie) ;
- Connexion pour une carte GY-27 contenant un accéléromètre et un compas ;
- un module Bluetooth JY-MCU ;
- une connexion pour une guirlande de led RGB à base de LPD8806 ;
- un mosfet pour pouvoir piloter un élément de puissance (je ne sais pas vraiment quoi pour le moment…).

`Plus d'informations sur cette carte <//github.com/hugokernel/Bleuette/wiki/Bleuette-Sensor-Shield>`_.

Version Raspberry-Pi
--------------------

Piloter Bleuette via un Arduino est plutôt aisé mais on se retrouve assez vite limité
en place, en puissance et en facilité pour développer.
J'ai donc décidé de faire une carte fille pour Raspberry-Pi, cette carte fille nommée simplement
Bleuette-Pi propose tout ce que fait la shield Arduino avec plein de choses en plus !

.. image:: bleuette/bleuettepi.jpeg
   :width: 300px
   :alt: Bleuette-Pi en cours de montage : le circuit imprimé dédié à la Raspberry-Pi et ses composants.
   :target: bleuette/bleuettepi.jpeg

Voici ses caractéristiques :

- gestion de **14 servos** (toujours de manière synchrone) ;
- **mesure du courant** consommé par les servos ;
- **mesure de la tension** de la batterie ;
- connexion pour une carte GY-27 contenant un **accéléromètre et un compas** (via I2C) ;
- **16 entrées / sorties** compatibles 5V avec 2 lignes d'interruption,
  le tout commandé en I2C ;
- **6 entrées analogiques** ;
- **amplificateur audio** pour ajouter le son à votre Raspberry-Pi (à base de LM386) ;
- **5 entrées / sorties généralistes compatibles 5V** direct Raspberry +
  5 autres entrées/sorties disponible si le bus SPI n'est pas utilisé ;
- toutes les broches du SPI sont disponibles sur un connecteur et compatible 5V ;
- un module **horloge temps réel (RTC)** pour garder votre Raspberry Pi à l'heure !
- **4 lignes d'interruptions physiques**.

Son schéma de principe :

.. image:: bleuette/elec_schema_bleuettepi.png
   :width: 300px
   :alt: Schéma de principe de la carte Bleuette-Pi
   :target: bleuette/elec_schema_bleuettepi.png

`Toutes les informations sur cette carte sont disponibles sur le wiki <//github.com/hugokernel/Bleuette/wiki/BleuettePi>`_

BleuettePi montée sur un Raspberry-Pi (on aperçoit une petite carte bleue, c'est le GY-27
c'est une combinaison d'un accéléromètre et d'un compas) :

.. image:: bleuette/bleuettepi2.jpeg
   :width: 300px
   :alt: Bleuette-Pi montée et enfilées sur la Raspberry-Pi
   :target: bleuette/bleuettepi2.jpeg

Exemple de code en Python
-------------------------

Pour animer les pattes de Bleuette, il faut créer une séquence qui n'est rien
d'autre qu'une classe, voici un exemple qui fait faire une pompe à Bleuette :

.. code-block:: python

    class Seq_PushUp:
        # On donne un nom à notre séquence
        name = "Push Up"

        # La séquence de mouvement
        sequence = [
            [
                # Délai de 0.5 seconde
                0.5,
                [
                    FRONT, FRONT, MID, MID, BACK, BACK,     # Positions des servos de pattes (servos d'axe horizontal)
                    UP, UP, UP, UP, UP, UP                  # On place les pattes en haut (servos d'axe vertical)
                ],
                # Ici, on peut définir une callback qui sera appelée à chaque fois que les pattes
                # seront placées dans leur position voulue
                None
            ],
            [
                0.5,
                [
                    __, __, __, __, __, __,                 # On ne touche pas à la position horizontale des pattes
                    DOWN, DOWN, DOWN, DOWN, DOWN, DOWN      # On place les pattes en bas
                ],
                None
            ]
        ]

Maintenant, pour exécuter la séquence ci-dessus, il suffit du bout de code suivant :

.. code-block:: python

    from Bleuette import Bleuette

    B = Bleuette()

    # Fait faire 4 pompes à Bleuette
    B.Sequencer.forward(Seq_PushUp, 4)

Voilà, c'est aussi simple que ça !

Sur les nouvelles versions du code, j'ai ajouté un thread qui s'occupe uniquement d'envoyer
les ordres aux servos, ainsi, il est possible de faire d'autres tâches pendant ce temps.

`Tout le code pour jouer avec Bleuette <//github.com/hugokernel/Bleuette/tree/master/src/BleuettePi/Python>`_

Une vidéo des premiers mouvements de pattes de Bleuette pilotée par une Raspberry-Pi.

<iframe width="800" height="450" src="//www.youtube.com/embed/_7C_EJtj_3M" frameborder="0" allowfullscreen></iframe>


Fabriquer
:::::::::

Pour fabriquer votre propre Bleuette, il vous faudra :

Une CNC
-------

Pour les pièces du corps de Bleuette, il vous faudra avoir accès à une imprimante 3D
ou une découpe CNC, inutile d'en posséder une, il vous suffira de trouver le fablab
le plus proche de chez vous qui pourra vous orienter et vous aider dans leur réalisation.

`Fabriquer les pièces en plastique <//github.com/hugokernel/Bleuette/wiki/Fabriquer>`_.

L'électronique
--------------

Selon la version choisie, vous devrez vous procurer :

- 1 carte Arduino Leonardo + la Shield Bleuette ;
- 1 Raspberry-Pi + la carte fille Bleuette-Pi.

Pour la Shield Bleuette ou la carte fille Bleuette-Pi, 2 solutions :

- `fabriquer l'électronique <//github.com/hugokernel/Bleuette/wiki/%C3%89lectronique>`_ ;
- `ou vous les procurer sur cette page <//github.com/hugokernel/Bleuette/wiki/Commander>`_.


Pièces diverses
---------------

- 12 servos standard (type Futaba S3003) ;
- visserie, tiges, clips, pièces mécaniques diverses ;
- batterie, divers…

Tout ce matériel doit couter au maximum 250€, ce qui fait de Bleuette un robot hexapode très abordable,
notez que l'on trouve dans le commerce des équivalents à plus de 900€…

Participez !
::::::::::::

Bleuette est en perpétuel développement, vous pouvez suivre le dépôt GitHub pour
vous en rendre compte, le développement se poursuit sur différents axes :

- Logiciel : poursuite du développement en Python sur Raspberry, gestion de la webcam du RaspberryPi avec OpenCV ;
- Mécanique : développemement d'une tourelle 2 axes pour la webcam ;
- Électronique : ajout d'un watchdog sur la carte BleuettePi et développement de la carte de puissance.

Chacun peut apporter ses propres compétences dans un domaine particulier !

- `Le blog de développement : <http://www.digitalspirit.org/>`_ ;
- `toutes les sources de Bleuette <//github.com/hugokernel/Bleuette/>`_ ;
- `le wiki en français <//github.com/hugokernel/Bleuette/wiki/Accueil>`_.
