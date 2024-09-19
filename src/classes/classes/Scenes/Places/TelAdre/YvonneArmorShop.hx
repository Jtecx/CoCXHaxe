package classes.scenes.places.telAdre;

import classes.globalFlags.KFLAGS;
import classes.CoC;
import classes.ItemType;
import classes.items.Armor;
import classes.scenes.SceneLib;
import classes.display.SpriteDb;

class YvonneArmorShop extends Shop
{
    public function new()
    {
        super();
        story = baseStory.locate("YvonneArmorShop");
    }
    
    override public function sprite() : Void
    {
        spriteSelect(SpriteDb.s_yvonne);
    }
    
    //-----------------
    //-- ARMOUR SHOP
    //-----------------
    override private function inside() : Void
    {
        super.inside();
        menu();
        addButton(0, armors.CHBIKNI.shortName, confirmBuy, armors.CHBIKNI);
        addButton(1, armors.FULLCHN.shortName, confirmBuy, armors.FULLCHN);
        addButton(2, armors.FULLPLT.shortName, confirmBuy, armors.FULLPLT);
        addButton(3, armors.INDECST.shortName, confirmBuy, armors.INDECST);
        addButton(4, armors.SCALEML.shortName, confirmBuy, armors.SCALEML);
        addButton(5, shields.BUCKLER.shortName, confirmBuy, shields.BUCKLER);
        addButton(6, shields.KITE_SH.shortName, confirmBuy, shields.KITE_SH);
        addButton(7, shields.SPIL_SH.shortName, confirmBuy, shields.SPIL_SH);
        addButton(8, shields.GREATSH.shortName, confirmBuy, shields.GREATSH);
        addButton(9, shields.TOWERSH.shortName, confirmBuy, shields.TOWERSH);
        addButton(10, armors.SAMUARM.shortName, confirmBuy, armors.SAMUARM);
        addButton(11, headjewelries.KABUMEMP.shortName, confirmBuy, headjewelries.KABUMEMP);
        if (player.hasKeyItem("Dragon Eggshell") >= 0 && player.gems >= 200)
        {
            addButton(12, "Eggshell", SceneLib.emberScene.getSomeStuff);
        }
        addButton(13, "Flirt", yvonneFlirt);
        addButton(14, "Leave", telAdre.telAdreMenu);
    }
    //[Flirt]
    private function yvonneFlirt() : Void
    {
        spriteSelect(SpriteDb.s_yvonne);
        clearOutput();
        display("yvonneFlirt/intro");
        dynStats("lus", 10 + player.lib / 10, "scale", false);
        if (player.cockTotal() == 0 || ((player.tallness > 65 || player.cockThatFits(75) == -1) && flags[kFLAGS.LOW_STANDARDS_FOR_ALL] == null))
        {
            display("yvonneFlirt/noGo");
            doNext(inside);
            return;
        }
        display("yvonneFlirt/go");
        simpleChoices("Fuck Her", fuckYvonneInZeBlacksmith, "Never mind", backOutOfYvonneFuck, "", null, "", null, "", null);
    }
    
    //[Never mind]
    private function backOutOfYvonneFuck() : Void
    {
        clearOutput();
        display("yvonneFlirt/backOut");
        doNext(inside);
    }
    
    //[Fuck]
    private function fuckYvonneInZeBlacksmith() : Void
    {
        spriteSelect(SpriteDb.s_yvonne);
        clearOutput();
        //X = cock that fits!
        display("fuckYvonneInZeBlacksmith");
        player.orgasm();
        dynStats("sen", -1);
        flags[kFLAGS.YVONNE_FUCK_COUNTER]++;
        doNext(camp.returnToCampUseOneHour);
    }
}
