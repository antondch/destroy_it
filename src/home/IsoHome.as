/**
 * Created by Crazy Horse on 05.02.2015.
 */
package home
{
import flash.display.BitmapData;

import isoCore.IsoStarlingSprite;
import isoCore.IsoUtils;

import starling.display.Image;
import starling.textures.Texture;

public class IsoHome extends IsoStarlingSprite
{
    public function IsoHome(x:Number,y:Number,z:Number,width:Number,length:Number,height:Number)
    {
        super(x,y,z,width,length,height);
        draw();
    }

    //todo: remove this trash.
    private function draw():void
    {
        var bmp:BitmapData = IsoUtils.drawTile(isoBounds.size.width,isoBounds.size.length,0x00ff00,1,0x000000);
        var image:Image = new Image(Texture.fromBitmapData(bmp));
        addChild(image);
    }
}
}
