package classes.items;

import classes.items.dynamic.DynamicShield;
import classes.items.shields.*;
import classes.PerkLib;
import classes.Races;

/**
	 * ...
	 * @author Kitteh6660
	 */
@:final class ShieldLib extends ItemConstants
{
    public function Legendary() : Array<Dynamic>
    {
        return legendaryPure().concat(LegendaryCorrupt());
    }
    public function legendaryPure() : Array<Dynamic>
    {
        return [
        SANCTYL
    ];
    }
    public function LegendaryCorrupt() : Array<Dynamic>
    {
        return [
        SANCTYD
    ];
    }
    
    public static inline var DEFAULT_VALUE : Float = 6;  //cena dla tarcz bazowa to 50 gems a nie 40 gems  
    
    public static var NOTHING : Nothing = new Nothing();
    
    public var AETHERS(default, never) : AetherS = new AetherS();
    public var ANC_CON(default, never) : AncientConduit = new AncientConduit();
    public var BATTNET(default, never) : Shield = new Shield("BattNet", "BattleNet", "Battle Net", "a Battle Net", 0, 100, "A battle net used in the off hand to impair the opponent's movement. Also very good for fishing.");
    public var BSHIELD(default, never) : BeautifulShield = new BeautifulShield();
    public var BLASPHE(default, never) : Shield = try cast(new Shield("Blasphe", "Blasphemy", "Blasphemy", "a Blasphemy", 1, 200, "Metal prayer beads, engraved with holy symbols of dead gods.", "Obsession").withPerk(PerkLib.Obsession, 0.2, 0.15, 0, 0), Shield) catch(e:Dynamic) null;
    public var BUCKLER(default, never) : Shield = new Shield("Buckler", "Buckler", "buckler", "a buckler", 5, 250, "A simple wooden rounded shield.");
    public var DRGNSHL(default, never) : DragonShellShield = new DragonShellShield();
    public var GREATSH(default, never) : GreatShield = new GreatShield();
    public var IMPTOME(default, never) : DynamicShield = ItemTemplateLib.instance.createShield("tome", ItemConstants.RARITY_MAGICAL, 0, ItemConstants.CS_HIDDEN_CURSED, [EnchantmentLib.RaceSpellPowerDoubled.spawn2(true, 1, Races.IMP)]);
    public var NEKONOM(default, never) : Shield = try cast(new Shield("Nekonomicon", "Nekonomicon", "Nekonomicon", "a Nekonomicon", 0, 500, 
        "A copy of the unholy texts of the Hellcat sect. Rumor has it their blasphemous lord Abraxas wrote it himself. (+100% power to fire and dark spell)"), Shield) catch(e:Dynamic) null;
    public var KITE_SH(default, never) : Shield = new Shield("Kite Sh", "KiteShield", "kite shield", "a kite shield", 14, 700, "An average-sized kite shield.");
    public var MABRACE(default, never) : Shield = try cast(new Shield("MaBrace", "ManaBracer", "mana bracer", "a mana bracer", 2, 200, 
                "Runed bracers such as this are popular amongst mages that can afford them. This silver bracer augments a mage’s spell power while leaving the hand open to make gestures used in spellcasting.", 
                "Magic").withBuff("spellpower", +0.5), Shield) catch(e:Dynamic) null;
    public var NECROSH(default, never) : NecroShield = new NecroShield();
    public var SPI_FOC(default, never) : SpiritFocus = new SpiritFocus();
    public var TRASBUC(default, never) : Shield = new Shield("TraSBuc", "TrainSBuckler", "training soul buckler", "a training soul buckler", 3, 300, "A simple rounded shield made of soulmetal used to train soulforce by soul cultivator novices.");
    public var TOWERSH(default, never) : Shield = new TowerShield();
    public var SANCTYN(default, never) : SanctuaryN = new SanctuaryN();
    public var SANCTYL(default, never) : Sanctuary = new Sanctuary();
    public var SANCTYD(default, never) : DarkAegis = new DarkAegis();
    public var SPIH_SH(default, never) : SpikedHeavyShield = new SpikedHeavyShield();
    public var SPIL_SH(default, never) : Shield = new Shield("SpiL Sh", "SpikeLShield", "spiked light shield", "a spiked light shield", 10, 750, "An average-sized shield with spikes.");
    public var SPIM_SH(default, never) : SpikedMassiveShield = new SpikedMassiveShield();
    public var Y_U_PAN(default, never) : Shield = new Shield("Y.U.Pan", "Y.U.Panel", "Yogi Uh Panel", "an Yogi Uh Panel", 0, 200, "This strange shield helps Summoners, Tamers and Golemancers store their pets inside an extra dimensional space when out of battle. The shield can then release them through a system of Calling Cards. Apparently it was a widely used tool for summoner battles back in the days which they called duels.");
    
    /*private static function mk(id:String,shortName:String,name:String,longName:String,effectId:Number,effectMagnitude:Number,value:Number,description:String,type:String,perk:String=""):Jewelry {
			return new Shield(id,shortName,name,longName,effectId,effectMagnitude,value,description,type,perk);
		}*/
    
    public function new()
    {
        super();
    }
}

