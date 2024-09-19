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

class OrcAdrenalGlandsMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Orc Adrenal Glands";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        var fero : Int = 1;
        var phan : Int = 5;
        if (pTier >= 2)
        {
            fero += 2;
            phan += 10;
        }
        if (pTier >= 3)
        {
            phan += 15;
        }
        if (pTier >= 4)
        {
            fero += 5;
            phan += 20;
        }
        if (pTier >= 1)
        {
            descS += "Your Orc adrenal glands are increasing Ferocity limit by " + fero + "%, +" + phan + "% of max core Str as phantom Str";
        }
        if (pTier >= 2)
        {
            descS += ", increase your natural strength and tone";
        }
        if (pTier >= 3)
        {
            descS += ", boost natural wrath generation rate, allow to use Ferocity even when been no longer an orc";
        }
        if (pTier >= 4)
        {
            descS += ", out of combat when below 10% would not loose wrath and gain +2% per hour, +0.5% wrath generated in combat";
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
                this.requireAdrenalGlandsMutationSlot().requirePerk(PerkLib.Ferocity).requireRace(Races.ORC);
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
        if (pTier == 2)
        {
            Reflect.setField(pBuffs, "str.mult", 0.5);
        }
        if (pTier == 3)
        {
            Reflect.setField(pBuffs, "str.mult", 1);
        }
        if (pTier == 4)
        {
            Reflect.setField(pBuffs, "str.mult", 3);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_ADRENALS, 4);
    }
}

