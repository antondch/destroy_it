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
import flash.events.IOErrorEvent;
import flash.geom.Point;
import flash.net.URLRequest;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.utils.Dictionary;

import starling.textures.Texture;

import starling.textures.TextureAtlas;
import starling.utils.AssetManager;

/**
 * Singleton service class load assets and prepare texture atlases, and grant access to textures.
 * For load assets and prepare textures use loadAssets().
 * For get texture  use getTexture(name:String):Texture.
 * For get texture  use getTextures(prefix:String):Vector.<Texture>.
 * @see loadAssets(rootPath:String,swfPath:String,swfName:String,swfExtension:String,onComplete:Function = null):void.
 * @see getTexture(name:String):Texture.
 * @see getTextures(prefix:String):Vector.<Texture>.
 * @see get sharedAssets():AssetsService.
 */
public class AssetsService extends EventDispatcher
{
    private var loader:Loader = new Loader();
    private static const TEXTURES_POSTFIX:String = "_00000";
    private var onComplete:Function;
    private var _isComplete:Boolean = false;
    private static var _sharedAssets:AssetsService;
    private var swfName:String;
    private static const TEXTURES:Dictionary = new Dictionary(true);
    private static const ATLASES:Dictionary = new Dictionary(true);


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
        loader.addEventListener(IOErrorEvent.IO_ERROR, loader_ioErrorHandler);
    }

    private function drawCleanTile(size:Number, color:uint):Sprite
    {
        var rect:Sprite = new Sprite();
        //In box ABCDEFGH:
        var pointA:Point = IsoUtils.isoToScreen(0, 0, 0);
        var pointB:Point = IsoUtils.isoToScreen(size, 0, 0);
        var pointC:Point = IsoUtils.isoToScreen(size, 0, size);
        var pointD:Point = IsoUtils.isoToScreen(0, 0, size);
        //****************

                rect.graphics.clear();
                rect.graphics.beginFill(color);
                rect.graphics.lineStyle(0,0x000000,0);
                rect.graphics.moveTo(pointA.x, pointA.y);
                rect.graphics.lineTo(pointB.x, pointB.y);
                rect.graphics.lineTo(pointC.x, pointC.y);
                rect.graphics.lineTo(pointD.x, pointD.y);
                rect.graphics.lineTo(pointA.x, pointA.y);
        return rect;
    }

    private function drawLine(thickness:Number, color:uint, from:Point,to:Point):Sprite
    {
        var pointA:Point = IsoUtils.isoToScreen(from.x, 0, from.y);
        var pointB:Point = IsoUtils.isoToScreen(to.x, 0, to.y);
        var line:Sprite = new Sprite();
                line.graphics.clear();
                line.graphics.beginFill(color);
                line.graphics.lineStyle(thickness,color);
                line.graphics.moveTo(pointA.x, pointA.y);
                line.graphics.lineTo(pointB.x, pointB.y);
        return line;
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
        var mcClasses:Vector.<Class> = new Vector.<Class>();
//        for each(var clazz4:Explode1x1NamesEnum in Enumeration.getElementsList(Explode1x1NamesEnum))
//        {
//            var Explode1x1NamesClass:Class = loader.contentLoaderInfo.applicationDomain.getDefinition(clazz4.value) as Class;
//            mcClasses.push(Explode1x1NamesClass);
//        }
        for each(var clazz5:Explode2x2NamesEnum in Enumeration.getElementsList(Explode2x2NamesEnum))
        {
            var Explode2x2NamesClass:Class = loader.contentLoaderInfo.applicationDomain.getDefinition(clazz5.value) as Class;
            mcClasses.push(Explode2x2NamesClass);
        }
        ATLASES["mc"] = DynamicAtlas.fromClassVector(mcClasses);

        //*************************************************************************
        //Create tiles texture atlas:
        var tilesColor:Vector.<Enumeration> = Enumeration.getElementsList(TilesColorEnum);
        var tilesDictionary:Dictionary = new Dictionary(true);
        for each (var color:TilesColorEnum in tilesColor)
        {
                //FIXME: remove external dependence
                var tile:Sprite = drawCleanTile(LandscapeConfig.CEIL_SIZE, color.value);
                var key:String = TileTypesEnum.CLEAR.value + "_" + color.value;
                tilesDictionary[key] = tile;
        }
        //create tile lines:
        var horizontalLineKey:String = LineTypes.HORIZONTAL;
        tilesDictionary[horizontalLineKey]= drawLine(LandscapeConfig.BUILDING_BORDER_THICKNESS,LandscapeConfig.BUILDING_BORDER_COLOR,new Point(0,0), new Point(LandscapeConfig.CEIL_SIZE,0));

        var verticalLineKey:String = LineTypes.VERTICAL;
        tilesDictionary[verticalLineKey]= drawLine(LandscapeConfig.BUILDING_BORDER_THICKNESS,LandscapeConfig.BUILDING_BORDER_COLOR,new Point(0,0),new Point(0,LandscapeConfig.CEIL_SIZE));


        var atlas:TextureAtlas = DynamicAtlas.fromClassVector(staticDisplayClasses);
        var tilesAtlas:TextureAtlas = DynamicAtlas.fromDictionaryWithNamesInKeys(tilesDictionary);

        ATLASES[swfName] = atlas;
        ATLASES[AssetsConfig.TILES_ATLAS_NAME] = tilesAtlas;

        _isComplete = true;
        if (onComplete)
        {
            onComplete();
        }
    }

    public function getTexture(name:String):Texture
    {
        name+=TEXTURES_POSTFIX;
        var texture:Texture = TEXTURES[name];
        if (!texture)
        {
            for each(var atlas:TextureAtlas in ATLASES)
            {
                texture = atlas.getTexture(name);
                if(texture)
                {
                    TEXTURES[name]=texture;
                    break;
                }
            }
        }
        return texture;
    }
    public function getTextures(prefix:String):Vector.<Texture>
    {
        var result:Vector.<Texture> = TEXTURES[prefix];
        if (!result)
        {
            for each(var atlas:TextureAtlas in ATLASES)
            {
                result = atlas.getTextures(prefix);
                if(result.length>0)
                {
                    TEXTURES[prefix]=result;
                    break;
                }
            }
        }
        return result;
    }

    private function loader_ioErrorHandler(event:IOErrorEvent):void
    {
        trace(this, "error loading assets");
    }
}
}
