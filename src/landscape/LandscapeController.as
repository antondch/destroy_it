/**
 * Created by Crazy Horse on 06.02.2015.
 */
package landscape
{
import config.Config;

import mvc.IViewController;

import objects.HomeView;

import starling.display.DisplayObject;
import starling.display.DisplayObjectContainer;

public class LandscapeController implements IViewController
{
    private var view:LandscapeView;

    public function LandscapeController(view:LandscapeView)
    {
        this.view = view;
        createHomes(Config.HOMES_COUNT,Config.HOME_MIN_FACE_SIZE,Config.HOME_MAX_FACE_SIZE);
    }

    //todo: move it to prepare game class.
    private function createHomes(count:int,minFaceSize:int,maxFaceSize:int):void
    {
        var row:int = 0;
        for (var i:int = 0; i < count; i++)
        {
            var isoHome:HomeView = new HomeView(0, 0, 0, 200, 300, 0);
            view.add2Scene(isoHome);
        }
    }

    public function showOnView(rootView:DisplayObjectContainer):DisplayObject
    {
        return rootView.addChild(view);
    }

    public function removeView():void
    {
        if (view.parent)
        {
            view.parent.removeChild(view);
        }
    }
}
}
