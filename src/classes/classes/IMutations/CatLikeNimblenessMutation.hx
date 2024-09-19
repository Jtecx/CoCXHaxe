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

class CatLikeNimblenessMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Cat-like Nimbleness";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "Increases Evasion and allows you to keep Flexibility even without cat arms/legs/tail";
        }
        if (pTier >= 2)
        {
            descS += "";
        }
        if (pTier >= 3)
        {
            descS += "";
        }
        if (pTier >= 4)
        {
            descS += ", giving you 10% of max core Spe as phantom Spe";
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
                this.requireAdaptationsMutationSlot().requirePerk(PerkLib.Flexibility).requireRacialGroup(Races.CatlikeRaces, "Any cat race");
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
            Reflect.setField(pBuffs, "spe.mult", 0.1);
        }
        if (pTier == 3)
        {
            Reflect.setField(pBuffs, "spe.mult", 0.3);
        }
        if (pTier == 4)
        {
            Reflect.setField(pBuffs, "spe.mult", 0.5);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_ADAPTATIONS, 4);
    }
}

