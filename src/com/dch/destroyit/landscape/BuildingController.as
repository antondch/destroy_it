/**
 * Created by Crazy Horse on 15.02.2015.
 */
package com.dch.destroyit.landscape
{
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class BuildingController
{
    private var buildingModel:BuildingModel;
    private var _view:BuildingView;

    public function BuildingController(buildingModel:BuildingModel,buildingView:BuildingView)
    {
        this.buildingModel = buildingModel;
        this._view = buildingView;
        addExplodeHandler();
    }

    private function addExplodeHandler():void
    {
        _view.addEventListener(TouchEvent.TOUCH, view_touchHandler);
    }

    private function view_touchHandler(event:TouchEvent):void
    {
        var touch:Touch = event.touches[0];

            if(touch.phase== TouchPhase.ENDED)
            {
                _view.explodeBuilding();
            }

    }
}
}
