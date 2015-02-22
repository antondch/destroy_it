/**
 * Created by Crazy Horse on 05.02.2015.
 */
package com.dch.destroyit.landscape
{
import com.dch.destroyit.assets.AssetsService;
import com.dch.destroyit.assets.LineTypes;
import com.dch.destroyit.assets.TileTypesEnum;
import com.dch.destroyit.config.LandscapeConfig;
import com.dch.destroyit.isoCore.IsoStarlingImage;
import com.dch.destroyit.isoCore.IsoStarlingImage;
import com.dch.destroyit.isoCore.IsoStarlingSprite;

import flash.utils.Dictionary;

import starling.display.Image;

import starling.display.Image;

import starling.display.Image;
import starling.display.QuadBatch;
import starling.textures.Texture;

public class BuildingView extends IsoStarlingSprite
{
    private var color:uint;
    private var borderColor:uint;
    private var borderThickness:Number;
    private var cleanBuildingImage:Image;
//    public static const CLEAN_TEXTURE_PREFIX:String = "cleanBuilding_";
//    public static const GROUND_TEXTURE_PREFIX:String = "ground";
    private var cellSize:Number;
    private var groundTypeName:String;
    private var model:BuildingModel;
    public static const GROUND_QUAD_BATCHES:Dictionary = new Dictionary(true);
    public static const GREEN_QUAD_BATCHES:Dictionary = new Dictionary(true);
    //images ONLY FOR REUSE IN QUAD BATCHES!!! --->
    public static const IMAGES:Dictionary = new Dictionary(true);

    public function BuildingView(model:BuildingModel, tileSize:Number, groundTypeName:String)
    {
        this.model = model;
        super(model.x*tileSize, 0,model.z*tileSize, model.width*tileSize, model.length*tileSize, 0);
        this.groundTypeName = groundTypeName;
        this.cellSize = tileSize;
        this.color = color;
        this.borderColor = borderColor;
        this.borderThickness = borderThickness;
        draw();
    }

    private function draw():void
    {
        var widthInTiles:int = isoBounds.size.width / cellSize;
        var lengthInTiles:int = isoBounds.size.length / cellSize;
        var buildingSizeKey:String = widthInTiles + "x" + lengthInTiles;

        //get green building quadBatch
        var greenQuadBatch:QuadBatch = GREEN_QUAD_BATCHES[buildingSizeKey];
        if(!greenQuadBatch)
        {
            greenQuadBatch = new QuadBatch();
            GREEN_QUAD_BATCHES[buildingSizeKey] = greenQuadBatch;


            //get images for batch
            var greenTileImageName:String = TileTypesEnum.CLEAR.value + "_" + LandscapeConfig.BUILDING_INNER_COLOR;
            var greenTileImage:IsoStarlingImage = IMAGES[greenTileImageName];
            if (!greenTileImage)
            {
                greenTileImage = new IsoStarlingImage(AssetsService.sharedAssets.getTexture(greenTileImageName),0,0,0,cellSize,cellSize);
                IMAGES[greenTileImageName] = greenTileImage;
            }
            var verticalLineImage:IsoStarlingImage = IMAGES[LineTypes.VERTICAL];
            if (!verticalLineImage)
            {
                verticalLineImage = new IsoStarlingImage(AssetsService.sharedAssets.getTexture(LineTypes.VERTICAL),0,0,0,0,cellSize);
                IMAGES[LineTypes.VERTICAL] = verticalLineImage;
            }
            var horizontalLineImage:IsoStarlingImage = IMAGES[LineTypes.HORIZONTAL];
            if (!horizontalLineImage)
            {
                horizontalLineImage = new IsoStarlingImage(AssetsService.sharedAssets.getTexture(LineTypes.HORIZONTAL),0,0,0,cellSize,0);
                IMAGES[LineTypes.HORIZONTAL] = horizontalLineImage;
            }
            for (var row:int = 0; row < model.width; row++)
            {
                for (var column:int = 0; column < model.length; column++)
                {
                    greenQuadBatch.addImage(greenTileImage);
                }
            }
        }
        var currentGreenBatch:QuadBatch = new QuadBatch();
        currentGreenBatch.addQuadBatch(greenQuadBatch);
        addChild(currentGreenBatch);

        //get ground texture
//        var groundTextureName:String = GROUND_TEXTURE_PREFIX + String(widthInTiles) + "x" + String(lengthInTiles);
//        var atlas:TextureAtlas = assetsManager.getTextureAtlas(atlasName);
//        var groundTexture:Texture = atlas.getTexture(groundTextureName);

//        if (!groundTexture)
//        {
//            var ground1x1:Texture = assetsManager.getTexture(groundTypeName+AssetsService.TEXTURES_POSTFIX);
//            var groundQuadBatch:QuadBatch = new QuadBatch();
//            var cell1x1CenterPoint:Point = IsoUtils.isoToScreen(tileSize/2,0,tileSize/2);
//            var buildingCenterPoint:Point = IsoUtils.isoToScreen(isoBounds.size.width/2,0,isoBounds.size.length/2);
//            var groundTile:Image = new Image(ground1x1);
//            groundTile.pivotX = groundTile.width/2;
//            groundTile.pivotY = groundTile.height/2;
//            for (var column:int = 0; column < lengthInTiles; column++)
//            {
//                for (var row:int = 0; row < widthInTiles; row++)
//                {
//                    var groundTilePos:Point = IsoUtils.isoToScreen(row*tileSize,0,column*tileSize);
//                    groundTile.x= groundTilePos.x+cell1x1CenterPoint.x+pivotX;
//                    groundTile.y= groundTilePos.y+cell1x1CenterPoint.y+pivotY;
//                    groundQuadBatch.addImage(groundTile);
//                    addChild(groundTile);
//                }
//            }
//            groundQuadBatch.reset();
//            groundQuadBatch.pivotX = groundQuadBatch.width/2;
//            groundQuadBatch.pivotY = groundQuadBatch.height/2;
//            groundQuadBatch.x = width/2+pivotX;
//            groundQuadBatch.y = height/2+pivotY;
//            addChild(groundQuadBatch);
//        }
    }


}
}
