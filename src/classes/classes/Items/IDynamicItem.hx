package classes.items;

import classes.ItemType;

interface IDynamicItem
{
    
    var subtypeId(get, never) : String;    
    var subtype(get, never) : Dynamic;    
    var quality(get, never) : Int;    
    var rarity(get, never) : Int;    
    var curseStatus(get, never) : Int;    
    var identified(get, never) : Bool;    
    var effects(get, never) : Array<Dynamic>;

    /**
	 * Returns fully identified copy of this item (this if it is already identified)
	 */
    function identifiedCopy() : ItemType
    ;
    
    /**
	 * Returns copy of this item with curse flag removed
	 */
    function uncursedCopy() : ItemType
    ;
    
    /**
	 * Returns a copy of this item, modified with options
	 * @param options
	 * @param options.t (optional) New subtype
	 * @param options.c (optional) New curse status
	 * @param options.q (optional) New quality
	 * @param options.r (optional) New rarity
	 * @param options.e (optional) New Enchantment[] array
	 */
    function moddedCopy(options : Dynamic) : ItemType
    ;
    function copyWithEnchantment(e : Enchantment) : ItemType
    ;
    function copyWithoutEnchantment(e : Enchantment) : ItemType
    ;
}

