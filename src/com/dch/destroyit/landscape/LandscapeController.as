/**
 * Created by Crazy Horse on 06.02.2015.
 */
package com.dch.destroyit.landscape
{
import com.dch.destroyit.assets.AssetsService;
import com.dch.destroyit.assets.Ground1x1NamesEnum;
import com.dch.destroyit.assets.TilesColorEnum;
import com.dch.destroyit.config.AssetsConfig;
import com.dch.destroyit.config.LandscapeConfig;
import com.dch.destroyit.mvc.IViewController;

import flash.geom.Point;

import starling.display.DisplayObject;
import starling.display.DisplayObjectContainer;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class LandscapeController implements IViewController
{
    private var view:LandscapeView;
    private var _isPanning:Boolean = false;
    private var _allowExplode:Boolean = true;
    private var mousePanBeginPoint:Point = new Point(0, 0);
    private var landscapeModel:LandscapeModel;

    public function LandscapeController(view:LandscapeView)
    {
        this.view = view;
        registerTouchEvents();
        createLandscapeModel(LandscapeConfig.BUILDINGS_COUNT, LandscapeConfig.LANDSCAPE_WIDTH_IN_CEIL, LandscapeConfig.LANDSCAPE_LENGTH_IN_CEIL, LandscapeConfig.BUILDING_SIDE_MIN_SIZE_IN_CEIL,
                LandscapeConfig.BUILDING_SIDE_MAX_SIZE_IN_CEIL, LandscapeConfig.BUILDING_SIDE_SIZE_DIFFERENCE_IN_CEIL, LandscapeConfig.FREE_DISTANCE_IN_CEIL);
        createBuildings(LandscapeConfig.CEIL_SIZE);
    }

    private function createLandscapeModel(buildingsCount:int, landscapeWidth:Number, landscapeLength:Number, minFaceSize:Number, maxFaceSize:Number, maxSideDifference:int, freeDistance:Number):void
    {
        landscapeModel = new LandscapeModel();
        landscapeModel.generateBuildings(buildingsCount, landscapeWidth, landscapeLength, minFaceSize, maxFaceSize, maxSideDifference, freeDistance, LandscapeConfig.BUILDINGS_COUNT);
    }

    private function registerTouchEvents():void
    {
        view.addEventListener(TouchEvent.TOUCH, view_touchHandler);
    }

    private function view_touchHandler(event:TouchEvent):void
    {
        var touch:Touch = event.touches[0];
        switch (touch.phase)
        {
            case TouchPhase.BEGAN:
            {
                _isPanning = true;
                mousePanBeginPoint = touch.getLocation(view.stage);
                break;
            }
            case TouchPhase.MOVED:
            {
                if (_isPanning)
                {
                    var mouseCurrent:Point = touch.getLocation(view.stage);
                    view.x -= mousePanBeginPoint.x - mouseCurrent.x;
                    view.y -= mousePanBeginPoint.y - mouseCurrent.y;
                    mousePanBeginPoint = mouseCurrent;
                    _allowExplode = false;
                }
                break;
            }
            case TouchPhase.ENDED:
            {
                if (_allowExplode)
                {
                    trace(this, "BOOOM");
                }
                _isPanning = false;
                _allowExplode = true;
            }

        }
    }

    private function createBuildings(tileSize:Number):void
    {
        for each(var building:BuildingModel in landscapeModel.buildings)
        {
            var isoBuilding:BuildingView = new BuildingView(building.x * tileSize, 0, building.z * tileSize, building.width * tileSize, building.length * tileSize, 0,
                    LandscapeConfig.CEIL_SIZE, Ground1x1NamesEnum.GROUND_1X1_NAME.value,AssetsService.sharedAssets.assetsManager,AssetsConfig.BUILDING_SWF_NAME);
            var buildingController:BuildingController = new BuildingController(building, isoBuilding);
            view.add2Scene(isoBuilding);
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
