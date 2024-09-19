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
import classes.Player;

class NaturalPunchingBagMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Natural Punching Bag";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier == 1)
        {
            descS = "Increases the damage reduction from Bouncy body by 5% and increase your natural toughness";
        }
        else if (pTier == 2)
        {
            descS = "Increases the damage reduction from Bouncy body by 15%, continue to increase your natural toughness and healing items are more effective";
        }
        else if (pTier == 3)
        {
            descS = "Increases the damage reduction from Bouncy body by 35%, continue to increase your natural toughness, healing/wrath/stat boosting items are more effective and allows you to keep the effect of bouncy body as long as you are below 4 feet tall";
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
                this.requireFatTissueMutationSlot().requirePerk(PerkLib.BouncyBody).requireCustomFunction(function(player : Player) : Bool
                        {
                            return player.isGoblinoid();
                        }, "Goblin race");
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
            Reflect.setField(pBuffs, "tou.mult", 0.35);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_FAT, 3);
    }
}

