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

class GorgonEyesMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Gorgon Eyes";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "Allows you to use Petrify with any type of eyes and improves your resistance to attacks that are related to sight";
        }
        if (pTier == 2)
        {
            descS += ", increases your reactions & Petrify's duration";
        }
        if (pTier >= 3)
        {
            descS += ", increases your reactions & Petrify's duration (with bonus for having gorgon hair)";
        }
        if (pTier >= 2)
        {
            descS += ", and inverts the negative effects of resistances against basilisk and similars";
        }
        if (pTier == 3)
        {
            descS += ", same bonus as Eyes of the Hunter (Ex) perk but with limit to 5(10 w/ gorgon hair) lvl's, Petrify would work on any enemy even if they used invisibility ability (excluding been underground)";
        }
        if (pTier == 4)
        {
            descS += ", same bonus as Eyes of the Hunter (Ex) perk but with limit to 15(30 w/ gorgon hair) lvl's, Petrify would work on any enemy even if they used invisibility ability (excluding been underground), could use enhanced version of Petrification that is shorter but enemy HP/mana/SF recovery is fully stopped during it";
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
                this.requireEyesMutationSlot().requireCustomFunction(function(player : Player) : Bool
                                {
                                    return player.eyes.type == 4;
                                }, "Gorgon eyes").requireRace(Races.GORGON);
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
            Reflect.setField(pBuffs, "sens", 5);
        }
        if (pTier == 2)
        {
            Reflect.setField(pBuffs, "spe.mult", 0.15);
            Reflect.setField(pBuffs, "sens", 15);
        }
        if (pTier == 3)
        {
            Reflect.setField(pBuffs, "spe.mult", 0.45);
            Reflect.setField(pBuffs, "sens", 45);
        }
        if (pTier == 4)
        {
            Reflect.setField(pBuffs, "spe.mult", 1.5);
            Reflect.setField(pBuffs, "sens", 150);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_EYES, 4);
    }
}

