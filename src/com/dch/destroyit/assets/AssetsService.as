/**
 * Created by Crazy Horse on 14.02.2015.
 */
package com.dch.destroyit.assets
{
import com.dch.destroyit.config.AssetsConfig;
import com.dch.destroyit.config.LandscapeConfig;
import com.dch.destroyit.enums.Enumeration;
import com.dch.destroyit.isoCore.IsoUtils;
import com.emibap.textureAtlas.DynamicAtlas;

import flash.display.Loader;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.geom.Point;
import flash.net.URLRequest;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.utils.Dictionary;

import starling.textures.TextureAtlas;
import starling.utils.AssetManager;

/**
 * Singleton service class load assets and prepare texture atlases, and grant access to assetsManager.
 * For load assets use loadAssets().
 * For add texture to atlas use addTexture().
 * @see loadAssets(rootPath:String,swfPath:String,swfName:String,swfExtension:String,onComplete:Function = null):void.
 * @see starling.utils.AssetManager.
 * @see get sharedAssets():AssetsService.
 */
public class AssetsService extends EventDispatcher
{
    private var loader:Loader = new Loader();
    public static const TEXTURES_POSTFIX:String = "_00000";
    private var onComplete:Function;
    private var _isComplete:Boolean = false;
    private static var _sharedAssets:AssetsService;
    private var _assetsManager:AssetManager = new AssetManager();
    private var swfName:String;


    public function AssetsService()
    {
        if (_sharedAssets)
        {
            throw new Error("This is a singleton! Use AssetsService.sharedAssets");
        }
        _sharedAssets = this;
    }

    public static function get sharedAssets():AssetsService
    {
        if (!_sharedAssets)
        {
            _sharedAssets = new AssetsService();
        }
        return _sharedAssets;
    }


    public function loadAssets(rootPath:String, swfPath:String, swfName:String, swfExtension:String, onComplete:Function = null):void
    {
        this.swfName = swfName;
        this.onComplete = onComplete;
        var context:LoaderContext = new LoaderContext();
        context.applicationDomain = ApplicationDomain.currentDomain;
        loader.load(new URLRequest(rootPath + swfPath + swfName + swfExtension), context);
        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, generateAtlas);
    }

    private function drawCleanHomeTile(width:Number, length:Number, color:uint, borderThickness:Number, borderColor:uint, tilePosition:TilePositionsEnum):Sprite
    {
        var rect:Sprite = new Sprite();
        //In box ABCDEFGH:
        var pointA:Point = IsoUtils.isoToScreen(0, 0, 0);
        var pointB:Point = IsoUtils.isoToScreen(width, 0, 0);
        var pointC:Point = IsoUtils.isoToScreen(width, 0, length);
        var pointD:Point = IsoUtils.isoToScreen(0, 0, length);
        //****************

        switch (tilePosition)
        {
            case TilePositionsEnum.INNER:
            {
                rect.graphics.clear();
                rect.graphics.beginFill(color);
                rect.graphics.lineStyle(0);
                rect.graphics.moveTo(pointA.x, pointA.y);
                rect.graphics.lineTo(pointB.x, pointB.y);
                rect.graphics.lineTo(pointC.x, pointC.y);
                rect.graphics.lineTo(pointD.x, pointD.y);
                rect.graphics.lineTo(pointA.x, pointA.y);
                break;
            }
            case TilePositionsEnum.TOP_LEFT:
            {
                rect.graphics.clear();
                rect.graphics.beginFill(color);
                rect.graphics.lineStyle(borderThickness, borderColor);
                rect.graphics.moveTo(pointA.x, pointA.y);
                rect.graphics.lineTo(pointB.x, pointB.y);
                rect.graphics.lineStyle(0);
                rect.graphics.lineTo(pointC.x, pointC.y);
                rect.graphics.lineTo(pointD.x, pointD.y);
                rect.graphics.lineStyle(borderThickness, borderColor);
                rect.graphics.lineTo(pointA.x, pointA.y);
                break;
            }
            case TilePositionsEnum.TOP:
            {
                rect.graphics.clear();
                rect.graphics.beginFill(color);
                rect.graphics.lineStyle(borderThickness, borderColor);
                rect.graphics.moveTo(pointA.x, pointA.y);
                rect.graphics.lineTo(pointB.x, pointB.y);
                rect.graphics.lineStyle(0);
                rect.graphics.lineTo(pointC.x, pointC.y);
                rect.graphics.lineTo(pointD.x, pointD.y);
                rect.graphics.lineTo(pointA.x, pointA.y);
                break;
            }
            case TilePositionsEnum.TOP_RIGHT:
            {
                rect.graphics.clear();
                rect.graphics.beginFill(color);
                rect.graphics.lineStyle(borderThickness, borderColor);
                rect.graphics.moveTo(pointA.x, pointA.y);
                rect.graphics.lineTo(pointB.x, pointB.y);
                rect.graphics.lineTo(pointC.x, pointC.y);
                rect.graphics.lineStyle(0);
                rect.graphics.lineTo(pointD.x, pointD.y);
                rect.graphics.lineTo(pointA.x, pointA.y);
                break;
            }
            case TilePositionsEnum.BOTTOM_RIGHT:
            {
                rect.graphics.clear();
                rect.graphics.beginFill(color);
                rect.graphics.lineStyle(0);
                rect.graphics.moveTo(pointA.x, pointA.y);
                rect.graphics.lineTo(pointB.x, pointB.y);
                rect.graphics.lineStyle(borderThickness, borderColor);
                rect.graphics.lineTo(pointC.x, pointC.y);
                rect.graphics.lineTo(pointD.x, pointD.y);
                rect.graphics.lineStyle(0);
                rect.graphics.lineTo(pointA.x, pointA.y);
                break;
            }
            case TilePositionsEnum.BOTTOM:
            {
                rect.graphics.clear();
                rect.graphics.beginFill(color);
                rect.graphics.lineStyle(0);
                rect.graphics.moveTo(pointA.x, pointA.y);
                rect.graphics.lineTo(pointB.x, pointB.y);
                rect.graphics.lineTo(pointC.x, pointC.y);
                rect.graphics.lineStyle(borderThickness, borderColor);
                rect.graphics.lineTo(pointD.x, pointD.y);
                rect.graphics.lineStyle(0);
                rect.graphics.lineTo(pointA.x, pointA.y);
                break;
            }
            case TilePositionsEnum.BOTTOM_LEFT:
            {
                rect.graphics.clear();
                rect.graphics.beginFill(color);
                rect.graphics.lineStyle(0);
                rect.graphics.moveTo(pointA.x, pointA.y);
                rect.graphics.lineTo(pointB.x, pointB.y);
                rect.graphics.lineTo(pointC.x, pointC.y);
                rect.graphics.lineStyle(borderThickness, borderColor);
                rect.graphics.lineTo(pointD.x, pointD.y);
                rect.graphics.lineTo(pointA.x, pointA.y);
                break;
            }
        }
        return rect;
    }

    private function generateAtlas(event:Event):void
    {
        //Create objects texture atlas from swf:
        var staticDisplayClasses:Vector.<Class> = new Vector.<Class>();

        for each(var clazz:Crater1x1NamesEnum in Enumeration.getElementsList(Crater1x1NamesEnum))
        {
            var Crater1X1Class:Class = loader.contentLoaderInfo.applicationDomain.getDefinition(clazz.value) as Class;
            staticDisplayClasses.push(Crater1X1Class);
        }

        for each(var clazz1:Crater2x2NamesEnum in Enumeration.getElementsList(Crater2x2NamesEnum))
        {
            var Crater2X2Class:Class = loader.contentLoaderInfo.applicationDomain.getDefinition(clazz1.value) as Class;
            staticDisplayClasses.push(Crater2X2Class);
        }

        for each(var clazz2:Garbage1x1NamesEnum in Enumeration.getElementsList(Garbage1x1NamesEnum))
        {
            var Garbage1x1NamesClass:Class = loader.contentLoaderInfo.applicationDomain.getDefinition(clazz2.value) as Class;
            staticDisplayClasses.push(Garbage1x1NamesClass);
        }
        for each(var clazz3:Ground1x1NamesEnum in Enumeration.getElementsList(Ground1x1NamesEnum))
        {
            var Ground1x1NamesClass:Class = loader.contentLoaderInfo.applicationDomain.getDefinition(clazz3.value) as Class;
            staticDisplayClasses.push(Ground1x1NamesClass);
        }


        //*************************************************************************
        //Create tiles texture atlas:
        var tilesColor:Vector.<Enumeration>= Enumeration.getElementsList(TilesColorEnum);
        var tilesPositions:Vector.<Enumeration> = Enumeration.getElementsList(TilePositionsEnum);
        var tilesDictionary:Dictionary = new Dictionary(true);
        for each (var color:TilesColorEnum in tilesColor)
        {
            for each(var tilePos:TilePositionsEnum in tilesPositions)
            {
                //FIXME: remove external dependence
                var tile:Sprite = drawCleanHomeTile(LandscapeConfig.CEIL_SIZE,LandscapeConfig.CEIL_SIZE,color.value,LandscapeConfig.BUILDING_BORDER_THICKNESS,LandscapeConfig.BUILDING_BORDER_COLOR,tilePos);
                var key:String = TileTypesEnum.CLEAR_TYLE.value+"_"+color.value+"_"+tilePos.value;
                tilesDictionary[key]=tile;
            }
        }

        var atlas:TextureAtlas = DynamicAtlas.fromClassVector(staticDisplayClasses);
        var tilesAtlas:TextureAtlas = DynamicAtlas.fromDictionaryWithNamesInKeys(tilesDictionary);
        _assetsManager.addTextureAtlas(swfName, atlas);
        //FIXME: remove external dependence
        _assetsManager.addTextureAtlas(AssetsConfig.TILES_ATLAS_NAME, tilesAtlas);

        _isComplete = true;
        if (onComplete)
        {
            onComplete();
        }
    }

    public function get assetsManager():AssetManager
    {
        return _assetsManager;
    }
}
}
