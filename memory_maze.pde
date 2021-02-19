/*
Decide who to play first
Move 3 spots per turn
Chance (move 6 spots)
*/

int GRIDSIZE = 100;
int NUM = 7;
int SIDE = GRIDSIZE * NUM;

int[][] walls = new int[SIDE][SIDE];
// x and y coordinates of both players
int[] pos = new int[4];
int[] count = new int[2];
int[] chance = new int[2];

// difficulty - integer between 0 and 100
int level = 20;
boolean twoPlayer = false;
boolean turnOne;

void setup () {
  // SIDE
  size(700, 700);
  frameRate(20);
  
  pos[0] = GRIDSIZE / 2;
  pos[1] = SIDE - GRIDSIZE / 2;
  pos[2] = SIDE - GRIDSIZE / 2;
  pos[3] = SIDE - GRIDSIZE / 2;
  
  chance[0] = 2;
  chance[1] = 2;
  
  initialize(level);
}

void draw() {
  fill(255);
  stroke(0);
  for(int i = 0; i < NUM * SIDE; i += 2 * GRIDSIZE) {
    rect(i % SIDE, i / SIDE * GRIDSIZE, GRIDSIZE, GRIDSIZE);
  }
  fill(255, 0, 0);
  rect(SIDE - GRIDSIZE, 0, GRIDSIZE, GRIDSIZE);
  fill(153);
  for(int i = GRIDSIZE; i < NUM * SIDE; i += 2 * GRIDSIZE) {
    rect(i % SIDE, i / SIDE * GRIDSIZE, GRIDSIZE, GRIDSIZE);
  }
  
  noStroke();
  fill(255, 0, 0);
  circle(pos[0], pos[1], 40);
  fill(0, 255, 0);
  if (twoPlayer) {
    circle(pos[2], pos[3], 40);
    stroke(0);
    fill(0, 255, 0);
    rect(0, 0, GRIDSIZE, GRIDSIZE);
    noStroke();
  }
  
  if (pos[0] == SIDE - GRIDSIZE / 2 && pos[1] == GRIDSIZE / 2) {
    System.out.println("Player 1 won!");
    System.out.println("Player 1 solved in " + count[0] + " tries");
    noLoop();
  }
  if (pos[2] == GRIDSIZE / 2 && pos[3] == GRIDSIZE / 2) {
    System.out.println("Player 2 won!");
    System.out.println("Player 2 solved in " + count[1] + " tries");
    noLoop();
  }
}

void initialize(int level) {
  // initialize walls
  for(int i = 0; i < SIDE; i++) {
    for(int j = 0; j < SIDE; j++) {
      if(int(random(101)) < level) {
        walls[i][j] = 1;
      }
    }
  }
  
  // decide who goes first if two-player mode is enabled
  if (twoPlayer) {
    
  }
}

void keyPressed() {
  try {
    if (turnOne == false && twoPlayer == true) {
      switch (key) {
        case 'a':
          pos[2] -= GRIDSIZE;
          if ((pos[2] < 0) || (walls[pos[2] + GRIDSIZE / 2][pos[3]] == 1)) {
            pos[2] = SIDE - GRIDSIZE / 2;
            pos[3] = SIDE - GRIDSIZE / 2;
          }
          break;
        case 's':
          pos[3] += GRIDSIZE;
          if ((pos[3] > SIDE) || (walls[pos[2]][pos[3] - GRIDSIZE / 2] == 1)) {
            pos[2] = SIDE - GRIDSIZE / 2;
            pos[3] = SIDE - GRIDSIZE / 2;
          }
          break;
        case 'w':
          pos[3] -= GRIDSIZE;
          if ((pos[3] < 0) || (walls[pos[2]][pos[3] + GRIDSIZE / 2] == 1)) {
            pos[2] = SIDE - GRIDSIZE / 2;
            pos[3] = SIDE - GRIDSIZE / 2;
          }
          break;
        case 'd':
          pos[2] += GRIDSIZE;
          if ((pos[2] > SIDE) || (walls[pos[2] - GRIDSIZE / 2][pos[3]] == 1)) {
            pos[2] = SIDE - GRIDSIZE / 2;
            pos[3] = SIDE - GRIDSIZE / 2;
          }
          break;
        default:
          System.out.println("keypressed else");
      }
    } else {
      switch (key) {
        case 'a':
          pos[0] -= GRIDSIZE;
          if ((pos[0] < 0) || (walls[pos[0] + GRIDSIZE / 2][pos[1]] == 1)) {
            pos[0] = GRIDSIZE / 2;
            pos[1] = SIDE - GRIDSIZE / 2;
          }
          break;
        case 's':
          pos[1] += GRIDSIZE;
          if ((pos[1] > SIDE) || (walls[pos[0]][pos[1] - GRIDSIZE / 2] == 1)) {
            pos[0] = GRIDSIZE / 2;
            pos[1] = SIDE - GRIDSIZE / 2;
          }
          break;
        case 'w':
          pos[1] -= GRIDSIZE;
          if ((pos[1] < 0) || (walls[pos[0]][pos[1] + GRIDSIZE / 2] == 1)) {
            pos[0] = GRIDSIZE / 2;
            pos[1] = SIDE - GRIDSIZE / 2;
          }
          break;
        case 'd':
          pos[0] += GRIDSIZE;
          if ((pos[0] > SIDE) || (walls[pos[0] - GRIDSIZE / 2][pos[1]] == 1)) {
            pos[0] = GRIDSIZE / 2;
            pos[1] = SIDE - GRIDSIZE / 2;
          }
          break;
        default:
          System.out.println("keypressed else");
      }
    }
  } catch (IndexOutOfBoundsException e) {
    System.out.println("index out of bounds");
  } finally {
    if (twoPlayer) {
      // !turnOne; <- ???
      if (turnOne == true) {
        count[0]++;
        turnOne = false;
      } else {
        count[1]++;
        turnOne = true;
      }
    }
  }
}
