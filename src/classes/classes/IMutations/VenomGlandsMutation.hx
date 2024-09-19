/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.iMutations;

import flash.errors.Error;
import classes.bodyParts.Face;
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Player;
import classes.Races;

class VenomGlandsMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Venom Glands";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier == 1)
        {
            descS = "You now possess venom glands, and your teeth now can inject the venom when you bite";
        }
        if (pTier == 2)
        {
            descS = "You now possess venom glands with increased venom capacity, and your teeth now can inject the venom when you bite (+5% poison resistance)";
        }
        if (pTier == 3)
        {
            descS = "You now possess venom glands with increased venom capacity, and your teeth now can inject the venom when you bite (+15% poison resistance)";
        }
        if (pTier == 4)
        {
            descS = "You now possess venom glands with greatly increased venom capacity, and your teeth now can inject the venom when you bite (+30% poison resistance)";
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
                this.requireMouthMutationSlot().requireCustomFunction(function(player : Player) : Bool
                                {
                                    return player.facePart.isAny(Face.SNAKE_FANGS, Face.SPIDER_FANGS);
                                }, "Spider or Snake fangs").requireAnyRace(Races.SPIDER, Races.APOPHIS, Races.NAGA, Races.GORGON, Races.VOUIVRE, Races.COUATL, Races.HYDRA, Races.ATLACH_NACHA);
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

