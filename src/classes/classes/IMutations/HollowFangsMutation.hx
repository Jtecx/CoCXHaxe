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

class HollowFangsMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Hollow Fangs";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier == 1)
        {
            descS = "Your fangs and mouth started to slowly change showing rudimental ability to suck out fluids like blood. (+5 max stack of Vampire Thirst)";
        }
        if (pTier == 2)
        {
            descS = "Your ability to suck substances like blood have developed halfway. (+5 max stack of Vampire Thirst, +2% more healed from Vampire Bite)";
        }
        if (pTier >= 3)
        {
            descS = "You can now freely feed on blood and other atypical fluids. (+10 max stack of Vampire Thirst, ";
        }
        if (pTier == 3)
        {
            descS = "+8% more healed from Vampire Bite, each Vampire Bite giving 2 stacks and deal +50% lust dmg)";
        }
        if (pTier == 4)
        {
            descS = "+20% more healed from Vampire Bite, each Vampire Bite giving 5 stacks and deal +100% lust dmg)";
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
                this.requireMouthMutationSlot().requireMutation(IMutationsLib.VampiricBloodstreamIM).requireCustomFunction(function(player : Player) : Bool
                                {
                                    return player.facePart.type == 34;
                                }, "Vampire fangs").requireAnyRace(Races.VAMPIRE, Races.DRACULA);
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
        if (pTier == 4)
        {
            Reflect.setField(pBuffs, "tou.mult", 0.6);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_MOUTH, 4);
    }
}

