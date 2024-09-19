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
import classes.Player;
import classes.Races;

class EquineMuscleMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Equine Muscle";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "+" + (pTier * 25) + "% to all Physical Ability damage. Gallop cost " + pTier + "0% less fatigue";
        }
        if (pTier >= 2)
        {
            descS += ". Physical ability consumes " + ((pTier - 1) * 5) + "% less fatigue";
        }
        if (pTier >= 3)
        {
            descS += ". Physical ability that stuns do so for one extra round";
        }
        if (pTier >= 4)
        {
            descS += ". While Galloping gains +10% evasion against ranged attack";
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
                this.requireMusclesMutationSlot().requireCustomFunction(function(player : Player) : Bool
                        {
                            return player.isAnyRaceCached(Races.HORSE, Races.CENTAUR, Races.UNICORN, Races.ALICORN, Races.LAQUINE);
                        }, "Horse/Centaur/Unicorn/Bicorn/Alicorn/Nightmare/Laquine race");
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
            Reflect.setField(pBuffs, "str.mult", 0.05);
        }
        if (pTier == 2)
        {
            Reflect.setField(pBuffs, "str.mult", 0.15);
        }
        if (pTier == 3)
        {
            Reflect.setField(pBuffs, "str.mult", 0.35);
        }
        if (pTier == 4)
        {
            Reflect.setField(pBuffs, "str.mult", 0.75);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_MUSCLE, 4);
    }
}

