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
import starling.display.QuadBatch;
import starling.display.Sprite;

public class LandscapeView extends IsoStarlingScene
{
    private var bgQuadBatch:QuadBatch = new QuadBatch();
    private var greenLayer:Sprite = new Sprite();
    private var infoLayer:Sprite = new Sprite();
    private var groundLayer:Sprite = new Sprite();
    private var explodeLayer:Sprite = new Sprite();

    public function LandscapeView(isoX:Number, isoY:Number, isoZ:Number, isoWidth:Number, isoLength:Number, backgroundColor:TilesColorEnum):void
    {
        super(isoX, isoY, isoZ, isoWidth, isoLength);
        draw(backgroundColor);
    }

    private function draw(backgroundColor:TilesColorEnum):void
    {
        var textureName:String = TileTypesEnum.CLEAR.value + "_" + backgroundColor.value;
        var greenTileImage:IsoStarlingImage = new IsoStarlingImage(AssetsService.sharedAssets.getTexture(textureName), 0, 0, 0, LandscapeConfig.CEIL_SIZE, LandscapeConfig.CEIL_SIZE);
        for (var row:int = 0; row < isoBounds.size.width; row++)
        {
            for (var column:int = 0; column < isoBounds.size.length; column++)
            {
                greenTileImage.move(row * LandscapeConfig.CEIL_SIZE + LandscapeConfig.BUILDING_BORDER_THICKNESS / 2, 0, column * LandscapeConfig.CEIL_SIZE + LandscapeConfig.BUILDING_BORDER_THICKNESS / 2);
                bgQuadBatch.addImage(greenTileImage);
            }
        }
        addChild(bgQuadBatch);
        addChild(greenLayer);
//        addChild(infoLayer);
//        infoLayer.touchable = false;
//        addChild(groundLayer);
//        groundLayer.touchable = false;
//        addChild(explodeLayer);
//        explodeLayer.touchable = false;
    }


    public function add2FirstLayer(buildingX:int, buildingY:int, image:DisplayObject):void
    {
        image.x += buildingX;
        image.y += buildingY;
        greenLayer.unflatten();
        greenLayer.addChild(image);
        greenLayer.flatten(true);
    }

    public function add2infoLayer(buildingX:int, buildingY:int, image:DisplayObject):void
    {
        image.x += buildingX;
        image.y += buildingY;

        infoLayer.addChild(image);
    }

    public function add2GroundLayer(buildingX:int, buildingY:int, object:DisplayObject):void
    {
        object.x += buildingX;
        object.y += buildingY;
        groundLayer.unflatten();
        groundLayer.addChild(object);
        groundLayer.flatten(true);
    }

    public function add2ExplodeLayer(buildingX:int, buildingY:int, object:DisplayObject):void
    {
        object.x += buildingX;
        object.y += buildingY;
        explodeLayer.addChild(object);
    }
}
}
