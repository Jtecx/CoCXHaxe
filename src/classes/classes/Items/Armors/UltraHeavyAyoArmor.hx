/**
 * ...
 * @author Ormael
 */
package classes.items.armors;

import classes.globalFlags.KFLAGS;
import classes.ItemType;
import classes.items.Armor;
import classes.Player;
import classes.EngineCore;

class UltraHeavyAyoArmor extends Armor
{
    
    public function new()
    {
        super();  //150 * armor + mres  
        super("UHAyoArm", "UHAyoArm", "ultra heavy ayo armor", "an ultra heavy ayo armor", 180, 30, 31500, "This suit of armor is more than typical heavy armor - it have added pieces of Ayo Tech that increase by a large margin it properties as long user is capable to feed it on regular basis with soulforce.", "Ultra Heavy Ayo");
    }
    
    override private function get_def() : Float
    {
        if (game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] > 0)
        {
            return 180;
        }
        else
        {
            return 108;
        }
    }
    
    override private function get_mdef() : Float
    {
        if (game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] > 0)
        {
            return 30;
        }
        else
        {
            return 18;
        }
    }
    
    override public function afterEquip(doOutput : Bool, slot : Int) : Void
    {
        if (!game.isLoadingSave)
        {
            var oldHPratio : Float = game.player.hp100 / 100;
            game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] = 0;
            game.player.buff("Ayo Armor").remove();
            game.player.buff("Ayo Armor").addStats({
                        str.mult : -0.40,
                        spe.mult : -0.30,
                        tou.mult : -0.10
                    });
            game.player.HP = oldHPratio * game.player.maxHP();
            EngineCore.statScreenRefresh();
        }
        super.afterEquip(doOutput, slot);
    }
    
    override public function afterUnequip(doOutput : Bool, slot : Int) : Void
    {
        if (game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] > 0)
        {
            game.player.soulforce += game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR];
            if (game.player.soulforce > game.player.maxOverSoulforce())
            {
                game.player.soulforce = game.player.maxOverSoulforce();
            }
            game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] = 0;
        }
        game.player.buff("Ayo Armor").remove();
        super.afterUnequip(doOutput, slot);
    }
    
    override public function canEquip(doOutput : Bool, slot : Int) : Bool
    {
        if (game.player.str >= 100 && game.player.spe >= 100)
        {
            return super.canEquip(doOutput, slot);
        }
        if (doOutput)
        {
            outputText("You aren't strong and/or agile enough to wear this armor!  Unless you like to move slower than a snail and hit as weak as a wet noodle?  ");
        }
        return false;
    }
}

