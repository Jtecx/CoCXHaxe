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

class WhiteFacedOneBirthrightMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "White-Faced One Birthright";
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
            descS += " soul nexus-like organ modeled after White-Faced One. (+";
        }
        if (pTier == 1)
        {
            descS += "0.25/0.5/1";
        }
        if (pTier == 2)
        {
            descS += "0.5/1/2";
        }
        if (pTier == 3)
        {
            descS += "0.75/1.5/3";
        }
        if (pTier == 4)
        {
            descS += "1/2/4";
        }
        if (pTier >= 1)
        {
            descS += "% Soulforce regen per tail you posses (New moon / Half moon / Full moon";
        }
        if (pTier >= 2)
        {
            descS += "), +";
        }
        if (pTier == 2)
        {
            descS += "50";
        }
        if (pTier == 3)
        {
            descS += "75";
        }
        if (pTier == 4)
        {
            descS += "100";
        }
        if (pTier >= 2)
        {
            descS += "% to magical soulskills power (doubled if you have 3+ tails)";
        }
        if (pTier == 4)
        {
            descS += ", -10% of soulskills cost";
        }
        if (pTier >= 3)
        {
            descS += ", SF gains per level/Wisdom stat increased to ";
        }
        if (pTier == 3)
        {
            descS += "200%";
        }
        if (pTier == 4)
        {
            descS += "300%";
        }
        if (pTier == 4)
        {
            descS += ", +20% to OverMax Soulforce";
        }
        if (descS != "")
        {
            descS += ")";
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
                this.requireAdaptationsMutationSlot().requirePerk(PerkLib.Vulpesthropy).requireRace(Races.WEREFOX);
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
            Reflect.setField(pBuffs, "spe.mult", 0.01);
            Reflect.setField(pBuffs, "tou.mult", 0.01);
            Reflect.setField(pBuffs, "wis.mult", 0.03);
        }
        else if (pTier == 2)
        {
            Reflect.setField(pBuffs, "spe.mult", 0.03);
            Reflect.setField(pBuffs, "tou.mult", 0.03);
            Reflect.setField(pBuffs, "wis.mult", 0.09);
        }
        else if (pTier == 3)
        {
            Reflect.setField(pBuffs, "spe.mult", 0.07);
            Reflect.setField(pBuffs, "tou.mult", 0.07);
            Reflect.setField(pBuffs, "wis.mult", 0.2);
        }
        else if (pTier == 4)
        {
            Reflect.setField(pBuffs, "spe.mult", 0.15);
            Reflect.setField(pBuffs, "tou.mult", 0.15);
            Reflect.setField(pBuffs, "wis.mult", 0.42);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_ADAPTATIONS, 4);
    }
}

