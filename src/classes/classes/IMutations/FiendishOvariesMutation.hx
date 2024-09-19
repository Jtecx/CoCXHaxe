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

class FiendishOvariesMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Fiendish Ovaries";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "Increases fertility rating by " + ((pTier * 2) + 2) + "0%";
        }
        if (pTier >= 2)
        {
            descS += ", all born children from your womb will either be born as imps or greatly corrupted";
        }
        if (pTier >= 3)
        {
            descS += ", while pregnant with imps tease is " + ((pTier - 2) * 25) + "% stronger";
        }
        if (pTier >= 4)
        {
            descS += ". May benefit from pregomania when pregnant with imps";
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
                this.requireOvariesMutationSlot();
                requireCustomFunction(function(player : Player) : Bool
                                        {
                                            return player.hasVagina();
                                        }, "is Female").requireCustomFunction(function(player : Player) : Bool
                                {
                                    return player.femininity >= 95;
                                }, "95+ feminity").requireCustomFunction(function(player : Player) : Bool
                        {
                            return player.racialScore(Races.DEMON) > 14;
                        }, "Demon race (15+)");
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
            Reflect.setField(pBuffs, "lib.mult", 0.05);
        }
        if (pTier == 2)
        {
            Reflect.setField(pBuffs, "lib.mult", 0.1);
        }
        if (pTier == 3)
        {
            Reflect.setField(pBuffs, "lib.mult", 0.15);
        }
        if (pTier == 4)
        {
            Reflect.setField(pBuffs, "lib.mult", 0.2);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_OVARIES, 4);
    }
}

