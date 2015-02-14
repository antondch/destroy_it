/**
 * Created by Crazy Horse on 04.02.2015.
 */
package
{

import flash.display.Sprite;

import services.AssetsService;

import starling.core.Starling;
import starling.events.Event;

[SWF(width = 1500,height=1500,frameRate=60)]
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
//        starling.start();
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
