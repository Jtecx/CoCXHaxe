package classes.items;

import haxe.Constraints.Function;
import classes.*;
import classes.items.alchemy.AlchemyLib;

/**
	 * Helper class to get rid of the copy&paste-mess in classes.Items.Mutations
	 * @since July 8, 2016
	 * @author Stadler76
	 */
class MutationsHelper extends AlchemyLib
{
    
    public var changes : Int = 0;
    public var changeLimit : Int = 1;
    
    public function new()
    {
        super();
    }
    
    /**
	 * Initializes changes=0 and changeLimit to (1..maxChanges) + perk bonuses
	 * @param name
	 * @param maxChanges
	 * @return
	 */
    private function mutationStart(name : String, maxChanges : Int) : Int
    {
        changes = 0;
        changeLimit = 1;
        for (i in 2...maxChanges + 1)
        {
            if (rand(i) == 0)
            {
                changeLimit++;
            }
        }
        if (player.hasPerk(PerkLib.HistoryAlchemist) || player.hasPerk(PerkLib.PastLifeAlchemist))
        {
            changeLimit++;
        }
        if (player.hasPerk(PerkLib.Enhancement))
        {
            changeLimit++;
        }
        if (player.hasPerk(PerkLib.Fusion))
        {
            changeLimit++;
        }
        if (player.hasPerk(PerkLib.Enchantment))
        {
            changeLimit++;
        }
        if (player.hasPerk(PerkLib.Refinement))
        {
            changeLimit++;
        }
        if (player.hasPerk(PerkLib.Saturation))
        {
            changeLimit++;
        }
        if (player.hasPerk(PerkLib.Perfection))
        {
            changeLimit++;
        }
        if (player.hasPerk(PerkLib.Creationism))
        {
            changeLimit++;
        }
        if (player.hasPerk(PerkLib.EzekielBlessing))
        {
            changeLimit++;
        }
        if (player.hasPerk(PerkLib.TransformationResistance))
        {
            changeLimit--;
        }
        if (player.hasPerk(PerkLib.TransformationAcclimation))
        {
            changeLimit * 2;
        }
        return changes;
    }
    /**
	 * If:
	 * * changes < changeLimit
	 * * `condition` is 'true'
	 * * random*rarity < 1  (equivalent to (rand(rarity) = 0) for `rarity:int`)
	 * Then:
	 * * call `code`
	 * * changes++
	 * * return true
	 * Else:
	 * * return false
	 */
    private function mutationStep(condition : Bool, rarity : Float, code : Function) : Bool
    {
        if (changes < changeLimit && condition && Math.random() * rarity < 1)
        {
            code();
            changes++;
            return true;
        }
        else
        {
            return false;
        }
    }
}

