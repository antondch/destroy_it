/**
 * Created by Crazy Horse on 05.02.2015.
 */
package home
{
import flash.display.BitmapData;

import isoCore.IsoStarlingSpriteObject;
import isoCore.IsoUtils;

import starling.display.Image;
import starling.textures.Texture;

public class IsoHome extends IsoStarlingSpriteObject
{
    public function IsoHome(size:Number)
    {
        super(size);
        draw();
    }

    //todo: remove this trash.
    private function draw():void
    {
        var bmp:BitmapData = IsoUtils.drawTile(100,300,0x00ff00,1,0x000000);

        var image:Image = new Image(Texture.fromBitmapData(bmp));
        addChild(image);
    }
}
}
