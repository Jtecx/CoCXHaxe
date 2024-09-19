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

class HeavyAyoArmor extends Armor
{
    
    public function new()
    {
        super();  //100 * armor + mres  
        super("HAyoArm", "HAyoArm", "heavy ayo armor", "a heavy ayo armor", 120, 20, 14000, "This suit of armor is more than typical heavy armor - it have added pieces of Ayo Tech that increase by a huge margin it properties as long user is capable to feed it on regular basis with soulforce.", "Heavy Ayo");
    }
    
    override private function get_def() : Float
    {
        if (game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] > 0)
        {
            return 120;
        }
        else
        {
            return 72;
        }
    }
    
    override private function get_mdef() : Float
    {
        if (game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] > 0)
        {
            return 20;
        }
        else
        {
            return 12;
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
                        str.mult : -0.20,
                        spe.mult : -0.20
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
        if (game.player.str >= 40 && game.player.spe >= 40)
        {
            return super.canEquip(doOutput, slot);
        }
        if (doOutput)
        {
            outputText("You aren't strong and agile enough to wear this armor!  Unless you likes to move slower than snail and hit weaked than wet noddle!  ");
        }
        return false;
    }
}

