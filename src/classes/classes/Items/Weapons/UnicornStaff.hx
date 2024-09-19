package classes.items.weapons;

import classes.EventParser;
import classes.items.IELib;
import classes.items.Weapon;
import classes.PerkLib;
import classes.TimeAwareInterface;

class UnicornStaff extends Weapon implements TimeAwareInterface
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
        super("U.Staff", "U. Staff", "unicorn staff", "a unicorn staff", "bonk", 23, 3680, 
                "This blessed staff is made in pearl-white sandalwood and decorated with a golden spiral pattern, reminiscent of a unicorn’s horn. The magic within seems to greatly enhance the user’s healing spells, not unlike those of the fabled creature that it emulates. Furthermore, the staff allows the user to preserve mana when casting using a minimal ammount of energy on each spell. (Spell Cost -50%, increases Spellpower based on purity)", 
                WT_STAFF, WSZ_LARGE
        );
        withBuff("spellpower", +1.0);
        withTag(I_LEGENDARY);
        withEffect(IELib.ScaleAttack_Str, 50);
        withEffect(IELib.AttackBonus_Cor, -1 / 10);
        EventParser.timeAwareClassAdd(this);
    }
    
    public function calcWizardsMult() : Float
    {
        var multadd : Float = 1.0;
        if (game && game.player)
        {
            multadd += (100 - game.player.cor) * 0.05;
        }
        return multadd;
    }
    
    private static var lastCor : Float = 100;
    
    public function updateWizardsMult() : Void
    {
        if (game.player.cor != lastCor)
        {
            Reflect.setField(_buffs, "spellpower", calcWizardsMult());
            if (game.player.weapon == game.weapons.U_STAFF)
            
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
            (game.player.cor > 75) ? "\n\nYour demonic aura almost breaks the flow of energy inside the staff, decreasing its power!\n" : 
            (game.player.cor > 50) ? "\n\nYour corrupted aura interrupts your connection with the staff, decreasing its power.\n" : 
            (game.player.cor > 25) ? "\n\nYour aura slightly distorts the staff's energy flow, not allowing you to use its full power.\n" : 
            "\n\nYour pure energy flows throgh the staff, empowering it!\n");
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

