/**
 * Created by Crazy Horse on 05.02.2015.
 */
package com.dch.destroyit.landscape
{
import com.dch.destroyit.assets.AssetsService;
import com.dch.destroyit.assets.TileTypesEnum;
import com.dch.destroyit.assets.TilesColorEnum;
import com.dch.destroyit.config.LandscapeConfig;
import com.dch.destroyit.isoCore.IsoStarlingImage;
import com.dch.destroyit.isoCore.IsoStarlingScene;

import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.QuadBatch;
import starling.display.Sprite;

public class LandscapeView extends IsoStarlingScene
{
    private var quadBatch:QuadBatch  = new QuadBatch();
    private var groundLayer:Sprite = new Sprite();
    private var explodeLayer:Sprite = new Sprite();

    public function LandscapeView(isoX:Number, isoY:Number, isoZ:Number, isoWidth:Number, isoLength:Number,backgroundColor:TilesColorEnum):void
    {
        super(isoX, isoY, isoZ, isoWidth, isoLength);
        draw(backgroundColor);
    }

    private function draw(backgroundColor:TilesColorEnum):void
    {
        var textureName:String = TileTypesEnum.CLEAR.value + "_" + backgroundColor.value;
        for (var row:int = 0; row < isoBounds.size.width; row++)
        {
            for (var column:int = 0; column < isoBounds.size.length; column++)
            {
                var greenTileImage:IsoStarlingImage = new IsoStarlingImage(AssetsService.sharedAssets.getTexture(textureName), row * LandscapeConfig.CEIL_SIZE + LandscapeConfig.BUILDING_BORDER_THICKNESS / 2, 0, column * LandscapeConfig.CEIL_SIZE + LandscapeConfig.BUILDING_BORDER_THICKNESS / 2, LandscapeConfig.CEIL_SIZE, LandscapeConfig.CEIL_SIZE);
                addImage2StaticLayer(0,0,greenTileImage);
            }
        }
        addChild(quadBatch);
        addChild(groundLayer);
        addChild(explodeLayer);
    }

    /**
     * add static images to quad batch. All textures must be placed in one atlas!!!
     * @param image
     */
    public function addImage2StaticLayer(buildingX:int,buildingY:int,image:Image):void
    {
        image.x+=buildingX;
        image.y+=buildingY;
        quadBatch.addImage(image);
    }

    public function add2GroundLayer(buildingX:int,buildingY:int,object:DisplayObject):void
    {
        object.x+=buildingX;
        object.y+=buildingY;
        groundLayer.addChild(object);
    }
    public function add2ExplodeLayer(buildingX:int,buildingY:int,object:DisplayObject):void
    {
        object.x+=buildingX;
        object.y+=buildingY;
        explodeLayer.addChild(object);
    }
}
}
