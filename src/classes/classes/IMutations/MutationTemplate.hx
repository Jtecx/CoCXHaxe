/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.iMutations;

import flash.errors.Error;
import classes.IMutationPerkType;
import classes.Creature;
import classes.PerkClass;

class MutationTemplate extends IMutationPerkType
{
    override private function get_mName() : String
    {
        return "PerkName Here";
    }
    //v1 contains the mutation tier
    override public function mDesc(params : PerkClass, pTier : Int = -1) : String
    {
        var descS : String = "";
        pTier = ((pTier == -1)) ? currentTier(this, player) : pTier;
        if (pTier >= 1)
        {
            descS += "";
        }
        if (pTier >= 2)
        {
            descS += ", ";
        }
        if (pTier >= 3)
        {
            descS += ", ";
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
                this.requireHeartMutationSlot();
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
        //if (player.perkv3(this) == 1){} //This checks in player has the "true" mutation.
        /*
        if (pTier == 1) {
        pBuffs['spe.mult'] = 0;
        }
        if (pTier == 2){
        pBuffs['spe.mult'] = 0;
        }
        if (pTier == 3){
        pBuffs['spe.mult'] = 0;
        }*/
        return pBuffs;
    }
    
    public function new()
    {
        super();
        // replace SLOT_NONE with other SLOT_XXXX constant
        super(mName + " IM", mName, SLOT_NONE, 3, true);
    }
}

