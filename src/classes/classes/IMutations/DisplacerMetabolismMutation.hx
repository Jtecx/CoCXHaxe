/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.iMutations;

import flash.errors.Error;
import classes.globalFlags.KFLAGS;
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Races;

class DisplacerMetabolismMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Displacer Metabolism";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "Increase strength and speed, reduces int after consuming milk";
        }
        if (pTier >= 2)
        {
            descS += ", increase the milk STR and SPD boost by 100% * NG+, int reduction lasts 5 hours longer and adds 50% extra duration";
        }
        if (flags[kFLAGS.HUNGER_ENABLED] > 0)
        {
            descS += ", increases max hunger cap by 50";
        }
        if (descS != "")
        {
            descS += (", and increases displacer beast claws attack damage by x" + (pTier + 1));
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
                this.requireMetabolismMutationSlot().requireRace(Races.DISPLACERBEAST);
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
        super(mName + " IM", mName, SLOT_METABOLISM, 3);
    }
}

