/**
 * Coded by aimozg on 28.07.2017.
 */
package coc.view.charview;

import coc.view.Color;

class Palette
{
    public var paletteProps(get, never) : Array<Dynamic>;
    public var keyColorsList(get, never) : Array<Dynamic>;
    public var lookupObjects(get, never) : Dynamic;

    private var _keyColorsList : Array<Dynamic> = [];
    private var _paletteProps : Array<Dynamic> = [];
    private var _lookupObjects : Dynamic = { };  // { dict_name => { color_name => color_string } }  
    
    public function new()
    {
    }
    public function addKeyColor(src : Int, base : String, tf : String) : Void
    {
        this._keyColorsList.push(new KeyColor(src, base, tf));
    }
    public function addPaletteProperty(name : String, expr : String, defaultt : Int, lookupNames : Array<Dynamic>) : Void
    {
        this._paletteProps.push(new PaletteProperty(name, expr, defaultt, lookupNames));
    }
    public function addLookups(name : String, lookup : Dynamic) : Void
    {
        Reflect.setField(_lookupObjects, name, lookup);
    }
    public function lookupColor(propname : String, colorname : String) : Int
    {
        for (property in _paletteProps)
        {
            if (property.name == propname)
            {
                return property.lookup(colorname, _lookupObjects);
            }
        }
        return 0xfff000e0;
    }
    // { key_color -> actual_color }
    public function calcKeyColors(character : Dynamic) : Dynamic
    {
        var props : Dynamic = { };
        for (property in _paletteProps)
        {
            Reflect.setField(props, Std.string(property.name), property.colorValue(character, _lookupObjects));
        }
        var keyColorsMap : Dynamic = { };
        for (color in _keyColorsList)
        {
            Reflect.setField(keyColorsMap, Std.string(color.src), color.transform(Reflect.field(props, Std.string(color.base))));
        }
        return keyColorsMap;
    }
    private function get_paletteProps() : Array<Dynamic>
    {
        return _paletteProps;
    }
    private function get_keyColorsList() : Array<Dynamic>
    {
        return _keyColorsList;
    }
    private function get_lookupObjects() : Dynamic
    {
        return _lookupObjects;
    }
}



