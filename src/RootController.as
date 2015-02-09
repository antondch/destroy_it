/**
 * Created by Crazy Horse on 06.02.2015.
 */
package
{
import landscape.LandscapeController;
import landscape.LandscapeView;

import mvc.IViewController;

import starling.display.DisplayObject;
import starling.display.DisplayObjectContainer;

public class RootController implements IViewController
{
    private var view:DisplayObject;
    private var landscapeController:LandscapeController;

    public function RootController(view:DisplayObject)
    {
        this.view = view;
        createLandscape();
    }

    private function createLandscape():void
    {
        var landscape:LandscapeView = new LandscapeView();
        landscapeController = new LandscapeController(landscape);
        landscapeController.showOnView(view as DisplayObjectContainer)
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
