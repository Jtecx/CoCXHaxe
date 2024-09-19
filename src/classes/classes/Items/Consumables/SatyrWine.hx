package classes.items.consumables;

import classes.items.*;
import classes.items.alchemy.AlchemyLib;
import classes.scenes.SceneLib;

/**
	 * Satyr Wine, part of the Black Cock by Foxxling
	 * @author Kitteh6660
	 */
class SatyrWine extends Consumable
{
    
    public function new()
    {
        super("SatyrWn", "SatyrWine", "a bottle of satyr wine", 20, "A dark bottle with a brilliant red liquid sloshing around inside. On the label there is a picture of a satyr playing pipes.");
        withTag(U_TF);
        refineableInto(
                AlchemyLib.DEFAULT_SUBSTANCES_DROP_TABLE, 
                AlchemyLib.MULTIRACE_ESSENCE_DROP_TABLE(AlchemyLib.AE_SATYR, AlchemyLib.AE_GOAT)
        );
    }
    
    override public function useItem() : Bool
    {
        outputText("Feeling parched you tug the cork from a bottle of wine. As you put the bottle to your lips and drink the rich, invigorating liquid you soon find yourself with an empty bottle and a smile. ");
        mutations.DrunkenPowerEmpowerIfPossible();
        mutations.AelfwineEmpowerIfPossible();
        player.refillHunger(10);
        SceneLib.bazaar.blackCock.satyrTFs();
        return false;
    }
}


