/**
 * Created by Crazy Horse on 05.02.2015.
 */
package com.dch.destroyit.landscape
{
import com.dch.destroyit.assets.AssetsService;
import com.dch.destroyit.assets.TileTypesEnum;
import com.dch.destroyit.config.LandscapeConfig;
import com.dch.destroyit.isoCore.IsoStarlingSprite;

import flash.utils.Dictionary;

import starling.display.Image;
import starling.textures.Texture;
import starling.textures.TextureAtlas;
import starling.utils.AssetManager;

public class BuildingView extends IsoStarlingSprite
{
    private var color:uint;
    private var borderColor:uint;
    private var borderThickness:Number;
    private var cleanBuildingImage:Image;
//    public static const CLEAN_TEXTURE_PREFIX:String = "cleanBuilding_";
//    public static const GROUND_TEXTURE_PREFIX:String = "ground";
    private var tileSize:Number;
    private var groundTypeName:String;
    public static const GROUND_QUAD_BATCHES:Dictionary = new Dictionary(true);
    public static const CLEAN_BUILDINGS_TEXTURES:Dictionary = new Dictionary(true);

    public function BuildingView(x:Number, y:Number, z:Number, width:Number, length:Number, height:Number, tileSize:Number, groundTypeName:String)
    {
        super(x, y, z, width, length, height);
        this.groundTypeName = groundTypeName;
        this.tileSize = tileSize;
        this.color = color;
        this.borderColor = borderColor;
        this.borderThickness = borderThickness;
        draw();
    }

    private function draw():void
    {
        var widthInTiles:int = isoBounds.size.width / tileSize;
        var lengthInTiles:int = isoBounds.size.length / tileSize;

        //get clean texture
        var cleanTextureName:String = TileTypesEnum.CLEAR.value + "_" + LandscapeConfig.BUILDING_INNER_COLOR;
        var cleanTexture:Texture = CLEAN_BUILDINGS_TEXTURES[cleanTextureName];
        if (!cleanTexture)
        {
            cleanTexture = AssetsService.sharedAssets.getTexture(cleanTextureName);
            CLEAN_BUILDINGS_TEXTURES[cleanTextureName]= cleanTexture;
        }
        cleanBuildingImage = new Image(cleanTexture);
        addChild(cleanBuildingImage);

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
