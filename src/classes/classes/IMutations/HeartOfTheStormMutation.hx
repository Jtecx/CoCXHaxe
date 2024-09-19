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

class HeartOfTheStormMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Heart Of The Storm";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "Increase the power of all Wind and Lightning racial abilities";
        }
        if (pTier >= 3)
        {
            descS += ", you can fly continuously as long as you yourself can fly, if you have energy attacks they now include a chance to stun";
        }
        if (pTier >= 2)
        {
            descS += " and you increase wind and electricity resistance by ";
            if (pTier == 2)
            {
                descS += "10%";
            }
            if (pTier == 3)
            {
                descS += "30%";
            }
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
                this.requireHeartMutationSlot().requireAnyRace(Races.RAIJU, Races.THUNDERBIRD, Races.KAMAITACHI, Races.COUATL, Races.KIRIN);
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
            Reflect.setField(pBuffs, "spe.mult", 0.05);
        }
        if (pTier == 2)
        {
            Reflect.setField(pBuffs, "spe.mult", 0.15);
        }
        if (pTier == 3)
        {
            Reflect.setField(pBuffs, "spe.mult", 0.35);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_HEART, 3);
    }
}

