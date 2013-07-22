/*******/
/* LCD */
/*******/

#include "U8glib.h" // Inclut la librairie U8G
U8GLIB_ST7920_128X64 u8g(A0, A1, A2, U8G_PIN_NONE); // Câblage SPI

/*********/
/* servo */
/*********/

#include <Servo.h> 
Servo myservo;  // create servo object to control a servo
int ouvert = 115;    // position servo ouvert
int ferme=25; // position servo ferme

/*************/
/* Chronodot */
/*************/

#include <Wire.h>       // Communication avec le RTC
#include <Chronodot.h>  // Fonctions du Chronodot
#define CHRONODOT_ADDRESS 0x68
Chronodot RTC; 

/***********************************/
/* donnees temporelles nom de Zeus */
/***********************************/


// temps en cours
int heures; 
int minutes;
int secondes;

// temps de référence pour période de 24h
int heuresRef = 19; 
int minutesRef = 45;
int secondesRef = 30;

long delta=0; // difference 24h horloge-reference
long totalDelta=0; // total delta pour moyenne
long deltaMoyenne = 0; // moyenne des delta 

// Echelle des temps d'avance pour afficheur led

int borneMin = 0;
int borneInf = 20;
int borneSup = 40;
int borneMax = 60;


/**************************/
/* capteurs  et compteurs */
/**************************/

volatile unsigned long compteur=0; // compteur de passages
unsigned long compteurTotal = 0;
unsigned long compteurMoyenne = 0; // affichage du nombre moyen de comptages/jour
volatile int bitPassage=0; // switch pour passage
volatile int bitTerminal=0; //sitch fin de course
int reglage=0; // bit pour le mode reglage
int uptime = 0; // compteur de jours
int piezoPin = 10; // bipeur
int CapteurCentral = 3;
int CapteurFinCourse = 2;
int CapteurPoids = 12;
int contactPin = A3; // capteur feedback aiguille

volatile unsigned long millis1 = 0; // variables pour calculs temps de passage
volatile unsigned long millis2 = 0;

/*****************/
/* affichage LCD */
/*****************/

char tempsChar[10];
char compteurChar[7];
char compteurMoyenneChar[10];
char tempsReferenceChar[10];
char deltaChar[5];
char uptimeChar[5];
char deltaMoyenneChar[5];

// bouton d'allumage
#include <Bounce.h>
int bouton = 11; 
Bounce bouncer = Bounce( bouton,5 ); 
int push;
int afficheEcran = 13; // pin pour afficher ou non l'ecran
int ecranAllume = LOW;

/********/
/* Leds */
/********/

int led1 = 4; // rouge 1
int led2 = 5; // orange 1
int led3 = 6; // vert
int led4 = 7; // orange 2
int led5 = 8; // rouge 2

void setup(){
  // Serial.begin(9600);

  // mode test
  // minutesRef=minutesRef+1;
  // compteur=80330;

  // init. servo
  myservo.attach(9);  
  myservo.write(ouvert);

  // initialisation du chronodot
  Wire.begin(); 
  RTC.begin();
  // regle le chronodot sur l'heure de compilation, à ne faire qu'une fois puis à commenter
  // RTC.adjust(DateTime(__DATE__, __TIME__));   

  // bip 

  pinMode(piezoPin, OUTPUT);
  digitalWrite(piezoPin, LOW);

  // initHorloge(); // heure de démarrage

  pinMode(led1, OUTPUT);
  pinMode(led2, OUTPUT);
  pinMode(led3, OUTPUT);
  pinMode(led4, OUTPUT);
  pinMode(led5, OUTPUT);
  pinMode(bouton,INPUT);

  digitalWrite(bouton,HIGH); // pull_up
  pinMode(afficheEcran,OUTPUT); // pilotage transistor alim ecran
  digitalWrite(afficheEcran,LOW); // on eteint l'ecran

  u8g.setRot180(); // rotation ecran 180°

  /* capteurs */
  pinMode(CapteurCentral,INPUT); // capteur central
  digitalWrite(CapteurCentral,HIGH); // pull-up
  attachInterrupt(1, passage, RISING); 
  pinMode(CapteurFinCourse,INPUT); // capteur fin de course
  digitalWrite(CapteurFinCourse,HIGH); // pull-up
  attachInterrupt(0, terminal, RISING); 
  pinMode(CapteurPoids, INPUT);
  pinMode(contactPin,INPUT);
  digitalWrite(contactPin, HIGH);
}

void loop(){
  updateHeure(); // on lit l'heure

  if ( heures == heuresRef && minutes == (minutesRef-2)){ // quand on entre dans la dernière minute, on passe en mode réglage
    reglage=1; // on passe en mode réglage
  } 
  
  if (reglage == 1 && digitalRead(contactPin) == LOW && bitTerminal == 1){ // quand l'aiguille atteint le contacteur et que le balancier arrive en bout de course
    delta=((minutesRef*60)+secondesRef)-((minutes*60)+secondes); // on calcule l'avance pour affichage sur LCD et diodes
    if (delta > 0) { // si l'horloge avance 
      while (heures != heuresRef || minutes != minutesRef || secondes != secondesRef) { // on bloque le balancier le temps nécessaire
        myservo.write(ferme); // blocage balancier
        updateHeure(); 
      }
      reglage=0;
      uptime++; // on incrémente le compteur de jours
      if (uptime > 1) { // on ne prend pas en compte le 1er jour car les comptages sont partiels
        compteurTotal = compteurTotal + compteur;
        compteurMoyenne = compteurTotal/(uptime-1); // moyenne des comptages de balancier
        totalDelta = totalDelta+delta; // calcul moyenne delta
        deltaMoyenne = totalDelta/(uptime-1);
      }
      compteur = 0;
      myservo.write(ouvert); // on relache
    } 
  }

  if (bouncer.update ( )){ // on poll le bouton
    push=bouncer.read();
    if(push==0){ // allume l'écran quand on appuie sur le bouton
      if (ecranAllume == LOW) {
        ecranAllume = HIGH;
      }
      else {
        ecranAllume = LOW;
      }
      digitalWrite(afficheEcran,ecranAllume);
    }
  }


  if(bitPassage==1){ // quand on passe devant le capteur central
    delay(50); // delai de sécurité

    long difference = millis2-millis1;
    if (difference > 2000) compteur=compteur+1; //si plus de 2s entre 2 passages on en a rate un : on le rajoute
    bitPassage=0; // réinitialisation bit

    if(ecranAllume == HIGH){ // si l'écran est allumé
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

    if (reglage == 1 && digitalRead(CapteurPoids)==LOW){ // on bipe à chaque passage pendant les 120 dernières secondes s'il faut remonter les poids
      bip();
    }
    if (digitalRead(contactPin) == LOW){
      digitalWrite(led2, HIGH);
      digitalWrite(led4, HIGH);
    }

    // affichage de l'avance/retard sur les leds
    if (delta <= borneMin){
      indicateur(led5); // rouge 1
    }
    if (delta > borneMin && delta <= borneInf){ 
      indicateur(led4); // orange 1
    }
    if (delta > borneInf && delta <= borneSup){ 
      indicateur(led3); // vert
    }
    if (delta > borneSup && delta <= borneMax){ 
      indicateur(led2); // orange 2
    }
    if (delta > borneMax){ 
      indicateur(led1); // rouge 2
    }
  }
}

/*********************/
/* Fonctions de temps */
/*********************/

void updateHeure(){
  DateTime now = RTC.now();    // on lit l'heure en cours 
  heures = now.hour(), DEC;
  minutes = now.minute(), DEC;
  secondes = now.second(), DEC;
}

/**************/
/* Interrupts */
/**************/

void passage(){ // passage du balancier devant capteur central
  bitPassage=1;
  millis1 = millis2; // on mesure l'ecart entre deux passages pour etre sur qu'on n'en a pas rate
  millis2=millis();
  compteur=compteur+1;
  bitTerminal=0;
}
void terminal(){ // passage du balancier en fin de course
  bitTerminal=1;
}


/*****************************************/
/* Focntions pour l'affichage LCD et LED */
/*****************************************/

void draw() { // affichange écran
  u8g.setFont(u8g_font_6x12); // Utilise la police de caractère standard
  u8g.drawStr( 22, 8, "Val");
  u8g.drawStr( 80,8, "Ref");
  u8g.drawStr( 0, 20, "Ct");
  u8g.drawStr( 22,20, compteurChar);
  u8g.drawStr( 80,20, compteurMoyenneChar);
  u8g.drawStr( 0, 32, "Hr");
  u8g.drawStr( 22,32, tempsChar);
  u8g.drawStr( 80,32, tempsReferenceChar);
  u8g.drawStr( 0, 44, "Dt");
  u8g.drawStr( 22,44, deltaChar);
  u8g.drawStr( 80, 44, deltaMoyenneChar);
  u8g.drawStr( 0,56, "Ut");
  u8g.drawStr( 22, 56, uptimeChar);
}

String subzero(int valeur){ // ajoute une zero aux chiffres horaires < 10
  String resultat = String(valeur);
  if (valeur < 10){
    resultat = '0'+ resultat;
  }
  return(resultat);
}

char longToChar(long valeur, int taille, char cible[]){ // convertit les long en char affichables par l'écran
  String string = String(valeur);
  string.toCharArray(cible,taille);
}

char heureToChar(int h, int m, int s,  char cible[10]){ // convertit l'heure en char affichables par l'écran
  String heureString = String(subzero(h));
  String minuteString = String(subzero(m));
  String secondeString = String(subzero(s));
  String temps = heureString + ":" + minuteString + ":" + secondeString;
  temps.toCharArray(cible,10);
}

void indicateur(int led){ // eteint toutes les leds et allume la bonne
  for (int i=4; i <=8; i++){ // on eteint toutes les leds
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

void bip(){
  for (int i=0; i<150; i++){
    digitalWrite(piezoPin, HIGH);
    delay(1);
    digitalWrite(piezoPin, LOW);
    delay(1);
  }
}







