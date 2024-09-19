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

class PigBoarFatMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Pig Boar Fat";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "Your altered fat tissue allows to increase your natural resistance to damage, toughness and thickness";
        }
        if (pTier == 1)
        {
            descS = "Increase max Hunger cap by 5 (if PC have Hunger bar active)";
        }
        if (pTier == 2)
        {
            descS = "Body Slam req. lower thickness to be used, increase max Hunger cap by 15 (if PC have Hunger bar active)";
        }
        if (pTier == 3)
        {
            descS = "Body Slam thickness requirement lowered and it power is doubled, pig/boar/red panda req. removed, increase max Hunger cap by 35 (if PC have Hunger bar active)";
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
                this.requireFatTissueMutationSlot().requireCustomFunction(function(player : Player) : Bool
                                {
                                    return player.thickness >= 100;
                                }, "100+ thickness").requireRace(Races.PIG);
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
            Reflect.setField(pBuffs, "tou.mult", 0.05);
        }
        if (pTier == 2)
        {
            Reflect.setField(pBuffs, "tou.mult", 0.15);
        }
        if (pTier == 3)
        {
            Reflect.setField(pBuffs, "tou.mult", 0.3);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_FAT, 3);
    }
}

