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

class AnubiHeartMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Anubi Heart";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        var perkCent : Int = 0;
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS = "Increase Soulskills power by " + (20 + ((pTier - 1) * 10)) + "%";
        }
        if (pTier >= 2)
        {
            descS += ". Soul skills cost 50% more but are twice as effective when above " + (90 - ((pTier - 1) * 10)) + "% Soulforce";
        }
        if (pTier >= 3)
        {
            descS += ". Soul skills become vampiric in nature, healing the user for 10% of their hp on use. This effect can only happen once per round";
        }
        if (pTier >= 4)
        {
            descS += ". While below half health, soul skill inflicts 20% more damage and leech twice as many hit points";
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
                this.requireHeartMutationSlot().requireRace(Races.ANUBIS);
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
            Reflect.setField(pBuffs, "wis.mult", 0.05);
        }
        if (pTier == 2)
        {
            Reflect.setField(pBuffs, "wis.mult", 0.15);
        }
        if (pTier == 3)
        {
            Reflect.setField(pBuffs, "wis.mult", 0.35);
        }
        if (pTier == 4)
        {
            Reflect.setField(pBuffs, "wis.mult", 0.75);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_HEART, 4);
    }
}
