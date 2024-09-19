package classes.scenes.places.telAdre;

import classes.globalFlags.KFLAGS;
import classes.ItemType;
import classes.display.SpriteDb;

class WeaponShop extends Shop
{
    public function new()
    {
        super();
        story = baseStory.locate("WeaponShop");
    }
    
    override public function sprite() : Void
    {
        spriteSelect(SpriteDb.s_weaponsmith);
    }
    
    //-----------------
    //-- WEAPON SHOP
    //-----------------
    override private function inside() : Void
    {
        super.inside();
        addButton(0, weapons.CLAYMOR.shortName, confirmBuy, weapons.CLAYMOR);
        addButton(1, weapons.WARHAMR.shortName, confirmBuy, weapons.WARHAMR);
        addButton(2, weapons.BFSWORD.shortName, confirmBuy, weapons.BFSWORD);
        addButton(3, weapons.SPEAR.shortName, confirmBuy, weapons.SPEAR);
        addButton(4, weapons.LANCE.shortName, confirmBuy, weapons.LANCE);
        addButton(5, weapons.SCIMITR.shortName, confirmBuy, weapons.SCIMITR);
        addButton(6, weapons.MACE.shortName, confirmBuy, weapons.MACE);
        addButton(7, weapons.FLAIL.shortName, confirmBuy, weapons.FLAIL);
        addButton(8, weapons.HALBERD.shortName, confirmBuy, weapons.HALBERD);
        addButton(9, weapons.G_SHURI.shortName, confirmBuy, weapons.G_SHURI);
        addButton(10, weapons.DSWORD_.shortName, confirmBuy, weapons.DSWORD_);
        //11
        addButton(12, miscjewelries.ATLATL_.shortName, confirmBuy, miscjewelries.ATLATL_);
        if (player.hasKeyItem("Sheila's Lethicite") >= 0 || flags[kFLAGS.SHEILA_LETHICITE_FORGE_DAY] > 0)
        {
            addButton(13, "ScarBlade", forgeScarredBlade);
        }
        addButton(14, "Leave", telAdre.telAdreMenu);
    }
    
    private function forgeScarredBlade() : Void
    {
        clearOutput();
        doNext(inside);
        if (player.hasKeyItem("Sheila's Lethicite") >= 0)
        
        //remove Sheila's Lethicite key item, set sheilacite = 3, start sheilaforge timer, increment once per day at 0:00{
            
            display("scarredBlade/start");
            flags[kFLAGS.SHEILA_LETHICITE_FORGE_DAY] = model.time.days;
            player.removeKeyItem("Sheila's Lethicite");
        }
        else if (model.time.days - flags[kFLAGS.SHEILA_LETHICITE_FORGE_DAY] < 14)
        {
            display("scarredBlade/middle");
        }
        else if (model.time.days - flags[kFLAGS.SHEILA_LETHICITE_FORGE_DAY] >= 14)
        {
            display("scarredBlade/end");
            inventory.takeItem(weapons.SCARBLD, finishTakingScarredBlade, inside);
        }
        flushOutputTextToGUI();
        var finishTakingScarredBlade : Void->Void = function() : Void
        {
            flags[kFLAGS.SHEILA_LETHICITE_FORGE_DAY] = -1;
            inside();
        }
    }
}
