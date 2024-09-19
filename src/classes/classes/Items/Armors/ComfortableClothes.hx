/**
 * Created by aimozg on 18.01.14.
 */
package classes.items.armors;

import classes.items.Armor;

class ComfortableClothes extends Armor
{
    
    public function new()
    {
        super("C.Cloth", "C.Cloth", "comfortable clothes", "a set of comfortable clothes", 0, 0, 10, "These loose fitting and comfortable clothes allow you to move freely while protecting you from the elements.", AP_LIGHT, true);
    }
    
    override private function get_supportsBulge() : Bool
    {
        return game.player.modArmorName != "crotch-hugging clothes";
    }
}

