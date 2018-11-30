/*--------------------------------------------------
                    MAKE ENEMY
--------------------------------------------------*/
void enemySpawner()
{
  enemy.add( new Enemy(width * .5, height * .5) );
  enemy.add( new Enemy(width * .1, height * .4) );
  enemy.add( new Enemy(width * .7, height * .9) );
}
/*--------------------------------------------------
                    ENEMY CLASS
--------------------------------------------------*/
class Enemy
{
  PVector position;
  PVector zonePos;
  float zone;
  
  Enemy(float posX, float posY)
  {
    position = new PVector(posX, posY);
    zonePos = new PVector(posX, posY);
    zone = 400;
  }
  
  void update()
  {
    isAggro();
  }
  
  void render()
  {
    if(isAggro())
    {
      fill(100, 80, 80, 20); //red
    }else{
      fill(50, 50, 50, 10); //white
    }
    ellipse(zonePos.x, zonePos.y, zone, zone);
    
    fill(100, 80, 80);
    ellipse(position.x, position.y, 50, 50);
  }
  
  boolean isAggro()
  {
    if(playerDistanceTo(zonePos) < zone/2)
    {
      //chase
      position.x = easeOutBack(position.x, player.position.x, ease);  //0.006
      position.y = easeOutBack(position.y, player.position.y, ease);  //0.006
      return true;
    }
    //return home
    position.x = easeOut(position.x, zonePos.x, 0.002);
    position.y = easeOut(position.y, zonePos.y, 0.002);
    return false;
  }
  
}

/*--------------------------------------------------
                    UPDATE ENEMY
--------------------------------------------------*/
void enemyUpdater() 
{
    for(int i = enemy.size() - 1; i >= 0; i--)
    {
      Enemy e = enemy.get(i);
      e.update();
      e.render();
    }
}
