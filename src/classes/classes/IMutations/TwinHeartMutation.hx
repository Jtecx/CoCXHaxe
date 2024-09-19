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

class TwinHeartMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Twin Heart";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier == 1)
        {
            descS = "+40% fatigue recovery, with tauric/drider body: +100% fatigue recovery, reduce Charge fatigue cost by ~10% as well as its cooldown by 1.";
        }
        if (pTier == 2)
        {
            descS = "+80% fatigue recovery, with tauric/drider body: +200% fatigue recovery, reduce Charge fatigue cost by ~20% as well as its cooldown by 2, increase damage by 20%.";
        }
        if (pTier == 3)
        {
            descS = "+120% fatigue recovery, with tauric/drider body: +300% fatigue recovery, reduce Charge fatigue cost by ~30% as well as its cooldown by 3, increase damage by 80%.";
        }
        if (pTier == 4)
        {
            descS = "+160% fatigue recovery, with tauric/drider body: +400% fatigue recovery, reduce Charge fatigue cost by ~40% as well as its cooldown by 4, increase damage by 200%.";
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
                this.requireAdaptationsMutationSlot().requireCustomFunction(function(player : Player) : Bool
                        {
                            return player.isRace(Races.CENTAUR) || player.isRace(Races.UNICORN, 2) || player.isRace(Races.SPHINX) || player.isRace(Races.CANCER) || player.isRace(Races.SANDWORM) || player.isTaur() || player.isDrider();
                        }, "Taur/Drider or Unicorn/Bicorn race");
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
            Reflect.setField(pBuffs, "spe.mult", 0.05);
        }
        else if (pTier == 2)
        {
            Reflect.setField(pBuffs, "tou.mult", 0.15);
            Reflect.setField(pBuffs, "spe.mult", 0.15);
        }
        else if (pTier == 3)
        {
            Reflect.setField(pBuffs, "tou.mult", 0.35);
            Reflect.setField(pBuffs, "spe.mult", 0.35);
        }
        else if (pTier == 4)
        {
            Reflect.setField(pBuffs, "tou.mult", 0.75);
            Reflect.setField(pBuffs, "spe.mult", 0.75);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_ADAPTATIONS, 4);
    }
}

