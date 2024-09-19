/**
 * Coded by aimozg on 23.07.2017.
 */
package coc.view;

import flash.errors.Error;
import haxe.Constraints.Function;
import classes.internals.LoggerFactory;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import mx.logging.ILogger;

/**
 *
 */
class CoCLoader
{
    private static var LOGGER : ILogger = LoggerFactory.getLogger(CoCLoader);
    public function new()
    {
    }
    // [path:String]=>String
    private static var TEXT_BUNDLE : Dynamic = { };
    
    @:meta(Embed(source="../../../res/model.xml",mimeType="application/octet-stream"))

    public static var BUNDLE_RES_MODEL_XML : Class<Dynamic>;
    
    
    @:meta(Embed(source="../../../content/coc.xml",mimeType="application/octet-stream"))

    public static var BUNDLE_CONTENT_COC_XML : Class<Dynamic>;
    
    
    @:meta(Embed(source="../../../content/coc/NPC/teladreshops.xml",mimeType="application/octet-stream"))

    public static var BUNDLE_CONTENT_COC_NPC_TELADRESHOPS_XML : Class<Dynamic>;
    
    
    public static function bundleText(key : String, c : Class<Dynamic>) : Void
    {
        if (c != null)
        {
            Reflect.setField(TEXT_BUNDLE, key, Type.createInstance(c, []));
        }
    }
    
    // [path:String]=>BitmapData
    private static var IMAGE_BUNDLE : Dynamic = { };
    //
    // [Embed(source="../../../res/char1.png", mimeType="image/png")]
    //	public static var BUNDLE_RES_CHAR1_PNG:Class;
    //	ldbmp("res/char1.png",BUNDLE_RES_CHAR1_PNG);
    
    @:meta(Embed(source="../../../res/icons/items.png",mimeType="image/png"))

    public static var BUNDLE_RES_ICONS_ITEMS_PNG : Class<Dynamic>;
    
    
    @:meta(Embed(source="../../../res/icons/ui.png",mimeType="image/png"))

    public static var BUNDLE_RES_ICONS_UI_PNG : Class<Dynamic>;
    
    
    @:meta(Embed(source="../../../res/icons.xml",mimeType="application/octet-stream"))

    public static var BUNDLE_RES_ICONS_XML : Class<Dynamic>;
    
    
    @:meta(Embed(source="../../../res/charview/body.png",mimeType="image/png"))

    public static var BUNDLE_RES_CHARVIEW_BODY_PNG : Class<Dynamic>;
    
    
    @:meta(Embed(source="../../../res/charview/extra.png",mimeType="image/png"))

    public static var BUNDLE_RES_CHARVIEW_EXTRA_PNG : Class<Dynamic>;
    
    
    @:meta(Embed(source="../../../res/charview/hair.png",mimeType="image/png"))

    public static var BUNDLE_RES_CHARVIEW_HAIR_PNG : Class<Dynamic>;
    
    
    @:meta(Embed(source="../../../res/charview/head.png",mimeType="image/png"))

    public static var BUNDLE_RES_CHARVIEW_HEAD_PNG : Class<Dynamic>;
    
    
    @:meta(Embed(source="../../../res/charview/lewd.png",mimeType="image/png"))

    public static var BUNDLE_RES_CHARVIEW_LEWD_PNG : Class<Dynamic>;
    
    
    @:meta(Embed(source="../../../res/charview/tails.png",mimeType="image/png"))

    public static var BUNDLE_RES_CHARVIEW_TAILS_PNG : Class<Dynamic>;
    
    
    @:meta(Embed(source="../../../res/charview/wings.png",mimeType="image/png"))

    public static var BUNDLE_RES_CHARVIEW_WINGS_PNG : Class<Dynamic>;
    
    
    public static function bundleImage(key : String, c : Class<Dynamic>) : Void
    {
        var o : BitmapData = (c != null) ? ((try cast(Type.createInstance(c, []), Bitmap) catch(e:Dynamic) null).bitmapData) : null;
        if (o != null)
        {
            Reflect.setField(IMAGE_BUNDLE, key, o);
        }
    }
    public static function getEmbedText(path : String) : String
    {
        return Reflect.field(TEXT_BUNDLE, path);
    }
    /**
	 * @param path
	 * @param callback Function (success:Boollean, result:*,event:Event):*
	 * where result is String or Error
	 * @param location "external", "internal"
	 */
    public static function loadText(path : String, callback : Function, location : String = "external") : Void
    {
        var orLocal : Event->Void = function(e : Event) : Void
        {
            if (Lambda.has(TEXT_BUNDLE, path))
            {
                as3hx.Compat.setTimeout(callback, 0, [true, Reflect.field(TEXT_BUNDLE, path), new Event("complete")]);
            }
            else
            {
                as3hx.Compat.setTimeout(callback, 0, [false, null, e]);
            }
        }
        if (path.indexOf("./") == 0)
        {
            path = path.substring(2);
        }
        switch (location)
        {
            case "internal":
                orLocal(new ErrorEvent("error", false, false, 
                        "Internal resource " + path + "not found"));
            case "external":
                var loader : URLLoader = new URLLoader();
                loader.addEventListener(Event.COMPLETE, function(e : Event) : Void
                        {
                            try
                            {
                                LOGGER.info("Loaded external " + path);
                                Reflect.setField(TEXT_BUNDLE, path, loader.data);
                            }
                            catch (e : Error)
                            {
                                LOGGER.warn(e.name + " loading external " + path + ": " + e.message);
                                orLocal(new ErrorEvent("error", false, false, e.message));
                                return;
                            }
                            callback(true, loader.data, e);
                        });
                var req : URLRequest = new URLRequest(path);
                loader.addEventListener(IOErrorEvent.IO_ERROR, function(e : IOErrorEvent) : Void
                        {
                            LOGGER.warn(e.type + " loading external " + path + ": " + Std.string(e));
                            orLocal(e);
                        });
                try
                {
                    loader.load(req);
                }
                catch (e : Error)
                {
                    LOGGER.warn(e.name + " loading external " + path + ": " + e.message);
                    orLocal(new ErrorEvent("error", false, false, e.message));
                }
            default:
                throw new Error("Incorrect location " + location);
        }
    }
    /**
	 * @param path
	 * @param callback Function (success:Boollean, result:BitmapData, e:Event):*
	 * @param location "external", "internal"
	 */
    public static function loadImage(path : String, callback : Function, location : String = "external") : Void
    {
        var orLocal : Event->Void = function(e : Event) : Void
        {
            if (Lambda.has(IMAGE_BUNDLE, path))
            {
                as3hx.Compat.setTimeout(callback, 0, [true, Reflect.field(IMAGE_BUNDLE, path), new Event("complete")]);
            }
            else
            {
                as3hx.Compat.setTimeout(callback, 0, [false, null, e]);
            }
        }
        if (path.indexOf("./") == 0)
        {
            path = path.substring(2);
        }
        switch (location)
        {
            case "internal":
                orLocal(new ErrorEvent("error", false, false, 
                        "Internal resource " + path + "not found"));
            case "external":
                var loader : Loader = new Loader();
                var cli : LoaderInfo = loader.contentLoaderInfo;
                cli.addEventListener(Event.COMPLETE, function(e : Event) : Void
                        {
                            var bmp : Bitmap = null;
                            try
                            {
                                bmp = try cast(cli.content, Bitmap) catch(e:Dynamic) null;
                            }
                            catch (e : Error)
                            {
                                LOGGER.warn(e.name + " loading external " + path + ": " + e.message);
                                orLocal(new ErrorEvent("error", false, false, e.message));
                                return;
                            }
                            if (bmp != null)
                            {
                                LOGGER.info("Loaded external " + path);
                                Reflect.setField(IMAGE_BUNDLE, path, bmp.bitmapData);
                                callback(true, bmp.bitmapData, e);
                            }
                            else
                            {
                                LOGGER.warn("Not found external " + path);
                                callback(false, null, e);
                            }
                        });
                cli.addEventListener(IOErrorEvent.IO_ERROR, function(e : IOErrorEvent) : Void
                        {
                            LOGGER.warn(e.type + " loading external " + path + ": " + Std.string(e));
                            orLocal(e);
                        });
                try
                {
                    loader.load(new URLRequest(path));
                }
                catch (e : Error)
                {
                    LOGGER.warn(e.name + " loading external " + path + ": " + e.message);
                    orLocal(new ErrorEvent("error", false, false, e.message));
                }
            default:
                throw new Error("Incorrect location " + location);
        }
    }
    private static var CoCLoader_static_initializer = {
        bundleText("res/model.xml", BUNDLE_RES_MODEL_XML);
        bundleText("content/coc.xml", BUNDLE_CONTENT_COC_XML);
        bundleText("content/coc/NPC/teladreshops.xml", BUNDLE_CONTENT_COC_NPC_TELADRESHOPS_XML);
        bundleImage("res/icons/items.png", BUNDLE_RES_ICONS_ITEMS_PNG);
        bundleImage("res/icons/ui.png", BUNDLE_RES_ICONS_UI_PNG);
        bundleText("res/icons.xml", BUNDLE_RES_ICONS_XML);
        bundleImage("res/charview/body.png", BUNDLE_RES_CHARVIEW_BODY_PNG);
        bundleImage("res/charview/extra.png", BUNDLE_RES_CHARVIEW_EXTRA_PNG);
        bundleImage("res/charview/hair.png", BUNDLE_RES_CHARVIEW_HAIR_PNG);
        bundleImage("res/charview/head.png", BUNDLE_RES_CHARVIEW_HEAD_PNG);
        bundleImage("res/charview/lewd.png", BUNDLE_RES_CHARVIEW_LEWD_PNG);
        bundleImage("res/charview/tails.png", BUNDLE_RES_CHARVIEW_TAILS_PNG);
        bundleImage("res/charview/wings.png", BUNDLE_RES_CHARVIEW_WINGS_PNG);
        true;
    }

}

