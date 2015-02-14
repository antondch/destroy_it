/**
 * Created by Crazy Horse on 14.02.2015.
 */
package com.dch.destroyit.assets
{
import com.dch.destroyit.config.AssetsConfig;
import com.dch.destroyit.enums.Enumeration;
import com.emibap.textureAtlas.DynamicAtlas;

import flash.display.Loader;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLRequest;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;

import starling.textures.Texture;

import starling.textures.TextureAtlas;

public class AssetsService extends EventDispatcher
{
    private var loader:Loader = new Loader();
    private var atlas:TextureAtlas;
    private static const TEXTURES_POSTFIX:String="00000";
    public static const ASSETS_PREPARED:String = "assets_prepared";

    public function AssetsService()
    {

    }

    public function loadAssets():void
    {
        var context:LoaderContext = new LoaderContext();
        context.applicationDomain = ApplicationDomain.currentDomain;
        loader.load(new URLRequest(AssetsConfig.ROOT_ASSETS_PATH + AssetsConfig.SWF_ASSETS_PATH + AssetsConfig.HOME_SWF_NAME + AssetsConfig.SWF_EXTENSION), context);
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

        atlas = DynamicAtlas.fromClassVector(staticDisplayClasses);

        dispatchEvent(new Event(ASSETS_PREPARED));
    }

    public function getTexture(name:String):Texture
    {
        return atlas.getTexture(name);
    }

    public function getMCTextures(perfix:String):Vector.<Texture>
    {
        return atlas.getTextures(perfix);
    }
}
}
