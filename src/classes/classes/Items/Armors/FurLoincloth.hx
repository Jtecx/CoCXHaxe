/**
 * Created by aimozg on 11.01.14.
 */
//Not used in game
package classes.items.armors;

import classes.items.Armor;
import classes.items.ArmorLib;

@:final class FurLoincloth extends Armor
{
    public function new()
    {
        super("FurLoin", "FurLoin", "revealing fur loincloths", "a front and back set of loincloths", 0, 0, 100, "A pair of loincloths to cover your crotch and butt.  Typically worn by people named 'Conan'.", "Light");
    }
    
    override private function get_description() : String
    {
        return "A pair of loincloths to cover your crotch and " + game.player.buttDescript() + ".  Typically worn by people named 'Conan'. \n\nType: Clothing \nDefense: 0 \nBase value: 100";
    }
}
