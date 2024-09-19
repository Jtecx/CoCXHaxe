/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations;

import flash.errors.Error;
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Player;
import classes.Races;
import classes.scenes.nPCs.LunaFollower;

class AlphaHowlMutation extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "Alpha Howl";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "You may now form a pack. Unlock the pack attack Feral attack. ";
        }
        if (pTier >= 2)
        {
            descS += "Each additional pack member assists in your defense increasing damage reduction by 2%. ";
        }
        if (pTier >= 3)
        {
            descS += "Each additional pack member helps coordinate your offense, increasing your feral damage by 2% per member. ";
        }
        if (pTier >= 4)
        {
            descS += "Raise the bonus from Evolved to 5% and while a canine grants an increase to all stat of 5% per pack member. ";
        }
        descS += "You may have up to " + 5 * pTier + " pack members";
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
                this.requireLungsMutationSlot().requireCustomFunction(function(player : Player) : Bool
                        {
                            return player.isAnyRaceCached(Races.WEREWOLF, Races.WOLF, Races.CERBERUS, Races.ANUBIS);
                        }, "Werewolf/Wolf/Cerberus/Anubis race");
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
        var packMembers : Float = LunaFollower.WerewolfPackMember;
        if (target.hasMutation(IMutationsLib.HellhoundFireBallsIM))
        {
            packMembers += LunaFollower.HellhoundPackMember;
        }
        if (pTier == 1)
        {
            Reflect.setField(pBuffs, "str.mult", 0.05);
        }
        if (pTier == 2)
        {
            Reflect.setField(pBuffs, "str.mult", 0.15);
        }
        if (pTier == 3)
        {
            Reflect.setField(pBuffs, "str.mult", 0.30);
        }
        if (pTier == 4)
        {
            Reflect.setField(pBuffs, "str.mult", 0.45);
        }
        if (pTier == 4 && (player.isRaceCached(Races.WEREWOLF) || player.isRaceCached(Races.DOG) || player.isRaceCached(Races.WOLF) || player.isRaceCached(Races.CERBERUS)))
        {
            Reflect.field(pBuffs, "str.mult") += 0.05 * packMembers;
            Reflect.setField(pBuffs, "spe.mult", 0.05 * packMembers);
            Reflect.setField(pBuffs, "tou.mult", 0.05 * packMembers);
            Reflect.setField(pBuffs, "int.mult", 0.05 * packMembers);
            Reflect.setField(pBuffs, "wis.mult", 0.05 * packMembers);
            Reflect.setField(pBuffs, "lib.mult", 0.05 * packMembers);
        }
        return pBuffs;
    }
    
    public function new()
    {
        super(mName + " IM", mName, SLOT_LUNGS, 4, false);
    }
}

