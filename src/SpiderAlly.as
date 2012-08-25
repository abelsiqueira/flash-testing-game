package
{
  import net.flashpunk.Entity;
  import net.flashpunk.graphics.Spritemap;
  import net.flashpunk.graphics.Image;
  import net.flashpunk.utils.Input;
  import net.flashpunk.utils.Key;
  import net.flashpunk.FP;

  public class SpiderAlly extends Spider
  {
    public function SpiderAlly()
    {
      super();
      type = "ally";
      sprWalk.color = 0x00ff00;
    }

    override public function update():void
    {
      super.update()
    }

  }

}
