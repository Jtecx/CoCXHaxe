package classes.items.weapons;

import classes.EventParser;
import classes.items.Weapon;
import classes.PerkLib;
import classes.TimeAwareInterface;

class Occulus extends Weapon implements TimeAwareInterface
{
    //Implementation of TimeAwareInterface
    //Recalculate Wizard's multiplier every hour
    public function timeChange() : Bool
    {
        updateWizardsMult();
        return false;
    }
    
    public function timeChangeLarge() : Bool
    {
        updateWizardsMult();
        return false;
    }
    
    //Normal weapon stuff
    public function new()
    {
        super("Occulus", "Occulus", "Occulus", "an Occulus", "bonk", 10, 1600, 
                "A wand rumored to have been the favorite catalyst of the now missing in action god of magic. The Occulus is rumored to have been seen and used as early as the genesis of Mareth. Occulus was made to create not to destroy and thus perform best when used to cast restorative magic. (greatly empowers healing spells, increases Spellpower based on purity)", 
                WT_WAND, WSZ_MEDIUM
        );
        withBuff("spellpower", +1.0);
        withTag(I_LEGENDARY);
        EventParser.timeAwareClassAdd(this);
    }
    
    public function calcWizardsMult() : Float
    {
        var multadd : Float = 1.0;
        if (game && game.player)
        {
            multadd += (100 - game.player.cor) * 0.04;
        }
        return multadd;
    }
    
    private static var lastCor : Float = 100;
    
    public function updateWizardsMult() : Void
    {
        if (game.player.cor != lastCor)
        {
            Reflect.setField(_buffs, "spellpower", calcWizardsMult());
            if (game.player.weapon == game.weapons.OCCULUS)
            
            //re-requip to update player's perk{
                
                var slot : Int = game.player.slotOfEquippedItem(this);
                afterUnequip(false, slot);
                afterEquip(false, slot);
            }
        }
        lastCor = game.player.cor;
    }
    
    override private function get_descBase() : String
    {
        if (game && game.player)
        {
            return _description + (
            (game.player.cor > 75) ? "\n\nYour demonic aura almost breaks the flow of energy inside the wand, decreasing its power!\n" : 
            (game.player.cor > 50) ? "\n\nYour corrupted aura interrupts your connection with the wand, decreasing its power.\n" : 
            (game.player.cor > 25) ? "\n\nYour aura slightly distorts the wand's energy flow, not allowing you to use its full power.\n" : 
            "\n\nYour pure energy flows through the wand, empowering it!\n");
        }
        else
        {
            return _description;
        }
    }
    
    override private function get_attack() : Float
    {
        var boost : Int = 0;
        var scal : Float = 25;
        if (game.player.str >= 50)
        {
            boost += 4;
            scal -= 5;
        }
        boost += Math.round(game.player.cor / scal);
        return (1 + boost);
    }
    
    override private function get_description() : String
    {
        updateWizardsMult();  //To display *correct* values  
        return super.description;
    }
}

