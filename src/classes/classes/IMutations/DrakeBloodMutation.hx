/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.iMutations;

import flash.errors.Error;
import classes.bodyParts.Tail;
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Player;
import classes.Races;

class DrakeBloodMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Drake Blood";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "Dragon strong vitality grants mana, soulforce and health regeneration " + pTier + "%";
        }
        if (pTier >= 2)
        {
            descS += ". You take " + (pTier - 1) * 5 + "% less damage from magical attack";
        }
        if (pTier >= 3)
        {
            descS += ". Magic Effect from you are " + (pTier - 2) * 25 + "% more powerful";
        }
        if (pTier >= 4)
        {
            descS += ". Magic Ability are 100% Stronguer";
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
                this.requireBloodsteamMutationSlot().requireAnyRace(Races.DRAGON, Races.FROSTWYRM, Races.JABBERWOCKY, Races.SEA_DRAGON);
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
            Reflect.setField(pBuffs, "tou.mult", 0.35);
        }
        if (pTier == 4)
        {
            Reflect.setField(pBuffs, "tou.mult", 0.75);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_BLOODSTREAM, 4);
    }
}

