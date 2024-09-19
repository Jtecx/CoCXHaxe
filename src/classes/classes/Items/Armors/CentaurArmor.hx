package classes.items.armors;

import classes.items.Armor;
import classes.scenes.nPCs.CelessScene;
import classes.Player;
import classes.PerkLib;

import classes.StatusEffects;

/**
	 * ...
	 * @author Liadri
	 */
class CentaurArmor extends Armor
{
    
    public function new()
    {
        super("TaurPAr", "Taur P. Armor", "some taur armor", "a set of taur armor", 23, 0, 1698, "A suit of armor for centaurs.", "Heavy");
    }
    override public function canEquip(doOutput : Bool, slot : Int) : Bool
    {
        if (game.player.isTaur())
        {
            return super.canEquip(doOutput, slot);
        }
        if (doOutput)
        {
            outputText("This armor is designed for centaurs, so it doesn't really fit you. You place the armor back in your inventory.");
        }
        return false;
    }
    
    override public function equipText() : Void
    {
        outputText(CelessScene.instance.Name + " helps you put on the barding and horseshoes. Wow, taking a look at yourself, you look like those knights of legend. Fighting the wicked with this armor should be quite easy.");
    }
    
    override public function unequipText(slot : Int) : Void
    {
        outputText(CelessScene.instance.Name + "helps you remove the centaur armor. Whoa, you were starting to forget what not being weighted down by heavy armor felt like.");
    }
    
    override private function get_def() : Float
    {
        var mod : Int = as3hx.Compat.parseInt((100 - game.player.cor) / 10);
        return 13 + mod;
    }
}


