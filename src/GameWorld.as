package
{
  import net.flashpunk.World;
  import net.flashpunk.graphics.Backdrop;
  import net.flashpunk.FP;

  public class GameWorld extends World
  {
    [Embed(source = '../assets/background/sand.png')]
    private const BACKGROUND:Class;

    public function GameWorld()
    {
      var background:Backdrop = new Backdrop(BACKGROUND);
      addGraphic(background);
      add(new Base("enemy"));
      add(new Base("ally"));
      add(new Red("ally", FP.width/2 - 48, FP.height/2 - 48));
    }

  }

}
