/**
 * ...
 * @author Ormael
 */
package classes.items.vehicles;

import classes.bodyParts.Tail;
import classes.bodyParts.Wings;
import classes.items.Vehicles;
import classes.PerkLib;
import classes.Player;
import classes.Races;

class GiantSlayerMech extends Vehicles
{
    
    public function new()
    {
        super("GS Mech", "GiantSlayerMech", "Giant Slayer Mech", "a Giant Slayer Mech", 0, 0, 2000, "A customisable goblin invention, this bipedal, large mech is equipped with a comfortable seat, fit for a goblin or a small person. Within it you feel like you could kill gods or well gigants... \n\nType: Goblin Mech \nBase value: 2000", "Mech");
    }
    
    override public function canEquip(doOutput : Bool, slot : Int) : Bool
    {
        if (!super.canEquip(doOutput, slot))
        {
            return false;
        }
        if (game.player.isRace(Races.ELF) || game.player.isRace(Races.WOODELF))
        
        //Elf{
            
            if (doOutput)
            {
                outputText("No way you’re going into this mechanical abomination. You’re an Elf and as such you have a natural disgust of technology, not to mention the claustrophobia.\n\n");
            }
            return false;
        }
        if (game.player.basetallness > 66 || game.player.haveWingsForWingSlap())
        
        //Taller than 5'6" ft{
            
            if (doOutput)
            {
                outputText("Your current size prevents you from properly entering the small compact cockpit of the vehicle.\n\n");
            }
            return false;
        }
        return true;
    }
    
    override public function afterEquip(doOutput : Bool, slot : Int) : Void
    {
        if (!game.isLoadingSave)
        
        //status effect to later track when mech enter enrage/stage 2 mode{
            
            if (game.player.hasKeyItem("Upgraded Armor plating 1.0") >= 0 || game.player.hasKeyItem("Upgraded Leather Insulation 1.0") >= 0)
            {
                var EHP : Float = 1;
                if (game.player.hasKeyItem("Upgraded Armor plating 1.0") >= 0)
                {
                    EHP += 0.25;
                }
                if (game.player.hasKeyItem("Upgraded Armor plating 2.0") >= 0)
                {
                    EHP += 0.5;
                }
                if (game.player.hasKeyItem("Upgraded Armor plating 3.0") >= 0)
                {
                    EHP += 0.75;
                }
                if (game.player.hasKeyItem("Upgraded Armor plating 4.0") >= 0)
                {
                    EHP += 1;
                }
                if (game.player.hasKeyItem("Upgraded Armor plating 5.0") >= 0)
                {
                    EHP += 1.25;
                }
                if (game.player.hasKeyItem("Upgraded Armor plating 6.0") >= 0)
                {
                    EHP += 1.5;
                }
                if (game.player.hasKeyItem("Upgraded Leather Insulation 1.0") >= 0)
                {
                    EHP += 0.25;
                }
                if (game.player.hasKeyItem("Upgraded Leather Insulation 2.0") >= 0)
                {
                    EHP += 0.5;
                }
                if (game.player.hasKeyItem("Upgraded Leather Insulation 3.0") >= 0)
                {
                    EHP += 0.75;
                }
                game.player.HP = EHP * game.player.maxHP();
            }
            outputText("As you turn the mech on the welcoming voice of your AI booms in. \"<i>Welcome back aboard operator [name]. All functions are nominal.</i>\"");
        }
        super.afterEquip(doOutput, slot);
    }
    
    override public function afterUnequip(doOutput : Bool, slot : Int) : Void
    {
        if (game.player.hasKeyItem("Upgraded Armor plating 1.0") >= 0 || game.player.hasKeyItem("Upgraded Leather Insulation 1.0") >= 0)
        {
            var RHP : Float = 1;
            if (game.player.hasKeyItem("Upgraded Armor plating 1.0") >= 0)
            {
                RHP += 0.25;
            }
            if (game.player.hasKeyItem("Upgraded Armor plating 2.0") >= 0)
            {
                RHP += 0.5;
            }
            if (game.player.hasKeyItem("Upgraded Armor plating 3.0") >= 0)
            {
                RHP += 0.75;
            }
            if (game.player.hasKeyItem("Upgraded Armor plating 4.0") >= 0)
            {
                RHP += 1;
            }
            if (game.player.hasKeyItem("Upgraded Armor plating 5.0") >= 0)
            {
                RHP += 1.25;
            }
            if (game.player.hasKeyItem("Upgraded Armor plating 6.0") >= 0)
            {
                RHP += 1.5;
            }
            if (game.player.hasKeyItem("Upgraded Leather Insulation 1.0") >= 0)
            {
                RHP += 0.25;
            }
            if (game.player.hasKeyItem("Upgraded Leather Insulation 2.0") >= 0)
            {
                RHP += 0.5;
            }
            if (game.player.hasKeyItem("Upgraded Leather Insulation 3.0") >= 0)
            {
                RHP += 0.75;
            }
            game.player.HP /= RHP;
        }
        game.player.HP = Math.round(game.player.HP);
        super.afterUnequip(doOutput, slot);
    }
}

