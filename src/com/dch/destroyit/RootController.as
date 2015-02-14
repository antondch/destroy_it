/**
 * Created by Crazy Horse on 06.02.2015.
 */
package com.dch.destroyit
{
import com.dch.destroyit.config.LandscapeConfig;
import com.dch.destroyit.landscape.LandscapeController;
import com.dch.destroyit.landscape.LandscapeView;
import com.dch.destroyit.mvc.IViewController;

import starling.display.DisplayObject;
import starling.display.DisplayObjectContainer;

public class RootController implements IViewController
{
    private var view:DisplayObject;
    private var landscapeController:LandscapeController;

    public function RootController(view:DisplayObject)
    {
        this.view = view;
        createLandscape(LandscapeConfig.LANDSCAPE_START_POINT_X, LandscapeConfig.LANDSCAPE_START_POINT_Y, LandscapeConfig.LANDSCAPE_START_POINT_Z, LandscapeConfig.LANDSCAPE_WIDTH, LandscapeConfig.LANDSCAPE_LENGTH);
    }

    private function createLandscape(x:Number, y:Number, z:Number, width:Number, length:Number):void
    {
        var landscapeView:LandscapeView = new LandscapeView(x, y, z, width, length);
        landscapeView.y = 100;
        landscapeView.x = 600;


        landscapeController = new LandscapeController(landscapeView);
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
