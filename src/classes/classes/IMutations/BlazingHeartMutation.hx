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

class BlazingHeartMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Blazing Heart";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "Gain permanent weakness to cold and fire resistance. Increase fire damage by " + (25 * pTier) + "%";
        }
        if (pTier >= 2)
        {
            descS += ". Heat and Rut also grants you a bonus equal to ";
        }
        if (pTier == 2 || pTier == 3)
        {
            descS += "1";
        }
        if (pTier >= 4)
        {
            descS += "2";
        }
        if (pTier >= 2)
        {
            descS += "0% of the libido bonus to strength";
        }
        if (pTier >= 3)
        {
            descS += ". Setting an enemy on fire emboldens and arouses you, increasing damage dealt to burn enemies by 100% but also making you take lust damage as a recoil";
        }
        if (pTier >= 4)
        {
            descS += ". Fire active and passive abilities have a 20% chance to apply the burning status effect if they do not already";
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
                this.requireHeartMutationSlot().requireCustomFunction(function(player : Player) : Bool
                        {
                            return player.isRace(Races.FIRESNAILS) || player.isRace(Races.HELLCAT) || player.isRace(Races.PHOENIX) || player.isRace(Races.SALAMANDER) || player.isRace(Races.MOUSE, 2);
                        }, "fire snail, hellcat, phoenix, salamander or hinezumi race");
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
        else if (pTier == 2)
        {
            Reflect.setField(pBuffs, "lib.mult", 0.15);
        }
        else if (pTier == 3)
        {
            Reflect.setField(pBuffs, "lib.mult", 0.3);
        }
        else if (pTier == 4)
        {
            Reflect.setField(pBuffs, "lib.mult", 0.9);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_HEART, 4);
    }
}

