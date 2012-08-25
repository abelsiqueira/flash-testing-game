package
{
  import net.flashpunk.Entity;
  import net.flashpunk.graphics.Spritemap;
  import net.flashpunk.graphics.Image;
  import net.flashpunk.utils.Input;
  import net.flashpunk.utils.Key;
  import net.flashpunk.FP;

  public class Red extends Entity
  {
    [Embed(source = '../assets/red_swordsman/run.png')]
    private const RUN:Class;
    [Embed(source = '../assets/red_swordsman/paused.png')]
    private const PAUSED:Class;

    private var sprRun:Spritemap = new Spritemap(RUN, 96, 96);
    private var sprPaused:Spritemap = new Spritemap(PAUSED, 96, 96);
    private var sprFps:int = 10;
    private var keyPressed:Vector.<Boolean> = new Vector.<Boolean>(4,false);
    private var direction:String;
    private var speed:Number = 140;

    public function Red()
    {
      keyPressed[0] = false; keyPressed[1] = false;
      keyPressed[2] = false; keyPressed[3] = false;
      setHitbox(96, 96);
      sprRun.add("n",  [ 0,  1,  2,  3,  4,  5,  6,  7], sprFps, true);
      sprRun.add("ne", [ 8,  9, 10, 11, 12, 13, 14, 15], sprFps, true);
      sprRun.add("e",  [16, 17, 18, 19, 20, 21, 22, 23], sprFps, true);
      sprRun.add("se", [24, 25, 26, 27, 28, 29, 30, 31], sprFps, true);
      sprRun.add("s",  [32, 33, 34, 35, 36, 37, 38, 39], sprFps, true);
      sprRun.add("sw", [40, 41, 42, 43, 44, 45, 46, 47], sprFps, true);
      sprRun.add("w",  [48, 49, 50, 51, 52, 53, 54, 55], sprFps, true);
      sprRun.add("nw", [56, 57, 58, 59, 60, 61, 62, 63], sprFps, true);
      sprPaused.add("n",  [ 0,  1,  2,  3,  4,  5,  6,  7], sprFps, true);
      sprPaused.add("ne", [ 8,  9, 10, 11, 12, 13, 14, 15], sprFps, true);
      sprPaused.add("e",  [16, 17, 18, 19, 20, 21, 22, 23], sprFps, true);
      sprPaused.add("se", [24, 25, 26, 27, 28, 29, 30, 31], sprFps, true);
      sprPaused.add("s",  [32, 33, 34, 35, 36, 37, 38, 39], sprFps, true);
      sprPaused.add("sw", [40, 41, 42, 43, 44, 45, 46, 47], sprFps, true);
      sprPaused.add("w",  [48, 49, 50, 51, 52, 53, 54, 55], sprFps, true);
      sprPaused.add("nw", [56, 57, 58, 59, 60, 61, 62, 63], sprFps, true);
      //var scale:Number = 0.8;
      //sprRun.scale = scale;
      //sprPaused.scale = scale;
      graphic = sprPaused;
      sprPaused.play("e");
      direction = "e";

      x = 400; y = 300;
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
          graphic = sprPaused;
          sprPaused.play(direction);
      }
      if (willMove) {
        graphic = sprRun;
        sprRun.play(direction);
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
