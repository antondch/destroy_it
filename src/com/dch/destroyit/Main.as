/**
 * Created by Crazy Horse on 04.02.2015.
 */
package com.dch.destroyit
{
import com.dch.destroyit.assets.AssetsService;

import flash.display.Sprite;

import starling.core.Starling;
import starling.events.Event;

[SWF(width=1500, height=1500, frameRate=60)]
public class Main extends Sprite
{
    private var starling:Starling;

    public function Main():void
    {
        startStarling();
    }

    private function startStarling():void
    {
        starling = new Starling(RootView, stage);
        starling.addEventListener(Event.ROOT_CREATED, createAssets);
        starling.start();
    }

    private function createAssets(event:Event):void
    {
        var assetsService:AssetsService = new AssetsService();
        assetsService.loadAssets(createRootController);
    }

    private function createRootController():void
    {
        var rootController:RootController = new RootController(starling.root);
    }
}
}
