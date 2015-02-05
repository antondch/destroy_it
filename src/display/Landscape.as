/**
 * Created by Crazy Horse on 05.02.2015.
 */
package display
{
import isoCore.IsoStarlingScene;

public class Landscape extends IsoStarlingScene
{
    private static var instance:Landscape;

    public function Landscape()
    {
        if(instance){
            throw new Error("Is singleton. Use Landscape.getInstance()");
        }
    }

    public function getInstance():Landscape
    {
        if(!instance){
            instance = new Landscape();
        }
        return instance;
    }
}
}
