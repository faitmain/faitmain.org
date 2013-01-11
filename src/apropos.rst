A propos
========


Le projet
:::::::::

**Fait Main** est un magazine en ligne conçu par des bénévoles
passionés par la bidouille en général.

Plus d'infos dans `l'édito du premier numéro </janvier-2013/edit.html>`_.

**Fait Main** n'a pas de structure officielle, bien qu'il soit
question de monter une association à but non lucratif.

Les articles sont protégés par la licence `CC-By-NC-SA <https://creativecommons.org/licenses/by-nc-sa/2.0/>`_
et le site web est en licence `Apache v2.0 <https://www.apache.org/licenses/LICENSE-2.0.html>`_

Le projet est fondé et maintenu par `Tarek Ziadé <http://ziade.org>`_ mais
**Fait Main** est un projet open-source et a pour vocation de construire
une communauté de contributeurs, que ce soit pour l'écriture d'articles,
les relectures ou la conception et la mise à jour du site (code ou design)-
ou tout simplement pour proposer un sujet ou un auteur.

Si vous avec envie de participer il suffit de vous inscrire sur la
mailing list XXX et de vous présenter - ou bien de forker un de nos
`repositories sur Github <http://github.com/faitmain>`_.

Vous pouvez aussi contacter Tarek : tarek@faitmain.org

Le site web
:::::::::::

Le site web est un site statique généré avec un script `Python <http://www.python.org/>`_, et
des templates `Mako <http://www.makotemplates.org/>`_.

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

Le moteur de recherche est un `web service <https://github.com/faitmain/search.faitmain.org>`_
écrit avec `Cornice <http://cornice.readthedocs.org>`_,
basé sur `Xapian <http://xapian.org/>`_, appelé en Javascript depuis l'écran
de recherche. La base Xapian est mise à jour à chaque modification de contenu.