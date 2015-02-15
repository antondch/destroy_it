/**
 * Created by Crazy Horse on 14.02.2015.
 */
package com.dch.destroyit.assets
{
import com.dch.destroyit.enums.Enumeration;
import com.emibap.textureAtlas.DynamicAtlas;

import flash.display.Loader;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.geom.Point;
import flash.net.URLRequest;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;

import starling.textures.TextureAtlas;

import starling.utils.AssetManager;

/**
 * Singleton service class load assets and grant access to assetsManager.
 * For load assets use loadAssets().
 * For get texture from atlas use getTexture() & getTextures().
 * For add texture to atlas use addTexture().
 * @see loadAssets(rootPath:String,swfPath:String,swfName:String,swfExtension:String,onComplete:Function = null):void.
 * @see get assetsManager():AssetsManager.
 * @see starling.utils.AssetManager.
 * @see get sharedAssets():AssetsService.
 */
public class AssetsService extends EventDispatcher
{
    private var loader:Loader = new Loader();
    private static const TEXTURES_POSTFIX:String = "00000";
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
        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, createAssetsFromSwf);
    }

    private function createAssetsFromSwf(event:Event):void
    {
        //Create static objects texture atlas:
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


        //********************************************************************
        //create movie clips texture atlas
        for each(var clazz4:Explode1x1NamesEnum in Enumeration.getElementsList(Explode1x1NamesEnum))
        {
            var Explode1x1NamesClass:Class = loader.contentLoaderInfo.applicationDomain.getDefinition(clazz4.value) as Class;
            staticDisplayClasses.push(Explode1x1NamesClass);
        }
        for each(var clazz5:Explode2x2NamesEnum in Enumeration.getElementsList(Explode2x2NamesEnum))
        {
            var Explode2x2NamesClass:Class = loader.contentLoaderInfo.applicationDomain.getDefinition(clazz5.value) as Class;
            staticDisplayClasses.push(Explode2x2NamesClass);
        }

        var atlas:TextureAtlas = DynamicAtlas.fromClassVector(staticDisplayClasses);
        _assetsManager.addTextureAtlas(swfName, atlas);

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
