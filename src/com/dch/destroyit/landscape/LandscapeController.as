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

import starling.core.Starling;
import starling.display.DisplayObject;
import starling.display.DisplayObjectContainer;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class LandscapeController implements IViewController
{
    private var staticLayer:StaticLayer;
    private var _isPanning:Boolean = false;
    private var _allowExplode:Boolean = true;
    private var mousePanBeginPoint:Point = new Point(0, 0);
    private var landscapeModel:LandscapeModel;
    private var explode1x1Layer:Explode1x1Layer;
    private var explode2x2Layer:Explode2x2Layer;

    public function LandscapeController(view:StaticLayer)
    {
        this.staticLayer = view;
        createExplodeLayers();
        registerTouchEvents();
        createLandscapeModel(LandscapeConfig.BUILDINGS_COUNT, LandscapeConfig.LANDSCAPE_WIDTH_IN_CEIL, LandscapeConfig.LANDSCAPE_LENGTH_IN_CEIL, LandscapeConfig.BUILDING_SIDE_MIN_SIZE_IN_CEIL,
                LandscapeConfig.BUILDING_SIDE_MAX_SIZE_IN_CEIL, LandscapeConfig.BUILDING_SIDE_SIZE_DIFFERENCE_IN_CEIL, LandscapeConfig.FREE_DISTANCE_IN_CEIL);
        createBuildings();
    }

    private function createExplodeLayers():void
    {
        explode1x1Layer = new Explode1x1Layer(staticLayer.isoBounds.origin.x, staticLayer.isoBounds.origin.y, staticLayer.isoBounds.origin.z, staticLayer.isoBounds.size.width, staticLayer.isoBounds.size.length);
        explode1x1Layer.x = staticLayer.x;
        explode1x1Layer.y = staticLayer.y;

        explode2x2Layer = new Explode2x2Layer(staticLayer.isoBounds.origin.x, staticLayer.isoBounds.origin.y, staticLayer.isoBounds.origin.z, staticLayer.isoBounds.size.width, staticLayer.isoBounds.size.length);
        explode2x2Layer.x = staticLayer.x;
        explode2x2Layer.y = staticLayer.y;

        //FIXME: remove direct access to stage
        Starling.current.root.stage.addChild(explode1x1Layer);
        Starling.current.root.stage.addChild(explode2x2Layer);
    }

    private function createLandscapeModel(buildingsCount:int, landscapeWidth:Number, landscapeLength:Number, minFaceSize:Number, maxFaceSize:Number, maxSideDifference:int, freeDistance:Number):void
    {
        landscapeModel = new LandscapeModel();
        landscapeModel.generateBuildings(buildingsCount, landscapeWidth, landscapeLength, minFaceSize, maxFaceSize, maxSideDifference, freeDistance, LandscapeConfig.BUILDINGS_COUNT);
    }

    private function registerTouchEvents():void
    {
        staticLayer.addEventListener(TouchEvent.TOUCH, view_touchHandler);
    }

    private function view_touchHandler(event:TouchEvent):void
    {
        var touch:Touch = event.touches[0];
        switch (touch.phase)
        {
            case TouchPhase.BEGAN:
            {
                _isPanning = true;
                mousePanBeginPoint = touch.getLocation(staticLayer.stage);
                break;
            }
            case TouchPhase.MOVED:
            {
                if (_isPanning)
                {
                    var mouseCurrent:Point = touch.getLocation(staticLayer.stage);
                    staticLayer.x -= mousePanBeginPoint.x - mouseCurrent.x;
                    staticLayer.y -= mousePanBeginPoint.y - mouseCurrent.y;
                    explode1x1Layer.x = staticLayer.x;
                    explode1x1Layer.y = staticLayer.y;
                    explode2x2Layer.x = staticLayer.x;
                    explode2x2Layer.y = staticLayer.y;
                    mousePanBeginPoint = mouseCurrent;
                    _allowExplode = false;
                }
                break;
            }
            case TouchPhase.ENDED:
            {
                if (_allowExplode)
                {
                    var mouseCurrent:Point = touch.getLocation(staticLayer.stage);
                    var cell:IsoPoint = IsoUtils.screenToIso((mouseCurrent.x - staticLayer.x) / LandscapeConfig.CEIL_SIZE, (mouseCurrent.y - staticLayer.y) / LandscapeConfig.CEIL_SIZE);
                    cell.x = Math.floor(cell.x);
                    cell.z = Math.floor(cell.z);
                    var building:BuildingModel = landscapeModel.getBuildingFromCell(cell.x, cell.z);
                    if (building)
                    {
                        building.explode();
                        trace("buildingX:"+building.x,"buildingZ:"+building.z);
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
            var isoBuilding:BuildingController = new BuildingController(building, staticLayer, explode1x1Layer, explode2x2Layer);
            staticLayer.add2Scene(isoBuilding);
        }
    }

    public function showOnView(rootView:DisplayObjectContainer):DisplayObject
    {
        return rootView.addChild(staticLayer);
    }

    public function removeView():void
    {
        if (staticLayer.parent)
        {
            staticLayer.parent.removeChild(staticLayer);
        }
    }
}
}
