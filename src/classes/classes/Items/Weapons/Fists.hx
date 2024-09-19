/**
 * Created by aimozg on 09.01.14.
 */
package classes.items.weapons;

import classes.items.Weapon;

class Fists extends Weapon
{
    
    public function new()
    {
        super("Fists  ", "Fists", "fists", "fists", "punch", 0, 0, "Type: Weapon (Unarmed) \nAttack: 0 \nBase value: N/A", WT_FISTS, WSZ_SMALL);
    }
    
    override public function useText() : Void
    {
    }  //No text for equipping fists  
    
    override public function canEquip(doOutput : Bool, slot : Int) : Bool
    {
        return true;
    }
    
    override private function get_isNothing() : Bool
    {
        return true;
    }
}

