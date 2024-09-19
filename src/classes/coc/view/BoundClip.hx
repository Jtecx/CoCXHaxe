/**
 * Coded by aimozg on 02.12.2017.
 */
package coc.view;

import flash.display.MovieClip;
import flash.display.Sprite;

class BoundClip extends MovieClip
{
    public static var nextContent : Sprite;
    public function new()
    {
        super();
        if (nextContent == null)
        {
            return;
        }
        
        addChild(nextContent);
    }
}

