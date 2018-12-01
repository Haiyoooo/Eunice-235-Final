ArrayList <GameObject> gameObject = new ArrayList<GameObject>();
Player player;
Enemy enemy1, enemy2, enemy3;

boolean DEBUG = true;
float ease;

boolean night;
boolean photosynthesis;
int timer; // for spawning puddles
int gameTimer; // for total game time
float step;
float x, y, x1, y1;

int gamestate;
final int RUNNING = 1;
final int GAMEEND = 2;


void setup()
{
  size(800, 800);
  colorMode(HSB, 100);
  imageMode(CENTER);
  noStroke();
  gamestate = 1;
  night = true;
  timer = 0;
  gameTimer = 0;
  step = PI;
  ease = 0.006;
  frameRate(60);
  
  loadImages();
  loadSounds();
  
  gameObject.add( enemy1 = new Enemy(width * .5, height * .5) );
  gameObject.add( enemy2 = new Enemy(width * .1, height * .4) );
  gameObject.add( enemy3 = new Enemy(width * .7, height * .9) );
  gameObject.add( player = new Player() );
}

void draw()
{ 
  switch(gamestate)
  {
    case RUNNING:
      gameTimer += 1;
      skyBox();
      ground();
      if(night) fogOfWar();
     
      
      //spawner
      puddleSpawner();
      
      //updater
      for(int i = gameObject.size() - 1; i >= 0; i--)
      {
        GameObject obj = gameObject.get(i);
        obj.update();
        obj.render();
        obj.checkCollision();
        
      //despawner
        if(obj.tab == "puddle" && ( obj.wetness < 0 || gamestate == GAMEEND) )
        {
          gameObject.remove(i);
        }
      }
      
      //night time


      hud();
      break;
      
    case GAMEEND:
      displayHighscore();
      for(int i = gameObject.size() - 1; i >= 0; i--)
      {
        gameObject.remove(i);
      }
  }


  if(DEBUG)
  {
    debugger();
  }
}

void mousePressed()
{
  if(gamestate == GAMEEND)
  {
    setup();
  }
  
  if(mouseButton == LEFT) ease -= 0.001 ;
  if(mouseButton == RIGHT) ease += 0.001 ;
}

/*--------------------------------------------------
                       KEYBOARD
--------------------------------------------------*/
// (c) https://forum.processing.org/two/discussion/16594/#Comment_68096
boolean isUp, isDown, isLeft, isRight;

void keyPressed()
{
  if(gamestate == RUNNING)
  {
    setMove(keyCode, true);
    if(player.sugar > 0)player.sugar--;
    if(key == ' ')player.getSugar();
  }
}
 
void keyReleased()
{
  photosynthesis = false;
  
  if(gamestate == RUNNING)
  {
    setMove(keyCode, false);
  }
}

boolean setMove(int k, boolean b)
{
  switch (k)
  {
    case UP:
      return isUp = b;
   
    case DOWN:
      return isDown = b;
   
    case LEFT:
      return isLeft = b;
   
    case RIGHT:
      return isRight = b;
   
    default:
      return b;
  }
}
