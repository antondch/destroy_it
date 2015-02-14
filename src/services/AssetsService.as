/**
 * Created by Crazy Horse on 14.02.2015.
 */
package services
{
import config.AssetsConfig;

import flash.display.Loader;

import starling.utils.AssetManager;

public class AssetsService
{
    private var _assets:AssetManager = new AssetManager();

    public function AssetsService()
    {

    }

    public function loadAssets():void
    {
        assets.verbose = true;
        assets.enqueue(AssetsConfig.ROOT_ASSETS_PATH+AssetsConfig.SWF_ASSETS_PATH+AssetsConfig.HOME_SWF_NAME+AssetsConfig.SWF_EXTENSION);
        assets.loadQueue(function(ratio:Number):void{
            if(ratio==1.0){
                createAssetsFromSwf(AssetsConfig.HOME_SWF_NAME);
            }
        })
    }

    private function createAssetsFromSwf(name:String):void
    {
        var loader:Loader = new Loader();
        loader.loadBytes(assets.getByteArray(name));
        trace(this,"swf is loaded to loader");
    }

    public function get assets():AssetManager
    {
        return _assets;
    }
}
}
