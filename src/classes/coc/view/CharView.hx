/**
 * Coded by aimozg on 10.07.2017.
 */
package coc.view;

import flash.errors.Error;
import classes.internals.Utils;
import coc.view.charview.CharViewCompiler;
import coc.view.charview.CharViewContext;
import coc.view.charview.CharViewSprite;
import coc.view.charview.Palette;
import coc.xlogic.Statement;
import coc.xlogic.StmtList;
import flash.display.BitmapData;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.Event;

class CharView extends Sprite
{
    public var palette(get, never) : Palette;

    
    private var loading : Bool;
    private var sprites : Dynamic = { };  // spritesheet/spritemap -> CharViewSprite  
    public var composite : CompositeImage;
    private var ss_total : Int;
    private var ss_loaded : Int;
    private var file_total : Int;
    private var file_loaded : Int;
    private var _originX : Int;
    private var _originY : Int;
    private var _width : Int;
    private var _height : Int;
    private var scale : Float;
    private var pendingRedraw : Bool;
    private var loaderLocation : String;
    private var parts : Statement;
    private var _palette : Palette;
    public var bgFill : Int = 0;
    private var time : Int = 0;
    
    private function get_palette() : Palette
    {
        return _palette;
    }
    public function new()
    {
        super();
        clearAll();
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
    }
    private function onAddedToStage(e : Event) : Void
    {
        addEventListener(Event.ENTER_FRAME, onEnterFrame);
    }
    private function onRemovedFromStage(e : Event) : Void
    {
        removeEventListener(Event.ENTER_FRAME, onEnterFrame);
    }
    private function onEnterFrame(e : Event) : Void
    {
        try
        {
            var t2 : Int = Math.round(haxe.Timer.stamp() * 1000);
            var dt : Int = Math.max(0, t2 - time);
            if (composite != null)
            {
                if (composite.advanceTime(dt, t2))
                {
                    composeFrame();
                }
            }
            time = t2;
        }
        catch (e : Error)
        {
            removeEventListener(Event.ENTER_FRAME, onEnterFrame);
            throw e;
        }
    }
    /**
	 * @param location "external" or "internal"
	 */
    public function reload(location : String = "external") : Void
    {
        loaderLocation = location;
        if (loading)
        {
            return;
        }
        try
        {
            loading = true;
            clearAll();
            if (loaderLocation == "external")
            {
                trace("loading XML res/model.xml");
            }
            CoCLoader.loadText("res/model.xml", function(success : Bool, result : String, e : Event) : Void
                    {
                        if (success)
                        {
                            init(FastXML.parse(result));
                        }
                        else
                        {
                            trace("XML file not found: " + e);
                            loading = false;
                        }
                    }, loaderLocation);
        }
        catch (e : Error)
        {
            loading = false;
            trace("[ERROR]\n" + e.getStackTrace());
        }
    }
    private function clearAll() : Void
    {
        this.time = Math.round(haxe.Timer.stamp() * 1000);
        this.sprites = { };
        this.composite = null;
        this.ss_total = 0;
        this.ss_loaded = 0;
        this.file_total = 0;
        this.file_loaded = 0;
        this._width = 1;
        this._height = 1;
        this.scale = 1;
        this.pendingRedraw = false;
        this.parts = new StmtList();
    }
    private function init(xml : FastXML) : Void
    {
        _width = xml.att.width;
        _height = xml.att.height;
        _originX = (xml.att.originX || 0) ? 1 : 0;
        _originY = (xml.att.originY || 0) ? 1 : 0;
        composite = new CompositeImage(_width, _height);
        ss_loaded = 0;
        ss_total = -1;
        /**/
        loadPalette(xml);
        var compiler : CharViewCompiler = new CharViewCompiler(this);
        this.parts = compiler.compileXMLList(xml.node.logic.innerData.node.children.innerData());
        var n : Int = 0;
        var item : FastXML;
        for (item in xml.nodes.spritesheet)
        {
            n++;
            loadSpritesheet(xml, item);
        }
        for (item in xml.nodes.spritemap)
        {
            n++;
            loadSpritemap(xml, item);
        }
        ss_total = n;
        if (n == 0)
        {
            loadLayers(xml);
        }
        var g : Graphics = graphics;
        g.clear();
        g.beginFill(bgFill & 0x00ffffff, (as3hx.Compat.parseInt(bgFill >> 24) & 0xff) / 256.0);
        g.drawRect(0, 0, _width, _height);
        g.endFill();
        scale = as3hx.Compat.parseFloat(xml.att.scale);
        this.scaleX = scale;
        this.scaleY = scale;
        loading = false;
        if (pendingRedraw)
        {
            redraw();
        }
    }
    private function loadPalette(xml : FastXML) : Void
    {
        _palette = new Palette();
        var commonLookups : Dynamic = { };
        for (color/* AS3HX WARNING could not determine type for var: color exp: EField(EField(EField(EIdent(xml),palette),common),color) type: null */ in xml.nodes.palette.node.common.innerData.color)
        {
            Reflect.setField(commonLookups, Std.string(Std.string(color.att.name)), Std.string(color.text()));
        }
        _palette.addLookups("common", commonLookups);
        for (prop/* AS3HX WARNING could not determine type for var: prop exp: EField(EField(EIdent(xml),palette),property) type: null */ in xml.nodes.palette.node.property.innerData)
        {
            var lookups : Dynamic = { };
            for (color/* AS3HX WARNING could not determine type for var: color exp: EField(EIdent(prop),color) type: null */ in prop.color)
            {
                Reflect.setField(lookups, Std.string(Std.string(color.att.name)), Std.string(color.text()));
            }
            var propname : String = Std.string(prop.att.name);
            _palette.addLookups(propname, lookups);
            _palette.addPaletteProperty(
                    propname, 
                    Std.string(prop.att.src), 
                    Color.convertColor(Std.string(prop.att.default)), 
                    [propname, "common"]
            );
        }
        for (key/* AS3HX WARNING could not determine type for var: key exp: EField(EField(EIdent(xml),colorkeys),key) type: null */ in xml.nodes.colorkeys.node.key.innerData)
        {
            var src : Int = Color.convertColor(Std.string(key.att.src));
            var base : String = Std.string(key.att.base);
            var tf : String = Std.string(key.att.transform) || "";
            _palette.addKeyColor(src, base, tf);
        }
    }
    public function lookupColorValue(propname : String, colorname : String) : Int
    {
        return _palette.lookupColor(propname, colorname);
    }
    private function loadLayers(xml : FastXML) : Void
    {
        file_loaded = 0;
        var item : FastXML;
        var n : Int = 0;
        file_total = -1;
        for (item/* AS3HX WARNING could not determine type for var: item exp: EE4XDescend(EField(EIdent(xml),layers),EIdent(layer)) type: null */ in xml.nodes.layers.descendants("layer"))
        {
            var lpfx : String = item.att.name + "/";
            for (sname in Reflect.fields(sprites))
            {
                if (sname.indexOf(lpfx) == 0)
                {
                    var sprite : CharViewSprite = Reflect.field(sprites, sname);
                    composite.addLayer(sname, sprite.bmp, 
                            sprite.dx - _originX, sprite.dy - _originY, false
                );
                }
            }
        }
        for (item/* AS3HX WARNING could not determine type for var: item exp: EE4XDescend(EField(EIdent(xml),animations),EIdent(animation)) type: null */ in xml.nodes.animations.descendants("animation"))
        {
            var animation : AnimationDef = new AnimationDef(Std.string(item.att.name));
            for (frame/* AS3HX WARNING could not determine type for var: frame exp: EE4XDescend(EIdent(item),EIdent(frame)) type: null */ in item.descendants("frame"))
            {
                var t : Int = as3hx.Compat.parseInt(Std.string(frame.att.t));
                var dx : Int = as3hx.Compat.parseInt(Std.string(frame.att.dx) || "0");
                var dy : Int = as3hx.Compat.parseInt(Std.string(frame.att.dy) || "0");
                var i : String = Std.string(frame.att.i) || "";
                animation.addFrame(t, dx, dy, i);
            }
            composite.addAnimation(animation);
        }
        file_total = n;
        if (pendingRedraw)
        {
            redraw();
        }
    }
    private var _character : Dynamic = { };
    public function setCharacter(value : Dynamic) : Void
    {
        _character = value;
    }
    public function isLoaded() : Bool
    {
        return !loading && ss_loaded == ss_total && file_loaded == file_total && (ss_total + file_total) > 0;
    }
    public function redraw() : Void
    {
        if (file_total == 0 && ss_total == 0 && !loading)
        {
            reload();
        }
        pendingRedraw = true;
        if (!isLoaded())
        {
            return;
        }
        pendingRedraw = false;
        
        
        // Mark visible layers
        composite.hideAll();
        composite.resetAnimations();
        time = Math.round(haxe.Timer.stamp() * 1000);
        parts.execute(new CharViewContext(this, _character));
        
        composeFrame();
        this.scaleX = scale;
        this.scaleY = scale;
    }
    
    private function composeFrame() : Void
    {
        var keyColors : Dynamic = _palette.calcKeyColors(_character);
        var bd : BitmapData = composite.draw(keyColors);
        var g : Graphics = graphics;
        g.clear();
        g.beginFill(bgFill & 0x00ffffff, (as3hx.Compat.parseInt(bgFill >> 24) & 0xff) / 256.0);
        g.drawRect(0, 0, _width, _height);
        g.endFill();
        g.beginBitmapFill(bd);
        g.drawRect(0, 0, _width, _height);
        g.endFill();
    }
    
    private function loadSpritemap(xml : FastXML, sm : FastXML) : Void
    {
        var filename : String = sm.att.file;
        var path : String = xml.att.dir + filename;
        if (loaderLocation == "external")
        {
            trace("loading spritemap " + path);
        }
        CoCLoader.loadImage(path, function(success : Bool, result : BitmapData, e : Event) : Void
                {
                    if (!success)
                    {
                        trace("Spritemap file not found: " + e);
                        ss_loaded++;
                        if (pendingRedraw)
                        {
                            redraw();
                        }
                        return;
                    }
                    var srects : Dynamic = { };
                    var aliasCells : Array<Dynamic> = [];
                    for (cell in sm.nodes.cell)
                    {
                        var srect : String = Std.string(cell.att.rect);
                        var sdx : String = Std.string(cell.att.dx);
                        var sdy : String = Std.string(cell.att.dy);
                        var rect : Array<Dynamic> = srect.match(new as3hx.Compat.Regex('^(\\d+),(\\d+),(\\d+),(\\d+)$', ""));
                        var x : Int = (rect != null) ? as3hx.Compat.parseInt(rect[1]) : cell.att.x;
                        var y : Int = (rect != null) ? as3hx.Compat.parseInt(rect[2]) : cell.att.y;
                        var w : Int = (rect != null) ? as3hx.Compat.parseInt(rect[3]) : cell.att.w;
                        var h : Int = (rect != null) ? as3hx.Compat.parseInt(rect[4]) : cell.att.h;
                        var f : String = cell.att.name;
                        var dx : Int = cell.att.dx;
                        var dy : Int = cell.att.dy;
                        if (rect != null)
                        {
                            if (Lambda.has(srects, srect))
                            {
                                trace("[INFO] Duplicate <cell rect>: " + f + ", " + Reflect.field(srects, srect));
                            }
                            else
                            {
                                Reflect.setField(srects, srect, f);
                            }
                            try
                            {
                                Reflect.setField(sprites, f, new CharViewSprite(UIUtils.subsprite(result, x, y, w, h), dx, dy));
                            }
                            catch (e : Error)
                            {
                                throw new Error("Error in model.xml <cell name='" + f + "'>: " + e.message);
                            }
                        }
                        else
                        {
                            aliasCells.push([srect, f, sdx, sdy]);
                        }
                    }
                    while (aliasCells.length > 0)
                    {
                        var progressed : Bool = false;
                        var i : Int = as3hx.Compat.parseInt(aliasCells.length - 1);
                        while (i >= 0)
                        {
                            srect = aliasCells[i][0];
                            f = aliasCells[i][1];
                            sdx = aliasCells[i][2];
                            sdy = aliasCells[i][3];
                            if (Lambda.has(sprites, srect))
                            {
                                progressed = true;
                                var ref : CharViewSprite = Reflect.field(sprites, Std.string(srect));
                                dx = (sdx) ? as3hx.Compat.parseInt(sdx) : ref.dx;
                                dy = (sdy) ? as3hx.Compat.parseInt(sdy) : ref.dy;
                                try
                                {
                                    Reflect.setField(sprites, Std.string(f), new CharViewSprite(ref.bmp, dx, dy));
                                }
                                catch (e : Error)
                                {
                                    throw new Error("Error in model.xml <cell name='" + f + "'>: " + e.message);
                                }
                                aliasCells.splice(i, 1);
                            }
                            i--;
                        }
                        if (!progressed)
                        {
                            throw new Error("Cannot resolve reference <cell name='" + aliasCells[0][1] + "' rect='" + aliasCells[0][0] + "'>");
                        }
                    }
                    ss_loaded++;
                    if (ss_loaded == ss_total)
                    {
                        loadLayers(xml);
                    }
                }, loaderLocation);
    }
    private function loadSpritesheet(xml : FastXML, ss : FastXML) : Void
    {
        var filename : String = ss.att.file;
        var cellwidth : Int = ss.att.cellwidth;
        var cellheight : Int = ss.att.cellheight;
        var path : String = xml.att.dir + filename;
        if (loaderLocation == "external")
        {
            trace("loading spritesheet " + path);
        }
        CoCLoader.loadImage(path, function(success : Bool, result : BitmapData, e : Event) : Void
                {
                    if (!success)
                    {
                        trace("Spritesheet file not found: " + e);
                        ss_loaded++;
                        if (pendingRedraw)
                        {
                            redraw();
                        }
                        return;
                    }
                    var y : Int = 0;
                    for (row in ss.nodes.row)
                    {
                        var x : Int = 0;
                        var files : Array<Dynamic> = Std.string(row.node.text.innerData()).split(",");
                        for (f in files)
                        {
                            if (f != null)
                            {
                                Reflect.setField(sprites, Std.string(f), new CharViewSprite(UIUtils.subsprite(result, x, y, cellwidth, cellheight), 0, 0));
                            }
                            x += cellwidth;
                        }
                        y += cellheight;
                    }
                    ss_loaded++;
                    if (ss_loaded == ss_total)
                    {
                        loadLayers(xml);
                    }
                }, loaderLocation);
    }
}


