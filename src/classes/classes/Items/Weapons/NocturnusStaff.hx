package classes.items.weapons;

import classes.EventParser;
import classes.items.IELib;
import classes.items.Weapon;
import classes.PerkLib;
import classes.TimeAwareInterface;

class NocturnusStaff extends Weapon implements TimeAwareInterface
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
        super("N.Staff", "N. Staff", "nocturnus staff", "a nocturnus staff", "bonk", 23, 3680, 
                "This corrupted staff is made in black ebonwood and decorated with a bat ornament in bronze. Malice seems to seep through the item, devouring the wielder’s mana to channel its unholy power. (+200% Spell cost, Spellpower bonus for corruption)", 
                WT_STAFF, WSZ_LARGE
        );
        withBuff("spellpower", +1.0);
        withTag(I_LEGENDARY);
        withEffect(IELib.AttackBonus_Cor, 1 / 10);
        withEffect(IELib.ScaleAttack_Str, 60);
        EventParser.timeAwareClassAdd(this);
    }
    
    public function calcWizardsMult() : Float
    {
        var multadd : Float = 1.0;
        if (game && game.player)
        {
            multadd += game.player.cor * 0.09;
        }
        return multadd;
    }
    
    private static var lastCor : Float = 0;
    
    public function updateWizardsMult() : Void
    {
        if (game.player.cor != lastCor)
        {
            Reflect.setField(_buffs, "spellpower", calcWizardsMult());
            if (game.player.weapon == this)
            
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
            (game.player.cor < 25) ? "\n\nYour pure aura almost breaks the flow of energy inside the staff, decreasing its power!\n" : 
            (game.player.cor < 50) ? "\n\nYour pure aura sligtly interrupts your connection with the staff, decreasing its power.\n" : 
            (game.player.cor < 75) ? "\n\nYour corrupted aura slightly increases the staff's power.\n" : 
            "\n\nYour corrupted energy flows throgh the staff, empowering it!\n");
        }
        else
        {
            return _description;
        }
    }
    
    override private function get_description() : String
    {
        updateWizardsMult();  //To display *correct* values  
        return super.description;
    }
}

