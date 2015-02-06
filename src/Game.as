/**
 * Created by Crazy Horse on 05.02.2015.
 */
package
{
import display.Landscape;

import home.IsoHome;

import starling.display.Sprite;

public class Game extends Sprite
{
    public function Game():void
    {
        var landscape = new Landscape();
        this.addChild(landscape);
        var isoHome:IsoHome = new IsoHome(0, 0, 0, 200, 300, 0);
//        isoHome.isoX=isoHome.isoY=300;
        landscape.x = landscape.y = 300;
        landscape.add2Scene(isoHome);
    }
}
}
