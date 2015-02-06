/**
 * Created by Crazy Horse on 06.02.2015.
 */
package
{
import land.LandscapeView;

import objects.Home;

import starling.display.DisplayObject;
import starling.display.DisplayObjectContainer;

public class RootController
{
    private var view:DisplayObject;

    public function RootController(view:DisplayObject)
    {
        this.view = view;
        createLandscape();
    }

    private function createLandscape():void
    {
        var landscape:LandscapeView = new LandscapeView();
        landscape.x = landscape.y = 300;
        DisplayObjectContainer(this.view).addChild(landscape);
        var isoHome:Home = new Home(0, 0, 0, 200, 300, 0);
//        isoHome.isoX=isoHome.isoY=300;
        landscape.add2Scene(isoHome);

    }
}
}
