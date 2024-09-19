package classes.items.armors;

import classes.items.Armor;
import classes.scenes.nPCs.CelessScene;

/**
	 * ...
	 * @author Liadri
	 */
class CentaurPaladinArmor extends Armor
{
    
    public function new()
    {
        super("TaurHPAr", "Taur HP. Armor", "some taur paladin armor", "a set of taur paladin armor", 40, 20, 1698, "A suit of paladin's armor for centaurs.", "Heavy");
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
            outputText("The paladin's armor is designed for centaurs, so it doesn't really fit you. You place the armor back in your inventory");
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
        var mod : Int = as3hx.Compat.parseInt((100 - game.player.cor) / 5);
        return 20 + mod;
    }
    override private function get_mdef() : Float
    {
        var mod : Int = as3hx.Compat.parseInt((100 - game.player.cor) / 10);
        return 10 + mod;
    }
}


