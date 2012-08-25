package
{
  import net.flashpunk.Entity;
  import net.flashpunk.graphics.Spritemap;
  import net.flashpunk.graphics.Image;
  import net.flashpunk.utils.Input;
  import net.flashpunk.utils.Key;
  import net.flashpunk.FP;

  public class MyEntity extends Entity
  {
    protected var sprMove:Spritemap = null;
    protected var sprStop:Spritemap = null;
    protected var sprAttack:Spritemap = null;
    protected var sprFps:int;
    protected var keyPressed:Vector.<Boolean> = new Vector.<Boolean>(4,false);
    protected var direction:String;
    protected var speed:Number = 10;
    //protected var scale:Number = 0.8;

    public function MyEntity(allegiance:String)
    {
      type = allegiance;
      keyPressed[0] = false; 
      keyPressed[1] = false; 
      keyPressed[2] = false; 
      keyPressed[3] = false;
      setHitbox(96, 96);
      direction = "e";

      x = 200; y = 300;
    }

    override public function update():void
    {
      movement();
      var enemy:Entity; 
      if (type == "enemy")
        enemy = collide("ally", x, y) as Entity;
      else if (type == "ally")
        enemy = collide("enemy", x, y) as Entity;

      if (enemy)
        attack();
      else
        sprMove.color = 0xffffff;
    }

    protected function attack():void
    {
    }

    protected function movement():void
    {
      var dirVal:int = 0;
      if (keyPressed[0])
        dirVal = dirVal + 1;
      if (keyPressed[1])
        dirVal = dirVal + 2;
      if (keyPressed[2])
        dirVal = dirVal + 4;
      if (keyPressed[3])
        dirVal = dirVal + 8;

      var willMove:Boolean = true;
      switch(dirVal) {
        case 1:
          direction = "n";
          break;
        case 3:
          direction = "ne";
          break;
        case 2:
          direction = "e";
          break;
        case 6:
          direction = "se";
          break;
        case 4:
          direction = "s";
          break;
        case 12:
          direction = "sw";
          break;
        case 8:
          direction = "w";
          break;
        case 9:
          direction = "nw";
          break;
        default:
          willMove = false;
          if (sprStop) {
            graphic = sprStop;
            sprStop.play(direction);
          }
      }

      if (willMove) {
        if (sprMove) {
          graphic = sprMove;
          sprMove.play(direction);
        }
        if (keyPressed[0])
          y -= speed * FP.elapsed;
        else if (keyPressed[2])
          y += speed * FP.elapsed;
        if (keyPressed[1])
          x += speed * FP.elapsed;
        else if (keyPressed[3])
          x -= speed * FP.elapsed;
      }
    }

  }

}
