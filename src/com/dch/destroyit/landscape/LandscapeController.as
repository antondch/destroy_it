/**
 * Created by Crazy Horse on 06.02.2015.
 */
package com.dch.destroyit.landscape
{
import config.Config;

import flash.geom.Point;

import isoCore.IsoPoint;

import mvc.IViewController;

import objects.HomeView;

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

    public function LandscapeController(view:LandscapeView)
    {
        this.view = view;
        registerTouchEvents();
        createHomes(Config.HOMES_COUNT, Config.TILE_SIZE, Config.HOME_SIDE_MIN_SIZE, Config.HOME_SIDE_MAX_SIZE, Config.HOME_SIDE_SIZE_DIFFERENCE, Config.FREE_DISTANCE_IN_TILES);
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
                if(_allowExplode)
                {
                    trace(this, "BOOOM");
                }
                _isPanning = false;
                _allowExplode = true;
            }

        }
    }

    //todo: move it to prepare game class.
    private function createHomes(count:int, tileSize:Number, minFaceSize:Number, maxFaceSize:Number, maxSideDifference:int, freeDistanceInTiles:Number):void
    {
//        var row:int = 0;
        var currentHomePoint:IsoPoint = new IsoPoint();
        var homeLength:Number = 0.0;
        var homeWidth:Number = 0.0;
        var widthInTiles:int = 0;
        var lengthInTiles:int = 0;
        var rowLengthInTiles:int = 0;
        var freeDistance:Number = freeDistanceInTiles * tileSize;
        for (var i:int = 0; i < count; i++)
        {
            widthInTiles = Math.round(Math.random() * (maxFaceSize - minFaceSize) + minFaceSize);
            lengthInTiles = Math.round(Math.random() * (maxFaceSize - minFaceSize) + minFaceSize);
            while (Math.abs(widthInTiles - lengthInTiles) > maxSideDifference)
            {
                lengthInTiles = Math.round(Math.random() * (maxFaceSize - minFaceSize) + minFaceSize);
            }
            if (lengthInTiles > rowLengthInTiles)
            {
                rowLengthInTiles = lengthInTiles;
            }
            homeWidth = widthInTiles * tileSize;
            homeLength = lengthInTiles * tileSize;

            if (currentHomePoint.x + homeWidth > view.isoBounds.size.width)
            {
                currentHomePoint.x = 0;
                currentHomePoint.z += rowLengthInTiles * tileSize + freeDistance;
                rowLengthInTiles = 0;
            }
            var isoHome:HomeView = new HomeView(currentHomePoint.x, 0, currentHomePoint.z, homeWidth, homeLength, 0);
            currentHomePoint.x = isoHome.isoBounds.size.width + isoHome.isoBounds.origin.x + freeDistance;
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
