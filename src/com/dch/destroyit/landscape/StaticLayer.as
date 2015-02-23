/**
 * Created by Crazy Horse on 05.02.2015.
 */
package com.dch.destroyit.landscape
{
import com.dch.destroyit.isoCore.IsoStarlingScene;

import starling.display.Image;

import starling.display.QuadBatch;

public class StaticLayer extends IsoStarlingScene
{
    private var quadBatch:QuadBatch  = new QuadBatch();

    public function StaticLayer(isoX:Number, isoY:Number, isoZ:Number, isoWidth:Number, isoLength:Number):void
    {
        super(isoX, isoY, isoZ, isoWidth, isoLength);
        draw();
    }

    private function draw():void
    {
        addChild(quadBatch);
    }

    /**
     * add static images to quad batch. All textures must be placed in one atlas!!!
     * @param image
     */
    public function addImage(buildingX:int,buildingY:int,image:Image):void
    {
        image.x+=buildingX;
        image.y+=buildingY;
        quadBatch.addImage(image);
    }
}
}
