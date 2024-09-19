package classes.stats.skills;

import classes.PerkLib;
import classes.Player;
import classes.Races;
import classes.iMutations.IMutationsLib;
import classes.stats.SkillXpStat;

class AlchemySkill extends SkillXpStat
{
    public function new(player : Player)
    {
        super(player, "alchemy", "Alchemy", "alchemyXP");
    }
    
    override public function xpToNextLevel() : Float
    {
        var base : Float = 10;
        var factor1 : Float = level + 1;
        var factor2 : Float = 5;
        var factor3 : Float = level + 1;
        if (player.hasPerk(PerkLib.UtilitySkillsApprentice))
        {
            factor1 -= 1;
        }
        //-2;//4th
        //-3;//6th
        if (player.hasMutation(IMutationsLib.HumanVersatilityIM) && player.perkv1(IMutationsLib.HumanVersatilityIM) >= 2 && player.racialScore(Races.HUMAN) > 17)
        {
            factor2 -= 1;
        }
        if (player.hasMutation(IMutationsLib.HumanVersatilityIM) && player.perkv1(IMutationsLib.HumanVersatilityIM) >= 3 && player.racialScore(Races.HUMAN) > 17)
        {
            factor2 -= 2;
        }
        //if (hasPerk(PerkLib.SuperSensual)) factor2 -= 1;
        if (player.hasPerk(PerkLib.UtilitySkillsBeginner))
        {
            factor3 -= 1;
        }
        if (player.hasPerk(PerkLib.UtilitySkillsSkilled))
        {
            factor3 -= 2;
        }
        //-3;//5th
        return base + factor1 * factor2 * factor3;
    }
    
    override public function maxLevel() : Float
    {
        var maxLevel : Float = 6;
        if (player.level < 64)
        {
            maxLevel += player.level;
        }
        else
        {
            maxLevel += 64;
        }
        return maxLevel;
    }
}

