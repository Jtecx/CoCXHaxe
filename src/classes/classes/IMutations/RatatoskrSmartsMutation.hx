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

class RatatoskrSmartsMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Ratatoskr Smarts";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "Allows you to perm Weird words";
        }
        if (pTier >= 3)
        {
            descS += ", knowledge is power is now three times as effective";
        }
        if (pTier >= 2)
        {
            descS += ", increase the damage of Weird words by " + (((pTier == 2)) ? "20%" : (((pTier == 3)) ? "50%" : "")) + ", lower cooldown of Knowledge overload by " + (((pTier == 2)) ? "1 turn" : (((pTier == 3)) ? "2 turns" : ""));
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
                this.requirePeripheralNervSysMutationSlot().requireRace(Races.RATATOSKR);
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
        }
        if (pTier == 3)
        {
            Reflect.setField(pBuffs, "int.mult", 0.35);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_NERVSYS, 3);
    }
}

