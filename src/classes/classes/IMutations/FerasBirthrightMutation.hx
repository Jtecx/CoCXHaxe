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

class FerasBirthrightMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Fera's Birthright";
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
            descS += " restorative system modeled by creator of all corrupted werebeasts. (+";
        }
        if (pTier == 1)
        {
            descS += "0.5/1/2";
        }
        if (pTier == 2)
        {
            descS += "1/2/4";
        }
        if (pTier == 3)
        {
            descS += "1.5/3/6";
        }
        if (pTier == 4)
        {
            descS += "2/4/8";
        }
        if (pTier >= 1)
        {
            descS += "% HP regen during New moon / Half moon / Full moon";
        }
        if (pTier >= 3)
        {
            descS += " (doubled when in Crinos Shape)";
        }
        if (pTier >= 2)
        {
            descS += ", double bonuses to unarmed/armor/wrath gains in crinos form & half the cost of maintaining it";
        }
        if (pTier >= 3)
        {
            descS += ", once each fight when HP drops below 0 it would trigger Regeneration Surge ";
        }
        if (pTier == 3)
        {
            descS += "(+20% regen for 2 turns)";
        }
        if (pTier == 3)
        {
            descS += "(+40% regen for 3 turns)";
        }
        if (pTier == 4)
        {
            descS += ", +20% OverMax HP";
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
                this.requireAdaptationsMutationSlot().requireAnyRace(Races.WEREWOLF, Races.WERESHARK);
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
            Reflect.setField(pBuffs, "spe.mult", 0.01);
            Reflect.setField(pBuffs, "tou.mult", 0.01);
        }
        else if (pTier == 2)
        {
            Reflect.setField(pBuffs, "str.mult", 0.03);
            Reflect.setField(pBuffs, "spe.mult", 0.03);
            Reflect.setField(pBuffs, "tou.mult", 0.03);
        }
        else if (pTier == 3)
        {
            Reflect.setField(pBuffs, "str.mult", 0.07);
            Reflect.setField(pBuffs, "spe.mult", 0.07);
            Reflect.setField(pBuffs, "tou.mult", 0.07);
        }
        else if (pTier == 4)
        {
            Reflect.setField(pBuffs, "str.mult", 0.15);
            Reflect.setField(pBuffs, "spe.mult", 0.15);
            Reflect.setField(pBuffs, "tou.mult", 0.15);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_ADAPTATIONS, 4);
    }
}

