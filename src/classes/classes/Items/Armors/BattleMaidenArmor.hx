/**
 * ...
 * @author Liadri
 */
package classes.items.armors;

import classes.items.Armor;

class BattleMaidenArmor extends Armor
{
    
    public function new()
    {
        super("BMArmor", "BMArmor", "Battle maiden armor", "a Battle maiden armor", 80, 40, 4800, "The purified original maiden armor recovered its former property. It fully protect the virginity of its wielder even going so far as to progressively clear the fog of lust from her mind.", "Light", false, false);
        withTag(A_REVEALING);
        withTag(I_LEGENDARY);
    }
    
    override private function get_def() : Float
    {
        var mod : Int = 0;
        if (game.player.hasVirginVagina())
        {
            mod += 40;
        }
        mod += as3hx.Compat.parseInt((100 - game.player.cor) / 5);
        return 20 + mod;
    }
    override private function get_mdef() : Float
    {
        var mod : Int = 0;
        if (game.player.hasVirginVagina())
        {
            mod += 20;
        }
        mod += as3hx.Compat.parseInt((100 - game.player.cor) / 10);
        return 10 + mod;
    }
    
    override public function canEquip(doOutput : Bool, slot : Int) : Bool
    {
        if (!super.canEquip(doOutput, slot))
        {
            return false;
        }
        return LustyMaidensArmor.canUseStatic(doOutput);
    }
}

