/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.iMutations;

import flash.errors.Error;
import classes.PerkClass;
import classes.PerkLib;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Races;

class LizanMarrowMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Lizan Marrow";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier == 1)
        {
            descS = "Regenerates 0.5% of HP per round in combat and 1% of HP per hour. Additionaly your limit for innate self-regeneration rate increased.";
        }
        if (pTier == 2)
        {
            descS = "Regenerates 1% of HP per round in combat and 2% of HP per hour. Additionaly your limit for innate self-regeneration rate increased.";
        }
        if (pTier == 3)
        {
            descS = "Regenerates 1.5% of HP per round in combat and 3% of HP per hour. Additionaly your limit for innate self-regeneration rate increased. When below 25% of max HP regeneration provided by Lizan regeneration is 2x. You can't lose by HP until your health drops into the negatives more than 5% of max HP.";
        }
        if (pTier == 4)
        {
            descS = "Regenerates 2% of HP per round in combat and 4% of HP per hour. Additionaly your limit for innate self-regeneration rate increased. When below 60%/20% of max HP regeneration provided by Lizan regeneration is 2x/3x. Could slowly recover lost bodyparts (~0.5/1% per combat round/hour). You can't lose by HP until your health drops into the negatives more than 10% of max HP, +10% OverMax HP.";
        }
        if (descS != "")
        {
            descS += ".";
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
                this.requireBonesAndMarrowMutationSlot().requirePerk(PerkLib.LizanRegeneration).requireRace(Races.LIZARD);
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
            Reflect.setField(pBuffs, "tou.mult", 0.01);
        }
        else if (pTier == 2)
        {
            Reflect.setField(pBuffs, "tou.mult", 0.03);
        }
        else if (pTier == 3)
        {
            Reflect.setField(pBuffs, "tou.mult", 0.07);
        }
        else if (pTier == 4)
        {
            Reflect.setField(pBuffs, "tou.mult", 0.15);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_BONE, 4);
    }
}

