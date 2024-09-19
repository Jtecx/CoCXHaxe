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

class RaijuCathodeMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Raiju Cathode";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier == 1)
        {
            descS = "Your Raiju Cathode provides an increase in speed by 10% and increase lust damage from weapons and natural weapons by 50%";
        }
        if (pTier == 2)
        {
            descS = "Your Raiju Cathode provides an increase in speed by 25% and increase lust damage from weapons and natural weapons by 100%, All lightning damage is increased by 20%";
        }
        if (pTier == 3)
        {
            descS = "Your Raiju Cathode provides an increase in speed by 50% and increase lust damage from weapons and natural weapons by 200%, All lightning damage is increased by 20%, Supercharged bonuses are twice as strong";
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
                this.requirePeripheralNervSysMutationSlot().requireAnyRace(Races.RAIJU, Races.KIRIN);
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
        }
        else if (pTier == 2)
        {
            Reflect.setField(pBuffs, "spe.mult", 0.25);
        }
        else if (pTier == 3)
        {
            Reflect.setField(pBuffs, "spe.mult", 0.5);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_NERVSYS, 3);
    }
}

