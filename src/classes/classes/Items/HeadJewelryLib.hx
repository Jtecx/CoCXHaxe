package classes.items;

import classes.items.headJewelries.*;

/**
	 * ...
	 * @author Ormael
	 */
@:final class HeadJewelryLib extends ItemConstants
{
    public static var MODIFIER_SF : Int = HEADEFF_SF;
    public static var MODIFIER_MP : Int = HEADEFF_MP;
    public static var MODIFIER_HP : Int = HEADEFF_HP;
    public static var MODIFIER_ATTACK_POWER : Int = HEADEFF_ATTACK_POWER;
    public static var MODIFIER_SPELL_POWER : Int = HEADEFF_SPELL_POWER;
    public static var MODIFIER_R_ATTACK_POWER : Int = HEADEFF_R_ATTACK_POWER;
    //public static const :int = 				7;
    public static var MODIFIER_WR : Int = HEADEFF_WR;
    public static var MODIFIER_FIRE_R : Int = HEADEFF_FIRE_R;
    public static var MODIFIER_ICE_R : Int = HEADEFF_ICE_R;
    public static var MODIFIER_LIGH_R : Int = HEADEFF_LIGH_R;
    public static var MODIFIER_DARK_R : Int = HEADEFF_DARK_R;
    public static var MODIFIER_POIS_R : Int = HEADEFF_POIS_R;
    public static var MODIFIER_MAGIC_R : Int = HEADEFF_MAGIC_R;
    public static var MODIFIER_LUST_R : Int = HEADEFF_LUST_R;
    public static var MODIFIER_PHYS_R : Int = HEADEFF_PHYS_R;
    
    public static inline var DEFAULT_VALUE : Float = 6;  //base cost 100 gems, each effect increase cost by 2x  
    
    public static var NOTHING : Nothing = new Nothing();
    
    public var AQBREATH(default, never) : HeadJewelry = new HeadJewelry("AqBreath", "Aqua breather", "Aqua breather", "an Aqua breather", 0, 0, 200, "This unfashionable, yet very practical, goblin device allows to breathe underwater. A must have for any underwater expedition.", HJT_HELMET);
    public var BESTBLAA(default, never) : BestialBlademasterAccoutrements = new BestialBlademasterAccoutrements();
    public var COWHAT(default, never) : HeadJewelry = new HeadJewelry("CGHAT", "C.G.Hat", "cow girl hat", "cow girl hat", 0, 0, 200, "This hat was retrieved from an offworld gunslinger who became a cow. As such aside from its powerful enchantment that increase firearms potency it also raise milk production.", HJT_HELMET);
    public var DEATHPR(default, never) : DeathPrinceRegalia = new DeathPrinceRegalia();
    public var DMONSKUL(default, never) : SkullOrnament = new SkullOrnament();
    public var DRABLOH(default, never) : HeadJewelry = new HeadJewelry("DraBloH", "DragonBloodHelmet", "Dragon Blood Helmet", "a Dragon Blood Helmet", 0, 0, 400, "An unnasumming helm made of iron with goat horns the large opening at the mouth and nose level allows for using breath attack unimpeded. Tho who worn this helmet in the days of the glorious dragon army where known to shout so loudly it would send people flying down clifts and mountain alike.", HJT_HELMET);
    public var FOXHAIR(default, never) : HeadJewelry = new HeadJewelry("FoxHair", "Fox Hairpin", "fox hairpin", "a fox hairpin", 0, 0, 800, "This hairpin, adorned with the design of a fox and blessed by Taoth, grants a kitsune increased magical power. (-20% spell and soulskills costs, +20% mag/lust dmg to fox fire specials)", HJT_HAIRPIN);
    public var GNHAIR(default, never) : HeadJewelry = new HeadJewelry("GNHair", "Golden Naga Hairpins", "pair of Golden Naga Hairpins", "a pair of Golden Naga Hairpins", 0, 0, 400, "This pair of lovely half moon-shaped golden hairpins are commonly used by the nagas to enhance their bodily charms. (+10% lust dmg from naga specials and +1 duration of Hypnosis)", HJT_HAIRPIN);
    public var HBHELM(default, never) : HBHelmet = new HBHelmet();
    public var KABUMEMP(default, never) : HeadJewelry = new HeadJewelry("KabuMemp", "KabutoMempo", "Kabuto & Mempo", "a Kabuto & Mempo", 0, 0, 100, "This fashionable and practical set of Kabuto (helmet) and Mempo (face mask) allow to protect whole head. Usualy worn alongside Samurai armor.", HJT_HELMET);
    public var MACHGOG(default, never) : MachinistGoggles = new MachinistGoggles();
    public var SATGOG(default, never) : SATechGoggle = new SATechGoggle();
    public var SCANGOG(default, never) : ScannerGoggle = new ScannerGoggle();
    public var SEERPIN(default, never) : SeersHairpin = new SeersHairpin();
    public var SKIGOGG(default, never) : HeadJewelry = new HeadJewelry("SkiGogg", "Ski goggles", "Ski goggles", "a Ski goggles", 0, 0, 400, "These goggles help shield your eyes against the snowstorms of the glacial rift, allowing you to see correctly in a blizzard like the denizens of the rift.", HJT_HELMET);
    public var SNOWFH(default, never) : SnowflakeHairpin = new SnowflakeHairpin();
    public var SPHINXAS(default, never) : SphinxAccessorySet = new SphinxAccessorySet();
    public var TSHAIR(default, never) : HeadJewelry = new HeadJewelry("TSHair", "T.S.Hairpin", "training soul hairpin", "training soul hairpin", 0, 0, 200, "This hairpin, made from soulmetal helps to train soulforce to the uttermost limit for novice soul cultivator. ", HJT_HAIRPIN);
    public var FIRECRO(default, never) : HeadJewelry = new HeadJewelry("FireCro", "Fire Crown", "crown of fire protection", "an enchanted crown of fire protection", MODIFIER_FIRE_R, 20, 3200, "This crown is topped with ruby gemstones. It is said that this will make you protected from fire.", HJT_CROWN);
    public var ICECROW(default, never) : HeadJewelry = new HeadJewelry("IceCrow", "Ice Crown", "crown of ice protection", "an enchanted crown of ice protection", MODIFIER_ICE_R, 20, 3200, "This crown is topped with sapphire gemstones. It is said that this will make you protected from ice.", HJT_CROWN);
    public var LIGHCRO(default, never) : HeadJewelry = new HeadJewelry("LighCro", "Ligh Crown", "crown of lightning protection", "an enchanted crown of lightning protection", MODIFIER_LIGH_R, 20, 3200, "This crown is topped with lapis lazuli gemstones. It is said that this will make you protected from lightning.", HJT_CROWN);
    public var DARKCRO(default, never) : HeadJewelry = new HeadJewelry("DarkCro", "Dark Crown", "crown of darkness protection", "an enchanted crown of darkness protection", MODIFIER_DARK_R, 20, 3200, "This crown is topped with onyx gemstones. It is said that this will make you protected from darkness.", HJT_CROWN);
    public var POISCRO(default, never) : HeadJewelry = new HeadJewelry("PoisCro", "Pois Crown", "crown of poison protection", "an enchanted crown of poison protection", MODIFIER_POIS_R, 20, 3200, "This crown is topped with pearls. It is said that this will make you protected from poison.", HJT_CROWN);
    public var LUSTCRO(default, never) : HeadJewelry = new HeadJewelry("LustCro", "Lust Crown", "crown of lust protection", "an enchanted crown of lust protection", MODIFIER_LUST_R, 20, 4800, "This crown is topped with amethyst gemstones. It is said that this will make you protected from lust.", HJT_CROWN);
    public var MAGICRO(default, never) : HeadJewelry = new HeadJewelry("MagiCro", "Magic Crown", "crown of magic protection", "an enchanted crown of magical protection", MODIFIER_MAGIC_R, 8, 6400, "This crown is topped with pyrite gemstones. It is said that this will make you protected from magic.", HJT_CROWN);
    public var PHYSCRO(default, never) : HeadJewelry = new HeadJewelry("PhysCro", "Phys Crown", "crown of physical protection", "an enchanted crown of physical protection", MODIFIER_PHYS_R, 12, 6400, "This crown is topped with hematite gemstones. It is said that this will make you protected from physical harm.", HJT_CROWN);
    public var CUNDKIN(default, never) : HeadJewelry = new HeadJewelry("CUndKing", "CroUndefKing", "Crown of the Undefeated King", "a Crown of the Undefeated King", 0, 0, 6000, "This splendid crown topped with many kinds of gems belonged in the past to the king, which claimed to be undefeated. But then how it get into your hands?", HJT_CROWN);
    //helmet(s) that giving armor and/or mres
    public var CROWINT(default, never) : HeadJewelry = try cast(new HeadJewelry("CrowInt", "CrownOfIntelligence", "Crown of Intelligence", "a Crown of Intelligence", 0, 0, 3200, "A simple crown to boost intelligence.", HJT_CROWN).withBuffs({
                    int.mult : +0.20
                }), HeadJewelry) catch(e:Dynamic) null;
    public var CROWLIB(default, never) : HeadJewelry = try cast(new HeadJewelry("CrowLib", "CrownOfLibido", "Crown of Libido", "a Crown of Libido", 0, 0, 3200, "A simple crown to boost libido.", HJT_CROWN).withBuffs({
                    lib.mult : +0.20
                }), HeadJewelry) catch(e:Dynamic) null;
    public var CROWSEN(default, never) : HeadJewelry = try cast(new HeadJewelry("CrowSen", "CrownOfSensitivity", "Crown of Sensitivity", "a Crown of Sensitivity", 0, 0, 3200, "A simple crown to boost sensitivity.", HJT_CROWN).withBuffs({
                    sens : +20
                }), HeadJewelry) catch(e:Dynamic) null;
    public var CROWSPE(default, never) : HeadJewelry = try cast(new HeadJewelry("CrowSpe", "CrownOfSpeed", "Crown of Speed", "a Crown of Speed", 0, 0, 3200, "A simple crown to boost speed.", HJT_CROWN).withBuffs({
                    spe.mult : +0.20
                }), HeadJewelry) catch(e:Dynamic) null;
    public var CROWSTR(default, never) : HeadJewelry = try cast(new HeadJewelry("CrowStr", "CrownOfStrength", "Crown of Strength", "a Crown of Strength", 0, 0, 3200, "A simple crown to boost strength.", HJT_CROWN).withBuffs({
                    str.mult : +0.20
                }), HeadJewelry) catch(e:Dynamic) null;
    public var CROWTOU(default, never) : HeadJewelry = try cast(new HeadJewelry("CrowTou", "CrownOfToughness", "Crown of Toughness", "a Crown of Toughness", 0, 0, 3200, "A simple crown to boost toughness.", HJT_CROWN).withBuffs({
                    tou.mult : +0.20
                }), HeadJewelry) catch(e:Dynamic) null;
    public var CROWWIS(default, never) : HeadJewelry = try cast(new HeadJewelry("CrowWis", "CrownOfWisdom", "Crown of Wisdom", "a Crown of Wisdom", 0, 0, 3200, "A simple crown to boost Wisdom.", HJT_CROWN).withBuffs({
                    wis.mult : +0.20
                }), HeadJewelry) catch(e:Dynamic) null;
    public var EZEKIELC(default, never) : HeadJewelry = new HeadJewelry("EzekielC", "EzekielCrown", "Ezekiel's Crown", "an Ezekiel's Crown", 0, 0, 400, "A crown rumored to be blessed by the Ezekiel himself. Is that real one or just another fake crown merchant sold you? (-4 to internal chimerical disposition)", HJT_CROWN);
    public var JIANGCT(default, never) : HeadJewelry = new HeadJewelry("JiangCT", "JiangshiCurseTag", "Jiangshi Curse Tag", "a Jiangshi Curse Tag", 0, 0, 400, "This item controls and alter your bodily function.", HJT_HELMET);
    public var SKULLCR(default, never) : SkullCrown = new SkullCrown();
    public var TREELCR(default, never) : TreeOfLifeCrown = new TreeOfLifeCrown();
    public var GHORNAM(default, never) : GoldenHornOrnament = new GoldenHornOrnament();
    
    public function new()
    {
        super();
    }
}

