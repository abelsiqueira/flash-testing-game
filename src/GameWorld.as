package
{
  import net.flashpunk.World;
  import net.flashpunk.graphics.Backdrop;

  public class GameWorld extends World
  {
    [Embed(source = '../assets/background/sand.png')]
    private const BACKGROUND:Class;

    public function GameWorld()
    {
      var background:Backdrop = new Backdrop(BACKGROUND);
      addGraphic(background);
      add(new Red("ally"));
      add(new Spider("enemy"));
      add(new Spider("enemy"));
    }

  }

}
