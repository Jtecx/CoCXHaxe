package classes.items.armors;

import classes.items.Armor;
import classes.scenes.nPCs.CelessScene;

/**
	 * ...
	 * @author Liadri
	 */
class CentaurBlackguardArmor extends Armor
{
    
    public function new()
    {
        super("TaurBAr", "Taur B. Armor", "some taur blackguard armor", "a set of taur blackguard armor", 40, 20, 1698, "A suit of blackguard's armor for centaurs.", "Heavy");
        withTag(I_LEGENDARY);
    }
    override public function canEquip(doOutput : Bool, slot : Int) : Bool
    {
        if (game.player.isTaur())
        {
            return super.canEquip(doOutput, slot);
        }
        if (doOutput)
        {
            outputText("The blackguard's armor is designed for centaurs, so it doesn't really fit you. You place the armor back in your inventory");
        }
        return false;
    }
    
    override public function equipText() : Void
    {
        outputText(CelessScene.instance.Name + " helps you put on the barding and horseshoes. Wow, taking a look at yourself, you think your intimidating appearance alone will scare the hell out of most opponents.");
    }
    
    override public function unequipText(slot : Int) : Void
    {
        outputText(CelessScene.instance.Name + "help you remove the centaur armor. Whoa you forgot what carrying light weight was.");
    }
    
    override private function get_def() : Float
    {
        var mod : Int = as3hx.Compat.parseInt(game.player.cor / 5);
        return 20 + mod;
    }
    override private function get_mdef() : Float
    {
        var mod : Int = as3hx.Compat.parseInt(game.player.cor / 10);
        return 10 + mod;
    }
}


