/**
 * ...
 * @author Liadri
 */
package classes.items.headJewelries;

import classes.items.HeadJewelry;
import classes.StatusEffects;

class SnowflakeHairpin extends HeadJewelry
{
    
    public function new()
    {
        super("SnowfH", "Snowflake hairpin", "Snowflake hairpin", "a Snowflake hairpin", 0, 0, 400, "This hair ornament favored by Yuki Onna empowers ice abilities and magic but weaken fire magic as well. (+30% ice spell dmg, -30% fire spell dmg)", HJT_HAIRPIN);
    }
    
    override public function afterEquip(doOutput : Bool, slot : Int) : Void
    {
        if (!game.isLoadingSave)
        {
            while (game.player.hasStatusEffect(StatusEffects.YukiOnnaHairpin))
            {
                game.player.removeStatusEffect(StatusEffects.YukiOnnaHairpin);
            }
            game.player.createStatusEffect(StatusEffects.YukiOnnaHairpin, 0, 0, 0, 0);
        }
        super.afterEquip(doOutput, slot);
    }
    
    override public function afterUnequip(doOutput : Bool, slot : Int) : Void
    {
        while (game.player.hasStatusEffect(StatusEffects.YukiOnnaHairpin))
        {
            game.player.removeStatusEffect(StatusEffects.YukiOnnaHairpin);
        }
        super.afterUnequip(doOutput, slot);
    }
}


