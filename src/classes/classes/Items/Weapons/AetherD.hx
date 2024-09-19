/**
 * ...
 * @author Ormael
 */
package classes.items.weapons;

import classes.CoC;
import classes.ItemType;
import classes.StatusEffects;
import classes.globalFlags.KFLAGS;
import classes.items.Weapon;
import classes.items.WeaponLib;
import classes.scenes.nPCs.AetherTwinsFollowers;

class AetherD extends Weapon
{
    
    public function new()
    {
        super("AetherD", "AetherD", "Aether (Dex)", "an Aether (Dex)", "punch", 0, 0, "Aether - dexter part of mysterious sentient weapons pair rumored to be forged by the god of blacksmiths.", WT_GAUNTLET, WSZ_MEDIUM);
    }
    
    private static var SLOTS : Array<Dynamic> = [SLOT_WEAPON_MELEE];
    override public function slots() : Array<Dynamic>
    {
        return SLOTS;
    }
    
    override private function get_description() : String
    {
        var desc : String = _description;
        //Type
        desc += "\n\nType: Weapon (";
        if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Daggers" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dagger and Shield")
        {
            desc += "Dagger";
        }
        else
        {
            desc += "Gauntlet";
        }
        desc += ")";
        //Attack
        desc += "\nAttack: " + Std.string(attack);
        //Value
        desc += "\nBase value: 0";
        return desc;
    }
    
    override private function get_verb() : String
    {
        if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Daggers" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dagger and Shield")
        {
            return "stab";
        }
        else
        {
            return "punch";
        }
    }
    
    override private function get_attack() : Float
    {
        var boost : Int = 0;
        boost += game.player.statusEffectv1(StatusEffects.AetherTwins1);
        return (0 + boost);
    }
    
    override private function get_type() : String
    {
        if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Daggers" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dagger and Shield")
        {
            return WT_DAGGER;
        }
        else
        {
            return WT_GAUNTLET;
        }
    }
    
    override private function get_size() : Int
    {
        if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Daggers" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dagger and Shield")
        {
            return WSZ_SMALL;
        }
        else if (AetherTwinsFollowers.AetherTwinsShape == "Sky-tier Gaunlets")
        {
            return WSZ_LARGE;
        }
        else
        {
            return WSZ_MEDIUM;
        }
    }
    
    override public function useText() : Void
    {
        outputText("\n\n\"<i>Well alright then, [name]!</i>\" Aether (Dex) says excitedly, \"<i>Let's go!</i>\"\n\n");
    }
    
    override public function afterEquip(doOutput : Bool, slot : Int) : Void
    {
        game.flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] = 2;
        super.afterEquip(doOutput, slot);
    }
    
    override public function unequipText(slot : Int) : Void
    {
        outputText("Aether (Dex) lays on the ground for a moment, \"<i>I will be waiting in the camp</i>\" she says before teleporting back to your camp.\n\n(<b>Aether (Dex) is now available in the followers tab!</b>)");
    }
    
    override public function afterUnequip(doOutput : Bool, slot : Int) : Void
    {
        game.flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] = 1;
        super.afterUnequip(doOutput, slot);
    }
    
    override public function beforeUnequip(doOutput : Bool, slot : Int) : ItemType
    {
        super.beforeUnequip(doOutput, slot);
        return WeaponLib.FISTS;
    }
}
