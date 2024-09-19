/**
 * Created by aimozg on 09.01.14.
 */
package classes.items;

import classes.CoCSettings;
import classes.ItemType;
import classes.PerkClass;
import classes.PerkType;
import classes.stats.StatUtils;
import classes.internals.Utils;
import classes.PerkLib;

/**
 * Superclass for items that could be equipped by player (armor, weapon, jewelry, ...).
 *
 * ## Call order
 *
 * Call order when player equips itemA into slotX while having itemB equipped:
 * (This is implemented in Player.internalEquipItem)
 *
 * 1. Test
 * 1.1. Test `itemA.canEquip`. If false, stop.
 * 1.2. Test `itemB.canUnequip`. If false, stop.
 * 2. Unequip itemB
 * 2.1. Call `itemB.beforeUnequip` (calls `itemB.unequipText`) and save itemReturn
 * 2.2. Put 'nothing' into slotX
 * 2.3. Call `itemB.afterUnequip` (effects go here)
 * 3. Equip itemA
 * 3.1. Call `itemA.beforeEquip` (calls `itemA.equipText`) and save itemActual
 * 3.2. Put itemActual into slotX
 * 3.3. Call `itemActual.afterEquip` (effects go here)
 * 4. Remove itemB from inventory.
 * 5. Add itemReturn to inventory.
 * (4 and 5 are done by calling function)
 *
 * Variations:
 * - If force=true, skip test
 * - All functions mentioned above have doOutput parameter
 * - When loading a save only afterEquip(doOutput=false) is called. Can be checked by game.isLoadingSave
 * - Skip certain sections for items flagged as 'nothing'
 *
 * ## What to override in subclasses
 *
 * - To add effect when equipped: `afterEquip` and `afterUnequip`. Note that it is called when loading a save, too. Guard the section with `if (!game.isLoadingSave) { ... }`.
 * - To add requirements to wear/remove: `canEquip` and `canUnequip`
 * - To display different text: `equipText` and `unequipText`.
 * - To transform item into another when equipping: `beforeEquip`.
 * - To transform item into another when unequipping: `beforeUnequip`.
 */
class Equipable extends Useable
{
    
    private var _name : String;
    private var _buffs : Dynamic;
    private var _buffsStack : Bool = false;
    /**
	 * Array of [perkType, value1, value2, value3, value4, stack]
	 */
    private var _playerPerks : Array<Dynamic>;
    
    override private function get_name() : String
    {
        return _name;
    }
    
    public function new(id : String, shortName : String, name : String, longName : String, value : Float, description : String)
    {
        super(id, shortName, longName, value, description);
        this._name = name || this.shortName;
    }
    
    override private function get_description() : String
    {
        var s : String = _description;
        var s2 : String = effectDescription();
        if (s != null && s2 != null)
        {
            return s + "\n\n" + s2;
        }
        return s || s2;
    }
    
    /**
	 * Array of pairs [order, name] to construct item description.
	 *
	 * *   0: Curse status
	 * *  10: type
	 * *  15: subtype
	 * *  20: main property (attack, defense)
	 * *  30: secondary property (mdef)
	 * *  40: rarity
	 * *  45: quality
	 * *  50: tags
	 * *  70: buffs
	 * *  80: effects and enchantments
	 * *  90: extra desc
	 * * 100: value
	 */
    public function effectDescriptionParts() : Array<Dynamic>
    {
        var list : Array<Dynamic> = [];
        list.push([100, "Base value: " + value]);
        if (_buffs != null)
        {
            var desc : String = "";
            for (key in Reflect.fields(_buffs))
            {
                if (desc != null)
                {
                    desc += ", ";
                }
                desc += StatUtils.explainBuff(key, Reflect.field(_buffs, key));
            }
            desc = "Effect: " + desc;
            list.push([70, desc]);
        }
        var desc2 : String = "";
        for (tag in Reflect.fields(_tags))
        {
            if (Lambda.has(ItemTagNames, tag))
            {
                tag = Reflect.field(ItemTagNames, tag);
            }
            if (tag != null)
            {
                if (desc2 != null)
                {
                    desc2 += ", ";
                }
                desc2 += tag;
            }
        }
        if (desc2 != null)
        {
            desc2 = "Tags: " + desc2;
            list.push([50, desc2]);
        }
        if (_playerPerks != null)
        {
            for (perk in _playerPerks)
            {
                var pc : PerkClass = new PerkClass(Reflect.field(perk, Std.string(0)), Reflect.field(perk, Std.string(1)), Reflect.field(perk, Std.string(2)), Reflect.field(perk, Std.string(3)), Reflect.field(perk, Std.string(4)));
                list.push([60, pc.perkDesc]);
            }
        }
        for (ie in itemEffects)
        {
            var ipdesc : String = ie.description(this);
            if (ipdesc != null)
            {
                list.push([ie.priority, ipdesc]);
            }
        }
        return list;
    }
    public function effectDescription() : String
    {
        var list : Array<Dynamic> = effectDescriptionParts().sortOn("0", Array.NUMERIC);
        return Utils.mapOneProp(list, "1").join("\n");
    }
    
    override public function canUse() : Bool
    {
        return canEquip(true, -1);
    }
    
    /**
	 * Slot ids this item could be equipped into
	 */
    public function slots() : Array<Dynamic>
    {
        CoC_Settings.errorAMC("Equipable(" + id + ")", "slots");
        return [];
    }
    
    public function getLegendaryEquipLevel() : Int
    {
        var equipLevel : Int = 54;
        equipLevel -= as3hx.Compat.parseInt(game.player.perkv1(PerkLib.AscensionHerosBirthrightRankX) * 9);
        if (equipLevel < 0)
        {
            equipLevel = 0;
        }
        if (game.player.compatibileSwordImmortalWeapons() && game.player.hasPerk(PerkLib.HiddenJobSwordImmortal))
        {
            equipLevel = 0;
        }
        return equipLevel;
    }
    
    /**
	 * Various texts used by equip/unequip code. Override to customize.
	 * - "onequip": successfully equipped
	 * - "onunequip": successfully unequipped
	 * - "legendary_fail": cannot equip legendary, level too low
	 * - "too_corrupt": cannot equip, corruption too high
	 * - "too_pure": cannot equip, corruption too low
	 * - "rigidity_fail": cannot equip, jiangshi
	 */
    public function getItemText(textid : String) : String
    {
        switch (textid)
        {
            case "onequip":
                return "You equip " + longName + ". ";
            case "onunequip":
                return "You unequip " + longName + ". ";
            case "legendary_fail":
                return "You try to equip the legendary item, but to your disapointment the item simply refuses to stay on your body. It seems you still lack the right to use this item.";
            case "too_corrupt":
                return "You grab hold of the handle of " + name + " only to have it grow burning hot. You're forced to let it go lest you burn yourself. Something within the tool must be displeased.";
            case "too_pure":
                return "As soon as you try to wield " + name + ", it jerks wildly like a bucking horse. You quickly put it back into your pouches before it can do harm to you.";
            case "rigidity_fail":
                return "You would very like to equip this item but your body stiffness prevents you from doing so.";
            default:
                return "Error getEquipText(" + textid + ")";
        }
    }
    
    /**
	 * Test if player can equip the item.
	 * Should NOT check empty target slot (but can check other slots).
	 * (ex. equipping large weapon can check for no shield but shouldn't check for no weapon)
	 * @param doOutput Player tries equipping the item, if fails, print why. And do any side effects related to failed equip attempt.
	 * @param slot Slot to equip the item onto. -1 - any slot.
	 * @return true if the player can wear the item
	 */
    public function canEquip(doOutput : Bool, slot : Int) : Bool
    {
        if (game.player.cor > effectPower(IELib.Require_CorBelow, 100) + game.player.corruptionTolerance)
        {
            if (doOutput)
            {
                outputText(getItemText("too_corrupt"));
            }
            return false;
        }
        if (game.player.cor < effectPower(IELib.Require_Cor, 0) - game.player.corruptionTolerance)
        {
            if (doOutput)
            {
                outputText(getItemText("too_pure"));
            }
            return false;
        }
        if (hasTag(I_LEGENDARY) && game.player.level < getLegendaryEquipLevel())
        {
            if (doOutput)
            {
                outputText(getItemText("legendary_fail"));
            }
            return false;
        }
        return true;
    }
    
    /**
	 * Test if player can unequip the item
	 * @param doOutput Player tries unequiping the item, if fails, print why. And do any side effects related to failed unequip attempt.
	 * @param slot Slot here to equip, -1 - any slot
	 * @return true if player can unequip the item
	 */
    public function canUnequip(doOutput : Bool) : Bool
    {
        if (isNothing)
        {
            return false;
        }
        if (cursed)
        {
            if (doOutput)
            {
                outputText("<b>You cannot remove a cursed item!</b>");
            }
            return false;
        }
        return true;
    }
    
    /**
	 * Called when player is equipping the item.
	 * Can transform item into another here.
	 * It is NOT called when loading a save, do not add any effects here.
	 * It is NOT called it item transforms into another.
	 * Do not apply equipment effects here.
	 * @param doOutput
	 * @return Actual item to be put into slot, or null
	 */
    public function beforeEquip(doOutput : Bool, slot : Int) : Equipable
    {
        if (doOutput)
        {
            equipText();
        }
        return this;
    }
    
    public function equipText() : Void
    {
        outputText(getItemText("onequip"));
    }
    
    /**
	 * Called after player has equipped the item.
	 * Also called during save load.
	 * Apply equipment effects here.
	 * @param doOutput
	 */
    public function afterEquip(doOutput : Bool, slot : Int) : Void
    {
        for (ie/* AS3HX WARNING could not determine type for var: ie exp: ECall(EIdent(effectsFlagged),[EIdent(IEF_ONEQUIP)]) type: null */ in effectsFlagged(IEF_ONEQUIP))
        {
            ie.onEquip(game.player, this);
        }
        if (_buffs != null)
        
        // don't write into savefile{
            
            if (_buffsStack)
            {
                game.player.buff(tagForBuffs).addStats(_buffs).withText(name).withOptions({
                            save : false
                        });
            }
            else
            {
                game.player.buff(tagForBuffs).setStats(_buffs).withText(name).withOptions({
                            save : false
                        });
            }
        }
        if (!game.isLoadingSave)
        {
            if (_playerPerks != null)
            {
                for (perk in _playerPerks)
                {
                    game.player.createPerk(Reflect.field(perk, Std.string(0)), Reflect.field(perk, Std.string(1)), Reflect.field(perk, Std.string(2)), Reflect.field(perk, Std.string(3)), Reflect.field(perk, Std.string(4)));
                }
            }
        }
    }
    
    /**
	 * Called when player removes the item.
	 * canUnequip is already called (or ignored)
	 * Do not undo the effects here
	 * @param doOutput
	 * @return Actual item to place into inventory (could be nothing)
	 */
    public function beforeUnequip(doOutput : Bool, slot : Int) : ItemType
    {
        if (doOutput)
        {
            unequipText(slot);
        }
        return this;
    }
    
    public function unequipText(slot : Int) : Void
    {
        outputText(getItemText("onunequip"));
    }
    
    /**
	 * Called after player removes the item.
	 * Undo effects here
	 * @param doOutput
	 */
    public function afterUnequip(doOutput : Bool, slot : Int) : Void
    {
        for (ie/* AS3HX WARNING could not determine type for var: ie exp: ECall(EIdent(effectsFlagged),[EIdent(IEF_ONEQUIP)]) type: null */ in effectsFlagged(IEF_ONEQUIP))
        {
            ie.onEquip(game.player, this);
        }
        if (_buffs != null)
        {
            if (game.player.countSameEquippedItems(this) == 0 || !_buffsStack)
            {
                game.player.buff(tagForBuffs).remove();
            }
            else
            {
                game.player.buff(tagForBuffs).subtractStats(_buffs);
            }
        }
        if (_playerPerks != null)
        {
            for (perk in _playerPerks)
            {
                game.player.removePerk(Reflect.field(perk, Std.string(0)));
            }
        }
    }
    
    /**
	 * Give buffs when equipping this item.
	 * Only use when constructing the item type!
	 * @param buffs
	 * @param stack Stack buffs from identical items
	 * @return this
	 */
    public function withBuffs(buffs : Dynamic, stack : Bool = true) : Equipable
    {
        if (Std.is(buffs, Array))
        {
            buffs = Utils.createMapFromPairs(try cast(buffs, Array</*AS3HX WARNING no type*/>) catch(e:Dynamic) null);
        }
        this._buffs = buffs;
        StatUtils.validateBuffObject(_buffs, "item " + id);
        this._buffsStack = stack;
        return this;
    }
    
    public function withBuff(statName : String, power : Float, stack : Bool = true) : Equipable
    {
        this._buffs = StatUtils.addBuffToObject(this._buffs, statName, power);
        StatUtils.validateBuff(statName, "item " + id);
        this._buffsStack = stack;
        return this;
    }
    
    public function hasBuff(statname : String) : Bool
    {
        return _buffs && Lambda.has(_buffs, statname);
    }
    public function hasAnyBuffs() : Bool
    {
        return _buffs;
    }
    public function getBuffs() : Dynamic
    {
        return _buffs || { };
    }
    /**
	 * Give perk when equipping this item.
	 * Only use when constructing the item type!
	 * If multiple items granting a perk are equipped, their values would stack.
	 * @return this
	 */
    public function withPerk(perk : PerkType, value1 : Float = 0, value2 : Float = 0, value3 : Float = 0, value4 : Float = 0) : Equipable
    {
        this._playerPerks ||= [];
        this._playerPerks.push([perk, value1, value2, value3, value4]);
        return this;
    }
    
    public function givesPerk(perk : PerkType) : Bool
    {
        if (!this._playerPerks)
        {
            return false;
        }
        for (entry in _playerPerks)
        {
            if (Reflect.field(entry, Std.string(0)) == perk)
            {
                return true;
            }
        }
        return false;
    }
    public function givesAnyPerk() : Bool
    {
        return _playerPerks && _playerPerks.length > 0;
    }
    public function getPlayerPerks() : Array<Dynamic>
    {
        return _playerPerks || [];
    }
}

