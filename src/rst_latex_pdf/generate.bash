#!/bin/bash

# Attention les noms des fichiers ne doivent pas contenir d'espace.
# Liste des fichiers .rst a inclure (dans l'ordre d'apparition des
# articles).
# - FILE_NAME doit être le nom du dossier dans lequel se trouve les
#             fichiers .rst
# - COVER_FILE_NAME est utilisé dans un script sed il faut laisser
#                   les '\' (les caractères de substitution
#                   semblent ne pas fonctionner dans un script).

# Valeurs par défaut. On peu imaginer les passer en paramètre
# par la suite :
# Le paramètre -4 indique un format 2 colonne en A4
# Le paramètre -5 indique un format 1 colonne en A5
# Le paramètre -n file attends le nom du volume a générer

function usage {

echo "Script generate.bash de génération du magazine faitmain.org"
echo
echo "Utilisation :"
echo
echo "./generate.bash [OPTIONS]"
echo
echo " -h affiche cette aide"
echo " -4 génère un format A4 en double colonnes"
echo " -5 génère un format A5 en simple colonne"
echo " -n fichier génère le volume 'fichier'"
echo
}

# Les valeurs par défaut.
VERSION=4
FILE_NAME="volume-3"
FILE_LIST="./${FILE_NAME}.filelist"
COVER_FILE_NAME="..\/${FILE_NAME}\/cover.pdf"
RST_EXT=rst
TEX_EXT=tex
RST_DEST="${FILE_NAME}.${VERSION}.${RST_EXT}"
TEX_DEST="${FILE_NAME}.${VERSION}.${TEX_EXT}"
FORM="A4" # Par défaut on génère le A4


while getopts "45hn:" opt; do
    case $opt in
        4 )
            FORM="A4"
            ;;
        5 )
            FORM="A5"
            ;;
        n )
            FILE_NAME=${OPTARG}
            FILE_LIST="./${FILE_NAME}.filelist"
            COVER_FILE_NAME="..\/${FILE_NAME}\/cover.pdf"
            RST_DEST="${FILE_NAME}.${VERSION}.${RST_EXT}"
            TEX_DEST="${FILE_NAME}.${VERSION}.${TEX_EXT}"
            ;;
        h )
            usage
            exit
            ;;
    esac;
done;

# Suppression des anciennes versions
rm -f "${RST_DEST}"
rm -f "${TEX_DEST}"

if [ -f Makefile ]
    then
        make distclean;
fi;

###
# Génération du .rst :


# Modification de l'IFS pour prise en compte des espaces dans
# les noms de fichiers (qui ne peuvent cependant pas contenir
# de caratctère de retour à la ligne !
# l'IFS est remis en place à la fin de la boucle.
OLD_IFS="${IFS}"
IFS=$'\n'
for a_file in $(cat "${FILE_LIST}"); do
  echo "Adding $a_file to ${RST_DEST}";
  cat "${a_file}" >> "${RST_DEST}";
  echo >> "${RST_DEST}";
  echo >> "${RST_DEST}";
done;
IFS="${OLD_IFS}"

# pandoc ne connais pas le style de code en c++ (mais c'est proche
# du c)
sed -e 's/code-block:: c++/code-block:: c/' -i "${RST_DEST}"

# pdflatex n'aime pas les .gif : remplacement avec des jpeg
# Ne pas oublier de générer les images au format jpeg (.jpg)
sed -e 's/\.gif/\.jpg/' -i "${RST_DEST}"

# Pour retrouver les figures ou les images depuis le dossier
# où nous sommes
echo "s/:target: /:target: ..\/${FILE_NAME}\//" > ./sed_script
echo "s/figure:: /figure:: ..\/${FILE_NAME}\//" >> ./sed_script
echo "s/image:: /image:: ..\/${FILE_NAME}\//" >> ./sed_script
sed -f ./sed_script -i "${RST_DEST}"

rm -f ./sed_script

echo "${RST_DEST} generated."

###
# Generation du Makefile :

cp ./Makefile.in ./Makefile
echo "s/_VERSION_/${VERSION}/" > ./sed_script
echo "s/_COVER_FILE_NAME_/${COVER_FILE_NAME}/" >> ./sed_script
echo "s/_FILE_NAME_/${FILE_NAME}/" >> ./sed_script
sed -f ./sed_script -i ./Makefile

rm -f ./sed_script

echo "Makefile generated."

###
# Génération du .tex :

case ${FORM} in
    A4 ) # Génération du format A4 en double colonnes.

        make "${TEX_DEST}"

        # Modification du tex pour changer l'aspect du code (une seule
        # colonne).
        sed -e 's/begin{Shaded}/debutcode/' -i "${TEX_DEST}"
        sed -e 's/end{Shaded}/fincode/' -i "${TEX_DEST}"

        # Pour les images (pas de multi colonne !)
        sed -e 's/^\\begin{figure}/\\debutcode\n\\begin{figure}/' -i "${TEX_DEST}"
        sed -e 's/^\\end{figure}/\\end{figure}\n\\fincode/' -i "${TEX_DEST}"

        echo
        echo "${TEX_DEST} generated."

        ###
        # Génération du PDF :
        make texpdf

    ;;
    A5 ) # Génération du format en A5 simple colonne.

        make "${FILE_NAME}.${VERSION}_A5.${TEX_EXT}"

        echo
        echo "${FILE_NAME}.${VERSION}_A5.${TEX_EXT} generated."

        ###
        # Génération du PDF :
        make a5texpdf

    ;;
esac

###
# Un peu de ménage :
make clean
