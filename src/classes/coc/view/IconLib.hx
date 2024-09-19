package coc.view;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;

class IconLib
{
    public static var INSTANCE : IconLib = new IconLib();
    
    private function new()
    {
    }
    
    // String -> Bitmap
    private var icons(default, never) : Dynamic = { };
    // String -> String
    private var aliases(default, never) : Dynamic = { };
    
    private function init(xml : FastXML) : Void
    {
        for (item in xml.nodes.file)
        {
            var name : String = item.att.name;
            // capture item
            function(xfile : FastXML) : Void
                    {
                        CoCLoader.loadImage("res/" + name, function(success : Bool, result : BitmapData, e : Event) : Void
                                {
                                    loadFile(xfile, result);
                                });
                    }(item);
        }
        for (item/* AS3HX WARNING could not determine type for var: item exp: EField(EField(EIdent(xml),aliases),alias) type: null */ in xml.nodes.aliases.node.alias.innerData)
        {
            Reflect.setField(aliases, Std.string(Std.string(item.att.alias)), Std.string(item.att.icon));
        }
    }
    private function loadFile(xfile : FastXML, bd : BitmapData) : Void
    {
        var cellwidth : Int = xfile.att.cellwidth;
        var cellheight : Int = xfile.att.cellheight;
        var prefix : String = xfile.att.prefix || "";
        var y : Int = 0;
        for (xrow in xfile.nodes.row)
        {
            var x : Int = 0;
            for (xicon/* AS3HX WARNING could not determine type for var: xicon exp: EField(EIdent(xrow),icon) type: null */ in xrow.node.icon.innerData)
            {
                var iconId : String = prefix + Std.string(xicon.text());
                if (iconId != null)
                {
                    Reflect.setField(icons, iconId, new Bitmap(UIUtils.subsprite(bd, x, y, cellwidth, cellheight)));
                }
                x += cellwidth;
            }
            y += cellheight;
        }
    }
    
    public function loadIcons() : Void
    {
        CoCLoader.loadText("res/icons.xml", function(success : Bool, result : String, e : Event) : Void
                {
                    if (!success)
                    {
                        return;
                    }
                    init(FastXML.parse(result));
                });
    }
    
    /**
	 * @return null if no icon with such id
	 */
    public function getBitmap(id : String) : Bitmap
    {
        var i : Int = 100;  // circular dependency protection  
        while (i-- > 0 && Lambda.has(aliases, id) && id != Reflect.field(aliases, id))
        {
            id = Reflect.field(aliases, id);
        }
        return Reflect.field(icons, id) || null;
    }
    public static function getBitmap(id : String) : Bitmap
    {
        return INSTANCE.getBitmap(id);
    }
    public static function hasIcon(id : String) : Bool
    {
        return !!getBitmap(id);
    }
    /**
	 * Pick and return first icon id that exists
	 **/
    public static function pickIcon(ids : Array<Dynamic> = null) : String
    {
        for (id in ids)
        {
            if (hasIcon(id))
            {
                return id;
            }
        }
        return null;
    }
    /**
	 * Pick and return first icon that exists
	 * @example
	 * IconLib.pickBitmap(item.id, "I_GenericWeapon", "I_GenericItem")
	 **/
    public static function pickBitmap(ids : Array<Dynamic> = null) : Bitmap
    {
        for (id in ids)
        {
            var bmp : Bitmap = getBitmap(id);
            if (bmp != null)
            {
                return bmp;
            }
        }
        return null;
    }
}

