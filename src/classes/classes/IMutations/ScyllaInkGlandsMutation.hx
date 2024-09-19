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

class ScyllaInkGlandsMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Scylla Ink Glands";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "Your Scylla Ink Glands increase rate at which your body produce ink";
        }
        if (pTier >= 2)
        {
            descS += ", duration ink spray affect enemies and lust damage by " + (pTier - 1) + "00%";
        }
        if (pTier >= 1)
        {
            descS += ", boost to your natural strength";
        }
        if (pTier >= 3)
        {
            descS += ", speed";
        }
        if (pTier >= 2)
        {
            descS += " and toughness, Scylla Squeeze damage during grapple as Kraken would be multiplied by " + pTier + "x";
        }
        if (pTier >= 3)
        {
            descS += ", scylla grapple will always succeed, when in an aquatic battle boost from Aquatic Affinity is " + (pTier - 1) + "x larger";
        }
        if (pTier >= 4)
        {
            descS += ", final boost from aquatic battle boost is 2x higher, enemy can't escape from scylla grapple using only it own strength and using Scylla Squeeze as Kraken would give each time 4% combat wounds debuff on enemy (up to 80%)";
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
                this.requireAdaptationsMutationSlot().requirePerk(PerkLib.InkSpray).requireRace(Races.SCYLLA);
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
            Reflect.setField(pBuffs, "str.mult", 0.1);
        }
        else if (pTier == 2)
        {
            Reflect.setField(pBuffs, "str.mult", 0.3);
            Reflect.setField(pBuffs, "tou.mult", 0.05);
        }
        else if (pTier == 3)
        {
            Reflect.setField(pBuffs, "str.mult", 0.6);
            Reflect.setField(pBuffs, "tou.mult", 0.2);
            Reflect.setField(pBuffs, "spe.mult", 0.1);
        }
        else if (pTier == 4)
        {
            Reflect.setField(pBuffs, "str.mult", 1.8);
            Reflect.setField(pBuffs, "tou.mult", 0.6);
            Reflect.setField(pBuffs, "spe.mult", 0.3);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_ADAPTATIONS, 4);
    }
}

