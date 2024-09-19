package classes.items;

import flash.errors.Error;
import classes.CoC;
import classes.EngineCore;
import classes.ItemTemplate;
import classes.ItemType;
import classes.items.dynamic.DynamicArmor;
import classes.items.dynamic.DynamicRing;
import classes.items.dynamic.DynamicWeapon;

/**
 * Dynamic Item Utilities
 */
class DynamicItems extends ItemConstants
{
    
    //////////////////////
    // Random generation Tables
    // (weights do not have to sum to 100)
    /////////////////////
    
    public static var RARITY_CHANCES_DEFAULT : Array<Dynamic> = [
        // weights sum to 100 so chances are in %
        [30, RARITY_COMMON], 
        [40, RARITY_MAGICAL], 
        [20, RARITY_RARE], 
        [8, RARITY_LEGENDARY], 
        [2, RARITY_DIVINE]
    ];
    
    public static var RARITY_CHANCES_LESSER : Array<Dynamic> = [
        // weights sum to 100 so chances are in %
        [75, RARITY_COMMON], 
        [20, RARITY_MAGICAL], 
        [5, RARITY_RARE]
    ];
    
    public static var RARITY_CHANCES_MINOR_LOW : Array<Dynamic> = [
        // weights sum to 100 so chances are in %
        [40, RARITY_COMMON], 
        [40, RARITY_MAGICAL], 
        [20, RARITY_RARE]
    ];
    
    public static var RARITY_CHANCES_MINOR_HIGH : Array<Dynamic> = [
        // weights sum to 100 so chances are in %
        [20, RARITY_COMMON], 
        [30, RARITY_MAGICAL], 
        [50, RARITY_RARE]
    ];
    
    /**
	 * Weighted random table for quality rolls at specific NG+ level
	 */
    public static function QUALITY_CHANCES(ngLevel : Int) : Array<Dynamic>
    {
        var table : Array<Dynamic> = [[1, +0]];
        var maxQuality : Int = as3hx.Compat.parseInt(ngLevel * 2);
        var chance : Float = 1;
        for (q in 1...maxQuality + 1)
        {
            chance /= 4;
            table.push([chance, q]);
        }
        return table;
    }
    
    public static var CURSE_CHANCES_FOR_NEGATIVE : Array<Dynamic> = [
        [30, CS_HIDDEN_CURSED], 
        [70, CS_HIDDEN_UNCURSED]
    ];
    public static var CURSE_CHANCES_DEFAULT : Array<Dynamic> = [
        [10, CS_HIDDEN_CURSED], 
        [90, CS_HIDDEN_UNCURSED]
    ];
    
    public static var ITEM_CATEGORY_CHANCES_DEFAULT : Array<Dynamic> = [
        [5, CATEGORY_WEAPON_MELEE], 
        //		[1, CATEGORY_WEAPON_RANGED],
        //		[1, CATEGORY_SHIELD],
        [5, CATEGORY_ARMOR], 
        //		[1, CATEGORY_UNDERGARMENT],
        //		[1, CATEGORY_NECKLACE],
        //		[1, CATEGORY_JEWELRY_HEAD],
        [1, CATEGORY_JEWELRY_RING]
    ];
    
    /**
	 * @param options.level Level (for picking enchantments), default - player level
	 * @param options.ng New Game+ factor, default - current NG factor
	 * @param options.rarity Rarity, const or weighted random table
	 * @param options.quality Quality, const or weighted random table
	 * @param options.category Item category (see ItemType.CATEGORY_XXXX) or weighted random table
	 * @param options.subtype Subtype within the category, or weighted random spetable
	 * @param options.cursed Curse status or weighted random table
	 * @param options.identified Effects are identified (defualt false)
	 * @return
	 */
    public static function randomItem(options : Dynamic = null) : ItemType
    {
        var ng : Int = valueOr(options.ng, CoC.instance.newGamePlusFactor());
        var level : Int = valueOr(options.level, CoC.instance.player.level);
        options = extend({
                            rarity : RARITY_CHANCES_DEFAULT,
                            quality : cast((ng), QUALITY_CHANCES),
                            category : ITEM_CATEGORY_CHANCES_DEFAULT,
                            identified : false
                        }, options);
        
        var rarity : Int = weightedRandom(options.rarity);
        var quality : Int = weightedRandom(options.quality);
        var category : String = weightedRandom(options.category);
        var identified : Bool = weightedRandom(options.identified);
        trace("Generating random " + Rarities[rarity].name + " q=" + quality + " " + category + "...");
        var subtype : String;
        
        var randomSubtype : Dynamic->String = function(subtypes : Dynamic) : String
        {
            var items : Array<Dynamic> = [];
            for (subtype in Reflect.fields(subtypes))
            {
                items.push([numberOr(Reflect.field(subtypes, subtype).chance, 1), subtype]);
            }
            return weightedRandom(items);
        }
        
        var template : ItemTemplate;
        var subtypeLib : Dynamic;
        switch (category)
        {
            case CATEGORY_WEAPON_MELEE:
                template = ItemTemplateLib.instance.TDynamicWeapon;
                subtypeLib = DynamicWeapon.Subtypes;
            case CATEGORY_ARMOR:
                template = ItemTemplateLib.instance.TDynamicArmor;
                subtypeLib = DynamicArmor.Subtypes;
            case CATEGORY_JEWELRY_RING:
                template = ItemTemplateLib.instance.TDynamicRing;
                subtypeLib = DynamicRing.Subtypes;
            default:
                throw new Error("Unsupported item category " + category);
        }
        if (options.subtype)
        {
            subtype = weightedRandom(options.subtype);
        }
        else
        {
            subtype = randomSubtype(subtypeLib);
        }
        trace("  subtype=" + subtype);
        var subtypeObj : Dynamic = Reflect.field(subtypeLib, subtype);
        if (subtype == null || subtypeObj == null)
        {
            throw new Error("Failed to pick subtype for " + category);
        }
        if (Lambda.has(subtypeObj, "quality"))
        {
            quality = subtypeObj.quality;
        }
        
        // encoded enchantments [identified, type, ...]
        var enchantments : Array<Dynamic> = [];
        var hasNegative : Bool = false;
        var hasCursed : Bool = false;
        
        var addEnchantment : Int->Int->Void = function(rarity : Int, tries : Int = 5) : Void
        {
            var e : Enchantment = EnchantmentLib.instance.randomEnchantment(category, rarity, level, {
                        identified : identified
                    });
            if (e != null)
            
            // Reroll max 5 times if found a duplicate{
                
                for (e2 in enchantments)
                {
                    if (Reflect.field(e2, Std.string(1)) == e.type.id)
                    {
                        if (tries > 0)
                        {
                            trace("  " + e.description + " (rerolling)");
                            addEnchantment(rarity, tries - 1);
                        }
                        else
                        {
                            trace("  " + e.description + " (reroll limit reached)");
                        }
                        return;
                    }
                }
                trace("  " + e.description);
                enchantments.push(e.encode());
                if (e.curse)
                {
                    hasCursed = true;
                }
            }
            else
            {
                trace("  (failed to generate magical effect)");
            }
        }
        
        switch (rarity)
        {
            case RARITY_DIVINE:
                addEnchantment(RARITY_MAGICAL);
                addEnchantment(RARITY_MAGICAL);
                addEnchantment(RARITY_LEGENDARY);
                addEnchantment(RARITY_DIVINE);
            case RARITY_LEGENDARY:
                addEnchantment(RARITY_MAGICAL);
                addEnchantment(RARITY_MAGICAL);
                addEnchantment(RARITY_LEGENDARY);
            case RARITY_RARE:
                addEnchantment(RARITY_MAGICAL);
                addEnchantment(RARITY_MAGICAL);
            case RARITY_MAGICAL:
                addEnchantment(RARITY_MAGICAL);
            case RARITY_COMMON:
            default:
        }
        
        var cursed : Int;
        if (hasCursed)
        {
            cursed = CS_HIDDEN_CURSED;
        }
        else if (Lambda.has(options, "cursed"))
        {
            cursed = weightedRandom(options.cursed);
        }
        else if (hasNegative)
        {
            cursed = weightedRandom(CURSE_CHANCES_FOR_NEGATIVE);
        }
        else
        {
            cursed = weightedRandom(CURSE_CHANCES_DEFAULT);
        }
        if (identified)
        {
            cursed = cursed | CSBITMASK_KNOWN;
        }  // set known flag  
        trace("  cursed=" + cursed);
        
        var itemType : ItemType = template.createItem({
                    t : subtype,
                    c : cursed,
                    q : quality,
                    r : rarity,
                    e : enchantments
                });
        trace("Generated '" + itemType.longName + "' " + itemType.id);
        return itemType;
    }
    
    /////////////////////
    // Utilities
    /////////////////////
    
    /**
	 * Load and process dynamic item params, generate name and desciption.
	 * @param params Encoded dynamic item params
	 * @param subtypes A subtype dictionary
	 * @return {{
	 *     subtypeId: String,
	 *     subtype: Object,
	 *     quality: int,
	 *     rarity: int,
	 *     curseStatus: int,
	 *     cursed: Boolean,
	 *     curseKnown: Boolean,
	 *     identified: Boolean,
	 *     effects: Enchantment[],
	 *     shortName: String,
	 *     name: String,
	 *     longName: String,
	 *     desc: String,
	 *     effectDesc: Array,
	 *     value: Number,
	 *     buffs: Object,
	 *     buffsStack: Boolean,
	 *     error: String
	 * }}
	 */
    public static function loadCommonDynamicItemParams(params : Dynamic, subtypes : Dynamic) : Dynamic
    {
        var o : Array<Dynamic>;
        var e : Enchantment;
        
        if (!(Lambda.has(params, "t") && Lambda.has(params, "q") && Lambda.has(params, "r") && Lambda.has(params, "c") && Lambda.has(params, "e")))
        {
            return {
                error : "Missing param key"
            };
        }
        // Pull out params
        var subtypeId : String = Reflect.field(params, "t");
        var quality : Int = Reflect.field(params, "q");
        var rarity : Int = Reflect.field(params, "r");
        var curseStatus : Int = Reflect.field(params, "c");
        var enchData : Array<Dynamic> = Reflect.field(params, "e");
        if (rarity < RARITY_COMMON || rarity > RARITY_DIVINE || curseStatus < 0 || curseStatus > 3 || enchData == null || subtypeId == null)
        {
            return {
                error : "Invalid params"
            };
        }
        
        // Compute props
        var cursed : Bool = !!(curseStatus & CSBITMASK_CURSED);
        var curseKnown : Bool = !!(curseStatus & CSBITMASK_KNOWN);
        var identified : Bool = curseKnown;
        for (o in enchData)
        {
            if (o == null || o.length < 2)
            {
                return {
                    error : "Invalid enchantment"
                };
            }
            if (Reflect.field(o, Std.string(1)) == null)
            {
                continue;
            }
            if (Reflect.field(o, Std.string(0)) == null)
            {
                identified = false;
                break;
            }
        }
        var effects : Array<Dynamic> = [];
        for (o in enchData)
        {
            if (Reflect.field(o, Std.string(1)) == null)
            {
                continue;
            }
            try
            {
                e = EnchantmentLib.decode(o);
            }
            catch (error : Error)
            {
                trace(error.getStackTrace());
                return {
                    error : error.message + "\n" + error.getStackTrace()
                };
            }
            if (e == null)
            {
                return {
                    error : "Invalid enchantment type " + Reflect.field(o, Std.string(1))
                };
            }
            effects.push(e);
        }
        
        // Pull stuff from the subtype and generate name and description
        var subtype : Dynamic = Reflect.field(subtypes, subtypeId);
        if (subtype == null)
        {
            return {
                error : "Invalid subtype"
            };
        }
        var shortName : String = subtype.shortName;
        var name : String = subtype.name;
        var desc : String = subtype.desc;
        var effectDesc : Array<Dynamic> = [];
        var value : Float = subtype.value;
        var rname : String = Rarities[rarity].name;
        var qname : String = ((quality < 0)) ? "" + quality : "+" + quality;
        var longName : String;
        
        // value = (base_value * rarity + sum of effects' add_value)
        //         * product of effects' mul_value
        // If quality > 0, add 20%*quality
        // If quality < 0, subtract 10%*quality but no less than 50%
        var valueMul : Float = 1.0;
        value *= Rarities[rarity].valueMul;
        if (quality > 0)
        {
            valueMul *= quality * 0.2;
        }
        if (quality < 0)
        {
            valueMul *= Math.max(0.5, quality * 0.1);
        }
        
        // Description:
        // 		Rarity: Divine
        // 		Quality: +15
        // 		This item is cursed!
        // 		+30% Int
        // 		(Unknown effet)
        // 		+10% EXP gain
        // 		(Unknown effect)
        // Names:
        // 		cursed Taoth's Vulpine sword of kitsune legacy +15
        // 		(?) legendary sword -5
        // Button names:
        // 		!swd TaoVlKL
        // 		?swd ??
        if (!curseKnown)
        {
            effectDesc.push([0, "Curse: Unknown."]);
        }
        else if (cursed)
        {
            effectDesc.push([0, "<b>Cursed!</b>"]);
        }
        effectDesc.push([40, "Rarity: " + capitalizeFirstLetter(rname)]);
        if (subtype.quality != 0)
        {
            effectDesc.push([45, "Quality: " + qname]);
        }
        var hasUnknownEffects : Bool = false;
        var i : Int = 0;
        for (e in effects)
        {
            if (e.identified)
            {
                if (!e.type.hideDescription(e))
                {
                    var description : String = e.description;
                    if (description != null)
                    {
                        effectDesc.push([80 + i, "Effect: " + description]);
                    }
                }
                value += e.valueAdd;
                valueMul *= e.valueMul;
            }
            else
            {
                hasUnknownEffects = true;
                effectDesc.push([80 + i, "Effect: (Unknown effect)"]);
            }
            i++;
        }
        if (identified)
        {
            var me1 : Enchantment = null;
            var me2 : Enchantment = null;
            var prefix : String = "";
            var suffix : String = "";
            var divinePrefix : String = "";
            if (effects.length > 0)
            {
                shortName += " ";
            }
            for (e in effects)
            {
                shortName += e.shortSuffix;
                var _sw0_ = (e.rarity);                

                switch (_sw0_)
                {
                    case RARITY_DIVINE:
                        divinePrefix += e.prefix;
                    case RARITY_LEGENDARY:
                    case RARITY_MAGICAL:
                        if (me1 == null)
                        {
                            me1 = e;
                        }
                        else if (me2 == null)
                        {
                            me2 = e;
                        }
                }
            }
            if (me1 != null && me2 != null)
            
            // 2 magical effects: use prefix and suffix{
                
                if (me1.prefix && me2.suffix)
                {
                    prefix = me1.prefix;
                    suffix = me2.suffix;
                }
                else
                {
                    prefix = me2.prefix;
                    suffix = me1.suffix;
                }
            }
            else if (me1 != null)
            
            // 1 magical effect: use prefix (preferred) or suffix{
                
                if (me1.prefix)
                {
                    prefix = me1.prefix;
                }
                else
                {
                    suffix = me1.suffix;
                }
            }
            name = divinePrefix + prefix + name + suffix;
        }
        else if (hasUnknownEffects)
        {
            if (rarity != RARITY_COMMON)
            {
                name = rname + " " + name;
            }
            name = "unidentified " + name;
            shortName += " ??";
        }
        // common name parts
        longName = name;  // name - long name without (?) or +X  
        if (quality != 0)
        {
            longName = longName + " " + qname;
        }
        if (!curseKnown)
        {
            longName = "(?) " + longName;
            shortName = "?" + shortName;
        }
        else if (cursed)
        {
            longName = "cursed " + longName;
            name = "cursed " + name;
            shortName = "!" + shortName;
        }
        
        // buffs
        var buffs : Dynamic = null;
        
        return {
            subtypeId : subtypeId,
            subtype : subtype,
            quality : quality,
            rarity : rarity,
            curseStatus : curseStatus,
            cursed : cursed,
            curseKnown : curseKnown,
            identified : identified,
            effects : effects,
            shortName : shortName,
            name : name,
            longName : longName,
            desc : desc,
            effectDesc : effectDesc,
            value : Math.round(value * valueMul),
            buffs : buffs,
            error : ""
        };
    }
    
    /**
	 * Finish initialization of a DynamicItem by assigning its tags, buffs, itemeffects, and invoking enchantments' onAdd() callbacks.
	 */
    public static function postConstruct(item : Equipable, tags : Array<Dynamic>, buffs : Dynamic, itemEffects : Array<Dynamic>, qitemEffects : Array<Dynamic>, quality : Float) : Void
    {
        item.stackSize = 1;
        item.pearlStackSize = 1;
        item.withTagsV(tags);
        item.withBuffs(buffs);
        for (iedef in itemEffects)
        {
            var type : ItemEffectType = try cast(Reflect.field(iedef, Std.string(0)), ItemEffectType) catch(e:Dynamic) null;
            var power : Float = as3hx.Compat.parseFloat(Reflect.field(iedef, Std.string(1)));
            var value1 : Dynamic = Reflect.field(iedef, Std.string(2));
            var value2 : Dynamic = Reflect.field(iedef, Std.string(3));
            var value3 : Dynamic = Reflect.field(iedef, Std.string(4));
            var value4 : Dynamic = Reflect.field(iedef, Std.string(5));
            for (qiedef in qitemEffects)
            {
                if (Reflect.field(qiedef, Std.string(0)) == type && Reflect.field(qiedef, Std.string(2)) == value1 && Reflect.field(qiedef, Std.string(3)) == value2 && Reflect.field(qiedef, Std.string(4)) == value3 && Reflect.field(qiedef, Std.string(5)) == value4)
                {
                    power += Reflect.field(qiedef, Std.string(1)) * quality;
                    break;
                }
            }
            item.withEffect(type, power, value1, value2, value3, value4);
        }
        for (enchantment/* AS3HX WARNING could not determine type for var: enchantment exp: ECall(EField(EIdent(item),getEnchantments),[]) type: null */ in item.getEnchantments())
        {
            if (enchantment.identified)
            {
                enchantment.type.onAdd(enchantment, item);
            }
        }
    }
    
    public static function itemHasEnchantment(item : ItemType, type : EnchantmentType) : Bool
    {
        return itemEnchantmentOfType(item, type) != null;
    }
    
    public static function itemEnchantmentPower(item : ItemType, type : EnchantmentType) : Float
    {
        var e : Enchantment = itemEnchantmentOfType(item, type);
        return (e != null) ? e.power : 0;
    }
    
    public static function itemEnchantmentOfType(item : ItemType, type : EnchantmentType) : Enchantment
    {
        for (e/* AS3HX WARNING could not determine type for var: e exp: ECall(EField(EIdent(item),getEnchantments),[]) type: null */ in item.getEnchantments())
        {
            if (e.type == type)
            {
                return e;
            }
        }
        return null;
    }
    
    public static function itemButtonColor(item : IDynamicItem) : String
    {
        if (item.curseStatus == CS_KNOWN_CURSED)
        {
            return BTNCOLOR_CURSED;
        }
        return Rarities[item.rarity].buttonColor;
    }
    
    public static function encodeEnchantments(effects : Array<Dynamic>) : Array<Dynamic>
    {
        var e : Array<Dynamic> = [];
        for (eff in effects)
        {
            e.push(eff.encode());
        }
        return e;
    }
    
    public static function identifiedCopy(item : ItemType) : ItemType
    {
        var params : Dynamic = item.templateParams();
        params.c = params.c | CSBITMASK_KNOWN;  // set known flag  
        for (effect/* AS3HX WARNING could not determine type for var: effect exp: EField(EIdent(params),e) type: null */ in params.e)
        {
            effect[0] = 1;
        }
        var id : String = ItemType.dynamicItemId(item.templateId(), params);
        return ItemType.lookupItem(id);
    }
    
    public static function uncursedCopy(item : ItemType) : ItemType
    {
        if (!item.cursed)
        {
            return item;
        }
        var params : Dynamic = item.templateParams();
        params.c = CS_KNOWN_UNCURSED;
        var id : String = ItemType.dynamicItemId(item.templateId(), params);
        return ItemType.lookupItem(id);
    }
    
    public static function moddedCopy(item : ItemType, options : Dynamic) : ItemType
    {
        var idi : IDynamicItem = try cast(item, IDynamicItem) catch(e:Dynamic) null;
        return createItem(ItemTemplate.lookupTemplate(item.templateId()), 
                valueOr(options.t, idi.subtypeId), 
                valueOr(options.r, idi.rarity), 
                valueOr(options.q, idi.quality), 
                valueOr(options.c, idi.curseStatus), 
                valueOr(options.e, idi.effects)
        );
    }
    
    public static function copyWithEnchantment(item : ItemType, e : Enchantment) : ItemType
    {
        return moddedCopy(item, {
                    e : (try cast(item, IDynamicItem) catch(e:Dynamic) null).effects.concat([e])
                });
    }
    
    public static function copyWithoutEnchantment(item : ItemType, e : Enchantment) : ItemType
    {
        var effects : Array<Dynamic> = (try cast(item, IDynamicItem) catch(e:Dynamic) null).effects.slice();
        if (Lambda.indexOf(effects, e) == -1)
        {
            return item;
        }
        effects.splice(Lambda.indexOf(effects, e), 1);
        return moddedCopy(item, {
                    e : effects
                });
    }
    
    public static function equipText(item : ItemType) : Void
    {
        EngineCore.outputText("You equip " + item.longName + ".  ");
        if (item.cursed)
        {
            if ((try cast(item, IDynamicItem) catch(e:Dynamic) null).curseStatus == CS_HIDDEN_CURSED)
            {
                if (EngineCore.silly())
                {
                    EngineCore.outputText("A horrible chill runs down your spine - <b>this item is cursed!</b> ");
                }
                else if (Std.is(item, Weapon))
                {
                    EngineCore.outputText("You feel a nasty zap in your hand and realize you cannot let go of the weapon - <b>it is cursed!</b> ");
                }
                else if (Std.is(item, Armor))
                {
                    EngineCore.outputText("You feel blanketed by evil and realize you cannot remove the armor - <b>it is cursed!</b> ");
                }
                else
                {
                    EngineCore.outputText("You feel an evil touch - <b>this item is cursed, you cannot unequip it!</b> ");
                }
            }
            else
            {
                EngineCore.outputText("<b>You cannot unequip it</b>. ");
            }
        }
        if (!(try cast(item, IDynamicItem) catch(e:Dynamic) null).identified)
        {
            if ((try cast(item, IDynamicItem) catch(e:Dynamic) null).effects.length > 0)
            
            // This should be in sync with playerEquip{
                
                EngineCore.outputText("You discover it to be " + identifiedCopy(item).longName + ". ");
            }
            else
            {
                EngineCore.outputText("It is not cursed. ");
            }
        }
    }
    
    public static function createItem(
            template : ItemTemplate,
            subtype : String,
            rarity : Int,
            quality : Int,
            curseStatus : Int,
            effects : Array<Dynamic>) : ItemType
    {
        return template.createItem({
                    t : subtype,
                    r : rarity,
                    q : quality,
                    c : curseStatus,
                    e : DynamicItems.encodeEnchantments(effects)
                });
    }
    
    public function new()
    {
        super();
    }
}

