Station météo USB
=================

:date: 2013-04-01
:category: electronique,informatique,ecologie
:level: vulgarisation, moyen
:author: Tarek Ziadé

Une station météo est composée d'une ensemble de senseurs qui
relèvent des informations comme la température, la pression
atmosphérique ou encore l'humidité et les transmettent à un
afficheur ou à un autre périphérique de traitement.

Les stations météos vendues dans le commerce sont en générale des boîtes
noires. Pour les plus basiques, elles affichent sur un écran LCD les
informations des senseurs.

Les stations un peu plus haut de gamme conservent un historique des
données ou proposent un afficheur sans fil déporté, mais on grimpe
très vite dans les prix.

Et il faut compter 2000 euros pour les stations haut de gamme comme
la station Capricorn 2000EX qui à défaut de faire le café,
possède les senseurs de base ainsi qu'un pluviomètre et un
anénomètre.

.. figure:: station/Cap2000EX-web.jpg

   Station Capricorn 2000EX - Columbia Weather System

Les stations haut de gamme sont par contre communicantes, et
donc programmables, que ce soit par USB, Wifi ou tout autre moyen
de communication que le fabricant a fourni.

Le gros interêt de communiquer avec une station est de pouvoir
conçevoir sa propre application avec les données collectées ou
de les transmettre à une application existante.

Un exemple très intéressant est le projet `Wunderground <http://www.wunderground.com/weatherstation/about.asp>`_
qui centralise toutes les informations envoyées par des particuliers
pour fournir une carte météo assez précise.

Wunderground reste un projet commercial, et je n'ai pas trouvé de projet
libre basé sur un protocol ouvert (je cherche encore..) c'est dommage

Les stations du commerce de toute façon sont en général basées sur
des protocoles et/ou des logiciels propriétaires. Quand on connaît
le prix des senseurs seuls, c'est assez rageant.

.. figure:: station/RHT03.jpg
   :target: https://www.sparkfun.com/products/10167

   Senseur humidité + température (Sparkfun, $9.95)


Les puces Yocto
---------------

XXX

decrire les puces - prix un peu onereux mais tout integré,
dire qu'il manque l'altimetre donc faut connaitre son altitude
pour calculer la vrai pression

https://www.sparkfun.com/products/8942
https://www.sparkfun.com/products/10586
https://www.sparkfun.com/products/11084
https://www.sparkfun.com/products/10988


souder les composants weather et light ensembles


Le projet
---------

XXX




