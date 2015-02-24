/**
 * Created by Crazy Horse on 06.02.2015.
 */
package com.dch.destroyit.landscape
{
import com.dch.destroyit.config.LandscapeConfig;
import com.dch.destroyit.isoCore.IsoPoint;
import com.dch.destroyit.isoCore.IsoUtils;
import com.dch.destroyit.mvc.IViewController;

import flash.geom.Point;

import starling.display.DisplayObject;
import starling.display.DisplayObjectContainer;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class LandscapeController implements IViewController
{
    private var landscapeLayer:LandscapeView;
    private var _isPanning:Boolean = false;
    private var _allowExplode:Boolean = true;
    private var mousePanPrevPoint:Point = new Point(0, 0);
    private var landscapeModel:LandscapeModel;

    public function LandscapeController(view:LandscapeView)
    {
        this.landscapeLayer = view;
        registerTouchEvents();
        createLandscapeModel(LandscapeConfig.BUILDINGS_COUNT, LandscapeConfig.LANDSCAPE_WIDTH_IN_CEIL, LandscapeConfig.LANDSCAPE_LENGTH_IN_CEIL, LandscapeConfig.BUILDING_SIDE_MIN_SIZE_IN_CEIL,
                LandscapeConfig.BUILDING_SIDE_MAX_SIZE_IN_CEIL, LandscapeConfig.BUILDING_SIDE_SIZE_DIFFERENCE_IN_CEIL, LandscapeConfig.FREE_DISTANCE_IN_CEIL);
        createBuildings();
    }

    private function createLandscapeModel(buildingsCount:int, landscapeWidth:Number, landscapeLength:Number, minFaceSize:Number, maxFaceSize:Number, maxSideDifference:int, freeDistance:Number):void
    {
        landscapeModel = new LandscapeModel();
        landscapeModel.generateBuildings(buildingsCount, landscapeWidth, landscapeLength, minFaceSize, maxFaceSize, maxSideDifference, freeDistance, LandscapeConfig.BUILDINGS_COUNT);
    }

    private function registerTouchEvents():void
    {
        landscapeLayer.addEventListener(TouchEvent.TOUCH, view_touchHandler);
    }

    private var mousePanBeginPoint:Point = new Point();
    private function view_touchHandler(event:TouchEvent):void
    {
        var touch:Touch = event.touches[0];
        switch (touch.phase)
        {
            case TouchPhase.BEGAN:
            {
                _isPanning = true;
                mousePanPrevPoint = touch.getLocation(landscapeLayer.stage);
                mousePanBeginPoint.x = mousePanPrevPoint.x;
                mousePanBeginPoint.y = mousePanPrevPoint.y;
                break;
            }
            case TouchPhase.MOVED:
            {
                if (_isPanning)
                {
                    var mouseCurrent:Point = touch.getLocation(landscapeLayer.stage);
                    var dx:int = mousePanPrevPoint.x - mouseCurrent.x;
                    var dy:int = mousePanPrevPoint.y - mouseCurrent.y;
                    landscapeLayer.x -= dx;
                    landscapeLayer.y -= dy;
                    mousePanPrevPoint = mouseCurrent;
                }
                break;
            }
            case TouchPhase.ENDED:
            {
                //explode, if not panning:
                var mouseCurrent:Point = touch.getLocation(landscapeLayer.stage);
                if (Math.abs(mousePanBeginPoint.x-mouseCurrent.x) < 20 && Math.abs(mousePanBeginPoint.x-mouseCurrent.x) < 20)
                {
                    var cell:IsoPoint = IsoUtils.screenToIso((mouseCurrent.x - landscapeLayer.x) / LandscapeConfig.CEIL_SIZE, (mouseCurrent.y - landscapeLayer.y) / LandscapeConfig.CEIL_SIZE);
                    cell.x = Math.floor(cell.x);
                    cell.z = Math.floor(cell.z);
                    var building:BuildingModel = landscapeModel.getBuildingFromCell(cell.x, cell.z);
                    if (building)
                    {
                        building.explode();
                        trace("buildingX:" + building.x, "buildingZ:" + building.z);
                    }
                    trace(this, "clicked on cell x:" + cell.x + " z:" + cell.z)
                    trace(this, "BOOOM");
                }
                _isPanning = false;
                _allowExplode = true;
            }

        }
    }

    private function createBuildings():void
    {
        for each(var building:BuildingModel in landscapeModel.buildings)
        {
            var isoBuilding:BuildingController = new BuildingController(building, landscapeLayer);
            landscapeLayer.add2Scene(isoBuilding);
        }
    }

    public function showOnView(rootView:DisplayObjectContainer):DisplayObject
    {
        return rootView.addChild(landscapeLayer);
    }

    public function removeView():void
    {
        if (landscapeLayer.parent)
        {
            landscapeLayer.parent.removeChild(landscapeLayer);
        }
    }
}
}
