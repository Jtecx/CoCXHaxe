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

class HumanMetabolismMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Human Metabolism";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "Your metabolism changes allowing to slowly detoxification of poisons ";
        }
        if (pTier >= 3)
        {
            descS += "or slight faster fatigue recovery ";
        }
        if (pTier >= 1)
        {
            descS += "(" + pTier + "0% chance to instantly remove some of toxic substance from body, -" + pTier + "% of lust";
        }
        if (pTier >= 3)
        {
            descS += " / -1% of fatigue";
        }
        if (pTier >= 1)
        {
            descS += " per turn";
        }
        if (pTier == 1)
        {
            descS += ")";
        }
        if (pTier >= 2)
        {
            descS += ", 2x shorter elemental dot effects duration)";
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
                this.requireBonesAndMarrowMutationSlot().requireCustomFunction(function(player : Player) : Bool
                        {
                            return player.racialScore(Races.HUMAN) > 16;
                        }, "Human race (17+)");
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
        super(mName + " IM", mName, SLOT_METABOLISM, 3);
    }
}

