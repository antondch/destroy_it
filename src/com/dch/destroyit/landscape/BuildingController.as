/**
 * Created by Crazy Horse on 05.02.2015.
 */
package com.dch.destroyit.landscape
{
import com.dch.destroyit.assets.AssetsService;
import com.dch.destroyit.assets.Crater1x1NamesEnum;
import com.dch.destroyit.assets.Crater2x2NamesEnum;
import com.dch.destroyit.assets.Explode1x1NamesEnum;
import com.dch.destroyit.assets.Explode2x2NamesEnum;
import com.dch.destroyit.assets.Ground1x1NamesEnum;
import com.dch.destroyit.assets.LineTypes;
import com.dch.destroyit.assets.TileTypesEnum;
import com.dch.destroyit.config.CeilTypes;
import com.dch.destroyit.config.LandscapeConfig;
import com.dch.destroyit.isoCore.IsoStarlingImage;
import com.dch.destroyit.isoCore.IsoStarlingMovieClip;
import com.dch.destroyit.isoCore.IsoStarlingSprite;

import flash.events.TimerEvent;
import flash.utils.Dictionary;
import flash.utils.Timer;

import starling.core.Starling;
import starling.display.Image;
import starling.display.MovieClip;
import starling.events.Event;
import starling.textures.Texture;

public class BuildingController extends IsoStarlingSprite
{
    private var color:uint;
    private var borderColor:uint;
    private var borderThickness:Number;
    private var cellSize:Number;
    private var groundTypeName:String;
    private var model:BuildingModel;
    private var cratersWithExplodeKey:Dictionary = new Dictionary(true);
    private var explodes:Vector.<IsoStarlingMovieClip> = new Vector.<IsoStarlingMovieClip>();
    private var explodeTimer:Timer;
    private var staticLayer:StaticLayer;
    private var explodes1x1Layer:Explode1x1Layer;
    private var explodes2x2Layer:Explode2x2Layer;

    public function BuildingController(model:BuildingModel,staticLayer:StaticLayer, explodes1x1Layer:Explode1x1Layer, explodes2x2Layer:Explode2x2Layer)
    {
        this.model = model;
        this.cellSize = LandscapeConfig.CEIL_SIZE;
        super(model.x * cellSize, 0, model.z * cellSize, model.width * cellSize, model.length * cellSize, 0);
        this.groundTypeName = Ground1x1NamesEnum.GROUND_1X1_NAME.value;

        this.color = color;
        this.borderColor = borderColor;
        this.borderThickness = borderThickness;
        this.staticLayer = staticLayer;
        this.explodes1x1Layer = explodes1x1Layer;
        this.explodes2x2Layer = explodes2x2Layer;
        addExplodeHandler();
        draw();
    }

    private function addExplodeHandler():void
    {
        model.addEventListener(BuildingModel.EXPLODE, model_explodeHandler);
    }

    private function draw():void
    {
        var widthInTiles:int = model.width;
        var lengthInTiles:int = model.length;
        var greenTileImageName:String = TileTypesEnum.CLEAR.value + "_" + LandscapeConfig.BUILDING_INNER_COLOR;
        for (var row:int = 0; row < widthInTiles; row++)
        {
            for (var column:int = 0; column < lengthInTiles; column++)
            {

                if (column == 0)
                {
                    var horizontalLineImage:IsoStarlingImage = new IsoStarlingImage(AssetsService.sharedAssets.getTexture(LineTypes.HORIZONTAL), row * cellSize, 0, 0, cellSize, 0);
                    staticLayer.addImage(x,y,horizontalLineImage);
                }

                var greenTileImage:IsoStarlingImage = new IsoStarlingImage(AssetsService.sharedAssets.getTexture(greenTileImageName), row * cellSize + LandscapeConfig.BUILDING_BORDER_THICKNESS / 2, 0, column * cellSize + LandscapeConfig.BUILDING_BORDER_THICKNESS / 2, cellSize, cellSize);
                staticLayer.addImage(x,y,greenTileImage);
                if (column == lengthInTiles - 1)
                {
                    var horizontalLineImage:IsoStarlingImage = new IsoStarlingImage(AssetsService.sharedAssets.getTexture(LineTypes.HORIZONTAL), row * cellSize, 0, cellSize * lengthInTiles, cellSize, 0);
                    staticLayer.addImage(x,y,horizontalLineImage);
                }
                if (row == 0)
                {
                    var verticalLineImage:IsoStarlingImage = new IsoStarlingImage(AssetsService.sharedAssets.getTexture(LineTypes.VERTICAL), 0, 0, column * cellSize, 0, cellSize);
                    staticLayer.addImage(x,y,verticalLineImage);
                }
                if (row == widthInTiles - 1)
                {
                    var verticalLineImage:IsoStarlingImage = new IsoStarlingImage(AssetsService.sharedAssets.getTexture(LineTypes.VERTICAL), widthInTiles * cellSize, 0, column * cellSize, 0, cellSize);
                    staticLayer.addImage(x,y,verticalLineImage);
                }
                if (model.matrix[row][column] == CeilTypes.EXPLODE_1X1)
                {
                    var craterImage:IsoStarlingImage = new IsoStarlingImage(AssetsService.sharedAssets.getTexture(Crater1x1NamesEnum.CRATER_1X1_NAME.value), row * cellSize - 14, 0, column * cellSize, cellSize, cellSize);

                    var textures:Vector.<Texture> = AssetsService.sharedAssets.getTextures(Explode1x1NamesEnum.DUST_1X1_NAME.value);
                    var explode1x1MC:IsoStarlingMovieClip = new IsoStarlingMovieClip(textures, 31, row * cellSize, 0, column * cellSize, cellSize, cellSize);
                    explode1x1MC.pivotX = explode1x1MC.width / 2 - 15;
                    explode1x1MC.pivotY = explode1x1MC.height / 2 + 2;
                    explode1x1MC.stop();
                    explode1x1MC.visible = false;
                    explodes1x1Layer.addExplode(x, y, explode1x1MC);
                    explodes.push(explode1x1MC);
                    cratersWithExplodeKey[explode1x1MC] = craterImage;
                }

                if (model.matrix[row][column] == CeilTypes.EXPLODE_2X2)
                {

                    var craterImage:IsoStarlingImage = new IsoStarlingImage(AssetsService.sharedAssets.getTexture(Crater2x2NamesEnum.CRATER_2X2_NAME.value), row * cellSize - cellSize / 2, 0, column * cellSize, 2 * cellSize, 2 * cellSize);

                    var textures:Vector.<Texture> = AssetsService.sharedAssets.getTextures(Explode2x2NamesEnum.DUST_2X2_NAME.value);
                    var explode2x2MC:IsoStarlingMovieClip = new IsoStarlingMovieClip(textures, 31, row * cellSize, 0, column * cellSize, 2 * cellSize, 2 * cellSize);
                    explode2x2MC.pivotX = explode2x2MC.width / 2 - cellSize / 4;
                    explode2x2MC.pivotY = explode2x2MC.height / 2 - cellSize / 2;
                    explode2x2MC.stop();
                    explode2x2MC.visible = false;
                    explodes2x2Layer.addExplode(x, y, explode2x2MC);

                    explodes.push(explode2x2MC);
                    cratersWithExplodeKey[explode2x2MC] = craterImage;
                }
            }
        }
        explodes.sort(shuffleExplodesOrder);
    }


    private function shuffleExplodesOrder(a:*, b:*):int
    {
        return ( Math.random() > .5 ) ? 1 : -1;
    }

    private function model_explodeHandler(event:Event):void
    {
        explodeBuilding();
    }


    private function explodeBuilding(event:TimerEvent = null):void
    {
        if (!explodeTimer)
        {
            explodeTimer = new Timer(LandscapeConfig.EXPLODES_INTERVAL_IN_MS);
            explodeTimer.addEventListener(TimerEvent.TIMER, explodeBuilding);
            explodeTimer.start();
        }
        if (explodes.length)
        {
            var explode:MovieClip = explodes.shift();
            Starling.juggler.add(explode);
            explode.play();
            explode.visible = true;
            staticLayer.addImage(x,y,Image(cratersWithExplodeKey[explode]));
            explode.addEventListener(Event.COMPLETE, removeExplode);
        } else
        {
            explodeTimer.stop();
            explodeTimer.removeEventListener(TimerEvent.TIMER, explodeBuilding);
            explodeTimer = null;
        }
    }

    private function removeExplode(event:Event):void
    {
        var explode:IsoStarlingMovieClip = IsoStarlingMovieClip(event.target);
        explode.parent.removeChild(explode);
        explode.stop();
        Starling.juggler.remove(explode);
        delete cratersWithExplodeKey[explode];
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
