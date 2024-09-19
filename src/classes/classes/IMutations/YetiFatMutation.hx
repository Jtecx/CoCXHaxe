/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.iMutations;

import flash.errors.Error;
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Races;

class YetiFatMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Yeti Fat";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        var pDR : Int = 5;
        if (pTier >= 2)
        {
            pDR += 10;
        }
        if (pTier >= 3)
        {
            pDR += 20;
        }
        if (pTier >= 1)
        {
            descS += "Gain damage reduction (" + pDR + "%) against attacks, increase strength of yeti ice breath by 50%";
        }
        if (pTier >= 2)
        {
            descS += ", potency of Big Hand and Feet by 50%";
        }
        if (pTier >= 3)
        {
            descS += ", duration of yeti breath stun by 1 round and reduce cooldown by 3 rounds.";
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
                this.requireFatTissueMutationSlot().requireRace(Races.YETI);
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
            Reflect.setField(pBuffs, "tou.mult", 0.05);
        }
        if (pTier == 2)
        {
            Reflect.setField(pBuffs, "tou.mult", 0.15);
        }
        if (pTier == 3)
        {
            Reflect.setField(pBuffs, "tou.mult", 0.3);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_FAT, 3);
    }
}

