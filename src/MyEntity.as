package
{
  import net.flashpunk.Entity;
  import net.flashpunk.utils.Draw;
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
    protected var speed:Number;
    //protected var scale:Number = 0.8;
    protected var attackCounter:Number = 0;
    protected var attackCooldown:Number = 1;
    protected var attackDuration:Number = 2;
    protected var attackMoment:Number = 1;
    protected var state:String = "move";
    protected var maxHP:int, HP:int;
    protected var damage:int;
    protected var nearEnemy:MyEntity = null;
    protected var willAttack:Boolean = false;

    public function MyEntity(allegiance:String, xx:int, yy:int)
    {
      type = allegiance;
      x = xx; y = yy;

      keyPressed[0] = false; 
      keyPressed[1] = false; 
      keyPressed[2] = false; 
      keyPressed[3] = false;
      direction = "s";
    }

    override public function update():void
    {
      if (type == "enemy") {
        GetNearestEnemy("ally");
      } else if (type == "ally") {
        GetNearestEnemy("enemy");
      }
      if (state == "attack") {
        attackCounter -= FP.elapsed;
        if (willAttack && attackCounter <= attackMoment) {
          if (nearEnemy.receiveDamage(damage))
            nearEnemy = null;
          willAttack = false;
        } else if (attackCounter <= 0) {
          attackCounter = attackCooldown;
          state = "inAttackRange";
        }
        return;
      } else if (state == "inAttackRange") {
        if (attackCounter <= 0)
          state = "attack";
      }
      if (attackCounter > 0) {
        attackCounter -= FP.elapsed;
        if (attackCounter <= 0) {
          attackCounter = 0;
        }
      }

      var coll:Boolean;
      if (collideWith(nearEnemy, x, y))
        coll = true;
      else 
        coll = false;

      if (!coll)
        state = "move";

      if (state == "inAttackRange")
        return;

      if (coll && attackCounter <= 0)
        attack(nearEnemy);
      else {
        MoveToNearestEntity();
        movement();
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
      if (attackCounter > 0) {
        state = "inAttackRange";
        return;
      }
      willAttack = true;
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
        sprAttack.play(direction, true);
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

    public function receiveDamage(dmg:int):Boolean
    {
      HP -= dmg;
      if (HP <= 0) {
        world.remove(this);
        return true;
      }
      return false;
    }

    override public function render():void
    {
      super.render();
      drawHP();
      //Draw.rectPlus(x+originX, y+originY, width, height, 0x000000, 1, false);
    }

    protected function drawHP():void
    {
      var value:Number = HP/maxHP;
      var bh:int = 10;
      var bw:int = value*width;

      Draw.rect(x + originX, y + originY, width, bh, 0xff0000, 0.5);
      Draw.rect(x + originX, y + originY, bw, bh, 0x00ff00, 0.5);
    }

  }

}
