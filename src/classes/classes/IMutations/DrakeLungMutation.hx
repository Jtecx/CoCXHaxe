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

class DrakeLungMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Drake Lung";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS = "Allows you to use breath attacks more often. (All dragon breaths usable once per combat)";
        }
        if (pTier >= 2)
        {
            descS = "Increases threefold the power of dragon breath attacks. (+300% to dragon breaths damage, +5% of max core Spe as phantom Spe)";
        }
        if (pTier >= 3)
        {
            descS = "Increases dragon breath attacks power and allows you to combine all 4 basic breath types more often. (+900% to dragon breaths damage, +20% of max core Spe as phantom Spe)";
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
                this.requireLungsMutationSlot().requireAnyPerk(PerkLib.DragonFireBreath, PerkLib.DragonIceBreath, PerkLib.DragonLightningBreath, PerkLib.DragonDarknessBreath, PerkLib.DragonPoisonBreath, PerkLib.DragonPoisonousSapBreath, PerkLib.DragonWaterBreath, PerkLib.DragonEarthBreath, PerkLib.DragonRegalBreath, PerkLib.DragonFaerieBreath).requireAnyRace(Races.DRAGON, Races.FROSTWYRM, Races.JABBERWOCKY, Races.VOUIVRE, Races.YGGDRASIL, Races.SEA_DRAGON, Races.FAERIEDRAGON, Races.DRAGONNE);
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
        if (pTier == 2)
        {
            Reflect.setField(pBuffs, "spe.mult", 0.15);
        }
        if (pTier == 3)
        {
            Reflect.setField(pBuffs, "spe.mult", 0.35);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_LUNGS, 3);
    }
}
