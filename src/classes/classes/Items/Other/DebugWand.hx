package classes.items.other;

import classes.scenes.SceneLib;

class DebugWand extends SimpleUseable
{
    
    public function new()
    {
        super("DbgWand", "Debug Wand", "a wand of debugging", 1000, "This mysterious wand has an entirely unknown origin but somehow you feel like a cheater when using it.", "You raise the wand and a slab of stone emerges from the ground. The slab has fifteen buttons and a text panel.");
    }
    
    override public function canUse() : Bool
    {
        return true;
    }
    
    override public function useItem() : Bool
    {
        if (!game.debug)
        {
            SceneLib.inventory.takeItem(this, SceneLib.debugMenu.accessDebugMenu);
        }
        SceneLib.debugMenu.accessDebugMenu();
        return true;
    }
}

