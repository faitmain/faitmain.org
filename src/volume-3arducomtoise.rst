Horloge Arducomtoise
====================

:date: 2013-08-01
:category: électronique,informatique
:level: vulgarisation, moyen
:author: Vincent Becker
:licence: By-Sa-3.0


.. figure:: comtoise/arducomtoise2.jpg
   :alt:    Arducomtoise et son vieux cadre rond à chiffres romains
   :target: comtoise/arducomtoise2.jpg 

  ArduComtoise, l'horloge comtoise la plus précise du monde

Je possède dans ma cuisine une très belle horloge comtoise héritée de mes
grands-parents. Si la précision de la mécanique est déjà assez épatante au
départ, j'ai chargé une Arduino de l'améliorer encore. Au vu de ses
caractéristiques techniques (balancier sur l'avant typique de la deuxième
moitié du XIXe siècle mais échappement à couronne et non à ancre typique de la
première moitié), cette horloge doit dater du milieu du XIXe siècle.

Le cadran mentionne Munster, en Alsace, comme ville d'origine, mais il s'agit
bien d'une comtoise. Les mouvements étaient fabriqués à Morez près de
Pontarlier dans le Haut Doubs puis expédiés nus dans toute l'Europe. Les
façades, caisses et poids étaient ensuite produits sur le lieu de destination,
portant mention de l'horloger local.

Elle possède un mouvement situé assez haut (environ 2m10) avec comme
garde-temps un balancier d'environ 1m20. Deux poids assurent la réserve
d'énergie, l'un pour le mouvement, l'autre pour la sonnerie. Elle sonne les
heures pleine avec répétition et les demi-heures. Il faut la remonter une fois
par semaine.

Le balancier est de type lenticulaire, monté sur un ruban métallique simple
avec un petit jeton de réglage permettant de faire varier la hauteur, et donc
la période, du pendule. Ce type de monture a l'inconvénient, du fait de la
dilatation, de rendre la période du balancier sensible à la température,
problème qui sera corrigé sur les modèles plus tardifs avec des montures plus
complexes auto-compensées. Dans des conditions de température bien stables, la
tenue de l'heure est très bonne, avec une dérive de quelques secondes par jour.

Mais on peut faire mieux ! C'est une Arduino qui va s'en charger.


ArduComtoise
::::::::::::

<iframe width="800" height="450" src="//www.youtube.com/embed/96fAYLu30QA" frameborder="0" allowfullscreen></iframe>


Pas question, dans ce projet, de toucher à la mécanique très sensible de
l'horloge elle-même. Tout se passe sans contact ou presque.

Un module Chronodot sert de garde-temps, avec une dérive typique de moins de 2s
par mois. La comtoise est réglée pour avancer légèrement (environ 30 secondes
par jour). Il suffit dès lors de retenir le balancier le temps nécessaire grâce
à un servo une fois par 24h pour conserver la précision de l'horloge
indéfiniment. Cela implique de déterminer précisément quand l'horloge a fait
deux tours complets (soit 24h).

Première approche : et Arduino comptait, comptait…
::::::::::::::::::::::::::::::::::::::::::::::::::

Dans un premier temps, j'ai voulu faire en sorte que le système soit totalement
invisible de l'extérieur : pas question donc de mettre un feedback sur les
aiguilles. Je suis parti sur une première solution consistant à compter le
nombre de passages de balancier effectués par l'horloge en 24h, le tout sans
contact.

En bas de la caisse de l'horloge, un capteur optique (un couple
émetteur/récepteur IR) compte les passages du balancier. Ce dernier effectue 80
350 passages en 24h, soit une période d'environ 1,07 secondes.

Lorsque les 80 350 passages de balancier ont été comptés et donc que 24h ont
passé sur l'horloge, l'Arduino fait pivoter un servo de 90° pour bloquer le
balancier. Comme l'horloge avance, l'Arduino maintient le balancier bloqué
jusqu'à ce que 24h aient passé sur le Chronodot puis le relâche en faisant
pivoter le servo en sens inverse.

Il est important de bloquer le balancier en bout de course afin qu'il reprenne
suffisamment d'élan pour repartir. Un deuxième capteur se charge de détecter ce
moment. On ne peut pas utiliser ce même capteur pour compter car lorsque le
balancier vient d'être relâché, sa course est trop courte pour qu'il revienne
jusqu'à ce capteur ; on raterait donc des passages et toute la précision du
montage repose sur un comptage précis.

Il arrive, sans que j'arrive à savoir pourquoi, que le détecteur rate un
passage. C'est rare, mais le bon comptage est vraiment critique pour le
fonctionnement du système. Le temps écoulé entre deux passages est donc calculé
et, s'il est supérieur à 2 secondes, c'est qu'on en a raté un et un passage est
rajouté « artificiellement ».

Limites du système
------------------

Ce système marche parfaitement entre deux remontages. Mais il se heurte à un
problème insoluble : lors du remontage, l'horloge recule aléatoirement de 10 à
15 secondes du fait des divers jeux internes de la mécanique.

On pourrait intégrer un temps moyen dans la calibration pour compenser, mais
c'est loin d'être idéal. J'ai donc changé d'approche.

Deuxième approche: feedback
:::::::::::::::::::::::::::

.. figure:: comtoise/feedback.jpg
   :alt:    Dispositif métallique relié à un fil rouge et à une palette en plastique transparent un peu pliée par l’aiguille qu’elle bloque
   :target: comtoise/feedback.jpg 

   Le capteur de feedback

J'ai dû me résoudre à employer la solution rejetée en première instance mais
qui semble la seule parfaitement fiable, à savoir un feedback sur les
aiguilles.

Celui-ci est constitué d'un micro-switch actionné par une came elle-même
actionnée par le passage de la grande aiguille qui appuie sur une palette en
plastique transparent rigide (un morceau de blister d'emballage de piles) pour
être aussi invisible que possible.

Après tests, le micro-switch se déclenche à 45 minutes et 30 secondes de chaque
heure, plus ou moins 3 secondes compte tenu de l'élasticité des divers éléments
(palette transparente et micro-switch lui-même). Ce n'est pas gênant, car ce
petit décalage n'est par définition pas cumulatif.

Une fois toutes les 24h (un peu avant 19h45), l'Arduino passe en mode réglage,
c'est à dire qu'elle va bloquer le balancier dès que le micro-switch va se
déclencher (donc quand l'horloge indiquera 19:45:30) pour le relâcher au bon
moment. L'horloge étant réglée pour avancer de 30s par jour, le système relâche
le balancier avec environ 15 secondes de retard sur l'heure juste : en tenant
compte de toutes les incertitudes, l'heure indiquée par l'horloge est donc
indéfiniment décalée au maximum de 20s par rapport à l'heure du Chronodot.

Mais revoyons la scène au ralenti.

En début de script, l'heure de référence (qui sert au recalage) est définie:

.. code-block:: c++

    // temps de référence pour période de 24h
    int heuresRef = 19;
    int minutesRef = 45;
    int secondesRef = 30;

Dans la boucle *loop()* l'action se décompose alors comme suit.

Au début de la séquence, on lit l'heure sur le Chronodot grâce à la fonction
*updateHeure()* qui renseigne les variables heures, minutes et secondes (en les
convertissant en décimal au passage) :

.. code-block:: c++

    void updateHeure(){
    DateTime now = RTC.now();    // on lit l'heure en cours
    heures = now.hour(), DEC;
    minutes = now.minute(), DEC;
    secondes = now.second(), DEC;
    }

Puis lorsqu'on atteint les deux dernières minutes avant l'heure de référence,
l'horloge passe en mode « réglage » :

.. code-block:: c++


    if ( heures == heuresRef && minutes == (minutesRef-2)) {
        // quand on entre dans les deux dernières minutes, on passe en mode réglage
        reglage = 1;
    }

Deux événements sont alors surveillés : l'activation du microswitch par la
grande aiguille (passage à LOW de contactPin) et l'arrivée en bout de course du
balancier, détectée grâce à une interruption mise sur le capteur infrarouge
correspondant et qui fait passer la variable bitTerminal à 1. Quand ces deux
conditions sont remplies, le balancier est bloqué par rotation du servo jusqu'à
ce que l'heure de référence soit atteinte, puis le balancier est relâché. On
sort alors du mode réglage et on calcule différentes statistiques pour
affichage sur les outils de monitoring (écran LCD et indicateur à LEDs, voir
plus bas).

.. code-block:: c++

    if (reglage == 1 && digitalRead(contactPin) == LOW && bitTerminal == 1) {
        // quand l'aiguille atteint le contacteur et que le balancier arrive en bout de course
        // on calcule l'avance (delta) pour affichage sur LCD et diodes
        delta=((minutesRef*60)+secondesRef)-((minutes*60)+secondes);

        if (delta > 0) { // si l'horloge avance
          while (heures != heuresRef || minutes != minutesRef || secondes != secondesRef) {
            // on bloque le balancier jusqu'à ce que l'heure de référence soit atteinte
            myservo.write(ferme); // blocage balancier
            updateHeure(); // lecture de l'heure sur le Chronodot
        }

        reglage=0; // on sort du mode réglage
        uptime++; // on incrémente le compteur de jours d'uptime

        if (uptime > 1) {
            // on calcule les stats pour affichage sur le LCD.
            // On ne prend pas en compte le 1er jour car les comptages sont partiels
            compteurTotal = compteurTotal + compteur;
            compteurMoyenne = compteurTotal/(uptime-1); // moyenne des comptages de balancier
            totalDelta = totalDelta+delta;
            deltaMoyenne = totalDelta/(uptime-1); // calcul moyenne du décalage quotidien
        }

        compteur = 0; // le compteur de passages est remis à 0
        myservo.write(ouvert); // on relache le balancier
        }
    }

Indicateurs et accessoires
::::::::::::::::::::::::::

.. figure:: comtoise/montage.jpg
   :alt:    Montage d’une Arduino reliée via pleins de câbles de couleurs différentes à la batterie, au dispositif précédemment décrit (hors-champ) et à un petit écran LCD (décrivant diverses données comme l’heure précise, le compte, leurs références, etc.) collé sur un circuit imprimé, le tout tenu collé sur un montage en bois.
   :target: comtoise/montage.jpg 

   Le montage

Histoire de ne pas tout faire à l'aveugle, des indicateurs permettent de
monitorer le bon fonctionnement du système.

L'écran LCD
-----------

Pour suivre un peu ce qui se passe, un écran LCD est connecté à l'Arduino. Il
s'agit d'un écran rétro-éclairé de 128×64 pixels acheté moins de 15 euros sur
Dealextreme, sur les bons conseils de Skywodd qui nous fait en plus la grâce
d'`un tuto complet sur son utilisation
<http://skyduino.wordpress.com/2012/05/25/arduino-ecran-lcd12864-dealextreme-pas-chere-et-puissant/>`_.

L'affichage se divise en 2 colonnes : les valeurs courantes et les valeurs de
référence.

- la première ligne indique le nombre de passages de balanciers comptés depuis
  le dernier réglage et le nombre moyen par 24h depuis le lancement du système ;
- la deuxième ligne indique l'heure courante et l'heure de référence ;
- la troisième ligne indique l'avance de l'horloge en secondes et la moyenne
  depuis la mise en route du système ;
- la dernière ligne indique le nombre de jours écoulés depuis la mise en route
  (uptime).

Le premier jour de fonctionnement est ignoré dans les statistiques puisqu'il
est forcément partiel.

Pour l'affichage sur l'écran, il est nécessaire de formater les données au
préalable. L'écran LCD ne comprend que les chaînes caractères en tableau et les
données à afficher sont des chiffres. Une fonction *longToChar()* transforme donc
le chiffre *valeur* en chaîne de caractère *cible[]* de longueur *taille*.

.. code-block:: c++

    char longToChar(long valeur, int taille, char cible[]) {
      // convertit les long en char affichables par l'écran
      String string = String(valeur);
      string.toCharArray(cible,taille);
    }

Pour convertir l'heure, c'est le même principe via la fonction *heureToChar()*
avec en plus une fonction *subzero()* qui ajoute un zéro aux valeurs inférieures
à 10 :

.. code-block:: c++

    char heureToChar(int h, int m, int s, char cible[10]) {
      // convertit l'heure en char affichables par l'écran
      String heureString = String(subzero(h));
      String minuteString = String(subzero(m));
      String secondeString = String(subzero(s));
      String temps = heureString + ":" + minuteString + ":" + secondeString;
      temps.toCharArray(cible, 10);
    }

    String subzero(int valeur){
      // ajoute une zero aux chiffres horaires < 10
      String resultat = String(valeur);
      if (valeur < 10) {
          resultat = '0'+ resultat;
      }
      return(resultat);
    }

Enfin la fonction *draw()* s'occupe de formatter toutes les données pour les
placer sur l'écran (voir `le tuto de Skywodd <un tuto complet sur son utilisation>`_ pour les détails) :

.. code-block:: c++

    void draw() {
      // affichage écran
      u8g.setFont(u8g_font_6x12); // Utilise la police de caractère standard
      u8g.drawStr(22, 8, "Val");
      u8g.drawStr(80,8, "Ref");
      u8g.drawStr(0, 20, "Ct");
      u8g.drawStr(22,20, compteurChar);
      u8g.drawStr(80,20, compteurMoyenneChar);
      u8g.drawStr(0, 32, "Hr");
      u8g.drawStr(22,32, tempsChar);
      u8g.drawStr(80,32, tempsReferenceChar);
      u8g.drawStr(0, 44, "Dt");
      u8g.drawStr(22,44, deltaChar);
      u8g.drawStr(80, 44, deltaMoyenneChar);
      u8g.drawStr(0,56, "Ut");
      u8g.drawStr(22, 56, uptimeChar);
    }

Pour générer l'affichage, toutes les conversions sont faites et les caractères
sont envoyés à l'écran par appel de la fonction *draw()*. A noter que l'écran ne
s'allume que si le bouton-boussoir correspondant a été pressé, faisant passer
la variable *ecranAllume* à 1. Si on le presse à nouveau la variable repasse à 0
et l'écran s'éteint.

.. code-block:: c++

    if (ecranAllume == HIGH) {
        // si l'ecran est allume
        // conversions pour l'ecran
        longToChar(compteur,7,compteurChar);
        longToChar(compteurMoyenne,7,compteurMoyenneChar);
        longToChar(delta,5,deltaChar);
        longToChar(uptime,5,uptimeChar);
        longToChar(deltaMoyenne,5,deltaMoyenneChar);
        heureToChar(heures,minutes,secondes,tempsChar);
        heureToChar(heuresRef,minutesRef,secondesRef,tempsReferenceChar);
        u8g.firstPage(); // Sélectionne la 1er page mémoire de l'écran
        do {
            draw(); // Redessine tout l'écran
        }
        while(u8g.nextPage()); // Sélectionne la page mémoire suivante
    }


L'indicateur lumineux
---------------------

Un indicateur lumineux constitué de LEDs permet en outre de surveiller la
dérive de l'horloge. Lorsque celle-ci est dans la « zone acceptable » (de 20 à 40
secondes) une diode verte s'allume. De 0 à 20 secondes ou de 40 à 60 secondes,
une diode orange signale la dérive. En cas de retard, ou d'avance supérieure à
60 secondes, une diode rouge signale le problème.

L'avantage de l'indicateur lumineux est que, contrairement à l'écran LCD, il
est visible en permanence par la vitre de la caisse, il n'est donc pas
nécessaire d'ouvrir l'horloge pour le consulter.

Pour l'affichage, rien de bien compliqué. les seuils d'activation sont définis
en début de script :

.. code-block:: c++

    // Echelle des temps d'avance pour afficheur led
    int borneMin = 0;
    int borneInf = 20;
    int borneSup = 40;
    int borneMax = 60;

La fonction *indicateur()* se charge d'éteindre toutes les LEDs puis d'allumer la
bonne. Celles-ci sont placées sur des pins consécutifs ce qui simplifie un peu
le code. Les cas particuliers de l'activation du microswitch par la grande
aiguille (allumage des deux LEDs orange) et de la détection des poids de
l'horloge (allumage des deux LEDs rouges) sont pris en compte en début de
fonction (voir paragraphe suivant).

.. code-block:: c++

    void indicateur(int led) { // eteint toutes les leds
      for (int i=4; i <=8; i++) {
          digitalWrite(i, LOW);
      }
      if (digitalRead(CapteurPoids)==LOW) { // si on voit le poids on allume les 2 leds rouges
          digitalWrite(led1,HIGH);
          digitalWrite(led5,HIGH);
      }
      else {
          digitalWrite(led, HIGH); // sinon on allume la LED d'indication du delta
      }
    }

On appelle ensuite la fonction à chaque passage du balancier devant le capteur
central, l'afficheur est donc mis à jour toutes les 1.07 secondes :

.. code-block:: c++

    // affichage de l'avance/retard sur les leds
    if (delta <= borneMin) {
      indicateur(led5); // rouge 1
    }
    if (delta > borneMin && delta <= borneInf) {
      indicateur(led4); // orange 1
    }
    if (delta > borneInf && delta <= borneSup) {
      indicateur(led3); // vert
    }
    if (delta > borneSup && delta <= borneMax) {
      indicateur(led2); // orange 2
    }
    if (delta > borneMax) {
      indicateur(led1); // rouge 2
    }


Le remontage des poids
----------------------

Le remontage des poids doit s'effectuer chaque semaine (enfin plutôt tous les 6
jours et demi, je pense que la caisse de l'horloge a été raccourcie au cours de
son histoire pour passer sous un plafond trop bas).

Pour ne pas rater ce moment, un détecteur de proximité (un `mini télémètre
infrarouge
<http://www.gotronic.fr/art-capteur-de-distance-sen0042-19371.htm>`_) détecte
quand le poids arrive en bas de l'horloge, environ 24h avant qu'il ne touche le
sol et que l'horloge s'arrête.

Sitôt le poids détecté, des Leds rouges s'allument sur l'indicateur lumineux.
Enfin, un buzzer piézo-électrique émet des bips pendant 2 minutes avant le
blocage du balancier.

Chose curieuse, la fonte noire dont est fait le poids était totalement
invisible pour le capteur infrarouge. J'ai donc dû l'emballer dans une feuille
de papier noir pour le rendre détectable (mais pas trop laid quand même).

L'alimentation
--------------

Lors de ma première approche qui impliquait le comptage des passages de
balancier, il était très important que l'Arduino ne se remette pas à zéro en
cas de coupure de courant par exemple.

J'ai donc intercalé un module `LipoRider
<faitmain.org/volume-2/batterie.html>`_ qui permet à une batterie de 2000 mAh
de prendre momentanément le relais en cas de défaillance de l'alimentation
principale. Avec le capteur sur aiguille de la deuxième approche cette
précaution se justifie moins, mais je l'ai tout de même laissée.

Évolution
:::::::::

Parmi les évolutions possibles, j'envisage l'ajout d'une connexion à un serveur
NTP via un shield Ethernet pour recaler le Chronodot périodiquement sur une
horloge atomique. On aura ainsi l'horloge comtoise la plus précise de
l'Univers.

Le code
:::::::

Je vous livre enfin le code complet du système. Ma formation universitaire étant
l'Histoire, je compte sur l'indulgence des développeurs professionnels !

`Le code de l'ArduComtoise. <comtoise/arduComtoiseFinal.ino>`_

