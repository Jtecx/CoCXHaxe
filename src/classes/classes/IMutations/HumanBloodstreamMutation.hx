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

class HumanBloodstreamMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Human Bloodstream";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "Increases maximum base/core Spe/Lib by ";
        }
        if (pTier == 1)
        {
            descS += "5.";
        }
        if (pTier == 2)
        {
            descS += "10. Increase a bit fatigue recovery (+5) and wrath generation (+2).";
        }
        if (pTier == 3)
        {
            descS += "10, maximum trainable Spe/Lib by 20%. Increase a bit fatigue recovery (+10) and wrath generation (+4).";
        }
        if (pTier == 4)
        {
            descS += "20, maximum trainable Spe/Lib by 30%. Increase fatigue recovery (+15), wrath generation (+6) and +2 to fatigue recovery/wrath gains multiplier. +5% to max overfatigue/overwrath.";
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
                this.requireBloodsteamMutationSlot().requireCustomFunction(function(player : Player) : Bool
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
            Reflect.setField(pBuffs, "spe.mult", 0.1);
            Reflect.setField(pBuffs, "lib.mult", 0.1);
        }
        if (pTier == 2)
        {
            Reflect.setField(pBuffs, "spe.mult", 0.2);
            Reflect.setField(pBuffs, "lib.mult", 0.2);
        }
        if (pTier == 3)
        {
            Reflect.setField(pBuffs, "spe.mult", 0.4);
            Reflect.setField(pBuffs, "lib.mult", 0.4);
        }
        if (pTier == 4)
        {
            Reflect.setField(pBuffs, "spe.mult", 0.8);
            Reflect.setField(pBuffs, "lib.mult", 0.8);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_BLOODSTREAM, 4);
    }
}

