package
{
  import net.flashpunk.Entity;
  import net.flashpunk.graphics.Spritemap;
  import net.flashpunk.graphics.Image;
  import net.flashpunk.utils.Input;
  import net.flashpunk.utils.Key;
  import net.flashpunk.FP;

  public class Spider extends Entity
  {
    [Embed(source = '../assets/spider/attack.png')]
    private const ATTACK:Class;
    [Embed(source = '../assets/spider/damage.png')]
    private const DAMAGE:Class;
    [Embed(source = '../assets/spider/death.png')]
    private const DEATH:Class;
    [Embed(source = '../assets/spider/walk.png')]
    private const WALK:Class;

    protected var sprWalk:Spritemap = new Spritemap(WALK, 96, 96);
    protected var sprFps:int = 8;
    protected var keyPressed:Vector.<Boolean> = new Vector.<Boolean>(4,false);
    protected var direction:String;
    protected var speed:Number = 10;

    public function Spider(side:String)
    {
      type=side;
      keyPressed[0] = false; keyPressed[1] = false;
      keyPressed[2] = false; keyPressed[3] = false;
      setHitbox(96, 96);
      sprWalk.add("n",  [ 0,  1,  2,  3,  4,  5,  6,  7], sprFps, true);
      sprWalk.add("ne", [ 8,  9, 10, 11, 12, 13, 14, 15], sprFps, true);
      sprWalk.add("e",  [16, 17, 18, 19, 20, 21, 22, 23], sprFps, true);
      sprWalk.add("se", [24, 25, 26, 27, 28, 29, 30, 31], sprFps, true);
      sprWalk.add("s",  [32, 33, 34, 35, 36, 37, 38, 39], sprFps, true);
      sprWalk.add("sw", [40, 41, 42, 43, 44, 45, 46, 47], sprFps, true);
      sprWalk.add("w",  [48, 49, 50, 51, 52, 53, 54, 55], sprFps, true);
      sprWalk.add("nw", [56, 57, 58, 59, 60, 61, 62, 63], sprFps, true);
      //var scale:Number = 0.8;
      //sprWalk.scale = scale;
      graphic = sprWalk;
      sprWalk.play("e");
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
        sprWalk.color = 0xffffff;
    }

    private function attack():void
    {
      sprWalk.color = 0x00ff00;
    }

    private function movement():void
    {
      if (FP.rand(100) < 1) {
        if (FP.rand(100) < 50)
          keyPressed[0] = FP.choose(true, true, false);
        else
          keyPressed[2] = FP.choose(true, true, false);
        if (FP.rand(100) < 50)
          keyPressed[1] = FP.choose(true, true, false);
        else
          keyPressed[3] = FP.choose(true, true, false);
      }
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
      }
      if (willMove) {
        graphic = sprWalk;
        sprWalk.play(direction);
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
