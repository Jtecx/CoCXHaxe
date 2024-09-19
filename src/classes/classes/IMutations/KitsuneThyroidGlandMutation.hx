/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.iMutations;

import flash.errors.Error;
import classes.IMutationPerkType;
import classes.Creature;
import classes.PerkClass;
import classes.PerkLib;
import classes.Player;
import classes.bodyParts.Tail;

class KitsuneThyroidGlandMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Kitsune Thyroid Gland";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "Illusion and Terror cooldown reduced by 3 turns";
        }
        if (pTier >= 2)
        {
            descS += ", 50% reduced costs for Illusion and Terror";
        }
        if (pTier >= 3)
        {
            descS += ", speed debuff from Terror increased to 70, evasion boost from Illusion increased by 30%";
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
                this.requireThyroidGlandMutationSlot().requireAnyPerk(PerkLib.EnlightenedKitsune, PerkLib.CorruptedKitsune, PerkLib.StarSphereMastery).requireCustomFunction(function(player : Player) : Bool
                        {
                            return (player.tailType == Tail.FOX || player.tailType == Tail.KITSHOO) && player.tailCount >= 2;
                        }, "2+ fox/kitsumori tails");
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
    
    override public function buffsForTier(pTier : Int, target : Creature) : Dynamic
    {
        var pBuffs : Dynamic = { };
        if (pTier == 1)
        {
            Reflect.setField(pBuffs, "spe.mult", 0.05);
            Reflect.setField(pBuffs, "wis.mult", 0.05);
        }
        if (pTier == 2)
        {
            Reflect.setField(pBuffs, "spe.mult", 0.1);
            Reflect.setField(pBuffs, "wis.mult", 0.15);
        }
        if (pTier == 3)
        {
            Reflect.setField(pBuffs, "spe.mult", 0.15);
            Reflect.setField(pBuffs, "wis.mult", 0.35);
            Reflect.setField(pBuffs, "int.mult", 0.2);
        }
        return pBuffs;
    }
    
    //Mutations Buffs
    public function new()
    {
        super(mName + " IM", mName, SLOT_THYROID, 3);
    }
}

