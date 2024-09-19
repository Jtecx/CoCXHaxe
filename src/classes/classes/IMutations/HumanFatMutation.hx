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

class HumanFatMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Human Fat";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier == 1)
        {
            descS = "Your altered fat tissue allows to increase your natural toughness and thickness.";
        }
        if (pTier == 2)
        {
            descS = "Your fat tissue continue to increase your natural toughness and thickness gained from previous change. (+15% of max core Tou as phantom Tou)";
        }
        if (pTier >= 3)
        {
            descS += "Your fat tissue increased again your natural toughness and thickness limit. Increased damage reduction against physical damage (+";
        }
        if (pTier == 3)
        {
            descS += "15% DR), natural resistance to damage (+15 armor/m.res), increase max Hunger cap by 50 (if PC have Hunger bar active) (+45% of max core Tou as phantom Tou)";
        }
        if (pTier == 4)
        {
            descS += "40% DR), natural resistance to damage (+40 armor/m.res), maximum base/core Tou by 10, +10% to max overfatigue, negate up to 3 points of internal chimera score, increase max Hunger cap by 150 (if PC have Hunger bar active) (+90% of max core Tou as phantom Tou)";
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
                this.requireFatTissueMutationSlot().requireCustomFunction(function(player : Player) : Bool
                        {
                            return player.thickness >= 100 && player.racialScore(Races.HUMAN) > 16;
                        }, "100+ thickness & Human race (17+)");
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
            Reflect.setField(pBuffs, "tou.mult", 0.15);
        }
        if (pTier == 2)
        {
            Reflect.setField(pBuffs, "tou.mult", 0.45);
        }
        if (pTier == 3)
        {
            Reflect.setField(pBuffs, "tou.mult", 0.9);
        }
        if (pTier == 4)
        {
            Reflect.setField(pBuffs, "tou.mult", 1.8);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_FAT, 4);
    }
}

