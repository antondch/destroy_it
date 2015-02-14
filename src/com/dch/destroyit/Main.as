/**
 * Created by Crazy Horse on 04.02.2015.
 */
package com.dch.destroyit
{
import com.dch.destroyit.assets.AssetsService;
import com.dch.destroyit.landscape.LandscapeModel;

import flash.display.Sprite;

import starling.core.Starling;
import starling.events.Event;

[SWF(width=1500, height=1500, frameRate=60)]
public class Main extends Sprite
{
    private var starling:Starling;
    private var rootController:RootController;
    private var assetsService:AssetsService;

    public function Main():void
    {
        startStarling();
    }

    private function startStarling():void
    {
        starling = new Starling(RootView, stage);
        starling.addEventListener(Event.ROOT_CREATED, createAssets);
        createLandscapeModel();
        starling.start();
    }

    private function createLandscapeModel():void
    {
        var landscapeModel:LandscapeModel = new LandscapeModel();
    }

    private function createAssets(event:Event):void
    {
        assetsService = new AssetsService();
        assetsService.loadAssets();
    }

    private function createRootController(event:Event):void
    {
        rootController = new RootController(starling.root)
    }
}
}
