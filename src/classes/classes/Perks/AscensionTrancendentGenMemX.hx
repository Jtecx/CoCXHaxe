/**
 * Created by aimozg on 27.01.14.
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.PerkLib;

class AscensionTrancendentGenMemX extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        var pVal : Float = player.perkv1(PerkLib.AscensionTrancendentalGeneticMemoryStageX);
        return "Your body has learned to retain " + Std.string(15 * pVal) + " metamorphic adaptations.";
    }
    
    override public function name(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _name;
        }
        var sufval : String = Std.string(player.perkv1(PerkLib.AscensionTrancendentalGeneticMemoryStageX));
        return "Ascension: Transcendental Genetic Memory Rank " + sufval;
    }
    
    public function new()
    {
        super("Ascension: Transcendental Genetic Memory Rank", "Ascension: Transcendental Genetic Memory Rank", 
                "."
        );
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}

