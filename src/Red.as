package
{
  import net.flashpunk.Entity;
  import net.flashpunk.graphics.Spritemap;
  import net.flashpunk.graphics.Image;
  import net.flashpunk.utils.Input;
  import net.flashpunk.utils.Key;
  import net.flashpunk.FP;

  public class Red extends MyEntity
  {
    [Embed(source = '../assets/red_swordsman/run.png')]
    private const MOVE:Class;
    [Embed(source = '../assets/red_swordsman/paused.png')]
    private const STOP:Class;

    public function Red(allegiance:String, xx:int, yy:int)
    {
      sprFps = 10;
      sprMove = new Spritemap(MOVE, 96, 96);
      sprStop = new Spritemap(STOP, 96, 96);
      sprMove.add("n",  [ 0,  1,  2,  3,  4,  5,  6,  7], sprFps, true);
      sprMove.add("ne", [ 8,  9, 10, 11, 12, 13, 14, 15], sprFps, true);
      sprMove.add("e",  [16, 17, 18, 19, 20, 21, 22, 23], sprFps, true);
      sprMove.add("se", [24, 25, 26, 27, 28, 29, 30, 31], sprFps, true);
      sprMove.add("s",  [32, 33, 34, 35, 36, 37, 38, 39], sprFps, true);
      sprMove.add("sw", [40, 41, 42, 43, 44, 45, 46, 47], sprFps, true);
      sprMove.add("w",  [48, 49, 50, 51, 52, 53, 54, 55], sprFps, true);
      sprMove.add("nw", [56, 57, 58, 59, 60, 61, 62, 63], sprFps, true);
      sprStop.add("n",  [ 0,  1,  2,  3,  4,  5,  6,  7], sprFps, true);
      sprStop.add("ne", [ 8,  9, 10, 11, 12, 13, 14, 15], sprFps, true);
      sprStop.add("e",  [16, 17, 18, 19, 20, 21, 22, 23], sprFps, true);
      sprStop.add("se", [24, 25, 26, 27, 28, 29, 30, 31], sprFps, true);
      sprStop.add("s",  [32, 33, 34, 35, 36, 37, 38, 39], sprFps, true);
      sprStop.add("sw", [40, 41, 42, 43, 44, 45, 46, 47], sprFps, true);
      sprStop.add("w",  [48, 49, 50, 51, 52, 53, 54, 55], sprFps, true);
      sprStop.add("nw", [56, 57, 58, 59, 60, 61, 62, 63], sprFps, true);

      super(allegiance, xx, yy);

      graphic = sprStop;
      sprStop.play(direction);
      speed = 150;
      Input.define("Left", Key.LEFT);
      Input.define("Right", Key.RIGHT);
      Input.define("Up", Key.UP);
      Input.define("Down", Key.DOWN);
    }

    override public function update():void
    {
      if (Input.check("Up"))
        keyPressed[0] = true;
      else
        keyPressed[0] = false;
      if (Input.check("Right"))
        keyPressed[1] = true;
      else
        keyPressed[1] = false;
      if (Input.check("Down"))
        keyPressed[2] = true;
      else
        keyPressed[2] = false;
      if (Input.check("Left"))
        keyPressed[3] = true;
      else
        keyPressed[3] = false;
      //super.update();
      super.movement();
    }

    override protected function attack(enemy:MyEntity):void
    {
    }

  }

}
