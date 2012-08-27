package
{
  import net.flashpunk.graphics.Spritemap;
  import net.flashpunk.graphics.Image;
  import net.flashpunk.utils.Input;
  import net.flashpunk.utils.Key;
  import net.flashpunk.FP;

  public class Spider extends MyEntity
  {
    [Embed(source = '../assets/spider/attack.png')]
    private const ATTACK:Class;
    [Embed(source = '../assets/spider/damage.png')]
    private const DAMAGE:Class;
    [Embed(source = '../assets/spider/death.png')]
    private const DEATH:Class;
    [Embed(source = '../assets/spider/walk.png')]
    private const MOVE:Class;

    public function Spider(allegiance:String, xx:int, yy:int)
    {
      sprFps = 8;
      speed = 30;
      sprMove = new Spritemap(MOVE, 96, 96);
      sprAttack = new Spritemap(ATTACK, 96, 96);
      sprMove.add("n",  [ 0,  1,  2,  3,  4,  5,  6,  7], sprFps, true);
      sprMove.add("ne", [ 8,  9, 10, 11, 12, 13, 14, 15], sprFps, true);
      sprMove.add("e",  [16, 17, 18, 19, 20, 21, 22, 23], sprFps, true);
      sprMove.add("se", [24, 25, 26, 27, 28, 29, 30, 31], sprFps, true);
      sprMove.add("s",  [32, 33, 34, 35, 36, 37, 38, 39], sprFps, true);
      sprMove.add("sw", [40, 41, 42, 43, 44, 45, 46, 47], sprFps, true);
      sprMove.add("w",  [48, 49, 50, 51, 52, 53, 54, 55], sprFps, true);
      sprMove.add("nw", [56, 57, 58, 59, 60, 61, 62, 63], sprFps, true);
      sprAttack.add("n",  [ 0,  1,  2,  3,  4,  5,  6,  7,  8], sprFps, false);
      sprAttack.add("ne", [ 9, 10, 11, 12, 13, 14, 15, 16, 17], sprFps, false);
      sprAttack.add("e",  [18, 19, 20, 21, 22, 23, 24, 25, 26], sprFps, false);
      sprAttack.add("se", [27, 28, 29, 30, 31, 32, 33, 34, 35], sprFps, false);
      sprAttack.add("s",  [36, 37, 38, 39, 40, 41, 42, 43, 44], sprFps, false);
      sprAttack.add("sw", [45, 46, 47, 48, 49, 50, 51, 52, 53], sprFps, false);
      sprAttack.add("w",  [54, 55, 56, 57, 58, 59, 60, 61, 62], sprFps, false);
      sprAttack.add("nw", [63, 64, 65, 66, 67, 68, 69, 70, 71], sprFps, false);
      //var scale:Number = 0.8;
      //sprMove.scale = scale;

      super(allegiance, xx, yy);
      graphic = sprMove;
      sprMove.play("e");
    }

    override public function update():void
    {
      randomMovement();
      super.update();
    }

    override protected function attack(enemy:MyEntity):void
    {
      super.attack(enemy);
      sprMove.color = 0x00ff00;
    }

    protected function randomMovement():void
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
    }

  }

}
