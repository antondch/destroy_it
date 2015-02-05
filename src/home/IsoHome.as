/**
 * Created by Crazy Horse on 05.02.2015.
 */
package home
{
import flash.display.BitmapData;
import flash.display.Sprite;

import isoCore.IsoStarlingSpriteObject;

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
        var rect:flash.display.Sprite = new flash.display.Sprite();
        rect.graphics.clear();
        rect.graphics.beginFill(0x00ff00);
        rect.graphics.lineStyle(0, 0, 0.5);
        rect. graphics.moveTo(-size, 0);
        rect. graphics.lineTo(0, -size * 0.5);
        rect. graphics.lineTo(size, 0);
        rect.graphics.lineTo(0, size * 0.5);
        rect.graphics.lineTo(-size, 0);

        var bmd:flash.display.BitmapData = new flash.display.BitmapData(rect.width, rect.height, true);
        bmd.draw(rect);

        addChild( new starling.display.Image(Texture.fromBitmapData(bmd, false, false)));

    }
}
}
