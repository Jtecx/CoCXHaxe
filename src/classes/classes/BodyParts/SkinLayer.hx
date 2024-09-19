/**
 * Created by aimozg on 25.04.2017.
 */
package classes.bodyParts;

import classes.Appearance;

class SkinLayer extends BodyPart
{
    public var material(get, never) : Int;
    public var color(get, set) : String;
    public var color1(get, set) : String;
    public var color2(get, set) : String;
    public var desc(get, set) : String;
    public var descRaw(get, set) : String;
    public var adj(get, set) : String;

    public var pattern : Int = Skin.PATTERN_NONE;
    private var _desc : String = "";
    private var _adj : String = "";
    private var skin : Skin;  // Reference to parent  
    
    private function get_material() : Int
    {
        return Skin.SkinTypes[type].material;
    }
    private function get_color() : String
    {
        return creature.bodyMaterials[material].color;
    }
    private function set_color(value : String) : String
    {
        creature.bodyMaterials[material].color = value;
        return value;
    }
    private function get_color1() : String
    {
        return creature.bodyMaterials[material].color1;
    }
    private function set_color1(value : String) : String
    {
        creature.bodyMaterials[material].color1 = value;
        return value;
    }
    private function get_color2() : String
    {
        return creature.bodyMaterials[material].color2;
    }
    private function set_color2(value : String) : String
    {
        creature.bodyMaterials[material].color2 = value;
        return value;
    }
    override public function hasMaterial(type : Int) : Bool
    {
        return material == type;
    }
    override public function setProps(p : Dynamic) : Void
    {
        super.setProps(p);
        if (Lambda.has(p, "color"))
        {
            color = p.color;
        }
        if (Lambda.has(p, "color1"))
        {
            color1 = p.color1;
        }
        if (Lambda.has(p, "color2"))
        {
            color2 = p.color2;
        }
    }
    
    public function defaultDesc() : String
    //if it throws an error hear, it means Svalkash fucked up again.
    {
        
        // Add the check like "if (Skin.SkinTypes[type])" then to check for undefined
        return Skin.SkinTypes[type].name || "skin";
    }
    public function defaultAdj() : String
    {
        return Skin.SkinTypes[type].adj || "";
    }
    private function get_desc() : String
    {
        return _desc || defaultDesc();
    }
    private function set_desc(value : String) : String
    {
        _desc = value;
        return value;
    }
    private function get_descRaw() : String
    {
        return _desc;
    }
    private function set_descRaw(value : String) : String
    {
        _desc = value;
        return value;
    }
    private function get_adj() : String
    {
        return _adj;
    }
    private function set_adj(value : String) : String
    {
        _adj = value;
        return value;
    }
    override private function set_type(value : Int) : Int
    {
        if (type != value)
        {
            super.type = value;
            _desc = "";
            pattern = Skin.PATTERN_NONE;
            if (_adj == null)
            {
                _adj = defaultAdj();
            }
        }
        return value;
    }
    /**
	 * Returns `s` (default "is") if the skin main layer noun is singular (skin,fur,chitin)
	 * and `p` (default "are") if plural (scales)
	 */
    public function isAre(s : String = "is", p : String = "are") : String
    {
        return (Skin.SkinTypes[type].plural) ? p : s;
    }
    override public function restore(keepColor : Bool = true) : Void
    {
        super.restore(keepColor);
        adj = "";
        desc = "";
    }
    public function new(skin : Skin)
    {
        super(skin.creature, ["adj", "desc", "pattern"]);
        this.skin = skin;
    }
    public function describe(noAdj : Bool = false, noColor : Bool = false) : String
    {
        var c_adj : String = (noAdj) ? "" : adj;
        var c_color : String = (noColor) ? "" : color;
        return c_adj + ((c_adj != null && c_color != null) ? ", " : "") + c_color + ((c_color != null || c_adj != null) ? " " : "") + desc;
    }
    
    override public function descriptionFull() : String
    {
        return describe();
    }
    
    override public function loadFromObject(o : Dynamic, ignoreErrors : Bool) : Void
    {
        super.loadFromObject(o, ignoreErrors);
    }
}

