/**
 * ...
 * @author Ormael
 */
package classes.items.shields;

import classes.ItemType;
import classes.StatusEffects;
import classes.globalFlags.KFLAGS;
import classes.items.Shield;
import classes.items.ShieldLib;
import classes.scenes.nPCs.AetherTwinsFollowers;

class AetherS extends Shield
{
    
    public function new()
    {
        super("AetherS", "AetherS", "Aether (Sin)", "an Aether (Sin)", 0, 0, "Aether - sinister part of mysterious sentient weapons pair rumored to be forged by the god of blacksmiths.");
    }
    
    override private function get_block() : Float
    {
        var boost : Int = 0;
        boost += game.player.statusEffectv2(StatusEffects.AetherTwins1);
        return (0 + boost);
    }
    
    override private function get_description() : String
    {
        var desc : String = _description;
        //Type
        desc += "\n\nType: Weapon (";
        if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Daggers")
        {
            desc += "Dagger";
        }
        else if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dagger and Shield")
        {
            desc += "Small Shield";
        }
        else
        {
            desc += "Gauntlet";
        }
        desc += ")";
        //Block Rating
        desc += "\nBlock: " + Std.string(block);
        //Value
        desc += "\nBase value: 0";
        return desc;
    }
    
    override public function equipText() : Void
    {
        outputText("\n\n\"<i>Well alright then, [name]!</i>\" Aether (Sin) says excitedly, \"<i>Let's go!</i>\"\n\n");
    }
    
    override public function afterEquip(doOutput : Bool, slot : Int) : Void
    {
        if (!game.isLoadingSave)
        {
            game.flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] = 2;
        }
        super.afterEquip(doOutput, slot);
    }
    
    override public function unequipText(slot : Int) : Void
    {
        outputText("Aether (Sin) lays on the ground for a moment, \"<i>I will be waiting in the camp</i>\" she says before teleporting back to your camp.\n\n(<b>Aether (Sin) is now available in the followers tab!</b>)");
    }
    
    override public function afterUnequip(doOutput : Bool, slot : Int) : Void
    {
        game.flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] = 1;
        super.afterUnequip(doOutput, slot);
    }
    
    override public function beforeUnequip(doOutput : Bool, slot : Int) : ItemType
    {
        return ShieldLib.NOTHING;
    }
}

