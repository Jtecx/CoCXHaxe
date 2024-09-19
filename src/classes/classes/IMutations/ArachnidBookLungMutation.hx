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

class ArachnidBookLungMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Arachnid Book Lung";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "Increase web and poison capacity by " + 100 * pTier + "%";
        }
        if (pTier >= 2)
        {
            descS += ", increases all Web abilities effectiveness by half ";
        }
        if (pTier >= 3)
        {
            descS += ", and gives them a 50% chance to immobilize opponents for 2 rounds when opponent tries to struggle out";
        }
        if (descS != "")
        {
            descS += ".";
        }
        return descS;
    }
    
    override public function evolveText() : String
    {
        var descS : String = "\nYou feel change overcoming your body. It would seem your symbiotic relationship with your err… was it your upper or lower half… has improved? Your webs are more voluminous while your venom is thicker and more potent. You could bite and weave for days right now.";
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
                            return player.isRace(Races.SPIDER) || player.isRace(Races.ATLACH_NACHA, 2);
                        }, "Arachnid race");
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
            Reflect.setField(pBuffs, "int.mult", 0.05);
        }
        if (pTier == 2)
        {
            Reflect.setField(pBuffs, "int.mult", 0.15);
        }
        if (pTier == 3)
        {
            Reflect.setField(pBuffs, "int.mult", 0.3);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_ADAPTATIONS, 3);
    }
}

