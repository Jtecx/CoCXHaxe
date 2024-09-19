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

class SalamanderAdrenalGlandsMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Salamander Adrenal Glands";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "Your Salamander adrenal glands are giving you slight boost to your natural stamina";
        }
        if (pTier == 1)
        {
            descS += " and libido";
        }
        if (pTier == 2)
        {
            descS += ", strength, speed, libido and extend lustzerker and berserker duration by 2 turns";
        }
        if (pTier == 3)
        {
            descS += ", strength, speed and libido, extend lustzerker and berserker duration by 8 turns, allows for either or both to trigger on combat start, double bonus to attack, boost slight natural wrath generation rate";
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
                this.requireAdrenalGlandsMutationSlot().requirePerk(PerkLib.Lustzerker).requireAnyRace(Races.SALAMANDER, Races.PHOENIX, Races.KITSHOO);
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
            Reflect.setField(pBuffs, "lib.mult", 0.05);
        }
        else if (pTier == 2)
        {
            Reflect.setField(pBuffs, "tou.mult", 0.1);
            Reflect.setField(pBuffs, "lib.mult", 0.1);
            Reflect.setField(pBuffs, "str.mult", 0.05);
            Reflect.setField(pBuffs, "spe.mult", 0.05);
        }
        else if (pTier == 3)
        {
            Reflect.setField(pBuffs, "tou.mult", 0.15);
            Reflect.setField(pBuffs, "lib.mult", 0.15);
            Reflect.setField(pBuffs, "str.mult", 0.2);
            Reflect.setField(pBuffs, "spe.mult", 0.2);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_ADRENALS, 3);
    }
}

