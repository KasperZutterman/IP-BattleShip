// *** Variabelen voor slepen boten (nieuw)***
float b1x; //plaats x-coordinaat positie boot 1
float b1y; //plaats y-coordinaat positie boot 1
float b2x; //plaats x-coordinaat positie boot 2
float b2y; //plaats y-coordinaat positie boot 2
float b3x; //plaats x-coordinaat positie boot 3
float b3y; //plaats y-coordinaat positie boot 3
float b4x; //plaats x-coordinaat positie boot 4
float b4y; //plaats y-coordinaat positie boot 4
float b5x; //plaats x-coordinaat positie boot 5
float b5y; //plaats y-coordinaat positie boot 5
int activeBoot = 0;
boolean bootAangeklikt = false;

boolean b1geplaatst = false;
boolean b2geplaatst = false;
boolean b3geplaatst = false;
boolean b4geplaatst = false;
boolean b5geplaatst = false;
// *** Variabelen voor slepen boten (nieuw)***

// init 2D bord array
int [][] bord_p; //spelbord gekozen door speler
int [][] bord_c; //spelbord gekozen door computer

PFont f;

int[] lengte_boten = {5, 4, 3, 2, 2}; //lijst met lengte schepen
int[] potentialT_x = {}; //lijst met potentiele x target posities
int[] potentialT_y = {}; //lijst met potentiele y target posities

// variabelen voor punten boten
int[] boot_c_x = {}; // lijst met positie boot volgens x
int[] boot_c_y = {}; // lijst met positie boot volgens y
boolean boot5_punten = false;
boolean boot4_punten = false;
boolean boot3_punten = false;
boolean boot2_punten = false;
boolean boot1_punten = false;
// variabelen voor punten boten
// **Variabelen**

// ***Basic + level 1***
int rows = 10; // aantal rijen in het bord (Y)
int cols = 10; // aantal kolommen in het bord (X)
int w = 60; // breedte van 1 cel
int h = 60; // hooghte van 1 cel
// ***Basic + level 1***

// ***level 2 ev***
/*
int rows = 20; // aantal rijen in het bord (Y)
 int cols = 20; // aantal kolommen in het bord (X)
 int w = 30; // breedte van 1 cel
 int h = 30; // hooghte van 1 cel
 */
// ***level 2 ev***

int start_x_comp = 40; // x beginpunt van spelbord computer
int start_y_comp = 10; // y beginpunt van spelbord computer
int start_x_player; // x beginpunt van spelbord player 
int start_y_player; // y beginpunt van spelbord player
int offset = 40; // afstand tussen de 2 spelborden
int pressedX; // laaste x coord waar de muis klikte binnen spelbord player
int pressedY; // laaste y coord waar de muis klikte binnen spelbord player
int cell_color; // de kleur van 1 cell op het bord
int boten_placed = 0; // hoeveel boten al op het spelbord staan
int schoten_p = 0; // hoeveel schoten al zijn gedaan door de player
int schoten_c = 0; // hoeveel schoten al zijn gedaan door de computer
int hit_door_player = 0; // hoeveel boten de player heeft geraakt van de computer
int hit_door_comp = 0; // hoeveel boten de computer van de speler heeft geraakt
boolean game_won; // == true als de player heeft gewonnen
boolean game_lost; // == true als de computer heeft gewonnen
int boats_placed_by_comp = 0; // hoeveelheid boten de computer heeft geplaatst
boolean bomHor = true; // de rotatie van de bom (standaard horizontaal)
int bom = 0; // welke bom er actief is (standaard 1*1 bom)
int punten = 0;
// **variabelen**

void setup() {

  // (nieuw)
  fullScreen();
  background(0);
  b1x = 540 - 60 + 640;
  b1y = height - 80;
  b2x = 360 - 30 + 640;
  b2y = height - 80;
  b3x = 420 + 640;
  b3y = height - 180;
  b4x = 60 + 640;
  b4y = height - 80;
  b5x = 60 + 640;
  b5y = height - 180;  
  // (nieuw)

  f = createFont("Arial", 16, true);

  background(0); // instellen achtergrondkleur
  fullScreen(); // fullscreen modus
  start_y_comp = start_y_player = ((height/2) - (h*(rows/2))); // start_y_comp en start_y_player bepaald zodat het gecentreed staat volgens de Y richting 
  start_x_player = (start_x_comp + (cols*w) + offset); // start_x_player bepalen zodat de offset tussen de 2 borden meegerekend wordt

  // init van spelboard als 2D array
  //bord_p = new int[rows][cols];
  //bord_c = new int[rows][cols];
  setEmptyBord();

  // deze funtie zorgt ervoor dat voor het spel de boten van de computer op het bord geplaats worden
  plaatsBoten();
}

void draw() {
  // (nieuw)
  background (0);
  textFont(f, 100);                  // STEP 3 Specify font to be used
  fill(127, 127, 127);                   // STEP 4 Specify font color 
  text("Punten: " + punten, 800, 100);
  // (nieuw)

  //dit is het spelbord voor alle boten zijn getekend
  if (boten_placed < 16) {
    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < cols; x++) {

        int temp = bord_c[y][x];
        display(temp, start_x_comp, start_y_comp, x, y);

        temp = bord_p[y][x];
        display(temp, start_x_player, start_y_player, x, y);
      }
    }
  }

  // eens alle boten geplaatst zijn verwisselen de spelborden van plaats
  else if (boten_placed == 16) {
    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < cols; x++) {

        int temp = bord_c[y][x];
        display(temp, start_x_player, start_y_player, x, y);

        temp = bord_p[y][x];
        display(temp, start_x_comp, start_y_comp, x, y);
      }
    }
    if (game_won) {
      textFont(f, 100);                  // STEP 3 Specify font to be used
      fill(0, 127, 0);                         // STEP 4 Specify font color 
      text("Gewonnen!", 100, 100);
    } else if (game_lost) {
      textFont(f, 100);                  // STEP 3 Specify font to be used
      fill(127, 0, 0);                         // STEP 4 Specify font color 
      text("Verloren!", 100, 100);
    }
  }


  //println("MouseX" ,mouseX);
  //bij hoover boven bord speler !!zolang niet alle boten zijn geplaatst!!
  if (boten_placed < 16) {
    if ((mouseX >= start_x_player && mouseX <= (start_x_player + w*cols)) && (mouseY >= start_y_player && mouseY <= (start_y_player + h*rows))) {
      int hovX = mouseX;
      int hovY = mouseY;
      int pos_x_bord = (hovX - start_x_player)/w;
      int pos_y_bord = (hovY - start_y_player)/h;
      // Als de speler net op de rand klikt wordt door de bovenstaande formule de coord 10, maar dit gaat niet binnen de array van 0-9, dus wordt de 10 als 9 aangenomen
      if (pos_x_bord == cols) {
        pos_x_bord = (cols - 1);
      }
      if (pos_y_bord == rows) {
        pos_y_bord = rows - 1;
      }

      /*
      if (bord_p[pos_y_bord][pos_x_bord] == 0 || bord_p[pos_y_bord][pos_x_bord] == 1) {
       fill(255, 0, 0);
       fill(60, 60, 60);
       rect(start_x_player + (pos_x_bord*w), start_y_player + (pos_y_bord*h), w, h);
       }
       */

      // (nieuw)
      if ((activeBoot == 5) && (!b5geplaatst)) {
        displayBoot(pos_y_bord, pos_x_bord, 5);
      } else if ((activeBoot == 4) && (!b4geplaatst)) {
        displayBoot(pos_y_bord, pos_x_bord, 4);
      } else if ((activeBoot == 3) && (!b3geplaatst)) {
        displayBoot(pos_y_bord, pos_x_bord, 3);
      } else if ((activeBoot == 2) && (!b2geplaatst)) {
        displayBoot(pos_y_bord, pos_x_bord, 2);
      } else if ((activeBoot == 1) && (!b1geplaatst)) {
        displayBoot(pos_y_bord, pos_x_bord, 2);
      }
      // (nieuw)
    }
  }
  //bij hoover boven bord speler !!als alle boten zijn geplaatst!!
  else {
    if ((mouseX >= start_x_player && mouseX <= (start_x_player + w*cols)) && (mouseY >= start_y_player && mouseY <= (start_y_player + h*rows))) {
      int hovX = mouseX;
      int hovY = mouseY;
      int pos_x_bord = (hovX - start_x_player)/w;
      int pos_y_bord = (hovY - start_y_player)/h;
      // Als de speler net op de rand klikt wordt door de bovenstaande formule de coord 10, maar dit gaat niet binnen de array van 0-9, dus wordt de 10 als 9 aangenomen
      if (pos_x_bord == cols) {
        pos_x_bord = (cols - 1);
      }
      if (pos_y_bord == rows) {
        pos_y_bord = (rows - 1);
      }
      // bom == 0    ==> 1*1
      if (bom == 0) {
        if (bord_c[pos_y_bord][pos_x_bord] == 0 || bord_c[pos_y_bord][pos_x_bord] == 1) {
          //fill(255, 0, 0);
          fill(160, 60, 60);
          rect(start_x_player + (pos_x_bord*w), start_y_player + (pos_y_bord*h), w, h);
        }
      }
      // bom == 1    ==> 2*1
      else if (bom == 1) {
        // Horizontaal
        if (bomHor) {
          if (bord_c[pos_y_bord][pos_x_bord] == 0 || bord_c[pos_y_bord][pos_x_bord] == 1) {
            //fill(255, 0, 0);
            fill(160, 60, 60);
            rect(start_x_player + (pos_x_bord*w), start_y_player + (pos_y_bord*h), w, h);
          }
          if (pos_x_bord+1 <= (cols - 1)) {
            if (bord_c[pos_y_bord][pos_x_bord+1] == 0 || bord_c[pos_y_bord][pos_x_bord+1] == 1) {
              //fill(255, 0, 0);
              fill(160, 60, 60);
              rect(start_x_player + 1*w + (pos_x_bord*w), start_y_player + (pos_y_bord*h), w, h);
            }
          }
        }

        // Verticaal
        else {
          if (bord_c[pos_y_bord][pos_x_bord] == 0 || bord_c[pos_y_bord][pos_x_bord] == 1) {
            //fill(255, 0, 0);
            fill(160, 60, 60);
            rect(start_x_player + (pos_x_bord*w), start_y_player + (pos_y_bord*h), w, h);
          }
          if (pos_y_bord+1 <= (rows - 1)) {
            if (bord_c[pos_y_bord+1][pos_x_bord] == 0 || bord_c[pos_y_bord+1][pos_x_bord] == 1) {
              //fill(255, 0, 0);
              fill(160, 60, 60);
              rect(start_x_player + (pos_x_bord*w), start_y_player + 1*h + (pos_y_bord*h), w, h);
            }
          }
        }
      }
      // bom == 2    ==> 3*1
      else if (bom == 2) {
        // Horizontaal
        if (bomHor) {
          if (bord_c[pos_y_bord][pos_x_bord] == 0 || bord_c[pos_y_bord][pos_x_bord] == 1) {
            //fill(255, 0, 0);
            fill(160, 60, 60);
            rect(start_x_player + (pos_x_bord*w), start_y_player + (pos_y_bord*h), w, h);
          }
          if (pos_x_bord+1 <= (cols - 1)) {
            if (bord_c[pos_y_bord][pos_x_bord+1] == 0 || bord_c[pos_y_bord][pos_x_bord+1] == 1) {
              //fill(255, 0, 0);
              fill(160, 60, 60);
              rect(start_x_player + 1*w + (pos_x_bord*w), start_y_player + (pos_y_bord*h), w, h);
            }
          }
          if (pos_x_bord+2 <= (cols - 1)) {
            if (bord_c[pos_y_bord][pos_x_bord+2] == 0 || bord_c[pos_y_bord][pos_x_bord+2] == 1) {
              //fill(255, 0, 0);
              fill(160, 60, 60);
              rect(start_x_player + 2*w + (pos_x_bord*w), start_y_player + (pos_y_bord*h), w, h);
            }
          }
        }

        // Verticaal
        else {
          if (bord_c[pos_y_bord][pos_x_bord] == 0 || bord_c[pos_y_bord][pos_x_bord] == 1) {
            //fill(255, 0, 0);
            fill(160, 60, 60);
            rect(start_x_player + (pos_x_bord*w), start_y_player + (pos_y_bord*h), w, h);
          }
          if (pos_y_bord+1 <= (rows - 1)) {
            if (bord_c[pos_y_bord+1][pos_x_bord] == 0 || bord_c[pos_y_bord+1][pos_x_bord] == 1) {
              //fill(255, 0, 0);
              fill(160, 60, 60);
              rect(start_x_player + (pos_x_bord*w), start_y_player + 1*h + (pos_y_bord*h), w, h);
            }
          }
          if (pos_y_bord+2 <= (rows - 1)) {
            if (bord_c[pos_y_bord+2][pos_x_bord] == 0 || bord_c[pos_y_bord+2][pos_x_bord] == 1) {
              //fill(255, 0, 0);
              fill(160, 60, 60);
              rect(start_x_player + (pos_x_bord*w), start_y_player + 2*h + (pos_y_bord*h), w, h);
            }
          }
        }
      }
      /* 4
       312  kruisbom
       5
       */
      else if (bom == 3) {
        // 1
        if (bord_c[pos_y_bord][pos_x_bord] == 0 || bord_c[pos_y_bord][pos_x_bord] == 1) {
          //fill(255, 0, 0);
          fill(160, 60, 60);
          rect(start_x_player + (pos_x_bord*w), start_y_player + (pos_y_bord*h), w, h);
        }
        // 2
        if (pos_x_bord+1 <= (cols - 1)) {
          if (bord_c[pos_y_bord][pos_x_bord+1] == 0 || bord_c[pos_y_bord][pos_x_bord+1] == 1) {
            //fill(255, 0, 0);
            fill(160, 60, 60);
            rect(start_x_player + 1*w + (pos_x_bord*w), start_y_player + (pos_y_bord*h), w, h);
          }
        }
        // 3
        if (pos_x_bord-1 >= 0) {
          if (bord_c[pos_y_bord][pos_x_bord-1] == 0 || bord_c[pos_y_bord][pos_x_bord-1] == 1) {
            //fill(255, 0, 0);
            fill(160, 60, 60);
            rect(start_x_player - 1*w + (pos_x_bord*w), start_y_player + (pos_y_bord*h), w, h);
          }
        }
        // 4
        if (pos_y_bord-1 >= 0) {
          if (bord_c[pos_y_bord-1][pos_x_bord] == 0 || bord_c[pos_y_bord-1][pos_x_bord] == 1) {
            //fill(255, 0, 0);
            fill(160, 60, 60);
            rect(start_x_player + (pos_x_bord*w), start_y_player - 1*h + (pos_y_bord*h), w, h);
          }
        }
        // 5
        if (pos_y_bord+1 <= (rows - 1)) {
          if (bord_c[pos_y_bord+1][pos_x_bord] == 0 || bord_c[pos_y_bord+1][pos_x_bord] == 1) {
            //fill(255, 0, 0);
            fill(160, 60, 60);
            rect(start_x_player + (pos_x_bord*w), start_y_player + 1*h + (pos_y_bord*h), w, h);
          }
        }
      }

      /*  BOM 4 nog doen  */
      else if (bom == 4) {
        // Horizontaal
        if ((pos_x_bord-1 >= 0) && (pos_y_bord-1 >= 0)) {
          if (bord_c[pos_y_bord-1][pos_x_bord-1] == 0 || bord_c[pos_y_bord-1][pos_x_bord-1] == 1) {
            //fill(255, 0, 0);
            fill(160, 60, 60);
            rect(start_x_player - 1*w + (pos_x_bord*w), start_y_player - 1*h + (pos_y_bord*h), w, h);
          }
        }
        if (pos_y_bord-1 >= 0) {
          if (bord_c[pos_y_bord-1][pos_x_bord] == 0 || bord_c[pos_y_bord-1][pos_x_bord] == 1) {
            //fill(255, 0, 0);
            fill(160, 60, 60);
            rect(start_x_player + (pos_x_bord*w), start_y_player - 1*h + (pos_y_bord*h), w, h);
          }
        }
        if ((pos_x_bord+1 <= (rows - 1)) && (pos_y_bord-1 >= 0)) {
          if (bord_c[pos_y_bord-1][pos_x_bord+1] == 0 || bord_c[pos_y_bord-1][pos_x_bord+1] == 1) {
            //fill(255, 0, 0);
            fill(160, 60, 60);
            rect(start_x_player + 1*w + (pos_x_bord*w), start_y_player - 1*h + (pos_y_bord*h), w, h);
          }
        }
        if (pos_x_bord-1 >= 0) {
          if (bord_c[pos_y_bord][pos_x_bord-1] == 0 || bord_c[pos_y_bord][pos_x_bord-1] == 1) {
            //fill(255, 0, 0);
            fill(160, 60, 60);
            rect(start_x_player - 1*w + (pos_x_bord*w), start_y_player + (pos_y_bord*h), w, h);
          }
        }
        if (bord_c[pos_y_bord][pos_x_bord] == 0 || bord_c[pos_y_bord][pos_x_bord] == 1) {
          //fill(255, 0, 0);
          fill(160, 60, 60);
          rect(start_x_player + (pos_x_bord*w), start_y_player + (pos_y_bord*h), w, h);
        }
        if (pos_x_bord+1 <= (cols - 1)) {
          if (bord_c[pos_y_bord][pos_x_bord+1] == 0 || bord_c[pos_y_bord][pos_x_bord+1] == 1) {
            //fill(255, 0, 0);
            fill(160, 60, 60);
            rect(start_x_player + 1*w + (pos_x_bord*w), start_y_player + (pos_y_bord*h), w, h);
          }
        }
        if ((pos_x_bord-1 >= 0) && (pos_y_bord+1 <= (rows - 1))) {
          if (bord_c[pos_y_bord+1][pos_x_bord-1] == 0 || bord_c[pos_y_bord+1][pos_x_bord-1] == 1) {
            //fill(255, 0, 0);
            fill(160, 60, 60);
            rect(start_x_player - 1*w + (pos_x_bord*w), start_y_player + 1*h + (pos_y_bord*h), w, h);
          }
        }
        if (pos_y_bord+1 <= (rows - 1)) {
          if (bord_c[pos_y_bord+1][pos_x_bord] == 0 || bord_c[pos_y_bord+1][pos_x_bord] == 1) {
            //fill(255, 0, 0);
            fill(160, 60, 60);
            rect(start_x_player + (pos_x_bord*w), start_y_player + 1*h + (pos_y_bord*h), w, h);
          }
        }
        if ((pos_x_bord+1 <= (cols - 1)) && pos_y_bord+1 <= (rows - 1)) {
          if (bord_c[pos_y_bord+1][pos_x_bord+1] == 0 || bord_c[pos_y_bord+1][pos_x_bord+1] == 1) {
            //fill(255, 0, 0);
            fill(160, 60, 60);
            rect(start_x_player + 1*w + (pos_x_bord*w), start_y_player + 1*h + (pos_y_bord*h), w, h);
          }
        }
      }

      // bom == 5    ==> volledige rij
      else if (bom == 5) {
        // Horizontaal
        if (bomHor) {
          for (int x = 0; x < cols; x++) {
            if (bord_c[pos_y_bord][x] == 0 || bord_c[pos_y_bord][x] == 1) {
              //fill(255, 0, 0);
              fill(160, 60, 60);
              rect(start_x_player + x*w /*+ (pos_x_bord*w)*/, start_y_player + (pos_y_bord*h), w, h);
            }
          }
        }

        // Verticaal
        else {
          for (int y = 0; y < rows; y++) {
            if (bord_c[y][pos_x_bord] == 0 || bord_c[y][pos_x_bord] == 1) {
              //fill(255, 0, 0);
              fill(160, 60, 60);
              rect(start_x_player + (pos_x_bord*w), start_y_player + y*h /*(pos_y_bord*h)*/, w, h);
            }
          }
        }
      }
    }
  }
  // (nieuw)

  drawBoot(mouseX, mouseY);


  stroke(153);
  fill(153);
  // tekenen van de boten
  if ((activeBoot != 5) && (!b5geplaatst)) {
    rect(b5x, b5y, 5*w, h); // boot 5
  }
  if ((activeBoot != 4) && (!b4geplaatst)) {
    rect(b4x, b4y, 4*w, h); // boot 4
  }
  if ((activeBoot != 3) && (!b3geplaatst)) {
    rect(b3x, b3y, 3*w, h); // boot 3
  }
  if ((activeBoot != 2) && (!b2geplaatst)) {
    rect(b2x, b2y, 2*w, h); // boot 2
  }
  if ((activeBoot != 1) && (!b1geplaatst)) {
    rect(b1x, b1y, 2*w, h); // boot 1
  }
  // (nieuw)
}

void keyPressed() {
  if (key == ' ') {
    bomHor = !bomHor;
    //println(bomHor);
  }
  // *** ONLY FOR TESTING
  /*
  if (key == '1') {
   bom = 1;
   }
   if (key == '2') {
   bom = 2;
   }
   if (key == '3') {
   bom = 3;
   }
   if (key == '4') {
   bom = 4;
   }
   if (key == '5') {
   bom = 5;
   }
   */
  // *** ONLY FOR TESTING
}

void mousePressed() {
  // als de muis geklikt wordt binnen het bord van de speler(rechts), worden de X en Y coord opgelsaan in de variablen pressedX en pressedY
  if ((mouseX >= start_x_player && mouseX <= (start_x_player + w*cols)) && (mouseY >= start_y_player && mouseY <= (start_y_player + h*rows))) {
    pressedX = mouseX;
    pressedY = mouseY;

    // De klikpositie op het bord van de speler wordt bepaald
    int pos_x_bord_player = (pressedX - start_x_player)/w;
    int pos_y_bord_player = (pressedY - start_y_player)/h; 
    // Als de speler net op de rand klikt wordt door de bovenstaande formule de coord 10, maar dit gaat niet binnen de array van 0-9, dus wordt de 10 als 9 aangenomen
    if (pos_x_bord_player == cols) {
      pos_x_bord_player = cols - 1;
    }
    if (pos_y_bord_player == rows) {
      pos_y_bord_player = rows-1;
    }

    // Er worden willekeurige coords gekozen door de computer (makelijke levels)
    int pos_x_bord_comp = (int(random(cols)));
    int pos_y_bord_comp = (int(random(rows)));
    // Zolang de willekeurig gekozen coords niet overeenstemmen met een ongeschoten cell kiest de computer andere cellen
    while (bord_p[pos_y_bord_comp][pos_x_bord_comp] != 0 && bord_p[pos_y_bord_comp][pos_x_bord_comp] != 4) {
      pos_x_bord_comp = (int(random(cols)));
      pos_y_bord_comp = (int(random(rows)));
    }


    // Er worden willekeurige diagonale coords gekozen door de computer (moeilijke levels)
    /*
      int pos_x_bord_comp = (int(random(cols)));
     int pos_y_bord_comp;
     if ((pos_x_bord_comp % 2) == 0) {
     pos_y_bord_comp = ((int(random(rows/2)) * 2) + 1);
     } 
     else {
     pos_y_bord_comp = (int(random(rows/2)) * 2);
     }
     
     while (bord_p[pos_y_bord_comp][pos_x_bord_comp] != 0 && bord_p[pos_y_bord_comp][pos_x_bord_comp] != 4) {
     pos_x_bord_comp = (int(random(cols)));
     if ((pos_x_bord_comp % 2) == 0) {
     pos_y_bord_comp = ((int(random(rows/2)) * 2) + 1);
     } 
     else {
     pos_y_bord_comp = (int(random(rows/2)) * 2);
     }
     }
     
     }
     */

    // als er nog geen 16 'bootblokjes' op het bord staan worden deze eerst geplaatst

    if ((boten_placed < 16) && (bord_p[pos_y_bord_player][pos_x_bord_player] != 4)) {
      if (activeBoot == 5) {
        plaatsBootInVeld(pos_y_bord_player, pos_x_bord_player, 5, 5);
        //b5geplaatst = true;
      } else if (activeBoot == 4) {
        plaatsBootInVeld(pos_y_bord_player, pos_x_bord_player, 4, 4);
        //b4geplaatst = true;
      } else if (activeBoot == 3) {
        plaatsBootInVeld(pos_y_bord_player, pos_x_bord_player, 3, 3);
        //b3geplaatst = true;
      } else if (activeBoot == 2) {
        plaatsBootInVeld(pos_y_bord_player, pos_x_bord_player, 2, 2);
        //b2geplaatst = true;
      } else if (activeBoot == 1) {
        plaatsBootInVeld(pos_y_bord_player, pos_x_bord_player, 2, 1);
        //b1geplaatst = true;
      }
      //bord_p[pos_y_bord_player][pos_x_bord_player] = 4;
      //boten_placed ++;
    } 


    // als alle boten zijn geplaatst, wordt om de beurt op het veld van de tegenstander gevuurd
    else if (boten_placed == 16 && (game_won == false) && (game_lost == false)) {

      // *** Schoten door speler 

      /*
        // als gevuurd wordt op een "lege cel" wordt deze een "lege geschoten cel"
       if (bord_c[pos_y_bord_player][pos_x_bord_player] == 0) {
       bord_c[pos_y_bord_player][pos_x_bord_player] = 2;
       schoten_p ++;
       }
       // als gevuurd wordt op een "cel met boot" wordt deze een "geschoten cel met boot"
       else if (bord_c[pos_y_bord_player][pos_x_bord_player] == 1) {
       bord_c[pos_y_bord_player][pos_x_bord_player] = 3;
       hit_door_player ++;
       schoten_p ++;
       }
       */

      if (bord_c[pos_y_bord_player][pos_x_bord_player] == 1 || bord_c[pos_y_bord_player][pos_x_bord_player] == 0) {
        schoten_p ++;
      }

      shootPlayer(pos_x_bord_player, pos_y_bord_player, bomHor, bom);


      // *** Schoten door speler

      // *** Schoten door computer

      if (potentialT_x.length == 0) {
        //println(schoten_p," ",schoten_c);
        if (schoten_p == (schoten_c +1)) {

          // als gevuurd wordt op een "lege cel" wordt deze een "lege geschoten cel"
          if (bord_p[pos_y_bord_comp][pos_x_bord_comp] == 0) {
            bord_p[pos_y_bord_comp][pos_x_bord_comp] = 2;
            schoten_c ++;
          }
          // als gevuurd wordt op een "cel met boot" wordt deze een "geschoten cel met boot"
          else if (bord_p[pos_y_bord_comp][pos_x_bord_comp] == 4) {
            bord_p[pos_y_bord_comp][pos_x_bord_comp] = 3;
            hit_door_comp ++;
            schoten_c ++;
            addPotentialT(pos_y_bord_comp, pos_x_bord_comp);
          }
        }
      } else {
        //println(schoten_p," ",schoten_c);
        hunt();
      }

      // *** Schoten door computer

      if (hit_door_player == 16) {
        game_won = true;
      } else if (hit_door_comp == 16) {
        game_lost = true;
      }
    }
  }
  // (nieuw)

  else {
    plaatsBoot(mouseX, mouseY);
    activeBoot = 0;
  }

  // (nieuw)

  //println(schoten ,hit_door_player);

  // (nieuw)
  int klikX = mouseX;
  int klikY = mouseY;
  if (bootAangeklikt) {
    plaatsBoot(klikX, klikY);
    bootAangeklikt = !bootAangeklikt;
  } else {
    klikBoot(klikX, klikY);
    bootAangeklikt = !bootAangeklikt;
  }
  // (nieuw)
}


//De kleur van de cell wordt teruggekeerd naargelang de waarde van de cell
int cellKleur(int tempState) {
  // value 0 = lege cel
  if (tempState == 0) {
    tempState = color(255, 255, 255);
  } 
  // value 1 = cel met boot (veld player)
  else if (tempState == 1 ) {
    tempState = color(255, 255, 255);
    //tempState = color(127, 127, 127); // ***uncomment deze functie om de geplaatste boten van de computer te zien***
  }
  // value 2 = geschoten op lege cel
  else if (tempState == 2) {
    tempState = color(48, 88, 153);
  } 
  // value 3 = geschoten op cel met boot
  else if (tempState == 3) {
    tempState = color(47, 198, 67);
  }
  // value 4 = cel met boot (veld comp)
  else if (tempState == 4) {
    tempState = color(0, 0, 0);
  }
  return tempState;
}

// Deze functie zorgt ervoor dat iedere cell de juiste kleur krijgt en getekend wordt
void display(int temp, int start_x, int start_y, int x, int y) {
  cell_color = cellKleur(temp);
  fill(cell_color);
  stroke(0, 255, 0);
  rect(start_x + (x*w), start_y + (y*h), w, h);
}

void plaatsBoten() {
  int tempNum = int(random(0, 3));
  tempNum = 4; // (bij moeilijkere levels gebruiken)
  if (tempNum == 0) {
    // zelf boten ingesteld voor test (deze worden gekozen door de computer)!
    bord_c[0][0] = 1;
    bord_c[0][1] = 1;
    bord_c[0][2] = 1; 
    bord_c[0][3] = 1;
    bord_c[0][4] = 1;

    bord_c[6][4] = 1;
    bord_c[6][5] = 1;
    bord_c[6][6] = 1;
    bord_c[6][7] = 1;

    bord_c[0][8] = 1;
    bord_c[1][8] = 1;
    bord_c[2][8] = 1;

    bord_c[9][8] = 1;
    bord_c[9][9] = 1;

    bord_c[3][5] = 1;
    bord_c[3][6] = 1;
  } else if (tempNum == 1) {
    // zelf boten ingesteld voor test (deze worden gekozen door de computer)!
    bord_c[3][2] = 1;
    bord_c[3][3] = 1;
    bord_c[3][4] = 1; 
    bord_c[3][5] = 1;
    bord_c[3][6] = 1;

    bord_c[5][3] = 1;
    bord_c[6][3] = 1;
    bord_c[7][3] = 1;
    bord_c[8][3] = 1;

    bord_c[5][8] = 1;
    bord_c[6][8] = 1;
    bord_c[7][8] = 1;

    bord_c[9][8] = 1;
    bord_c[9][9] = 1;

    bord_c[0][5] = 1;
    bord_c[0][6] = 1;
  } else if (tempNum == 2) {
    // zelf boten ingesteld voor test (deze worden gekozen door de computer)!
    bord_c[5][0] = 1;
    bord_c[6][0] = 1;
    bord_c[7][0] = 1; 
    bord_c[8][0] = 1;
    bord_c[9][0] = 1;

    bord_c[5][4] = 1;
    bord_c[5][5] = 1;
    bord_c[5][6] = 1;
    bord_c[5][7] = 1;

    bord_c[0][4] = 1;
    bord_c[0][5] = 1;
    bord_c[0][6] = 1;

    bord_c[8][8] = 1;
    bord_c[9][8] = 1;

    bord_c[0][9] = 1;
    bord_c[1][9] = 1;
  } else if (tempNum == 3) {
    // zelf boten ingesteld voor test (deze worden gekozen door de computer)!
    bord_c[4][7] = 1;
    bord_c[5][7] = 1;
    bord_c[6][7] = 1; 
    bord_c[7][7] = 1;
    bord_c[8][7] = 1;

    bord_c[1][1] = 1;
    bord_c[1][2] = 1;
    bord_c[1][3] = 1;
    bord_c[1][4] = 1;

    bord_c[3][5] = 1;
    bord_c[4][5] = 1;
    bord_c[5][5] = 1;

    bord_c[8][1] = 1;
    bord_c[8][2] = 1;

    bord_c[4][1] = 1;
    bord_c[5][1] = 1;
  } 
  // deze functie kiest 5 willekeurige geldige posities voor de computer zijn boten
  else if (tempNum == 4) {
    for (int i = 0; i < lengte_boten.length; i++) {
      int lengte = lengte_boten[i];
      int random_x;
      int random_y;
      int rotatie = int(random(2)); // 0 ==> horizontaal, 1 ==> verticaal
      if (rotatie == 0) {
        random_x = int(random(cols-lengte));
        random_y = int(random(rows));

        while (!check_no_boot(lengte, random_x, random_y, rotatie)) {
          random_x = int(random(cols-lengte));
          random_y = int(random(rows));
        }
        for (int x = 0; x < lengte; x++) {
          bord_c[random_y][random_x + x] = 1;
          boot_c_x = append(boot_c_x, random_x + x); //verticale boot als geheel beschouwen
          boot_c_y = append(boot_c_y, random_y);
        }
      } else {
        random_x = int(random(cols));
        random_y = int(random(rows-lengte));

        while (!check_no_boot(lengte, random_x, random_y, rotatie)) {
          random_x = int(random(cols));
          random_y = int(random(rows-lengte));
        }
        for (int y = 0; y < lengte; y++) {
          bord_c[random_y + y][random_x] = 1;
          boot_c_x = append(boot_c_x, random_x); //verticale boot als geheel beschouwen
          boot_c_y = append(boot_c_y, random_y+y);
        }
      }
    }
  }
  /*
  // deze functie visualiseert de locaties van boten 5->4->3->2->1
  for (int i=0; i<boot_c_x.length; i++) {
    println(boot_c_x[i], boot_c_y[i]);
  }
  */
}

// deze functie kijkt of het nodige aantal vakjes om een boot te plaatsen (lege vakjes) aanwezig is startende van een x en y coord volgens een bepaalde richting
boolean check_no_boot(int lengte, int random_x, int random_y, int rotatie) {
  int sum = 0;
  if (rotatie == 0) {
    for (int x = 0; x < lengte; x++) {
      if (bord_c[random_y][random_x + x] == 1) {
        sum++;
      }
    }
  } else if (rotatie == 1) {
    for (int y = 0; y < lengte; y++) {
      if (bord_c[random_y + y][random_x] == 1) {
        sum++;
      }
    }
  }
  if (sum == 0) {
    return true;
  } else {
    return false;
  }
}

// deze schiet op de potentiele targets en verwijdert de respectievelijke coords van het geschoten vak uit de potententialTarget lijst
void hunt() {
  int temp_x = potentialT_x[potentialT_x.length - 1]; //laad laatste x coord uit potentialTarget_x
  int temp_y = potentialT_y[potentialT_y.length - 1]; //laad laatste y coord uit potentialTarget_y
  potentialT_x = shorten(potentialT_x);
  potentialT_y = shorten(potentialT_y);

  while ((bord_p[temp_y][temp_x] == 2) || (bord_p[temp_y][temp_x] == 3)) {
    if (potentialT_x.length > 0) {
      temp_x = potentialT_x[potentialT_x.length - 1]; //laad laatste x coord uit potentialTarget_x
      temp_y = potentialT_y[potentialT_y.length - 1]; //laad laatste y coord uit potentialTarget_y
      potentialT_x = shorten(potentialT_x);
      potentialT_y = shorten(potentialT_y);
    } else {
      break;
    }
  }

  if (schoten_p == (schoten_c +1)) {
    // als gevuurd wordt op een "lege cel" wordt deze een "lege geschoten cel"
    if (bord_p[temp_y][temp_x] == 0) {
      bord_p[temp_y][temp_x] = 2;
      schoten_c ++;
    }
    // als gevuurd wordt op een "cel met boot" wordt deze een "geschoten cel met boot"
    else if (bord_p[temp_y][temp_x] == 4) {
      bord_p[temp_y][temp_x] = 3;
      hit_door_comp ++;
      schoten_c ++;
      addPotentialT(temp_y, temp_x);
    }
  }
}

// de 4 punten die gecheckt moeten worden 
void addPotentialT(int pos_y_bord_comp, int pos_x_bord_comp) {
  checkPotentialT(pos_y_bord_comp - 1, pos_x_bord_comp);
  checkPotentialT(pos_y_bord_comp + 1, pos_x_bord_comp);
  checkPotentialT(pos_y_bord_comp, pos_x_bord_comp - 1);
  checkPotentialT(pos_y_bord_comp, pos_x_bord_comp + 1);
}

// checkt of de potentiele target x en y binnen de range valt en dit vak nog niet is aangeklikt, indien goed, woden deze aan de respectievelijke coords lijst toegevoegd
void checkPotentialT(int pos_y_bord_comp, int pos_x_bord_comp) {
  if ((pos_y_bord_comp <= (cols -1)) && (pos_y_bord_comp >= 0) && (pos_x_bord_comp <= (rows - 1)) && (pos_x_bord_comp >= 0)) {
    if ((bord_p[pos_y_bord_comp][pos_x_bord_comp] != 2) && (bord_p[pos_y_bord_comp][pos_x_bord_comp] != 3)) {
      potentialT_x = append(potentialT_x, pos_x_bord_comp); // add x coord to potentialTarget_x list
      potentialT_y = append(potentialT_y, pos_y_bord_comp); // add y coord to potentialTarget_y list
      //println(pos_x_bord_comp, pos_y_bord_comp);
    }
  }
}

// deze functie zorgt ervoor det de juiste cellen worden beschoten bij de speciale bommen
void shootPlayer(int pos_x_bord_player, int pos_y_bord_player, boolean bomHor, int bom) {

  if (bom == 0) {
    vuurSpeler(pos_y_bord_player, pos_x_bord_player);
  } else if (bom == 1) {
    updatePunten(-200);
    resetBom();

    vuurSpeler(pos_y_bord_player, pos_x_bord_player);

    if (bomHor) {
      vuurSpeler(pos_y_bord_player, pos_x_bord_player+1);
    } else {
      vuurSpeler(pos_y_bord_player+1, pos_x_bord_player);
    }
  } else if (bom == 2) {
    updatePunten(-300);
    resetBom();

    vuurSpeler(pos_y_bord_player, pos_x_bord_player);

    if (bomHor) {
      vuurSpeler(pos_y_bord_player, pos_x_bord_player+1);
      vuurSpeler(pos_y_bord_player, pos_x_bord_player+2);
    } else {
      vuurSpeler(pos_y_bord_player+1, pos_x_bord_player);
      vuurSpeler(pos_y_bord_player+2, pos_x_bord_player);
    }
  } else if (bom == 3) {
    updatePunten(-500);
    resetBom();

    vuurSpeler(pos_y_bord_player-1, pos_x_bord_player);
    vuurSpeler(pos_y_bord_player, pos_x_bord_player-1);
    vuurSpeler(pos_y_bord_player, pos_x_bord_player);
    vuurSpeler(pos_y_bord_player, pos_x_bord_player+1);
    vuurSpeler(pos_y_bord_player+1, pos_x_bord_player);
  } else if (bom == 4) {
    updatePunten(-900);
    resetBom();

    vuurSpeler(pos_y_bord_player-1, pos_x_bord_player-1);
    vuurSpeler(pos_y_bord_player-1, pos_x_bord_player);
    vuurSpeler(pos_y_bord_player-1, pos_x_bord_player+1);
    vuurSpeler(pos_y_bord_player, pos_x_bord_player-1);
    vuurSpeler(pos_y_bord_player, pos_x_bord_player);
    vuurSpeler(pos_y_bord_player, pos_x_bord_player+1);
    vuurSpeler(pos_y_bord_player+1, pos_x_bord_player-1);
    vuurSpeler(pos_y_bord_player+1, pos_x_bord_player);
    vuurSpeler(pos_y_bord_player+1, pos_x_bord_player+1);
  } else if (bom == 5) {
    updatePunten(-1000);
    resetBom();

    // Horizontaal
    if (bomHor) {
      for (int x = 0; x < cols; x++) {
        vuurSpeler(pos_y_bord_player, x);
      }
    }
    // Verticaal
    else {
      for (int y = 0; y < rows; y++) {
        vuurSpeler(y, pos_x_bord_player);
      }
    }
  }
}

// deze functie checkt of de positie binnen het speelveld ligt en returnt deze value
boolean binnenVeld(int pos_y, int pos_x) {
  return ((pos_x <= rows - 1) && (pos_x >= 0) && (pos_y <= cols -1) && (pos_y >= 0));
}

// deze functie checkt of de cell onbeschoten+leeg is en maakt hiervan beschoten+leeg
void ongeschotenLeeg(int pos_y, int pos_x) {
  if (bord_c[pos_y][pos_x] == 0) {
    bord_c[pos_y][pos_x] = 2;
  }
}

// deze functie checkt of de cell onbeschoten+boot is en maakt hiervan beschoten+boot
void ongeschotenBoot(int pos_y, int pos_x) {
  if (bord_c[pos_y][pos_x] == 1) {
    bord_c[pos_y][pos_x] = 3;
    hit_door_player++;
    updatePunten(20);
  }
}

// deze functie checkt of het vakje in het veld ligt en indien dit zo is beschiet hij het
void vuurSpeler(int pos_y_bord_player, int pos_x_bord_player) {
  if (binnenVeld(pos_y_bord_player, pos_x_bord_player)) {
    // als gevuurd wordt op een "lege cel" wordt deze een "lege geschoten cel"
    ongeschotenLeeg(pos_y_bord_player, pos_x_bord_player);
    // als gevuurd wordt op een "cel met boot" wordt deze een "geschoten cel met boot"
    ongeschotenBoot(pos_y_bord_player, pos_x_bord_player);
    checkBotenGeschoten();
  }
}

void setEmptyBord() {
  bord_p = new int[rows][cols];
  bord_c = new int[rows][cols];
}

void updatePunten(int hoeveelheid) {
  punten += hoeveelheid;
}

void resetBom() {
  bom = 0;
}

// (nieuw)
void klikBoot(int X, int Y ) {
  // boot 5
  if ((X >= b5x) && (X <= (b5x + 5*w)) && (Y >= b5y) && (Y <= (b5y + h)) && (!b5geplaatst)) {
    //println("boot 5 aangeklikt");
    activeBoot = 5;
  }
  // boot 4
  else if ((X >= b4x) && (X <= (b4x + 4*w)) && (Y >= b4y) && (Y <= (b4y + h)) && (!b4geplaatst)) {
    //println("boot 4 aangeklikt");
    activeBoot = 4;
  }
  // boot 3
  else if ((X >= b3x) && (X <= (b3x + 3*w)) && (Y >= b3y) && (Y <= (b3y + h)) && (!b3geplaatst)) {
    //println("boot 3 aangeklikt");
    activeBoot = 3;
  }
  // boot 2
  else if ((X >= b2x) && (X <= (b2x + 2*w)) && (Y >= b2y) && (Y <= (b2y + h)) && (!b2geplaatst)) {
    //println("boot 2 aangeklikt");
    activeBoot = 2;
  }
  // boot 1
  else if ((X >= b1x) && (X <= (b1x + 2*w)) && (Y >= b1y) && (Y <= (b1y + h)) && (!b1geplaatst)) {
    //println("boot 1 aangeklikt");
    activeBoot = 1;
  }
}

void drawBoot(int X, int Y) {
  if (((X > start_x_player + rows*w) || (X < start_x_player)) || ((Y > start_y_player + cols*h) || (Y < start_y_player))) {
    fill(127, 127, 127);
    if (bomHor) {
      if ((activeBoot == 5) && (!b5geplaatst)) {
        rect(X, Y, 5*w, h);
      } else if ((activeBoot == 4)  && (!b4geplaatst)) {
        rect(X, Y, 4*w, h);
      } else if ((activeBoot == 3)  && (!b3geplaatst)) {
        rect(X, Y, 3*w, h);
      } else if ((activeBoot == 2) && (!b2geplaatst)) {
        rect(X, Y, 2*w, h);
      } else if ((activeBoot == 1) && (!b1geplaatst)) {
        rect(X, Y, 2*w, h);
      }
    } else {
      if ((activeBoot == 5) && (!b5geplaatst)) {
        rect(X, Y, w, 5*h);
      } else if ((activeBoot == 4)  && (!b4geplaatst)) {
        rect(X, Y, w, 4*h);
      } else if ((activeBoot == 3)  && (!b3geplaatst)) {
        rect(X, Y, w, 3*h);
      } else if ((activeBoot == 2) && (!b2geplaatst)) {
        rect(X, Y, w, 2*h);
      } else if ((activeBoot == 1) && (!b1geplaatst)) {
        rect(X, Y, w, 2*h);
      }
    }
  }
}

void plaatsBoot(int X, int Y) {
  if (activeBoot == 5) {
    b5x = X;
    b5y = Y;
  } else if (activeBoot == 4) {
    b4x = X;
    b4y = Y;
  } else if (activeBoot == 3) {
    b3x = X;
    b3y = Y;
  } else if (activeBoot == 2) {
    b2x = X;
    b2y = Y;
  } else if (activeBoot == 1) {
    b1x = X;
    b1y = Y;
  }
  //activeBoot = 0;
}
// (nieuw)

// (nieuw)
void displayBoot(int pos_y_bord, int pos_x_bord, int lengte) {
  if (bomHor) {

    if (pos_x_bord + lengte - 1 < rows) {
      int leeg = 0;
      for (int i = 0; i < lengte; i++) {
        if (bord_p[pos_y_bord][pos_x_bord+i] == 0) {
          leeg++;
        }
      }
      if (leeg == lengte) {
        for (int i = 0; i < lengte; i++) {
          if (bord_p[pos_y_bord][pos_x_bord+i] == 0 || bord_p[pos_y_bord][pos_x_bord+i] == 1) {
            fill(255, 0, 0);
            fill(60, 60, 60);
            rect(start_x_player + ((pos_x_bord + i)*w), start_y_player + (pos_y_bord*h), w, h);
          }
        }
      } else {
        illegaleBoot(lengte);
      }
    } else {
      illegaleBoot(lengte);
    }
  } else if (!bomHor) {

    if (pos_y_bord + lengte - 1< cols) {
      int leeg = 0;
      for (int i = 0; i < lengte; i++) {
        if (bord_p[pos_y_bord+i][pos_x_bord] == 0) {
          leeg++;
        }
      }
      if (leeg == lengte) {
        //println("leeg en verticaal");
        for (int i = 0; i < lengte; i++) {
          if (bord_p[pos_y_bord+i][pos_x_bord] == 0 || bord_p[pos_y_bord][pos_x_bord] == 1) {
            fill(255, 0, 0);
            fill(60, 60, 60);
            rect(start_x_player + (pos_x_bord*w), start_y_player + ((pos_y_bord + i)*h), w, h);
          }
        }
      } else {
        illegaleBoot(lengte);
      }
    } else {
      illegaleBoot(lengte);
    }
  }
}


// deze functie zorgt ervoor wannner de boot op een legale positie binnen het veld geplaats wordt dat deze als geklikt vakje wordt geregistreerd
void plaatsBootInVeld(int pos_y_bord_player, int pos_x_bord_player, int lengte, int boot) {
  if (bomHor) {
    int leeg = 0;
    if (pos_x_bord_player + lengte - 1 < rows) {
      for (int i = 0; i < lengte; i++) {
        if (bord_p[pos_y_bord_player][pos_x_bord_player+i] == 0) {
          leeg++;
        }
      }
    }
    if ((pos_x_bord_player + lengte - 1 < rows) && (leeg == lengte)) {  
      for (int i = 0; i < lengte; i++) {
        if (bord_p[pos_y_bord_player][pos_x_bord_player+i] == 0 || bord_p[pos_y_bord_player][pos_x_bord_player+i] == 1) {
          bord_p[pos_y_bord_player][pos_x_bord_player+i] = 4;
          boten_placed ++;
        }
      }
      activeBoot = 0;
      if (boot == 5) {
        b5geplaatst = true;
      } else if (boot == 4) {
        b4geplaatst = true;
      } else if (boot == 3) {
        b3geplaatst = true;
      } else if (boot == 2) {
        b2geplaatst = true;
      } else if (boot == 1) {
        b1geplaatst = true;
      }
    }
  } else if (!bomHor) {
    int leeg = 0;
    if (pos_y_bord_player + lengte - 1 < cols) {
      for (int i = 0; i < lengte; i++) {
        if (bord_p[pos_y_bord_player+i][pos_x_bord_player] == 0) {
          leeg++;
        }
      }
    }
    if ((pos_y_bord_player + lengte - 1 < cols) && (leeg == lengte)) {  
      for (int i = 0; i < lengte; i++) {
        if (bord_p[pos_y_bord_player+i][pos_x_bord_player] == 0 || bord_p[pos_y_bord_player][pos_x_bord_player] == 1) {
          bord_p[pos_y_bord_player+i][pos_x_bord_player] = 4;
          boten_placed ++;
        }
      }
      activeBoot = 0;
      if (boot == 5) {
        b5geplaatst = true;
      } else if (boot == 4) {
        b4geplaatst = true;
      } else if (boot == 3) {
        b3geplaatst = true;
      } else if (boot == 2) {
        b2geplaatst = true;
      } else if (boot == 1) {
        b1geplaatst = true;
      }
    }
  }
}

// deze functie toont een rode boot als de boot boven een locatie hangt waar de boot niet geplaatst kan worden
void illegaleBoot(int lengte) {
  if (bomHor) {
    fill(180, 60, 60);
    rect(mouseX, mouseY, lengte*w, h);
  } else if (!bomHor) {
    fill(180, 60, 60);
    rect(mouseX, mouseY, w, lengte*h);
  }
}
// (nieuw)
//gehele boten van computer geraakt => 50 punten bijvoegen
void checkBotenGeschoten() {
  int boot5_hit=0;
  int boot4_hit=0;
  int boot3_hit=0;
  int boot2_hit=0;
  int boot1_hit=0;


  for (int i=0; i<5; i++) {
    int x= boot_c_x[i];
    int y= boot_c_y[i];
    if (bord_c[y][x]==3) {
      boot5_hit++;
      //println(boot5_hit);
    }
  }
  for (int i=5; i<9; i++) {
    int x= boot_c_x[i];
    int y= boot_c_y[i];
    if (bord_c[y][x]==3) {
      boot4_hit++;
      //println(boot4_hit);
    }
  }
  for (int i=9; i<12; i++) {
    int x= boot_c_x[i];
    int y= boot_c_y[i];
    if (bord_c[y][x]==3) {
      boot3_hit++;
      //println(boot3_hit);
    }
  }
  for (int i=12; i<14; i++) {
    int x= boot_c_x[i];
    int y= boot_c_y[i];
    if (bord_c[y][x]==3) {
      boot2_hit++;
      //println(boot2_hit);
    }
  }
  for (int i=14; i<16; i++) {
    int x= boot_c_x[i];
    int y= boot_c_y[i];
    if (bord_c[y][x]==3) {
      boot1_hit++;
      //println(boot1_hit);
    }
  }
  //println(boot1_hit);
  if ((boot5_hit==5)&& (!boot5_punten)) {
    updatePunten(50);
    boot5_punten = true;
  }
  if ((boot4_hit==4)&& (!boot4_punten)) {
    updatePunten(50);
    boot4_punten = true;
  }
  if ((boot3_hit==3)&& (!boot3_punten)) {
    updatePunten(50);
    boot3_punten = true;
  }
  if ((boot2_hit==2)&& (!boot2_punten)) {
    updatePunten(50);
    boot2_punten = true;
  }
  if ((boot1_hit==2)&& (!boot1_punten)) {
    updatePunten(50);
    boot1_punten = true;
  }
}
