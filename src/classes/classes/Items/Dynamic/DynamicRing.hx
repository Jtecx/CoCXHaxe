package classes.items.dynamic;

import classes.ItemType;
import classes.items.DynamicItems;
import classes.items.Enchantment;
import classes.items.EnchantmentType;
import classes.items.Equipable;
import classes.items.IDynamicItem;
import classes.items.Jewelry;

class DynamicRing extends Jewelry implements IDynamicItem
{
    public var subtypeId(get, never) : String;
    public var subtype(get, never) : Dynamic;
    public var quality(get, never) : Int;
    public var rarity(get, never) : Int;
    public var curseStatus(get, never) : Int;
    public var identified(get, never) : Bool;
    public var effects(get, never) : Array<Dynamic>;

    public var _subtypeId : String;
    public var _subtype : Dynamic;
    public var _quality : Int;
    public var _rarity : Int;
    public var _curseStatus : Int;
    public var _cursed : Bool;
    public var _identified : Bool;
    public var _effects : Array<Dynamic>;
    public var _effectDesc : Array<Dynamic>;
    
    override private function get_cursed() : Bool
    {
        return _cursed;
    }
    
    private function get_subtypeId() : String
    {
        return _subtypeId;
    }
    
    private function get_subtype() : Dynamic
    {
        return _subtype;
    }
    
    private function get_quality() : Int
    {
        return _quality;
    }
    
    private function get_rarity() : Int
    {
        return _rarity;
    }
    
    private function get_curseStatus() : Int
    {
        return _curseStatus;
    }
    
    private function get_identified() : Bool
    {
        return _identified;
    }
    
    private function get_effects() : Array<Dynamic>
    {
        return _effects;
    }
    
    public function new(id : String, params : Dynamic)
    {
        var parsedParams : Dynamic = DynamicItems.loadCommonDynamicItemParams(params, Subtypes);
        _subtypeId = parsedParams.subtypeId;
        _subtype = parsedParams.subtype || { };
        _quality = parsedParams.quality;
        _rarity = parsedParams.rarity;
        _curseStatus = parsedParams.curseStatus;
        _cursed = parsedParams.cursed;
        _identified = parsedParams.identified;
        _effects = parsedParams.effects;
        var shortName : String = parsedParams.shortName;
        var name : String = parsedParams.name;
        var longName : String = parsedParams.longName;
        var desc : String = parsedParams.desc;
        _effectDesc = parsedParams.effectDesc;
        var value : Float = parsedParams.value;
        var buffs : Dynamic = parsedParams.buffs;
        var perks : Array<Dynamic> = (subtype.perks || []).slice();
        var tags : Array<Dynamic> = subtype.tags || [];
        var effectId : Int = subtype.effectId;
        var effectPower : Float = subtype.effectPower;
        var itemEffects : Array<Dynamic> = subtype.effects || [];
        var qitemEffects : Array<Dynamic> = subtype.qeffects || [];
        if (parsedParams.error)
        {
            trace("[ERROR] Failed to parse " + id + " with error " + parsedParams.error);
            name = "ERROR " + name;
            shortName = "ERROR " + shortName;
            longName = "ERROR " + longName;
            desc = "INVALID ITEM:\n" + parsedParams.error + "\n" + desc;
        }
        
        effectPower = Math.floor(effectPower * (1.0 + quality * subtype.qpower));
        
        super(
                id, 
                shortName, 
                name, 
                longName, 
                effectId, 
                effectPower, 
                Math.max(1, value), 
                desc, 
                "", 
                perks.join(", ")
        );
        
        DynamicItems.postConstruct(this, tags, buffs, itemEffects, qitemEffects, quality);
    }
    
    override public function effectDescriptionParts() : Array<Dynamic>
    {
        return super.effectDescriptionParts().concat(_effectDesc);
    }
    
    override private function get_buttonColor() : String
    {
        return DynamicItems.itemButtonColor(this);
    }
    
    override public function getEnchantments() : Array<Dynamic>
    {
        return effects;
    }
    
    override public function hasEnchantment(type : EnchantmentType) : Bool
    {
        return DynamicItems.itemHasEnchantment(this, type);
    }
    
    override public function enchantmentPower(type : EnchantmentType) : Float
    {
        return DynamicItems.itemEnchantmentPower(this, type);
    }
    
    override public function enchantmentOfType(type : EnchantmentType) : Enchantment
    {
        return DynamicItems.itemEnchantmentOfType(this, type);
    }
    
    private var _identifiedCopy : ItemType;
    
    /**
	 * Returns fully identified copy of this weapon (this if it is already identified)
	 */
    public function identifiedCopy() : ItemType
    {
        if (identified)
        {
            return this;
        }
        if (_identifiedCopy == null)
        {
            _identifiedCopy = DynamicItems.identifiedCopy(this);
        }
        return _identifiedCopy;
    }
    
    public function uncursedCopy() : ItemType
    {
        return DynamicItems.uncursedCopy(this);
    }
    
    public function moddedCopy(options : Dynamic) : ItemType
    {
        return DynamicItems.moddedCopy(this, options);
    }
    
    public function copyWithEnchantment(e : Enchantment) : ItemType
    {
        return DynamicItems.copyWithEnchantment(this, e);
    }
    
    public function copyWithoutEnchantment(e : Enchantment) : ItemType
    {
        return DynamicItems.copyWithoutEnchantment(this, e);
    }
    
    override public function equipText() : Void
    {
        DynamicItems.equipText(this);
    }
    
    override public function beforeEquip(doOutput : Bool, slot : Int) : Equipable
    {
        if (!identified)
        {
            return (try cast(identifiedCopy(), Equipable) catch(e:Dynamic) null).beforeEquip(doOutput, slot);
        }
        return super.beforeEquip(doOutput, slot);
    }
    
    override public function afterEquip(doOutput : Bool, slot : Int) : Void
    {
        super.afterEquip(doOutput, slot);
        for (e in effects)
        {
            e.onEquip(game.player, this);
        }
    }
    override public function afterUnequip(doOutput : Bool, slot : Int) : Void
    {
        super.afterUnequip(doOutput, slot);
        for (e in effects)
        {
            e.onUnequip(game.player, this);
        }
    }
    
    /**
	 * Key: subtype id
	 * Values:
	 * - chance: weight when generating random item of this category, default 1
	 * - name: displayed name
	 * - shortName: for buttons. keep it VERY short, 4-7 chars
	 * - TODO @aimozg longName?
	 * - desc: description, can contain templates
	 * - (optional) tags: Array of item tags (ItemTag.XXXX)
	 * - (optional) quality: force quality
	 * - value: Base cost in gems
	 * - effectId: Ring effect id (RINGEFF_XXXX)
	 * - effectPower: Ring effect magnitude
	 * - qpower: Ring effect magnitude per quality level (0.25 = +25% per +1)
	 */
    public static var Subtypes : Dynamic = {
            ring : {
                chance : 10,
                name : "ring",
                shortName : "Ring",
                desc : "A plain-looking ring.",
                quality : 0,
                value : 15,
                effectId : 0,
                effectPower : 0,
                qpower : 0
            },
            crimstone ring : {
                chance : 1,
                name : "crimstone ring",
                shortName : "Crimst.Ring",
                desc : "This ring is topped with crimstone. It is said that this will help to keep your desires burning.",
                value : 1000,
                effectId : RINGEFF_MINLUST,
                effectPower : 10,
                qpower : 0.25
            },
            icestone ring : {
                chance : 1,
                name : "icestone ring",
                shortName : "Icestn.Ring",
                desc : "This ring is topped with icestone. It is said that this will counter ever-burning desires.",
                value : 1000,
                effectId : RINGEFF_MINLUST,
                effectPower : -10,
                qpower : 0.25
            }
        };
}

