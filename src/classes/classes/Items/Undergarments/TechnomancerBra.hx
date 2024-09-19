/**
 * ...
 * @author Liadri
 */
package classes.items.undergarments;

import classes.items.Undergarment;

class TechnomancerBra extends Undergarment
{
    public function new()
    {
        super("TechBra", "TechnomancerBra", "Technomancer bra", "a Technomancer bra", UT_TOP, 600, 0, 0, 0, "A black latex bra to match with the technomancer clothes, it is decorated with a gears motif and is oil, shock and stainproof. This item also improve your aptitude at using technology. \n\nType: Undergarment (Upper)");
    }
    
    override public function canEquip(doOutput : Bool, slot : Int) : Bool
    {
        if (game.player.basetallness < 48)
        {
            return super.canEquip(doOutput, slot);
        }
        if (doOutput)
        {
            outputText("There is no way this tiny set of clothing would fit your current size.");
        }
        return false;
    }
}


