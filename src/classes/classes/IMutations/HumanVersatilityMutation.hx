/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.iMutations;

import flash.errors.Error;
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Player;
import classes.Races;

class HumanVersatilityMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Human Versatility";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "Mastery gains increased by 1 point or in case of multiplier +1 to multiplier";
        }
        if (pTier >= 2)
        {
            descS += "Mastery gains increased by " + pTier + " points or in case of multiplier +" + pTier + " to multiplier";
        }
        if (pTier == 2)
        {
            descS += ". Decrease a bit needed exp to lvl up weapon/lifeskill masteries";
        }
        if (pTier >= 3)
        {
            descS += ". Decrease needed exp to lvl up weapon/lifeskill masteries and have " + ((pTier * 2) - 4) + "0% chance to gain " + pTier + "x more XP for Mastery";
        }
        if (pTier == 4)
        {
            descS += ". 50% chance to gain 2 levels instead of 1 when leveling weapon/lifeskill mastery";
        }
        if (descS != "")
        {
            descS += ".";
        }
        if (pTier >= 1)
        {
            descS += " (req. 18+ human score to have all effects active)";
        }
        return descS;
    }
    
    //Mutation Requirements
    override public function pReqs(pCheck : Int = -1) : Void
    {
        try
        {
            var pTier : Int = (pCheck != -(1) ? pCheck : currentTier(this, player));
            //This helps keep the requirements output clean.
            this.requirements = [];
            if (pTier == 0)
            {
                this.requireAdaptationsMutationSlot().requireCustomFunction(function(player : Player) : Bool
                        {
                            return player.racialScore(Races.HUMAN) > 16;
                        }, "Human race (17+)");
            }
            else
            {
                var pLvl : Int = as3hx.Compat.parseInt(pTier * 30);
                this.requireLevel(pLvl);
            }
        }
        catch (e : Error)
        {
            trace(e.getStackTrace());
        }
    }
    
    //Mutations Buffs
    override public function buffsForTier(pTier : Int, target : Creature) : Dynamic
    {
        var pBuffs : Dynamic = { };
        if (pTier == 1)
        {
            Reflect.setField(pBuffs, "str.mult", 0.02);
            Reflect.setField(pBuffs, "tou.mult", 0.02);
            Reflect.setField(pBuffs, "spe.mult", 0.02);
            Reflect.setField(pBuffs, "int.mult", 0.03);
            Reflect.setField(pBuffs, "wis.mult", 0.03);
            Reflect.setField(pBuffs, "lib.mult", 0.03);
        }
        if (pTier == 2)
        {
            Reflect.setField(pBuffs, "str.mult", 0.05);
            Reflect.setField(pBuffs, "tou.mult", 0.05);
            Reflect.setField(pBuffs, "spe.mult", 0.05);
            Reflect.setField(pBuffs, "int.mult", 0.10);
            Reflect.setField(pBuffs, "wis.mult", 0.10);
            Reflect.setField(pBuffs, "lib.mult", 0.10);
        }
        if (pTier == 3)
        {
            Reflect.setField(pBuffs, "str.mult", 0.10);
            Reflect.setField(pBuffs, "tou.mult", 0.10);
            Reflect.setField(pBuffs, "spe.mult", 0.10);
            Reflect.setField(pBuffs, "int.mult", 0.20);
            Reflect.setField(pBuffs, "wis.mult", 0.20);
            Reflect.setField(pBuffs, "lib.mult", 0.20);
        }
        if (pTier == 4)
        {
            Reflect.setField(pBuffs, "str.mult", 0.20);
            Reflect.setField(pBuffs, "tou.mult", 0.20);
            Reflect.setField(pBuffs, "spe.mult", 0.20);
            Reflect.setField(pBuffs, "int.mult", 0.40);
            Reflect.setField(pBuffs, "wis.mult", 0.40);
            Reflect.setField(pBuffs, "lib.mult", 0.40);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_ADAPTATIONS, 4);
    }
}

