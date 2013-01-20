Petit guide à l'usage des auteurs
=================================

Format général
::::::::::::::

Le format des articles est le `reStructuredText <http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html>`_.
Ce format est très simple et vous pouvez lire `ce document <http://docutils.sourceforge.net/docs/user/rst/quickstart.html>`_
d'introduction.

Pour **Fait Main**, chaque article doit commencer par un titre souligné par des
signe *=* (égal), puis chaque sections par un titre souligné par un signe *:*
(deux points).

L'article commence par une série de méta-données:

- **date** — la date de l'article
- **category** — les catégories, en minuscule, séparées par des virgules, sans
  accents, à prendre dans : ecologie, informatique, electronique, art,
  hacktivisme, cuisine.
- **level** — le niveau de lecture: avancé, vulgarisation, moyen, etc. Champ libre.
- **author** — l'auteur de l'article au format **Prénom Nom** — Kompost va faire
  un lien entre l'article et la page */auteurs/prenom_nom.html* donc respectez bien
  le format.


Exemple::

    What The Feuille ?
    ==================

    :date: 2012-12-12
    :category: ecologie,informatique
    :level: vulgarisation
    :author: Tarek Ziadé

    Du texte...

    Section 1
    :::::::::

    Du Texte...

    ----

    Du texte

    Section 2
    :::::::::

    Du Texte


Notez que les saut de section (*----*) sont remplacés par des balises **HR**
qui apparaissent comme des petites scies dans la CSS faitmain.


Images
::::::


Les photos doivent être au format JPEG, en mode progressif en qualité 85%, et d'une
largeur de 800 pixels et 72 dpi.

Chaque photo peut avoir une version *retina* avec 1600 pixels. Le nom du fichier
dans ce cas doit être **nom_fichier@2x.jpg**, et le site séléctionnera automatiquement
la version haute résolution sur les écrans rétina.

Une image est placé à coté de l'article et mise dans une balise **figure**::

    .. figure:: nom_fichier.jpg

      :target: http://un.lien.clickable(optionel)

      La légende de l'image (obligatoire)


Pour afficher une image plus petite mais conserver son redimensionnement automatique,
il faut utiliser l'option **scale** qui est un pourcentage.

Exemple pour une image qui fera 50% de l'écran et sera centrée ::

    .. figure:: nom_fichier.jpg

      :scale: 50

      La légende de l'image (obligatoire)


Pour les petites images, le png est toleré.



