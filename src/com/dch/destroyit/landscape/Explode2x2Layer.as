/**
 * Created by Crazy Horse on 05.02.2015.
 */
package com.dch.destroyit.landscape
{
import com.dch.destroyit.isoCore.IsoStarlingScene;

import starling.display.DisplayObject;

public class Explode2x2Layer extends IsoStarlingScene
{
    public function Explode2x2Layer(isoX:Number, isoY:Number, isoZ:Number, isoWidth:Number, isoLength:Number):void
    {
        super(isoX, isoY, isoZ, isoWidth, isoLength);
    }
    public function addExplode(buildingX:int, buildingY:int, explode:DisplayObject):void
    {
        explode.x+=buildingX;
        explode.y+=buildingY;
        addChild(explode);
    }
}
}
