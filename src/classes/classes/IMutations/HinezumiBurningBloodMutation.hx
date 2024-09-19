/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.iMutations;

import flash.errors.Error;
import classes.bodyParts.Tail;
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Player;
import classes.Races;

class HinezumiBurningBloodMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Hinezumi Burning Blood";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "Increase the healing from the cauterize ability by 0.5%";
        }
        if (pTier >= 3)
        {
            descS += ", allows you to use Cauterize even if you're no longer a Hinezumi";
        }
        if (pTier >= 1)
        {
            descS += "and raise Blazing battle spirit duration by ";
        }
        if (pTier == 1)
        
        //Could have used tier....{
            
            descS += "1";
        }
        if (pTier == 2)
        
        ///but...{
            
            descS += "2";
        }
        if (pTier == 3)
        
        ///WHAM, 7. CAUSE WHY NOT.{
            
            descS += "7";
        }
        if (descS != "")
        {
            descS += " round(s).";
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
                this.requireBloodsteamMutationSlot().requireCustomFunction(function(player : Player) : Bool
                                {
                                    return player.tailType == Tail.HINEZUMI;
                                }, "Hinezumi tail").requireRace(Races.MOUSE, 2);
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
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_BLOODSTREAM, 3);
    }
}

