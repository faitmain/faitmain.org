.. _apropos:

A propos
========


Le projet
:::::::::

**Fait Main** est un magazine en ligne conçu par des bénévoles
passionnés par la bidouille en général.

Plus d'infos dans `l'édito du premier numéro </volume-1/edito.html>`_.

**Fait Main** n'a pas de structure officielle, bien qu'il soit
question de monter une association à but non lucratif.

Les articles sont protégés par la licence `CC-By-NC-SA 3.0 <https://creativecommons.org/licenses/by-nc-sa/3.0/deed.fr>`_
et le site web est en licence `Apache v2.0 <https://www.apache.org/licenses/LICENSE-2.0.html>`_

Le projet est fondé et maintenu par `Tarek Ziadé <http://ziade.org>`_ mais
**Fait Main** est un projet open-source et a pour vocation de construire
une communauté de contributeurs, que ce soit pour l'écriture d'articles,
les relectures ou la conception et la mise à jour du site (code ou design)-
ou tout simplement pour proposer un sujet ou un auteur.

Si vous avez envie de participer il suffit de vous inscrire sur la
`mailing list </mailing.html>`_ et de vous présenter - ou bien de forker
un de nos `repositories sur Github <http://github.com/faitmain>`_.

N'oubliez pas de lire `le guide à l'usage des auteurs </ecrire.html>`_

Vous pouvez aussi contacter Tarek : tarek@faitmain.org

Le site web
:::::::::::

Le site web est un site statique généré avec le moteur `kompost <https://github.com/faitmain/kompost>`_,
un script `Python <http://www.python.org/>`_ créé pour l'occasion, et des
templates `Mako <http://www.makotemplates.org/>`__.

Le contenu est au format `reStructuredText <https://fr.wikipedia.org/wiki/ReStructuredText>`_.
Ce format permet de générer les pages html mais aussi le PDF (spartiate), et dans le futur
un ePub, voir un magazine papier au format un peu plus léché.

Le site utilise `Bootstrap <http://twitter.github.com/bootstrap/>`_ pour un rendu correct
sur tous les périphériques. Les icônes sont de chez `Glyphicons <http://glyphicons.com>`_.

Le design est un derivé du thème *Amelia* du projet Bootswatch de
`Thomas Park <http://thomaspark.me>`_. Les polices de caractères viennent
de `Google Fonts <http://www.google.com/webfonts>`_

Chaque lien sortant est transformé en short link avec https://github.com/faitmain/short.faitmain.org.
Cette redirection permet de corriger d'éventuels liens cassés de manière
centralisée.

.. warning::

   Fait Main ajoute à tous les liens vers Amazon.fr un tag de référencement, qui rapporte
   au magazine un petit pourcentage des ventes réalisées si vous achetez sur cette boutique
   quelque chose. A terme, l'idée serait de voir si ce référencement permet de couvrir les
   frais d'hébergement du site.

   Conscients que c'est une option *opt-out* - nous envisageons aussi un modèle de dons,
   et les liens sont pour l'instant expérimentaux.


Le moteur de recherche est un `web service <https://github.com/faitmain/search.faitmain.org>`_
écrit avec `Cornice <http://cornice.readthedocs.org>`_,
basé sur `Xapian <http://xapian.org/>`_, appelé en Javascript depuis l'écran
de recherche. La base Xapian est mise à jour à chaque modification de contenu.


Le PDF
::::::

Le PDF est généré grâce à `rst2pdf <http://rst2pdf.ralsina.com.ar>`_, qui lui même utilise
`ReportLab <http://www.reportlab.com/software/opensource/rl-toolkit/>`_.

La mise en page est spartiate mais suffisante pour une lecture sur écran.

Informations légales
::::::::::::::::::::

Magazine publié en France. Numéro ISSN: 2261-8376 en cours d'obtention.

Contact & adresse:

    Tarek Ziadé - tarek@faitmain.org
    6 rue de l'Eglise
    21540 Turcey
    France


- **Éditeur** - Tarek Ziadé
- **Directeur de la publication** - Tarek Ziadé


Donnée personnelles stockées: chaque accès au site est stocké dans un fichier de log
à des fins de statistiques - mais **les adresses IP ne sont pas collectées** et
le serveur ne contact aucun service tiers.


