/**
 * Created by Crazy Horse on 14.02.2015.
 */
package com.dch.destroyit.assets
{
import com.dch.destroyit.config.AssetsConfig;

import flash.display.Loader;
import flash.events.Event;
import flash.net.URLRequest;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;

import starling.utils.AssetManager;

public class AssetsService
{
    private var assets:AssetManager = new AssetManager();
    private var loader:Loader = new Loader();

    public function AssetsService()
    {

    }

    public function loadAssets():void
    {
        var context:LoaderContext = new LoaderContext();
        context.applicationDomain = ApplicationDomain.currentDomain;
        loader.load(new URLRequest(AssetsConfig.ROOT_ASSETS_PATH + AssetsConfig.SWF_ASSETS_PATH + AssetsConfig.HOME_SWF_NAME + AssetsConfig.SWF_EXTENSION), context);
        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, createAssetsFromSwf);
//        assets.verbose = true;
//        assets.enqueue(AssetsConfig.ROOT_ASSETS_PATH+AssetsConfig.SWF_ASSETS_PATH+AssetsConfig.HOME_SWF_NAME+AssetsConfig.SWF_EXTENSION);
//        assets.loadQueue(function(ratio:Number):void{
//            if(ratio==1.0){
//                createAssetsFromSwf(AssetsConfig.HOME_SWF_NAME);
//            }
//        })
    }

    private function createAssetsFromSwf(event:Event):void
    {
        var GroundClass:Class = loader.contentLoaderInfo.applicationDomain.getDefinition(Ground1x1NamesEnum.GROUND_1X1_NAME) as Class;
        trace(this, "swf is loaded to loader");
    }

//    public function get assets():AssetManager
//    {
//        return _assets;
//    }
}
}
