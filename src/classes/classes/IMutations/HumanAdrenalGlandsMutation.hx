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

class HumanAdrenalGlandsMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Human Adrenal Glands";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "Your human adrenal glands are giving you " + ((pTier >= 4) ? "" : "slight ") + "boost to your natural stamina";
        }
        if (pTier == 1)
        {
            descS += " and increasing Diehard limit by 5%";
        }
        if (pTier == 2)
        {
            descS += ", strength, speed and increasing Diehard limit by 10%";
        }
        if (pTier == 3)
        {
            descS += ", strength, speed, wrath gained naturaly increased and rising Diehard limit by 25%";
        }
        if (pTier == 4)
        {
            descS += ", strength, speed; wrath gained naturaly and from taking damage or dealing damage increased; rising Diehard limit by 50%";
        }
        if (descS != "")
        {
            descS += ".";
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
                this.requireAdrenalGlandsMutationSlot().requireCustomFunction(function(player : Player) : Bool
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
        if (player.racialScore(Races.HUMAN) > 17)
        {
            if (pTier == 1)
            {
                Reflect.setField(pBuffs, "tou.mult", 0.3);
            }
            else if (pTier == 2)
            {
                Reflect.setField(pBuffs, "tou.mult", 0.3);
                Reflect.setField(pBuffs, "str.mult", 0.3);
                Reflect.setField(pBuffs, "spe.mult", 0.3);
            }
            else if (pTier == 3)
            {
                Reflect.setField(pBuffs, "tou.mult", 0.7);
                Reflect.setField(pBuffs, "str.mult", 0.7);
                Reflect.setField(pBuffs, "spe.mult", 0.7);
            }
            else if (pTier == 4)
            {
                Reflect.setField(pBuffs, "tou.mult", 1.8);
                Reflect.setField(pBuffs, "str.mult", 1.8);
                Reflect.setField(pBuffs, "spe.mult", 1.8);
            }
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_ADRENALS, 4);
    }
}

