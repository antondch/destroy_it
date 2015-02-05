/**
 * Created by Crazy Horse on 05.02.2015.
 */
package {
import display.Landscape;

import home.IsoHome;

import starling.display.Sprite;

public class Game extends Sprite
{
    public function Game():void
    {
        var landscape = new Landscape();
        this.addChild(landscape);
        var home:IsoHome = new IsoHome(100);
        landscape.addChild(home);
    }
}
}
