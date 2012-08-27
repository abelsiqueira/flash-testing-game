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
    protected var attackCounter:Number = 0;
    protected var attackCooldown:Number = 4;
    protected var attackDuration:Number = 4;
    protected var state:String = "idle";
    protected var maxHP:int, HP:int;
    protected var nearEnemy:MyEntity = null;

    public function MyEntity(allegiance:String, xx:int, yy:int)
    {
      type = allegiance;
      x = xx; y = yy;

      keyPressed[0] = false; 
      keyPressed[1] = false; 
      keyPressed[2] = false; 
      keyPressed[3] = false;
      setHitbox(96, 96);
      direction = "s";
    }

    override public function update():void
    {
      if (state == "attack") {
        attackCounter -= FP.elapsed;
        if (attackCounter <= 0) {
          attackCounter = attackCooldown;
          state = "idle";
        }
        return;
      }
      if (attackCounter > 0) {
        attackCounter -= FP.elapsed;
        if (attackCounter <= 0) {
          attackCounter = 0;
        }
      }

      if (type == "enemy") {
        GetNearestEnemy("ally");
        movement();
        if (world.typeCount("ally") == 0) {
          return;
        }
      } else if (type == "ally") {
        GetNearestEnemy("enemy");
        movement();
        if (world.typeCount("enemy") == 0) {
          return;
        }
      }

      if (collideWith(nearEnemy, x, y) && attackCounter == 0)
        attack(nearEnemy);
      else {
        MoveToNearestEntity();
        movement();
        sprMove.color = 0xffffff;
      }
    }

    protected function GetNearestEnemy(al:String):void 
    {
      if (world.typeCount(al) == 0) {
        nearEnemy = null;
        return;
      }
      var enemies:Array= [];
      world.getType(al, enemies);
      var minDist:Number = 100000;
      var d:Number;
      var len:int = enemies.length;
      for (var i:int = 0; i < len; i++) {
        var en:MyEntity = enemies[i];
        d = distanceFrom(en, false);
        if (d < minDist) {
          minDist = d;
          nearEnemy = en;
        }
      }
    }

    protected function MoveToNearestEntity():void
    {
      if ( (type == "ally" && world.typeCount("enemy") == 0) ||
           (type == "enemy" && world.typeCount("ally") == 0) ) {
        sprMove.color = 0x0000ff;
        return;
      }
      keyPressed[0] = false;
      keyPressed[1] = false;
      keyPressed[2] = false;
      keyPressed[3] = false;
      if (x < nearEnemy.x - 5) {
        keyPressed[1] = true;
      } else if (x > nearEnemy.x + 5) {
        keyPressed[3] = true;
      }
      if (y < nearEnemy.y - 5) {
        keyPressed[2] = true;
      } else if (y > nearEnemy.y + 5) {
        keyPressed[0] = true;
      }
    }

    protected function attack(enemy:MyEntity):void
    {
      attackCounter = attackDuration;
      state = "attack";
      var dx:Number = enemy.x - x;
      var dy:Number = enemy.y - y;
      var theta:Number = Math.atan2(dy, dx);
      var pi:Number = Math.PI;
      if (theta < -7*pi/8.0)
        direction = "w";
      else if (theta < -5*pi/8.0)
        direction = "nw";
      else if (theta < -3*pi/8.0)
        direction = "n";
      else if (theta < -pi/8.0)
        direction = "ne";
      else if (theta < pi/8.0)
        direction = "e";
      else if (theta < 3*pi/8.0)
        direction = "se";
      else if (theta < 5*pi/8.0)
        direction = "s";
      else if (theta < 7*pi/8.0)
        direction = "sw";
      else 
        direction = "w";

      if (sprAttack) {
        graphic = sprAttack;
        sprAttack.play(direction);
      }
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
