/**
 * Created by Crazy Horse on 06.02.2015.
 */
package landscape
{
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
        createHomes();
    }

    private function createHomes():void
    {
        var isoHome:HomeView = new HomeView(0, 0, 0, 200, 300, 0);
        view.add2Scene(isoHome);
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
