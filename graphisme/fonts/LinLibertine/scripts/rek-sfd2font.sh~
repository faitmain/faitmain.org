#!/bin/sh
mkdir Fonts
echo "Ordner 'Fonts' angelegt"
cd SRC 
for i in *.sfd; do  
    SONG=`basename "$i" .sfd`  
    if [ -e "$i" ]; then  
echo "Bailly: Generiere OTF aus" $i
../scripts/bailly-2.sh "$i" otf
mv *.otf ../Fonts
echo "OTFs nach 'Fonts' verschoben"
    fi  
done
for i in *.sfd; do  
    SONG=`basename "$i" .sfd`  
    if [ -e "$i" ]; then  
echo "Bailly: Generiere TTF aus" $i
../scripts/bailly-2.sh "$i" ttf
    fi
mv *.ttf ../Fonts  
echo "TTFs nach 'Fonts' verschoben"
done

#Original:
#!/bin/sh  
#for i in *.wav; do  
#    SONG=`basename "$i" .wav`  
#    if [ -e "$i" ]; then  
#        oggenc -o "$SONG.ogg" "$i"  
#    fi  
#done  