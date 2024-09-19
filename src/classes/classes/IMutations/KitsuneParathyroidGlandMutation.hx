/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.iMutations;

import flash.errors.Error;
import classes.bodyParts.Tail;
import classes.PerkClass;
import classes.PerkLib;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Races;

class KitsuneParathyroidGlandMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Kitsune Parathyroid Gland";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "50% reduced mana costs of FoxFire";
        }
        if (pTier >= 2)
        {
            descS += ", FoxFire +50% damage (fire and lust), Mana and SF recovery increased";
        }
        if (pTier >= 3)
        {
            descS += ", fatigue recover increased, +SF/Mana regen based on star sphere rank (Star Sphere rank x3/2 respectively), increase Star Sphere Max to 20";
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
                this.requireParathyroidGlandMutationSlot().requireAnyPerk(PerkLib.EnlightenedKitsune, PerkLib.CorruptedKitsune, PerkLib.StarSphereMastery).requireRacialGroup(Races.KitsunelikeRaces, "Any kitsune-like race");
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
            Reflect.setField(pBuffs, "int.mult", 0.05);
        }
        if (pTier == 2)
        {
            Reflect.setField(pBuffs, "spe.mult", 0.1);
            Reflect.setField(pBuffs, "int.mult", 0.15);
        }
        if (pTier == 3)
        {
            Reflect.setField(pBuffs, "spe.mult", 0.15);
            Reflect.setField(pBuffs, "int.mult", 0.35);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_PARATHYROID, 3);
    }
}

