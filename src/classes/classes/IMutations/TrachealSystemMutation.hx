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

class TrachealSystemMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Tracheal System";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "Your body possesses a ";
        }
        if (pTier == 1)
        {
            descS += "rudimentary";
        }
        if (pTier == 2)
        {
            descS += "basic";
        }
        if (pTier == 3)
        {
            descS += "half developed";
        }
        if (pTier == 4)
        {
            descS += "fully developed";
        }
        if (descS != "")
        {
            descS += " respiratory system modeled after insects.";
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
                this.requireAdaptationsMutationSlot().requireRacialGroup(Races.InsectRaces, "Any insect race");
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
            Reflect.setField(pBuffs, "str.mult", 0.01);
            Reflect.setField(pBuffs, "spe.mult", 0.02);
        }
        else if (pTier == 2)
        {
            Reflect.setField(pBuffs, "str.mult", 0.03);
            Reflect.setField(pBuffs, "spe.mult", 0.05);
            Reflect.setField(pBuffs, "tou.mult", 0.01);
        }
        else if (pTier == 3)
        {
            Reflect.setField(pBuffs, "str.mult", 0.07);
            Reflect.setField(pBuffs, "spe.mult", 0.1);
            Reflect.setField(pBuffs, "tou.mult", 0.04);
        }
        else if (pTier == 4)
        {
            Reflect.setField(pBuffs, "str.mult", 0.15);
            Reflect.setField(pBuffs, "spe.mult", 0.2);
            Reflect.setField(pBuffs, "tou.mult", 0.1);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_ADAPTATIONS, 4);
    }
}

