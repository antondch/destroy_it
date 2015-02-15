/**
 * Created by Crazy Horse on 05.02.2015.
 */
package com.dch.destroyit.landscape
{
import com.dch.destroyit.assets.AssetsService;
import com.dch.destroyit.isoCore.IsoStarlingSprite;
import com.dch.destroyit.isoCore.IsoUtils;

import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Dictionary;

import starling.display.Image;
import starling.display.QuadBatch;
import starling.textures.Texture;
import starling.textures.TextureAtlas;
import starling.utils.AssetManager;

public class BuildingView extends IsoStarlingSprite
{
    private var color:uint;
    private var borderColor:uint;
    private var borderThickness:Number;
    private var cleanBuildingImage:Image;
    private var assetsManager:AssetManager;
    public static const CLEAN_TEXTURE_PREFIX:String = "cleanBuilding_";
    public static const GROUND_TEXTURE_PREFIX:String = "ground";
    private var tileSize:Number;
    private var groundTypeName:String;
    public static const QUAD_BATCHES:Dictionary = new Dictionary(true);
    private var atlasName:String;

    public function BuildingView(x:Number, y:Number, z:Number, width:Number, length:Number, height:Number, tileSize:Number, color:uint, borderThickness:Number, borderColor:uint, groundTypeName:String, assetManager:AssetManager,atlasName:String)
    {
        super(x, y, z, width, length, height);
        this.atlasName = atlasName;
        this.groundTypeName = groundTypeName;
        this.tileSize = tileSize;
        this.assetsManager = assetManager;
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
        var cleanTextureName:String = CLEAN_TEXTURE_PREFIX + String(widthInTiles) + "x" + String(lengthInTiles);
        var cleanTexture:Texture = assetsManager.getTexture(cleanTextureName);
        if (!cleanTexture)
        {
            cleanTexture = drawTile(isoBounds.size.width, isoBounds.size.length, color, borderThickness, borderColor);
            assetsManager.addTexture(cleanTextureName, cleanTexture);
        }
        cleanBuildingImage = new Image(cleanTexture);
//        addChild(cleanBuildingImage);

        //get ground texture
        var groundTextureName:String = GROUND_TEXTURE_PREFIX + String(widthInTiles) + "x" + String(lengthInTiles);
        var atlas:TextureAtlas = assetsManager.getTextureAtlas(atlasName);
        var groundTexture:Texture = atlas.getTexture(groundTextureName);

        if (!groundTexture)
        {
            var ground1x1:Texture = assetsManager.getTexture(groundTypeName+AssetsService.TEXTURES_POSTFIX);
            var ground1x1PivotX:Number = IsoUtils.isoToScreen(ground1x1.width, 0, 0).x;
            var groundQuadBatch:QuadBatch = new QuadBatch();
            for (var column:int = 0; column < lengthInTiles; column++)
            {
                for (var row:int = 0; row < lengthInTiles; row++)
                {
                    var groundTile:Image = new Image(ground1x1);
                    groundTile.pivotX = ground1x1PivotX;
                    var groundTilePos:Point = IsoUtils.isoToScreen(row*tileSize,0,column*tileSize);
                    groundTile.x= groundTilePos.x;
                    groundTile.y= groundTilePos.y;
                    addChild(groundTile);
                }
            }
//            groundQuadBatch.reset();
//            addChild(groundQuadBatch);
        }
    }

    public static function drawTile(width:Number, length:Number, color:uint, borderThickness:Number, borderColor:uint):Texture
    {
        var rect:Sprite = new Sprite();
        //In box ABCDEFGH:

        var pointA:Point = IsoUtils.isoToScreen(0, 0, 0);
        var pointB:Point = IsoUtils.isoToScreen(width, 0, 0);
        var pointC:Point = IsoUtils.isoToScreen(width, 0, length);
        var pointD:Point = IsoUtils.isoToScreen(0, 0, length);
        //****************
        rect.graphics.clear();
        rect.graphics.beginFill(color);
        rect.graphics.lineStyle(borderThickness, borderColor);
        rect.graphics.moveTo(pointA.x, pointA.y);
        rect.graphics.lineTo(pointB.x, pointB.y);
        rect.graphics.lineTo(pointC.x, pointC.y);
        rect.graphics.lineTo(pointD.x, pointD.y);
        rect.graphics.lineTo(pointA.x, pointA.y);


        var bounds:Rectangle = rect.getBounds(rect);
        var matrix:Matrix = new Matrix();

        matrix.translate(-bounds.x, -bounds.y);

        var bitmapData:BitmapData = new BitmapData(rect.width, rect.height, true, 0x000000);
        bitmapData.draw(rect, matrix);

        var texture:Texture = Texture.fromBitmapData(bitmapData);
        return texture;
    }
}
}
