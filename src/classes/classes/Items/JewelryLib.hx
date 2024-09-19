package classes.items;

import classes.items.jewelries.*;
import classes.PerkLib;

/**
	 * ...
	 * @author Kitteh6660
	 */
//Enchantment IDs
/*
	 * 0: Nothing
	 * 1: Minimum lust
	 * 2: Fertility
	 * 3: Soulforce
	 * 4: Fatigue
	 * 5: HP
	 * 6: Attack power
	 * 7: Spell power
	 * 8: Purity
	 * 9: Corruption
	 
	 */
@:final class JewelryLib extends ItemConstants
{
    public static var MODIFIER_MINIMUM_LUST : Int = RINGEFF_MINLUST;
    public static var MODIFIER_FERTILITY : Int = RINGEFF_FERTILITY;
    public static var MODIFIER_SF : Int = RINGEFF_SF;
    public static var MODIFIER_MP : Int = RINGEFF_MP;
    public static var MODIFIER_HP : Int = RINGEFF_HP;
    public static var MODIFIER_ATTACK_POWER : Int = RINGEFF_ATTACK_POWER;
    public static var MODIFIER_SPELL_POWER : Int = RINGEFF_SPELL_POWER;
    public static var PURITY : Int = RINGEFF_PURITY;
    public static var CORRUPTION : Int = RINGEFF_CORRUPTION;
    public static var MODIFIER_WR : Int = RINGEFF_WR;
    public static var MODIFIER_R_ATTACK_POWER : Int = RINGEFF_R_ATTACK_POWER;
    public static var MODIFIER_SOUL_POWER : Int = RINGEFF_SOUL_POWER;
    //		public static const MODIFIER_FIRE_R:int = 			;// add 'res_fire' buff
    //		public static const MODIFIER_ICE_R:int = 			;// add 'res_ice' buff
    //		public static const MODIFIER_LIGH_R:int = 			;// add 'res_lightning' buff
    //		public static const MODIFIER_DARK_R:int = 			;// add 'res_darkness' buff
    //		public static const MODIFIER_POIS_R:int = 			;// add 'res_poison' buff
    //		public static const MODIFIER_MAGIC_R:int = 			;// add 'res_magic' buff
    //		public static const MODIFIER_LUST_R:int = 			;// add 'res_lust' buff
    //		public static const MODIFIER_PHYS_R:int = 			;// add 'res_physical' buff
    
    public static inline var DEFAULT_VALUE : Float = 6;  //base cost 200 gems, each effect increase up to 2x cost  
    
    public static var NOTHING : Nothing = new Nothing();
    
    //Pre-Enchanted rings
    public var CRIMRNG(default, never) : Jewelry = try cast(new Jewelry("CrimRng", "Crimst.Ring", "crimstone ring", "an enchanted crimstone ring", RINGEFF_MINLUST, 10, 1000, "This ring is topped with crimstone. It is said that this will help to keep your desires burning.").withBuffs({
                    minlust : 10
                }), Jewelry) catch(e:Dynamic) null;
    public var FERTRNG(default, never) : Jewelry = new Jewelry("FertRng", "FertiteRing", "fertite ring", "an enchanted fertite ring", MODIFIER_FERTILITY, 20, 1000, "This ring is topped with fertite. It is said that this will make you more virile and fertile.");
    public var ICE_RNG(default, never) : Jewelry = try cast(new Jewelry("Ice_Rng", "Icestn.Ring", "icestone ring", "an enchanted icestone ring", RINGEFF_MINLUST, -10, 2000, "This ring is topped with icestone. It is said that this will counter ever-burning desires.").withBuffs({
                    minlust : -10
                }), Jewelry) catch(e:Dynamic) null;
    public var SOULRNG(default, never) : Jewelry = new Jewelry("SoulRng", "Soul Ring", "soulmetal ring", "a soulmetal ring", MODIFIER_SF, 100, 1250, "This simple ring is made from low quality soulmetal. Despite it seemly simplicity it allow for slight compresion of it weaver soulforce allowing storing a little bit more of it.");
    public var MANARNG(default, never) : Jewelry = new Jewelry("ManaRng", "Mana Ring", "ring of mana", "an enchanted alexandrite ring of mana", MODIFIER_MP, 200, 1250, "This ring is topped with alexandrite gemstone. It is said that this will make you feel having more mana.");
    public var LIFERNG(default, never) : Jewelry = new Jewelry("LifeRng", "Life Ring", "ring of life", "an enchanted emerald ring of life force", MODIFIER_HP, 350, 1000, "This ring is topped with emerald gemstone. It is said that this will make you feel healthier.");
    public var WRATRNG(default, never) : Jewelry = new Jewelry("WratRng", "Wrath Ring", "ring of wrath", "an enchanted peridot ring of wrath", MODIFIER_WR, 175, 1000, "This ring is topped with peridot gemstone. It is said that this will make you feel angrier.");
    public var MYSTRNG(default, never) : Jewelry = new Jewelry("MystRng", "Mystic Ring", "ring of mysticality", "an enchanted sapphire ring of mysticality", MODIFIER_SPELL_POWER, 25, 1500, "This ring is topped with sapphire gemstone. It is said that this will make your spells more powerful.");
    public var SPIRRNG(default, never) : Jewelry = new Jewelry("SpirRng", "Spiritual Ring", "ring of spiritual enlightenment", "an enchanted realgar ring of spiritual enlightenment", MODIFIER_SOUL_POWER, 25, 1500, "This ring is topped with realgar crystal. It is said that this will make your soulskills more powerful.");
    public var POWRRNG(default, never) : Jewelry = new Jewelry("PowrRng", "Power Ring", "ring of power (M)", "an enchanted ruby ring of power (M)", MODIFIER_ATTACK_POWER, 10, 1500, "This ring is topped with ruby gemstone. It is said that this will make your melee attacks feel a bit more powerful.");
    public var RPOWRNG(default, never) : Jewelry = new Jewelry("RPowRng", "R. Power Ring", "ring of power (R)", "an enchanted ruby ring of power (R)", MODIFIER_R_ATTACK_POWER, 10, 1500, "This ring is topped with ruby gemstone. It is said that this will make your range attacks feel a bit more powerful.");
    public var PURERNG(default, never) : Jewelry = new Jewelry("PureRng", "Purity Ring", "purity ring", "an enchanted purity ring", PURITY, 10, 3000, "This ring symbolizes chastity and purity. When worn, it reduces minimum libido and makes it harder for you to get turned on.");
    public var TSRNG(default, never) : Jewelry = new Jewelry("TSRng  ", "T.S.Ring", "training soul ring", "a training soul ring", 0, 0, 100, "This simple ring is made from special forged soulmetal. It help train soulforce to the uttermost limit for novice soul cultivator.");
    public var RINGDEA(default, never) : Jewelry = new Jewelry("RingDeA", "RingDeadeyeAim", "Ring of Deadeye Aim", "a Ring of Deadeye Aim", 0, 0, 600, "This unique ring helps to remove the ranged accuracy penalty due to flying, and increases ranged accuracy by 20%.");
    public var RNGAMBI(default, never) : Jewelry = new Jewelry("RngAmbi", "RingOfAmbidexty", "Ring of Ambidexterity", "a Ring of Ambidexterity", 0, 0, 600, "This unique ring helps to remove the melee accuracy penalty due to flying, and increases melee accuracy by 15%.");
    public var FIRERNG(default, never) : Jewelry = try cast(new Jewelry("FireRng", "Fire Ring", "ring of fire protection", "an enchanted ruby ring of fire protection", 0, 0, 800, "This ring is topped with ruby gemstone. It is said that this will make you protected from fire.").withBuffs({
                    res_fire : 5
                }), Jewelry) catch(e:Dynamic) null;
    public var ICERNG(default, never) : Jewelry = try cast(new Jewelry("IceRng ", "Ice Ring", "ring of ice protection", "an enchanted sapphire ring of ice protection", 0, 0, 800, "This ring is topped with sapphire gemstone. It is said that this will make you protected from ice.").withBuffs({
                    res_ice : 5
                }), Jewelry) catch(e:Dynamic) null;
    public var LIGHRNG(default, never) : Jewelry = try cast(new Jewelry("LighRng", "Ligh Ring", "ring of lightning protection", "an enchanted lapis lazuli ring of lightning protection", 0, 0, 800, "This ring is topped with lapis lazuli gemstone. It is said that this will make you protected from lightning.").withBuffs({
                    res_lightning : 5
                }), Jewelry) catch(e:Dynamic) null;
    public var DARKRNG(default, never) : Jewelry = try cast(new Jewelry("DarkRng", "Dark Ring", "ring of darkness protection", "an enchanted onyx ring of darkness protection", 0, 0, 800, "This ring is topped with onyx gemstone. It is said that this will make you protected from darkness.").withBuffs({
                    res_darkness : 5
                }), Jewelry) catch(e:Dynamic) null;
    public var POISRNG(default, never) : Jewelry = try cast(new Jewelry("PoisRng", "Pois Ring", "ring of poison protection", "an enchanted pearl ring of poison protection", 0, 0, 800, "This ring is topped with pearl. It is said that this will make you protected from poison.").withBuffs({
                    res_poison : 5
                }), Jewelry) catch(e:Dynamic) null;
    public var LUSTRNG(default, never) : Jewelry = try cast(new Jewelry("LustRng", "Lust Ring", "ring of lust protection", "an enchanted amethyst ring of lust protection", 0, 0, 1200, "This ring is topped with amethyst gemstone. It is said that this will make you protected from lust.").withBuffs({
                    res_lust : 5
                }), Jewelry) catch(e:Dynamic) null;
    public var MAGIRNG(default, never) : Jewelry = try cast(new Jewelry("MagiRng", "Magic Ring", "ring of magical protection", "an enchanted pyrite ring of magical protection", 0, 0, 1600, "This ring is topped with pyrite gemstone. It is said that this will make you protected from magic.").withBuffs({
                    res_magic : 2
                }), Jewelry) catch(e:Dynamic) null;
    public var PHYSRNG(default, never) : Jewelry = try cast(new Jewelry("PhysRng", "Phys Ring", "ring of physical protection", "an enchanted hematite ring of physical protection", 0, 0, 1600, "This ring is topped with hematite gemstone. It is said that this will make you protected from physical harm.").withBuffs({
                    res_physical : 3
                }), Jewelry) catch(e:Dynamic) null;
    //armor, mag resis protection rings
    public var UNDKINS(default, never) : Jewelry = new Jewelry("UndKinS", "UndefKingSignet", "Undefeated King's Signet", "an Undefeated King's Signet", MODIFIER_WR, 100, 2000, "A signet that belonged in the past to the king, which claimed to be undefeated. But then how it get into your hands?");
    public var FLLIRNG(default, never) : Jewelry = new Jewelry("FlLiRng", "FlameLizardRing", "Flame Lizard ring", "an Flame Lizard ring", MODIFIER_WR, 75, 3200, "Ring is encrusted with a few small emerald, peridot and carnelian gemstones. Usefull to use Lustzerker or boost it.", "Special: Generate 2/1 wrath per turn/hour. Allow to use Lustzerker.");
    public var INMORNG(default, never) : Jewelry = new Jewelry("InMoRng", "InfernalMouseRing", "Infernal Mouse ring", "an Infernal Mouse ring", MODIFIER_WR, 75, 3200, "Ring is encrusted with a few small emerald, peridot and sunstone gemstones. Usefull to use Blazing battle spirit or boost it.", "Special: Generate 2/1 wrath per turn/hour. Allow to use Blazing battle spirit.");
    public var MSIGNIT(default, never) : Jewelry = try cast(new Jewelry("MSignit", "Medius Signet", "Medius Signet", "a Medius Signet", 0, 0, 800, "A gift from your mentor, this ring bears the seal of an extinct clan of magi.", "Special: Ambition (+20% spell effect multiplier, 15% power boost/cost reduction for white magic)").withPerk(PerkLib.Ambition, 0.2, 0.15, 0, 0), Jewelry) catch(e:Dynamic) null;
    public var RINGINT(default, never) : Jewelry = try cast(new Jewelry("RingInt", "RingOfIntelligence", "Ring of Intelligence", "a Ring of Intelligence", 0, 0, 800, "A simple ring to boost intelligence.").withBuffs({
                    int.mult : 0.05
                }), Jewelry) catch(e:Dynamic) null;
    public var RINGLIB(default, never) : Jewelry = try cast(new Jewelry("RingLib", "RingOfLibido", "Ring of Libido", "a Ring of Libido", 0, 0, 800, "A simple ring to boost libido.").withBuffs({
                    lib.mult : 0.05
                }), Jewelry) catch(e:Dynamic) null;
    public var RINGSEN(default, never) : Jewelry = try cast(new Jewelry("RingSen", "RingOfSensitivity", "Ring of Sensitivity", "a Ring of Sensitivity", 0, 0, 800, "A simple ring to boost sensitivity.").withBuffs({
                    sens : 5
                }), Jewelry) catch(e:Dynamic) null;
    public var RINGSPE(default, never) : Jewelry = try cast(new Jewelry("RingSpe", "RingOfSpeed", "Ring of Speed", "a Ring of Speed", 0, 0, 800, "A simple ring to boost speed.").withBuffs({
                    spe.mult : 0.05
                }), Jewelry) catch(e:Dynamic) null;
    public var RINGSTR(default, never) : Jewelry = try cast(new Jewelry("RingStr", "RingOfStrength", "Ring of Strength", "a Ring of Strength", 0, 0, 800, "A simple ring to boost strength.").withBuffs({
                    str.mult : 0.05
                }), Jewelry) catch(e:Dynamic) null;
    public var RINGTOU(default, never) : Jewelry = try cast(new Jewelry("RingTou", "RingOfToughness", "Ring of Toughness", "a Ring of Toughness", 0, 0, 800, "A simple ring to boost toughness.").withBuffs({
                    tou.mult : 0.05
                }), Jewelry) catch(e:Dynamic) null;
    public var RINGWIS(default, never) : Jewelry = try cast(new Jewelry("RingWis", "RingOfWisdom", "Ring of Wisdom", "a Ring of Wisdom", 0, 0, 800, "A simple ring to boost wisdom.").withBuffs({
                    wis.mult : 0.05
                }), Jewelry) catch(e:Dynamic) null;
    public var EZEKIELS(default, never) : Jewelry = new Jewelry("EzekielS", "EzekielSignet", "Ezekiel's Signet", "an Ezekiel's Signet", 0, 0, 100, "A signet rumored to be blessed by the Ezekiel himself. Is that real one or just another fake signet merchant sold you?", "Special: -1 to internal chimerical disposition");
    public var CHIMEMBR(default, never) : Jewelry = new Jewelry("ChimEmbr", "ChimericEmbrace", "Chimeric Embrace", "a Chimeric Embrace", 0, 0, 400, "This shining ring is made of gold.");
    //public const RINGWIS:Bullseye = new RingWisdom();
    
    public var STARBAND(default, never) : Jewelry = new StarfireBand();
    //Normal ring
    public var DIAMRNG(default, never) : Jewelry = new Jewelry("DiamRng", "Diam Ring", "gold and diamond ring", "a shining gold and diamond ring", 0, 0, 1000, "This shining ring is made of gold and topped with diamond. Truly expensive.");
    public var GOLDRNG(default, never) : Jewelry = new Jewelry("GoldRng", "Gold Ring", "gold ring", "a shining gold ring", 0, 0, 400, "This shining ring is made of gold.");
    public var LTHCRNG(default, never) : Jewelry = new Jewelry("LthcRng", "Lethic.Ring", "lethicite ring", "a glowing lethicite ring", 1, 0, 5000, "This ring appears to be made of platinum with some lethicite crystal. Very expensive as lethicite is rare.");
    public var PLATRNG(default, never) : Jewelry = new Jewelry("PlatRng", "Plat Ring", "platinum ring", "a shining platinum ring", 0, 0, 1000, "This shining ring is made of platinum, one of the rare precious metals. It looks expensive!");
    public var SILVRNG(default, never) : Jewelry = new Jewelry("SilvRng", "Silver Ring", "silver ring", "a normal silver ring", 0, 0, 200, "This ring looks like it's made of silver.");
    public var ENDGRNG(default, never) : Jewelry = new Jewelry("EndgRng", "Engagement Ring", "engagement ring", "an engagement ring", 0, 0, 200, "A symbol of eternal love to gift to someone else. Indispensable to any wedding.");
    
    public function new()
    {
        super();
    }
}

