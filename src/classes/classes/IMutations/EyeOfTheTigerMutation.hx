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

class EyeOfTheTigerMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Eye Of The Tiger";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS = "Increase precision of all attacks by 5%";
        }
        if (pTier >= 2)
        {
            descS += " and increase critical chance with natural weapons and weapons by 5%. Increase Rake and Claw attack damage by 50%.";
        }
        if (pTier == 1)
        {
            descS += ". Increase Rake and Claw attack damage by 50%.";
        }
        if (pTier == 3)
        {
            descS += " Critical strikes from claw attacks inflict bleed damage.";
        }
        if (pTier == 4)
        {
            descS += " Critical strikes from claw attacks inflict bleed damage. Increase Natural weapon critical damage by 50%.";
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
                this.requireEyesMutationSlot().requireAnyRace(Races.CatlikeRaces);
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
            Reflect.setField(pBuffs, "int.mult", 0.05);
        }
        if (pTier == 2)
        {
            Reflect.setField(pBuffs, "int.mult", 0.15);
            Reflect.setField(pBuffs, "lib.mult", 0.05);
        }
        if (pTier == 3)
        {
            Reflect.setField(pBuffs, "int.mult", 0.25);
            Reflect.setField(pBuffs, "lib.mult", 0.10);
        }
        if (pTier == 4)
        {
            Reflect.setField(pBuffs, "int.mult", 0.35);
            Reflect.setField(pBuffs, "lib.mult", 0.15);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_EYES, 4);
    }
}

