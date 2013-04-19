Comment ouvrir une puce ?
=========================

:date: 2013-05-01
:category: autre
:level: insolite
:author: Zeptobars
:translator: Tarek Ziadé


.. note::

   Cet article est une traduction adaptée de l'article de Zeptobars
   originalement paru en anglais & russe à
   `cette addresse <http://zeptobars.ru/en/read/how-to-open-microchip-asic-what-inside>`_.


Les puces électroniques sont des petites boîtes noires. Si elles fonctionnent,
aucune raison d'essayer de regarder dedans. Mais comment faire si l'on a *envie*
de regarder dedans ?

Dans cet article, nous expliquons comment *ouvrir* des puces électroniques
et ce qu'on peut trouver à l'intérieur.

.. warning::

   Toutes les manipulations de cet article sont faites avec de **l'acide chaud**
   et sont extrêmement dangeureuses. Seuless des personnes aguerries et habilitées
   à faire ce genre de manipulations, avec le materiel de protection adéquat
   (gants anti-acide, lunettes de protection, combinaison, cheminée d'extraction
   des fumées etc.) peuvent effectuer ces opérations.

   Rappelez-vous que vous n'avez que deux yeux.

   Cet article est juste informatif, n'essayez pas ces manipulations à la maison.


Ouvrir une puce
:::::::::::::::

Prenez des puces qui vous intéressent et de l'acide sulfurique concentré.
Le récipient à utiliser doit être fermé mais pa hermétique, pour laisser les
fumées s'échapper - c'est très important.

Chauffez l'acide jusqu'à sa température d'ébulition (300ºC). La matière blanche
au fond est du bicarbonate de soude qui est utilisé pour neutraliser les
projections accidentelles d'acide et une partie de la fumée.

.. figure:: puce/acid1.jpg

  Le bain d'acide


Après 30 à 40 minutes, l'acide brûle le plastique en carbone:

.. figure:: puce/acid2.jpg

   Dépôt de carbone en surface.


Une fois le mélange refroidi, nous pouvons trier les éléments qui sont prêts pour
la prochaine étape de ceux qui ont encore besoin d'un bain d'acide. Les
composants enrobés d'une grosse couche ont en général besoin de trois bains.

.. figure:: puce/acid3.jpg

   Résultat du premier bain.


Si des morcaux de carbones sont coincés dans la puce et ne peuvent être retirés
mécaniquement - ils peuvent en général être retirés dans un bain d'acide
concentré maintenue à une température plus basse (~110-120 °C)

.. figure:: puce/nitric.jpg

   Nettoyage de résidus.


Regardons de plus prêt
::::::::::::::::::::::

.. note::

   Les images ci-dessous peuvent être cliquées pour afficher une image haute résolution.
   Attention, les images en haute résolution pèsent entre 5 et 25Mb.

   Les couleurs ont été saturées pour mieux visualiser les circuits.


.. figure:: puce/PL2303HX.jpg
   :target: http://s.zeptobars.ru/PL2303HX-HD.jpg

   PL2303HX - convertisseur USB <> RS232 converter.
   Cette puce est présente dans les Arduino.

.. figure:: puce/LM1117.jpg
   :target: http://s.zeptobars.ru/LM1117-HD.jpg

   LM1117 — Regulateur ldo


.. figure:: puce/74HC595.jpg
   :target: http://s.zeptobars.ru/74HC595-HD.jpg

   74HC595 - Shift register 8 bits.


.. figure:: puce/NXP-74AHC00D.jpg
   :target: http://s.zeptobars.ru/NXP-74AHC00D-HD.jpg

   NXP-74AHC00D - porte NAND 2 entrées.

   La NXP-74AHC00 est un bon exemple des anciennes techniques de
   gravage en 1µm qui sont encore utilisées de nos jours.

.. figure:: puce/MT4C1024.jpg
   :target: http://s.zeptobars.ru/MT4C1024-HD.jpg

   Micron MT4C1024 - 1 mebibit (220 bit) de RAM dynamique
   Très utilisé dans les ordinateurs de la génération
   286 et 386 dans les années 90.

   Taille des semi-conducteurs: 8662 x 3969 µm.

.. figure:: puce/amd-palce16V8h.jpg
   :target: http://s.zeptobars.ru/amd-palce16V8h-HD.jpg

   AMD Palce16V8h GAL est un tableau AND de 32 x 64.
   Les puce GAL (Generic array logic) sont des puces reprogrammables,
   ancêtres des `FPGA <https://fr.wikipedia.org/wiki/FPGA>`_ et
   CPLD.

   Taille des semi-conducteurs: 2434 x 2079 µm, gravage 1µm


.. figure:: puce/atmel-attiny13a.jpg
   :target: http://s.zeptobars.ru/atmel-attiny13a-HD.jpg

   ATtiny13A — un des plus petits micro-contrôleurs. Seulement 1kb de
   mémoire flash et 32 bytes de SRAM.

   La taille des semi-conducteurs est étonamment grosse (1620 X 1640 µm)
   Gravage en 500nm

.. figure:: puce/atmega8.jpg
   :target: http://s.zeptobars.ru/atmega8-HD.jpg

   ATmega8 — un des micro-contrôleurs 8 bit les plus populaires.

   Taille des semi-conducteurs: 2855 x 2795 µm, gravage 500nm


.. figure:: puce/kr580ik80a.jpg
   :target: http://s.zeptobars.ru/kr580ik80a-HD.jpg

   KR580IK80A renommé KR580VM80A par la suite - un des microprocesseurs
   russe les plus répandus.

   Contrairement aux rumeurs, ce n'est pas un clone de l'Intel
   8080A (ou 8080), mais un redesign compatible. Plusieurs parties sont
   similaires mais le routage et le placement des pads est différent.

   Les plus petites lignes font 6µm


.. figure:: puce/STM32F100C4T6B.jpg
   :target: http://s.zeptobars.ru/STM32F100C4T6B-HD.jpg

   STM32F100C4T6B, le plus petit micro-contrôleur fabriqué par STMicroelectronics et
   basé sur un coeur ARM Cortex-M3.

   Taille des semi-conducteurs: 2854 x 3123 µm

.. figure:: puce/altera-epm7032.jpg
   :target: http://s.zeptobars.ru/altera-epm7032-HD.jpg

   Altera EPM7032 — une `CPLD <https://fr.wikipedia.org/wiki/Complex_Programmable_Logic_Device>`_ qui a roulé sa bosse.

   Une des dernières fonctionnant encore sur du 5v.

   Taille des semi-conducteurs: 3446 x 2252 µm, gravage 1µm


.. figure:: puce/mifare.jpg
   :target: http://s.zeptobars.ru/mifare-HD.jpg

   Puce MIFARE, utilisée dans les carte RFID du métro de Moscou.

   Taille des semi-conducteurs: 640x620 µm.


Voila. Les boîtes noires sont ouvertes :-)




