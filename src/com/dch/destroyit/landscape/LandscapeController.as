/**
 * Created by Crazy Horse on 06.02.2015.
 */
package com.dch.destroyit.landscape
{
import com.dch.destroyit.assets.AssetsService;
import com.dch.destroyit.config.LandscapeConfig;
import com.dch.destroyit.isoCore.IsoUtils;
import com.dch.destroyit.mvc.IViewController;

import flash.display.Sprite;
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
        createLandscapeModel(LandscapeConfig.BUILDINGS_COUNT, LandscapeConfig.LANDSCAPE_WIDTH_IN_TILES, LandscapeConfig.LANDSCAPE_LENGTH_IN_TILES, LandscapeConfig.BUILDING_SIDE_MIN_SIZE_IN_TILES,
                LandscapeConfig.BUILDING_SIDE_MAX_SIZE_IN_TILES, LandscapeConfig.BUILDING_SIDE_SIZE_DIFFERENCE_IN_TILES, LandscapeConfig.FREE_DISTANCE_IN_TILES);
        createBuildings(LandscapeConfig.TILE_SIZE);
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
                    LandscapeConfig.TILE_SIZE,LandscapeConfig.BUILDING_INNER_COLOR,LandscapeConfig.BUILDING_BORDER_THICKNESS,LandscapeConfig.BUILDING_BORDER_COLOR,AssetsService.sharedAssets.assetsManager);
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
