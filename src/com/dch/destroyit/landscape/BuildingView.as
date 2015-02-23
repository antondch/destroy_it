/**
 * Created by Crazy Horse on 05.02.2015.
 */
package com.dch.destroyit.landscape
{
import com.dch.destroyit.assets.AssetsService;
import com.dch.destroyit.assets.Crater2x2NamesEnum;
import com.dch.destroyit.assets.Explode2x2NamesEnum;
import com.dch.destroyit.assets.LineTypes;
import com.dch.destroyit.assets.TileTypesEnum;
import com.dch.destroyit.config.CeilTypes;
import com.dch.destroyit.config.LandscapeConfig;
import com.dch.destroyit.isoCore.IsoStarlingImage;
import com.dch.destroyit.isoCore.IsoStarlingMovieClip;
import com.dch.destroyit.isoCore.IsoStarlingSprite;
import com.dch.destroyit.isoCore.IsoUtils;

import flash.utils.Dictionary;

import starling.core.Starling;
import starling.display.Image;
import starling.display.Sprite;
import starling.textures.Texture;

public class BuildingView extends IsoStarlingSprite
{
    private var color:uint;
    private var borderColor:uint;
    private var borderThickness:Number;
    private var cellSize:Number;
    private var groundTypeName:String;
    private var model:BuildingModel;
    private var greenContainer:Sprite;
    private var explodes:Dictionary = new Dictionary(true);

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
        var widthInTiles:int = model.width;
        var lengthInTiles:int = model.length;
        greenContainer = new Sprite();
        addChild(greenContainer);
            var greenTileImageName:String = TileTypesEnum.CLEAR.value + "_" + LandscapeConfig.BUILDING_INNER_COLOR;
            for (var row:int = 0; row < widthInTiles; row++)
            {
                for (var column:int = 0; column < lengthInTiles; column++)
                {
                    if(column==0)
                    {
                        var horizontalLineImage:IsoStarlingImage = new IsoStarlingImage(AssetsService.sharedAssets.getTexture(LineTypes.HORIZONTAL),row*cellSize,0,0,cellSize,0);
                        greenContainer.addChild(horizontalLineImage);
                    }

                    var greenTileImage:IsoStarlingImage = new IsoStarlingImage(AssetsService.sharedAssets.getTexture(greenTileImageName),row*cellSize+LandscapeConfig.BUILDING_BORDER_THICKNESS/2,0,column*cellSize+LandscapeConfig.BUILDING_BORDER_THICKNESS/2,cellSize,cellSize);
                    greenContainer.addChild(greenTileImage);
                    if(column==lengthInTiles-1)
                    {
                        var horizontalLineImage:IsoStarlingImage = new IsoStarlingImage(AssetsService.sharedAssets.getTexture(LineTypes.HORIZONTAL),row*cellSize,0,cellSize*lengthInTiles,cellSize,0);
                        greenContainer.addChild(horizontalLineImage);
                    }
                    if(row==0)
                    {
                        var verticalLineImage:IsoStarlingImage = new IsoStarlingImage(AssetsService.sharedAssets.getTexture(LineTypes.VERTICAL),0,0,column*cellSize,0,cellSize);
                        greenContainer.addChild(verticalLineImage);
                    }
                    if(row==widthInTiles-1)
                    {
                        var verticalLineImage:IsoStarlingImage = new IsoStarlingImage(AssetsService.sharedAssets.getTexture(LineTypes.VERTICAL),widthInTiles*cellSize,0,column*cellSize,0,cellSize);
                        greenContainer.addChild(verticalLineImage);
                    }
                    if(model.matrix[row][column]==CeilTypes.EXPLODE_2X2)
                    {

                        trace(this,"x:"+row,"y:"+column);
                        var textures:Vector.<Texture> = AssetsService.sharedAssets.getTextures(Explode2x2NamesEnum.DUST_2X2_NAME.value);
                        var explode2x2MC:IsoStarlingMovieClip = new IsoStarlingMovieClip(textures,31,row*cellSize,0,column*cellSize,2*cellSize,2*cellSize);
                        explode2x2MC.pivotX=explode2x2MC.width/2-cellSize/4;
                        explode2x2MC.pivotY=explode2x2MC.height/2-cellSize/2;
//                        addChild(explode2x2MC);
//                        explode2x2MC.play();
                        explode2x2MC.stop();
//                        Starling.juggler.add(explode2x2MC);
                        var garbageImage:IsoStarlingImage = new IsoStarlingImage(AssetsService.sharedAssets.getTexture(Crater2x2NamesEnum.CRATER_2X2_NAME.value),row*cellSize-cellSize/2,0,column*cellSize,2*cellSize,2*cellSize);
//                        garbageImage.pivotX=0;
                        garbageImage.pivotY=0;
                        addChild(garbageImage);
                    }

                }
            }
//        this.flatten(true);
        }



//        var currentGreenBatch:QuadBatch = greenQuadBatch.clone();
//        currentGreenBatch.addQuadBatch(greenQuadBatch);
//        addChild(currentGreenBatch);

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
