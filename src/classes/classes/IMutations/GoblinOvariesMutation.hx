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

class GoblinOvariesMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Goblin Ovaries";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "Increase fertility rating by " + pTier + "0, While pregnant increase total libido by " + pTier + "0%. Double the number of kids you birth";
        }
        if (pTier >= 2)
        {
            descS += ". Increase physical damage done while pregnant by " + (pTier + 1) + "0%";
        }
        if (pTier == 3)
        {
            descS += ". Lust damage against male opponents increased by 25%";
        }
        if (pTier == 4)
        {
            descS += ". Lust damage against male opponents increased by 50%. Add your fertility score as a bonus to libido";
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
                this.requireOvariesMutationSlot().requireCustomFunction(function(player : Player) : Bool
                        {
                            return player.isGoblinoid();
                        }, "Goblin race");
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
            Reflect.setField(pBuffs, "lib.mult", 0.35);
        }
        if (pTier == 4)
        {
            Reflect.setField(pBuffs, "lib.mult", 0.75);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_OVARIES, 4);
    }
}

