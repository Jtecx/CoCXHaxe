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

class NukiNutsMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Nuki Nuts";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "Gain a natural armor bonus based on your ball size, prevent the loss of money strike";
        }
        if (pTier >= 2)
        {
            descS += ", increases cum production, cumming has a chance of producing gems";
        }
        if (pTier >= 3)
        {
            descS += ", and doubles Money Strike damage";
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
                this.requireBallsMutationSlot().requireCustomFunction(function(player : Player) : Bool
                        {
                            return player.isRace(Races.RACCOON) && player.hasBalls() && player.ballSize > 5;
                        }, "Tanuki race and large balls");
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
            Reflect.setField(pBuffs, "lib.mult", 0.05);
        }
        if (pTier == 2)
        {
            Reflect.setField(pBuffs, "lib.mult", 0.15);
        }
        if (pTier == 3)
        {
            Reflect.setField(pBuffs, "lib.mult", 0.3);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_TESTICLES, 3);
    }
}

