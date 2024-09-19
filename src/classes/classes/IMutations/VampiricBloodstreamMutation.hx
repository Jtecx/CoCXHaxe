/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.iMutations;

import flash.errors.Error;
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Player;
import classes.Races;
import classes.StatusEffects;

class VampiricBloodstreamMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Vampiric Bloodstream";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "Your bloodstream has started to adapt to the presence of vampiric blood";
        }
        if (pTier >= 2)
        {
            descS += " Vampire Thirst stack now decays every " + decay() + " days.";
        }
        descS += " Increases the maximum numbers of stacks of Vampire Thirst by " + vampStackC();
        if (pTier >= 3)
        {
            descS += ", and increase their potency by " + potency() + "%";
        }
        if (pTier >= 4)
        {
            descS += ", each Vampire Bite giving 2 more stacks";
        }
        if (descS != "")
        {
            descS += ".";
        }
        return descS;
        
        var vampStackC : Void->Int = function() : Int
        {
            if (pTier == 1)
            {
                return 15;
            }
            if (pTier == 2)
            {
                return 45;
            }
            if (pTier == 3)
            {
                return 120;
            }
            if (pTier == 4)
            {
                return 300;
            }
            return 0;
        }
        
        var decay : Void->Int = function() : Int
        {
            if (pTier == 2 || pTier == 3)
            {
                return 2;
            }
            if (pTier == 4)
            {
                return 3;
            }
            return 1;
        }
        
        var potency : Void->Int = function() : Int
        {
            if (pTier == 3)
            {
                return 50;
            }
            if (pTier == 4)
            {
                return 100;
            }
            return 0;
        }
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
                this.requireBloodsteamMutationSlot().requireCustomFunction(function(player : Player) : Bool
                                {
                                    return player.hasStatusEffect(StatusEffects.VampireThirst);
                                }, "Vampire Thirst").requireAnyRace(Races.VAMPIRE, Races.DRACULA);
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
            Reflect.setField(pBuffs, "lib.mult", 0.15);
        }
        if (pTier == 3)
        {
            Reflect.setField(pBuffs, "lib.mult", 0.3);
        }
        if (pTier == 4)
        {
            Reflect.setField(pBuffs, "lib.mult", 0.6);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_BLOODSTREAM, 4);
    }
}

