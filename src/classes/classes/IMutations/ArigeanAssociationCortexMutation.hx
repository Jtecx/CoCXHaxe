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

class ArigeanAssociationCortexMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Arigean Association Cortex";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        //var perChg:int = 5 * pTier
        var descS : String = "";
        if (pTier == 1)
        {
            descS += "Overtime your way of thinking has changed to be more alike to that of an Arigean";
        }
        if (pTier == 2)
        {
            descS += "Your way of thinking has become even more alike to that of an Arigean";
        }
        if (pTier == 3)
        {
            descS += "Your way of thinking has become identical to that of an Arigean";
        }
        if (pTier == 4)
        {
            descS += "You’ve adapted a way of thinking that surpasses the normal Arigean. Unlocks the risky but rewarding Finality Barrage";
        }
        if (pTier >= 1)
        {
            descS += ". Charged shot, Mana shot and Mana Barrage all deal ";
        }
        if (pTier == 1)
        {
            descS += "20%";
        }
        if (pTier == 2)
        {
            descS += "50%";
        }
        if (pTier == 3)
        {
            descS += "90%";
        }
        if (pTier == 4)
        {
            descS += "140%";
        }
        if (pTier >= 1)
        {
            descS += " more damage";
        }
        if (pTier >= 2)
        {
            descS += " and now cost ";
        }
        if (pTier == 2)
        {
            descS += "20%";
        }
        if (pTier == 3)
        {
            descS += "30%";
        }
        if (pTier == 4)
        {
            descS += "40%";
        }
        if (pTier >= 2)
        {
            descS += " less mana";
        }
        if (pTier >= 3)
        {
            descS += ", additionally your mana regen is increased by ";
        }
        if (pTier == 3)
        {
            descS += "10%";
        }
        if (pTier == 4)
        {
            descS += "15%";
        }
        if (pTier >= 3)
        {
            descS += " of your toughness";
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
                this.requirePeripheralNervSysMutationSlot().requireRace(Races.ARIGEAN);
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
            Reflect.setField(pBuffs, "tou.mult", 0.06);
            Reflect.setField(pBuffs, "spe.mult", 0.04);
        }
        if (pTier == 2)
        {
            Reflect.setField(pBuffs, "tou.mult", 0.12);
            Reflect.setField(pBuffs, "spe.mult", 0.08);
        }
        if (pTier == 3)
        {
            Reflect.setField(pBuffs, "tou.mult", 0.24);
            Reflect.setField(pBuffs, "spe.mult", 0.16);
        }
        if (pTier == 4)
        {
            Reflect.setField(pBuffs, "tou.mult", 0.48);
            Reflect.setField(pBuffs, "spe.mult", 0.32);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_NERVSYS, 4);
    }
}

