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

class ObsidianHeartMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Obsidian Heart";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "Devil.M Specials are available even if you do not qualify as devilkin, but will increase your corruption each use until it reaches 60";
        }
        if (pTier == 2)
        {
            descS += ", Maleficium's duration is increased by 5 turns and spellpower is boosted by 25%, Infernal Flare +~25%";
        }
        if (pTier == 3)
        {
            descS += ", Maleficium's duration is increased by 5 turns and spellpower is boosted by 150% + lowers lust resistance to 30%, Infernal Flare +~65% and 20% higher chance to crit";
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
                this.requireHeartMutationSlot().requireCor(100).requireRace(Races.DEVIL);
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
        if (pTier == 3)
        {
            Reflect.setField(pBuffs, "str.mult", 0.05);
            Reflect.setField(pBuffs, "tou.mult", 0.05);
            Reflect.setField(pBuffs, "spe.mult", 0.05);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_HEART, 3);
    }
}

