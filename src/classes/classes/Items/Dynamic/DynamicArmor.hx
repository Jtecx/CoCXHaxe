package classes.items.dynamic;

import classes.ItemType;
import classes.items.Armor;
import classes.items.dynamic.effects.SimpleRaceEnchantment;
import classes.items.DynamicItems;
import classes.items.Enchantment;
import classes.items.EnchantmentLib;
import classes.items.EnchantmentType;
import classes.items.Equipable;
import classes.items.IDynamicItem;
import classes.items.IELib;
import classes.items.ItemEffect;
import classes.Race;

class DynamicArmor extends Armor implements IDynamicItem
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
        var type : String = subtype.type;
        var tags : Array<Dynamic> = subtype.tags || [];
        var def : Float = subtype.def;
        var mdef : Float = subtype.mdef;
        var qdef : Float = numberOr(subtype.qdef, 0);
        var bulge : Bool = subtype.bulge;
        var undergarment : Bool = valueOr(subtype.undergarment, true);
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
        
        def *= (1.0 + quality * qdef);
        mdef *= (1.0 + quality * qdef);
        
        super(
                id, 
                shortName, 
                name, 
                longName, 
                def, 
                mdef, 
                value, 
                desc, 
                type, 
                bulge, 
                undergarment
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
    
    override private function get_def() : Float
    {
        var def : Float = super.def;
        var ie : ItemEffect = findEffect(IELib.DefenseMult_RaceTier);
        if (ie != null)
        {
            def *= 1 + ie.power * game.player.racialTier(try cast(ie.value1, Race) catch(e:Dynamic) null) / 100;
        }
        return def;
    }
    
    override public function equipText() : Void
    {
        DynamicItems.equipText(this);
    }
    override public function beforeEquip(doOutput : Bool, slot : Int) : Equipable
    {
        super.beforeEquip(doOutput, slot);
        if (!identified)
        {
            return (try cast(identifiedCopy(), Equipable) catch(e:Dynamic) null).beforeEquip(doOutput, slot);
        }
        return this;
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
	 * - (optional) type: Armor type (AT_XXXX)
	 * - (optional) quality: force quality
	 * - def: Base defense
	 * - mdef: Base magic defense
	 * - qdef: Defense-per-quality (0.25 = +25% per +1 qualiity)
	 * - value: Base cost in gems
	 * - bulge: Can be modded by Exgartuan (ugh). Default false
	 * - undergarment: Can be worn with undergarment. Default true
	 */
    public static var Subtypes : Dynamic = {
            clothes : {
                chance : 1,
                name : "comfortable clothes",
                shortName : "clothes",
                desc : "These loose fitting and comfortable clothes allow you to move freely while protecting you from the elements.",
                type : AP_LIGHT,
                def : 0,
                mdef : 0,
                qdef : 0.25,
                value : 10
            },
            fullchain : {
                chance : 1,
                name : "full-body chainmail",
                shortName : "full chm",
                desc : "This full suit of chainmail armor covers its wearer from head to toe in protective steel rings.",
                type : AP_MEDIUM,
                def : 8,
                mdef : 0,
                qdef : 0.25,
                value : 320
            },
            fullplate : {
                chance : 0.5,
                name : "full platemail",
                shortName : "full plm",
                desc : "A highly protective suit of steel platemail.  It would be hard to find better physical protection than this.",
                type : AP_HEAVY,
                def : 21,
                mdef : 0,
                qdef : 0.25,
                value : 1260
            },
            heavyleather : {
                chance : 1,
                name : "heavy leather armor",
                shortName : "hv lth",
                desc : "Layers of cured animal hide to offer greater protection from damage.",
                type : AP_HEAVY,
                def : 10,
                mdef : 0,
                qdef : 0.25,
                value : 375
            },
            leather : {
                chance : 1,
                name : "leather armor",
                shortName : "lth arm",
                desc : "This is a suit of well-made leather armor.  It looks fairly rugged.",
                type : AP_LIGHT,
                def : 5,
                mdef : 0,
                qdef : 0.25,
                value : 100
            },
            samurai : {
                chance : 0.5,
                name : "samurai armor",
                shortName : "samu arm",
                desc : "This suit of armor is originally worn by the Samurai, the warriors from the far East.",
                type : AP_HEAVY,
                def : 18,
                mdef : 0,
                qdef : 0.25,
                value : 300
            },
            scalemail : {
                chance : 1,
                name : "scale-mail armor",
                shortName : "sc mail",
                desc : "This suit of scale-mail covers the entire body with layered steel scales, providing flexibility and protection.",
                type : AP_HEAVY,
                def : 12,
                mdef : 0,
                qdef : 0.25,
                value : 820
            },
            studdedleather : {
                chance : 1,
                name : "cured leather armor",
                shortName : "cur lth",
                desc : "A cured leather armor, it’s tough and can offer some modest protection while also allowing freedom of movement.",
                type : AP_LIGHT,
                def : 8,
                mdef : 0,
                qdef : 0.25,
                value : 250
            }
        };
}

