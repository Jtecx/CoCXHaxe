package coc.view;

import flash.display.BitmapData;
import flash.display.Graphics;

/**
 * Cuts an image into 9 parts:
 * ```
 *  <-l-> <-cW-> <-r-->
 * |     |      |      | ^
 * |  0  |  1   |  2   | | top
 * |     |      |      | v
 * +-----+------+------+
 * |     |      |      | ^
 * |  3  |  4   |  5   | | centerHeight
 * |     |      |      | v
 * +-----+------+------+
 * |     |      |      | ^
 * |  6  |  7   |  8   | | bottom
 * |     |      |      | v
 * +-----+------+------+
 * ```
 * and covers another image with it:
 * * parts 0, 2, 6, 8 - not stretched
 * * parts 1, 7 - streched horizontally
 * * parts 3, 5 - streched vertically
 * * part 4 - streched in both axis
 */
class BorderImage
{
    public function new(
            source : BitmapData,
            top : Int,
            bottom : Int,
            left : Int,
            right : Int)
    {
        var width : Int = source.width;
        var height : Int = source.height;
        this.top = top;
        this.bottom = bottom;
        this.left = left;
        this.right = right;
        centerWidth = Math.max(0, width - left - right);
        centerHeight = Math.max(0, height - top - bottom);
        parts = [];
        var x0 : Int = 0;
        var x1 : Int = left;
        var x2 : Int = as3hx.Compat.parseInt(left + centerWidth);
        var w0 : Int = left;
        var w1 : Int = centerWidth;
        var w2 : Int = right;
        var y0 : Int = 0;
        var y1 : Int = top;
        var y2 : Int = as3hx.Compat.parseInt(top + centerHeight);
        var h0 : Int = top;
        var h1 : Int = centerHeight;
        var h2 : Int = bottom;
        parts[0] = UIUtils.subsprite(source, x0, y0, w0, h0);
        parts[1] = UIUtils.subsprite(source, x1, y0, w1, h0);
        parts[2] = UIUtils.subsprite(source, x2, y0, w2, h0);
        parts[3] = UIUtils.subsprite(source, x0, y1, w0, h1);
        parts[4] = UIUtils.subsprite(source, x1, y1, w1, h1);
        parts[5] = UIUtils.subsprite(source, x2, y1, w2, h1);
        parts[6] = UIUtils.subsprite(source, x0, y2, w0, h2);
        parts[7] = UIUtils.subsprite(source, x1, y2, w1, h2);
        parts[8] = UIUtils.subsprite(source, x2, y2, w2, h2);
    }
    private var top : Int;
    private var bottom : Int;
    private var left : Int;
    private var right : Int;
    private var centerWidth : Int;
    private var centerHeight : Int;
    public var parts : Array<Dynamic>;
    
    public function drawOver(dst : Graphics, dstWidth : Int, dstHeight : Int, fillCenter : Bool) : Void
    {
        dst.lineStyle();
        var dstCenterWidth : Int = Math.max(0, dstWidth - left - right);
        var dstCenterHeight : Int = Math.max(0, dstHeight - top - bottom);
        var widths : Array<Dynamic> = [left, dstCenterWidth, right];
        var heights : Array<Dynamic> = [top, dstCenterHeight, bottom];
        var y : Int = 0;
        var k : Int = 0;
        
        for (i in 0...3)
        {
            var x : Int = 0;
            for (j in 0...3)
            {
                UIUtils.drawBitmap(dst, parts[k], x, y, widths[j], Reflect.field(heights, i));
                x += widths[j];
                k++;
            }
            y += Reflect.field(heights, i);
        }
    }
}

