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

class SharkOlfactorySystemMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Shark Olfactory System";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        var perkCent : Int = 0;
        var bleedCent : Int = 0;
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            perkCent += 10;
            bleedCent += 25;
        }
        if (pTier >= 2)
        {
            perkCent += 15;
            bleedCent += 25;
        }
        if (pTier >= 3)
        {
            perkCent += 20;
            bleedCent += 25;
        }
        if (pTier >= 4)
        {
            perkCent += 25;
            bleedCent += 25;
        }
        if (pTier >= 1)
        {
            descS += "Increase bleed damage by " + bleedCent + "%, allows non-sharks to use blood frenzy";
        }
        if (pTier >= 2)
        {
            descS += ", Bite no longer use fatigue";
        }
        if (pTier >= 2)
        {
            descS += " and can be used once a turn without ending player turn";
        }
        if (pTier >= 1)
        {
            descS += " increase melee damage against bleeding enemies by " + perkCent + " %";
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
                this.requirePeripheralNervSysMutationSlot().requireAnyRace(Races.SHARK, Races.ABYSSAL_SHARK, Races.WERESHARK, Races.SIREN);
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
            Reflect.setField(pBuffs, "spe.mult", 0.05);
        }
        else if (pTier == 2)
        {
            Reflect.setField(pBuffs, "wis.mult", 0.05);
            Reflect.setField(pBuffs, "spe.mult", 0.1);
        }
        else if (pTier == 3)
        {
            Reflect.setField(pBuffs, "int.mult", 0.05);
            Reflect.setField(pBuffs, "wis.mult", 0.1);
            Reflect.setField(pBuffs, "spe.mult", 0.15);
        }
        else if (pTier == 4)
        {
            Reflect.setField(pBuffs, "int.mult", 0.1);
            Reflect.setField(pBuffs, "wis.mult", 0.15);
            Reflect.setField(pBuffs, "spe.mult", 0.25);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_NERVSYS, 4);
    }
}

