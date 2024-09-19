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

class EasterBunnyEggBagMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Easter Bunny Egg Bag";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "Keep oviposition, easter bunny balls and egg throw ability so long as you have balls. May now shoot more then one egg per round";
        }
        if (pTier >= 2)
        {
            descS += ", Raise libido by a percentage based on current balls size";
        }
        if (pTier >= 3)
        {
            descS += ", Further raise libido by a percentage based on current balls size. Double balls growth rates and";
        }
        if (pTier == 1)
        {
            descS += " x2";
        }
        if (pTier == 2)
        {
            descS += " x3";
        }
        if (pTier == 3)
        {
            descS += " x6";
        }
        if (pTier >= 1)
        {
            descS += " cum production";
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
                this.requireBallsMutationSlot().requirePerk(PerkLib.EasterBunnyBalls).requireRace(Races.EASTERBUNNY);
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
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_TESTICLES, 3);
    }
}

