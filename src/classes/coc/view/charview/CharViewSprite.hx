/**
 * Coded by aimozg on 06.08.2017.
 */
package coc.view.charview;

import flash.display.BitmapData;

class CharViewSprite
{
    public var bmp : BitmapData;
    public var dx : Int;
    public var dy : Int;
    public function new(
            bmp : BitmapData,
            dx : Int,
            dy : Int)
    {
        this.bmp = bmp;
        this.dx = dx;
        this.dy = dy;
    }
}

