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

class FeyArcaneBloodstreamMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Fey Arcane Bloodstream";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "Your Fey Arcane Bloodstream grants you an eternal lifespan, increased mana recovery and increased magical power";
        }
        if (pTier >= 2)
        {
            descS += ", as well as increasing the chance that chaotic magic you invoke will trigger additional effects";
        }
        if (pTier >= 3)
        {
            descS += ", and increase said damage by 50%";
        }
        if (pTier >= 4)
        {
            descS += ". When using an ability with random effects, the impact of the effects are doubled";
        }
        if (descS != "")
        {
            descS += ".";
        }
        return descS;
    }
    
    override public function evolveText() : String
    {
        var descS : String = "\nYou feel quite energetic and particularly happy today. Maybe it's just your optimistic view of life or maybe it has more to do with your fae blood having increased in potency. You feel if you wanted you could turn the world up on its head with a single spell!";
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
                this.requireBloodsteamMutationSlot().requireAnyRace(Races.FAIRY, Races.FAERIEDRAGON);
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
        if (pTier == 4)
        {
            Reflect.setField(pBuffs, "int.mult", 0.75);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_BLOODSTREAM, 4);
    }
}

