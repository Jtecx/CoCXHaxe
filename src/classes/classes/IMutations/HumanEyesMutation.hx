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

class HumanEyesMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Human Eyes";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        var pAcc : Int = 5;
        if (pTier >= 3)
        {
            pAcc += 5;
        }
        if (pTier >= 4)
        {
            pAcc += 10;
        }
        if (pTier >= 1)
        {
            descS = "Increase precision of all attacks by " + pAcc + "%. Same bonus as Eyes of the Hunter (Ex) perk but with limit to ";
        }
        if (pTier == 1)
        {
            descS += "5 lvl's.";
        }
        if (pTier == 2)
        {
            descS += "10 lvl's.";
        }
        if (pTier == 3)
        {
            descS += "30 lvl's. 5% less penalty to acc per each next attack during multiattack.";
        }
        if (pTier == 4)
        {
            descS += "60 lvl's. 10% less penalty to acc per each next attack during multiattack. You could also see in darkness - Dark Vision.";
        }
        if (pTier >= 1)
        {
            descS += " (req. 18+ human score to have all effects active)";
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
                this.requireEyesMutationSlot().requireCustomFunction(function(player : Player) : Bool
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
            Reflect.setField(pBuffs, "spe.mult", 0.15);
            Reflect.setField(pBuffs, "sens", 15);
        }
        if (pTier == 2)
        {
            Reflect.setField(pBuffs, "spe.mult", 0.45);
            Reflect.setField(pBuffs, "sens", 45);
        }
        if (pTier == 3)
        {
            Reflect.setField(pBuffs, "spe.mult", 1.5);
            Reflect.setField(pBuffs, "sens", 150);
        }
        if (pTier == 4)
        {
            Reflect.setField(pBuffs, "spe.mult", 4.5);
            Reflect.setField(pBuffs, "sens", 450);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_EYES, 4);
    }
}

