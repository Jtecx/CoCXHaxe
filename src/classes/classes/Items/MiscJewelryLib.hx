/**
 * ...
 * @author Ormael
 */
package classes.items;

import classes.items.miscJewelries.*;

@:final class MiscJewelryLib extends ItemConstants
{
    public static inline var DEFAULT_VALUE : Float = 6;  //base cost 200 gems, each effect increase up to 2x cost  
    
    public static var NOTHING : Nothing = new Nothing();
    
    public var ATLATL_(default, never) : MiscJewelry = new MiscJewelry("Atlatl", "Atlatl", "Atlatl", "an Atlatl", 0, 0, 800, 0, "This spear-throwing lever allows to throw any throwable range weapon with greater accuracy and power.", "Atlatl");
    public var BAMOBAG(default, never) : MiscJewelry = new MiscJewelry("BAmoBag", "BoundlessAmmoBag", "Boundless Ammo Bag", "a Boundless Ammo Bag", 0, 0, 1600, 0, "Crafted with magically enchanted animal skins, this bag can keep nearly a near infinite supply of ammo for any firearm you have. Magical properties within will automatically reload your firearm's magazine by reacting to your will.", "Bag");
    public var DMAGETO(default, never) : DemonicMageTailOrnament = new DemonicMageTailOrnament();
    public var ONI_GOURD(default, never) : MiscJewelry = new MiscJewelry("OniDGou", "OniDGourd", "Oni enchanted drinking gourd", "an Oni enchanted drinking gourd", 0, 0, 1600, 0, "This gourd grants an infinite supply of non-transformative alcohol and greatly increases attack power. Furthermore, the drunken power duration is doubled when drinking from the gourd.", "Gourd");
    public var SNOWBOA(default, never) : MiscJewelry = new MiscJewelry("Snowboa", "Snowboard", "Snowboard", "a Snowboard", 0, 0, 400, 0, "Allows for faster movement across the glacial wastes and helps escape from opponents.", "Snowboard");
    public var EZEKIELSL(default, never) : MiscJewelry = new MiscJewelry("EzekielSl", "EzekielSeal", "Ezekiel's Seal", "an Ezekiel's Seal", 0, 0, 800, 0, "Seal containing tiny amount of Ezekiel power. Or so the rumors says. (+3 additional transformation chances)", "Seal");
    public var KRATIASL(default, never) : MiscJewelry = new MiscJewelry("KratiaSl", "KratiaSeal", "Kratia's Seal", "a Kratia's Seal", 0, 0, 800, 0, "Set of seals containing tiny amount of restrictive power. Creater claims it's good for training. (+100(150) to effective level difference when fighting any enemy (training dummy))", "Seal");
    
    public function new()
    {
        super();
    }
}

