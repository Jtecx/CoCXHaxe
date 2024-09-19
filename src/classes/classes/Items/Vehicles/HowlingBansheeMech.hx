/**
 * ...
 * @author Ormael
 */
package classes.items.vehicles;

import classes.items.Vehicles;
import classes.PerkLib;
import classes.Player;

class HowlingBansheeMech extends Vehicles
{
    public var boost(get, never) : Float;

    
    public function new()
    {
        super("HB Mech", "HowlingBansheeMech", "Howling Banshee Mech", "a Howling Banshee Mech", 0, 0, 2000, "This twenty meters tall mech is equipped with a comfortable seat, fit for a medium sized person. It white bipedal frame covered with white armor plates is customisable. \n\nType: Howling Banshee Mech \nBase value: 2000", "Mech");
        withBuffs({
                    str.mult : 0.15,
                    tou.mult : 0.10,
                    spe.mult : 0.25
                });
    }
    
    override public function canEquip(doOutput : Bool, slot : Int) : Bool
    {
        if (!super.canEquip(doOutput, slot))
        {
            return false;
        }
        if (game.player.basetallness < 84)
        
        //Shorter than 7 ft{
            
            if (doOutput)
            {
                outputText("You aren't tall enough to properly use this vehicle.\n\n");
            }
            return false;
        }  //bonus to piloting HBmech if elf subtype especialy psionic elf / eldar ^^  
        return true;
    }
    
    private function get_boost() : Float
    {
        var boost : Float = 1;
        if (game.player.hasKeyItem("HB Armor Plating") >= 0)
        {
            var value : Float = game.player.keyItemvX("HB Armor Plating", 1);
            boost += 0.25;
            if (value >= 2)
            {
                boost += 0.25;
            }
            if (value >= 3)
            {
                boost += 0.25;
            }
            if (value >= 4)
            {
                boost += 0.25;
            }
            if (value >= 5)
            {
                boost += 0.25;
            }
            if (value >= 6)
            {
                boost += 0.25;
            }
            if (value >= 7)
            {
                boost += 0.25;
            }
        }
        if (game.player.hasKeyItem("HB Leather Insulation") >= 0)
        {
            value = game.player.keyItemvX("HB Leather Insulation", 1);
            boost += 0.25;
            if (value >= 2)
            {
                boost += 0.25;
            }
            if (value >= 3)
            {
                boost += 0.25;
            }
            if (value >= 4)
            {
                boost += 0.25;
            }
            if (value >= 5)
            {
                boost += 0.25;
            }
            if (value >= 6)
            {
                boost += 0.25;
            }
            if (value >= 7)
            {
                boost += 0.25;
            }
        }
        return boost;
    }
    
    override public function afterEquip(doOutput : Bool, slot : Int) : Void
    {
        if (!game.isLoadingSave)
        {
            game.player.HP = boost * game.player.maxHP();
            game.player.HP = Math.round(game.player.HP);
        }
        super.afterEquip(doOutput, slot);
    }
    
    override public function afterUnequip(doOutput : Bool, slot : Int) : Void
    {
        game.player.HP /= boost;
        game.player.HP = Math.round(game.player.HP);
        super.afterUnequip(doOutput, slot);
    }
}

