/**
 * Created by Crazy Horse on 06.02.2015.
 */
package landscape
{
import config.Config;

import isoCore.IsoPoint;

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
        createHomes(Config.HOMES_COUNT, Config.TILE_SIZE, Config.HOME_MIN_FACE_SIZE, Config.HOME_MAX_FACE_SIZE, Config.FREE_DISTANCE_IN_TILES);
    }

    //todo: move it to prepare game class.
    private function createHomes(count:int, tileSize:Number, minFaceSize:Number, maxFaceSize:Number, freeDistanceInTiles:Number):void
    {
        var row:int = 0;
        var currentHomePoint:IsoPoint = new IsoPoint();
        var homeLength:Number = 0.0;
        var homeWidth:Number = 0.0;
        var widthInTiles:int = 0;
        var lengthInTiles:int = 0;
        var rowLengthInTiles:int = 0;
        var freeDistance:Number = freeDistanceInTiles * tileSize;

        for (var i:int = 0; i < 5; i++)
        {
            widthInTiles = Math.round(Math.random() * (maxFaceSize - minFaceSize) + minFaceSize);
            lengthInTiles = Math.round(Math.random() * (maxFaceSize - minFaceSize) + minFaceSize);
            if (lengthInTiles > rowLengthInTiles)
            {
                rowLengthInTiles = lengthInTiles;
            }
            homeWidth = widthInTiles * tileSize;
            homeLength = lengthInTiles * tileSize;

            if(currentHomePoint.x+homeWidth> view.isoBounds.size.width)
            {
                row++;
                currentHomePoint.z = row * (freeDistance + rowLengthInTiles) * tileSize;
            }
            var isoHome:HomeView = new HomeView(currentHomePoint.x, 0, currentHomePoint.z, homeWidth, homeLength, 0);
            currentHomePoint.x = isoHome.width + isoHome.x + freeDistance;
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
