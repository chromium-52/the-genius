/*
Move rail back one grid when player guesses incorrectly
Check for win
*/

PImage PBOARD1, PBOARD2;
PImage PLAYER;

// Constant arrays
PImage[] letterBoard = new PImage[16];
PImage[] shapeBoard = new PImage[16];

PImage[] randShapeBoard = new PImage[16];
PImage[] playerShapes = new PImage[20];

int playerX = 900;
int playerY = 375;
int attempt;

//class Pice {
//  color c;
  
//  Piece() {
//    c = color(255);
//  }
//}

void setup () {
  size(1300, 500);
  background(255);
  
  initialize();
}

void draw() {
  image(PBOARD1, 50, 300);
  image(PBOARD2, 650, 300);
  
  for (int i = 0; i < randShapeBoard.length; i++) {
    image(randShapeBoard[i], 550 + (i * 60) % 240, 25 + 60 * ((i * 60) / 240));
  }
  
  for (int i = 0; i < playerShapes.length; i++) {
    image(playerShapes[i], 50 + 60 * i, 360);
  }
  
  for (int i = 0; i < letterBoard.length; i++) {
    image(letterBoard[i], 550 + (i * 60) % 240, 25 + 60 * ((i * 60) / 240));
  }
  
  image(PLAYER, playerX, playerY);
}

void initialize() {
  // letterBoard
  letterBoard[0] = loadImage("alpha-a.png"); // A
  letterBoard[1] = loadImage("alpha-l.png"); // L
  letterBoard[2] = loadImage("alpha-i.png"); // I
  letterBoard[3] = loadImage("alpha-e.png"); // E
  letterBoard[4] = loadImage("alpha-y.png"); // Y
  letterBoard[5] = loadImage("alpha-o.png"); // O
  letterBoard[6] = loadImage("alpha-u.png"); // U
  letterBoard[7] = loadImage("alpha-m.png"); // M
  letterBoard[8] = loadImage("alpha-s.png"); // S
  letterBoard[9] = loadImage("alpha-t.png"); // T
  letterBoard[10] = loadImage("alpha-n.png"); // N
  letterBoard[11] = loadImage("alpha-r.png"); // R
  letterBoard[12] = loadImage("alpha-h.png"); // H
  letterBoard[13] = loadImage("alpha-d.png"); // D
  letterBoard[14] = loadImage("alpha-g.png"); // G
  letterBoard[15] = loadImage("alpha-k.png"); // K
  
  // shapeBoard
  shapeBoard[0] = loadImage("image-r1.png"); 
  shapeBoard[1] = loadImage("image-r2.png");
  shapeBoard[2] = loadImage("image-r3.png");
  shapeBoard[3] = loadImage("image-r4.png");
  shapeBoard[4] = loadImage("image-y1.png");
  shapeBoard[5] = loadImage("image-y2.png");
  shapeBoard[6] = loadImage("image-y3.png");
  shapeBoard[7] = loadImage("image-y4.png");
  shapeBoard[8] = loadImage("image-g1.png");
  shapeBoard[9] = loadImage("image-g2.png");
  shapeBoard[10] = loadImage("image-g3.png");
  shapeBoard[11] = loadImage("image-g4.png");
  shapeBoard[12] = loadImage("image-b1.png");
  shapeBoard[13] = loadImage("image-b2.png");
  shapeBoard[14] = loadImage("image-b3.png");
  shapeBoard[15] = loadImage("image-b4.png");
  
  // PBOARD1, PBOARD2
  PBOARD1 = loadImage("game-1.png");
  PBOARD2 = loadImage("game-2.png");
  
  // randShapeBoard
  ArrayList<Integer> taken = new ArrayList<Integer>();
  for (int i = 0; i < randShapeBoard.length; i++) {
    int rand = int(random(16));
    while (contains(taken, rand)) {
      rand = int(random(16));
    }
    randShapeBoard[i] = shapeBoard[rand];
    taken.add(rand);
  }
  
  // playerShapes
  for (int i = 0; i < playerShapes.length; i++) {
    playerShapes[i] = shapeBoard[int(random(16))];
  }
  
  // PLAYER
  PLAYER = loadImage("player-red.png");
}

boolean contains(ArrayList<Integer> arr, int n) {
  for (int i = 0; i < arr.size(); i++) {
    if (arr.get(i) == n)
      return true;
  }
  return false;
}

void keyPressed() {
  resetBoard();
  attempt++;
  switch (key) {
    case 'a':
      flipLetter(0);
      break;
    case 'l':
      flipLetter(1);
      break;
    case 'i':
      flipLetter(2);
      break;
    case 'e':
      flipLetter(3);
      break;
    case 'y':
      flipLetter(4);
      break;
    case 'o':
      flipLetter(5);
      break;
    case 'u':
      flipLetter(6);
      break;
    case 'm':
      flipLetter(7);
      break;
    case 's':
      flipLetter(8);
      break;
    case 't':
      flipLetter(9);
      break;
    case 'n':
      flipLetter(10);
      break;
    case 'r':
      flipLetter(11);
      break;
    case 'h':
      flipLetter(12);
      break;
    case 'd':
      flipLetter(13);
      break;
    case 'g':
      flipLetter(14);
      break;
    case 'k':
      flipLetter(15);
      break;
    default:
      System.out.println("keyPress else");
  }
}

void flipLetter(int pos) {
  letterBoard[pos] = shapeBoard[pos];
  if (playerShapes[playerX / 60 - 2].equals(shapeBoard[pos])) {
    System.out.println("Correct");
    playerX -= 60;
    if (playerX == 60) {
      System.out.println("YOU WON!");
      noLoop();
    }
  } else {
    System.out.println("Incorrect");
    if (playerX < 1260 && (attempt % 2 == 0)) {
      playerX += 60;
      //System.out.println(playerShapes[0]);
      //PImage[] temp = new PImage[1];
      //temp[0] = shapeBoard[pos];
      //arrayCopy(temp, 0, );
      //playerShapes = playerShapes.remove(playerShapes.length - 1);
      //playerShapes = playerShapes.remove(0);
      //playerShapes = splice(playerShapes, shapeBoard[5], 0);
      //System.out.println(playerShapes[0]);
    }
    if (playerX == 1260) {
      System.out.println("GAME OVER");
      noLoop();
    }
  }
  for (int i = 0; i < letterBoard.length; i++) {
    image(letterBoard[i], 550 + (i * 60) % 240, 25 + 60 * ((i * 60) / 240));
  }
}

void resetBoard() {
  letterBoard[0] = loadImage("alpha-a.png"); // A
  letterBoard[1] = loadImage("alpha-l.png"); // L
  letterBoard[2] = loadImage("alpha-i.png"); // I
  letterBoard[3] = loadImage("alpha-e.png"); // E
  letterBoard[4] = loadImage("alpha-y.png"); // Y
  letterBoard[5] = loadImage("alpha-o.png"); // O
  letterBoard[6] = loadImage("alpha-u.png"); // U
  letterBoard[7] = loadImage("alpha-m.png"); // M
  letterBoard[8] = loadImage("alpha-s.png"); // S
  letterBoard[9] = loadImage("alpha-t.png"); // T
  letterBoard[10] = loadImage("alpha-n.png"); // N
  letterBoard[11] = loadImage("alpha-r.png"); // R
  letterBoard[12] = loadImage("alpha-h.png"); // H
  letterBoard[13] = loadImage("alpha-d.png"); // D
  letterBoard[14] = loadImage("alpha-g.png"); // G
  letterBoard[15] = loadImage("alpha-k.png"); // K
}
