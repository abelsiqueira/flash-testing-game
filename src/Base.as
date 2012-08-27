package
{
  import net.flashpunk.Entity;
  import net.flashpunk.FP;
  import net.flashpunk.graphics.Image;

  public class Base extends MyEntity
  {
    protected var timeBetweenWaves:Number = 2;
    protected var wavesTimer:Number = 0;
    protected var allegiance:String;
    [Embed(source = '../assets/Castle/red_castle_closed.png')]
    private const RED_CLOSED:Class;
    [Embed(source = '../assets/Castle/green_castle_closed.png')]
    private const GREEN_CLOSED:Class;
    private var image:Image;

    public function Base(al:String)
    {
      setHitbox(192, 384);
      allegiance = al;
      if (al == "ally") {
        image = new Image(GREEN_CLOSED);
        x = 0;
      } else if (al == "enemy") {
        image = new Image(RED_CLOSED);
        x = FP.width - width;
      }
      y = FP.height/2 - height/2;
      graphic = image;
      super(al, x, y);
      maxHP = 100;
      HP = 100;
    }

    override public function update():void
    {
      if (wavesTimer <= 0)
      {
        var outx:int;
        if (allegiance == "ally")
          outx = width;
        else if (allegiance == "enemy")
          outx = FP.width - width - 96;
        wavesTimer = timeBetweenWaves;
        world.add(new Spider(allegiance, outx, FP.rand(FP.height-96)));
      }
      else
      {
        wavesTimer -= FP.elapsed;
      }
    }

  }

}
