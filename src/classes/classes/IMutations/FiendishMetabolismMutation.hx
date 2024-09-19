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

class FiendishMetabolismMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Fiendish Metabolism";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "You may no longer gain nourishment from anything short of cum, milk and girl juice. If you have the demonic hunger perk, gain a stacking bonus of 10% to tease damage up to " + (pTier * 5) + "0%";
        }
        if (pTier >= 2)
        {
            descS += ". You may gain Fiendish metabolism bonus even without demonic hunger but gain half of the bonus. Gain immunity to all fluid negative effects and allows you to feed from sexual fluids";
        }
        if (pTier >= 3)
        {
            descS += ". Satisfying your crave for sex also raises your spell power for an amount equivalent to the tease damage bonus granted by this mutation";
        }
        if (pTier >= 4)
        {
            descS += ". Double all recovery from demonic hunger";
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
                this.requireMetabolismMutationSlot().requireAnyRace(Races.DEMON, Races.IMP);
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
            Reflect.setField(pBuffs, "lib.mult", 0.05);
        }
        if (pTier == 2)
        {
            Reflect.setField(pBuffs, "lib.mult", 0.1);
        }
        if (pTier == 3)
        {
            Reflect.setField(pBuffs, "lib.mult", 0.15);
        }
        if (pTier == 4)
        {
            Reflect.setField(pBuffs, "lib.mult", 0.2);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_METABOLISM, 4);
    }
}

