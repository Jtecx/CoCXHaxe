/**
 * Created by aimozg on 09.01.14.
 */
package classes.items;

import classes.iMutations.BlackHeartMutation;
import classes.items.dynamic.DynamicWeapon;
import classes.items.weapons.*;
import classes.PerkLib;
import classes.Races;

@:final class WeaponLib extends ItemConstants
{
    //1 atk for dual weapons = 80 lub 160 jeśli z dodatkowym perkiem lub 240 jeśli z dwoma dodatkowymi perkami
    //40 za 1 atk normalnie lub za wrath weapon lub 80 za 1 atk broni z perkiem/dod. efektem lub 120 za 1 atk broni z 2 perki/dod. efekty itd.
    //200 za 1 atk broni typu gaunlet (bo każda ma jakiś efekt lub perk dodany) lub 400 za 1 atk jeśli ma 2 efekty/perki lub 600 jak ma 3 itd.
    
    /** @paam subtypeId key in DynamicWeapon.Subtypes */
    private static function findCommonDynamicWeapon(subtypeId : String) : DynamicWeapon
    {
        return ItemTemplateLib.instance.createWeapon(subtypeId, RARITY_COMMON, 0, CS_KNOWN_UNCURSED, []);
    }
    
    public function Legendary() : Array<Dynamic>
    {
        return legendaryPure().concat(LegendaryCorrupt()).concat(NEXUS);
    }
    public function legendaryPure() : Array<Dynamic>
    {
        return [
        NPHBLDE, 
        T_HEART, 
        KARMTOU, 
        MASAMUN, 
        U_STAFF, 
        LHSCYTH, 
        MOONLIT, 
        WG_GAXE, 
        SESPEAR, 
        Q_GUARD, 
        POCDEST, 
        ARMAGED, 
        OCCULUS, 
        EXCALIB, 
        DEXCALI, 
        PARACEL, 
        ASTERIUS, 
        ELYSIUM
    ];
    }
    public function LegendaryCorrupt() : Array<Dynamic>
    {
        return [
        EBNYBLD, 
        DORSOUL, 
        YAMARG, 
        BLETTER, 
        N_STAFF, 
        HELRAIS, 
        C_BLADE, 
        DE_GAXE, 
        DSSPEAR, 
        B_WIDOW, 
        DOCDEST, 
        CHAOSEA, 
        ECLIPSE, 
        HELLCAL
    ];
    }
    
    public static inline var DEFAULT_VALUE : Float = 6;
    
    public static var FISTS : Fists = new Fists();
    
    // Template for new weapons
    
    //		public const CONSTANTNAME:Weapon = new Weapon(
    //				"id", "ButtonLabel","name","the long name", attack number, price number,
    //				"Tooltip description",
    //				WT_WEAPONTYPE, WSZ_WEAPONSSIZE, dual true/false) // dual is false by default
    //				// optional: buffs
    //				.withBuffs({
    //					'statname': buff value number
    //				})
    //				// optional: perk on equip
    //				.withPerk(PerkLib.Something)
    //				// optional: item tags
    //				.withTags(I_SOMETHING, W_SOMETHING)
    //				// optional: item effect
    //				.withEffect(IELib.Effect, power number)
    //				// optional: item effect with extra values
    //				.withEffect(IELib.Effect, power number, value1, value2, value3, value4) as Weapon;
    //				// 'as Weapon' is needed after last ')' if any of '.withSomething' was used
    
    public var A_STAFF(default, never) : Weapon = try cast(new Weapon(
                "A.Staff", "A. Staff", "amethyst staff", "an amethyst staff", "smack", 2, 240, 
                "This staff is made of very old wood and seems to tingle to the touch.  The top has amethyst embedded in it, and the wood is worn smooth from lots of use.  It probably belonged to a wizard at some point and would aid magic use.", 
                WT_STAFF, WSZ_LARGE).withBuffs({
                    spellpower : +0.2
                }), Weapon) catch(e:Dynamic) null;
    public var ACLAYMO(default, never) : Weapon = try cast(new Weapon(
                "AClaymo", "A.Claymore", "amethyst claymore", "an amethyst claymore", "cleaving sword-slash", 15, 1200, 
                "This two-handed sword is made of obsidian and grotesquely decorated with amethysts and lead engravings. The magic within this murky blade will bleed unnatural darkness when charged with magic.", 
                WT_SWORD, WSZ_LARGE).withEffect(IELib.ScaleAttack_Str, 60), Weapon) catch(e:Dynamic) null;
    public var ADAGGER(default, never) : Weapon = new Weapon(
        "ADagger", "A.Dagger", "amethyst dagger", "an amethyst dagger", "stab", 3, 240, 
        "This dagger is made of obsidian and grotesquely decorated with amethysts and lead engravings. The magic within this murky blade will bleed unnatural darkness when charged with magic.", 
        WT_DAGGER, WSZ_SMALL);
    public var AETHERD(default, never) : Weapon = new AetherD();
    //Effect: Magic catalyst 180%, Count as a dual weapon this item also damage enemies mana on each successful swing. Also cause the burn status for 3 rounds.
    public var ATWINSCY(default, never) : Weapon = try cast(new Weapon(
                                        "ATWINSCY", "A.TwinScythe", "twin scythe", "Alvina's Twin Scythes", "slash", 20, 12000, 
                                        "Alvina’s beloved weapons. These pair of scythes were used to slay rival mages. The black flame which blaze along this cursed item’s blade burns the victim’s magic like fuel. Alvina rarely ever used this item to its full extent, only pulling it out as a trump card against her deadliest opponents when magic alone proved insufficient.", 
                                        WT_SCYTHE, WSZ_LARGE, true).withBuff("spellpower", +1.8).withTags(W_WHIRLWIND, W_STAFFPART, W_FIRE_TYPE).withEffect(IELib.Bleed, 10).withEffect(IELib.AttackBonus_Cor, 1 / 20), Weapon) catch(e:Dynamic) null;
    public var ANGSTD(default, never) : Weapon = try cast(new Weapon(
                        "AngstD", "AngstDaggers", "Angst Daggers", "a set of Angst Daggers", "stab", 20, 3200, 
                        "A pair of small blades filled with anger. To fully unleash potential of those deadly blades is required 300+ speed and 60+ strength.", 
                        WT_DAGGER, WSZ_SMALL, true).withEffect(IELib.ScaleAttack_Spe, 300).withEffect(IELib.ScaleAttack_Str, 60), Weapon) catch(e:Dynamic) null;
    public var ANGSTD1(default, never) : Weapon = try cast(new Weapon(
                        "AngstD1", "AngstDagger", "Angst Dagger", "an Angst Dagger", "stab", 20, 1600, 
                        "A small blade filled with anger. To fully unleash potential of this deadly blade is required 300+ speed and 60+ strength.", 
                        WT_DAGGER, WSZ_SMALL).withEffect(IELib.ScaleAttack_Spe, 300).withEffect(IELib.ScaleAttack_Str, 60), Weapon) catch(e:Dynamic) null;
    public var ARI_SPR(default, never) : Weapon = try cast(new Weapon(
                "Ari_Spr", "ArigeanSpear", "Arigean Spear", "an Arigean Spear", "thrust", 13, 1040, 
                "A black spear with white wrappings around the length of it, the metal shines a beautiful silver when even a small glimmer of light touches it. It supposedly becomes more dangerous the lower your mana is, and also should have no problem piercing armor.", 
                WT_SPEAR, WSZ_MEDIUM).withEffect(IELib.ArmorPenetration, 30), Weapon) catch(e:Dynamic) null;
    public var ARICLUB(default, never) : Weapon = try cast(new Weapon(
                "AriClub", "ArigeanClub", "Arigean Club", "an Arigean Club", "smash", 11, 880, 
                "A black club with white wrappings, the metal shines silver when even a small glimmer of light hits it. It should prove useful in keeping your foes at bay.", 
                WT_MACE_HAMMER, WSZ_MEDIUM).withEffect(IELib.AttackBonus_RaceTier, 4, Races.ARIGEAN), Weapon) catch(e:Dynamic) null;
    public var ARMAGED(default, never) : Weapon = new ArmageddonBlade();
    public var ASCENSU(default, never) : Weapon = try cast(new Weapon(
                "Ascensus", "Ascensus", "Ascensus", "Ascensus, Element of Ascension", "smack", 30, 4800, 
                "This staff is made from sacred wood and holy bark. Vines and tentacles run along the staff, grown out of the wood itself. The top has an odd zigzag shape, with pulsing crystals adorning the recesses. This staff radiates power, neither pure nor corrupt. (-25% spell cost, x6.5 spellpower / healpower)", 
                WT_STAFF, WSZ_LARGE).withBuff("spellpower", +1.5), Weapon) catch(e:Dynamic) null;
    public var ASTERIUS(default, never) : AsteriusRage = new AsteriusRage();
    public var AWL_(default, never) : Weapon = try cast(new Weapon(
                "Awl    ", "Awl", "awl", "an awl", "pierce", 3, 240, 
                "A typical awl used to pierce magic hides when making magic armors or... to pierce organic object ;)", 
                WT_EXOTIC, WSZ_SMALL).withEffect(IELib.Bleed, 45), Weapon) catch(e:Dynamic) null;
    public var B_STAFF(default, never) : Weapon = new BeautifulStaff();
    public var B_SWORD(default, never) : Weapon = try cast(new Weapon(
                        "B.Sword", "B.Sword", "beautiful sword", "a beautiful shining sword", "slash", 17, 560, 
                        "This beautiful sword shines brilliantly in the light, showing the flawless craftsmanship of its blade.  The pommel and guard are heavily decorated in gold and brass.  Some craftsman clearly poured his heart and soul into this blade.", 
                        WT_SWORD, WSZ_MEDIUM).withEffect(IELib.Require_CorBelow, 33).withEffect(IELib.AttackBonus_Cor, -1 / 3), Weapon) catch(e:Dynamic) null;
    public var B_WHIP(default, never) : Weapon = try cast(new Weapon(
                                        "B.Whip", "B.Whip", "beautiful whip", "a beautiful shining whip", "whipping", 14, 400, 
                                        "This beautiful whip shines brilliantly in the light, showing the flawless craftsmanship.  The handle and transition knot are heavily decorated in gold and brass.  Some craftsman clearly poured his heart and soul into this whip.", 
                                        WT_WHIP, WSZ_MEDIUM).withBuffs({
                                            teasedmg : 35
                                        }).withTag(W_WHIPPING).withEffect(IELib.Require_CorBelow, 33).withEffect(IELib.AttackBonus_Cor, -1 / 3), Weapon) catch(e:Dynamic) null;
    public var B_FLYWHISK(default, never) : Weapon = new BeautifulFlyWhisk();
    public var B_SCARB(default, never) : Weapon = new Weapon(
        "B.ScarB", "B.ScarBlade", "broken scarred blade", "a broken scarred blade", "slash", 12, 480, 
        "This saber, made from lethicite-imbued metal, seems to no longer seek flesh; whatever demonic properties in this weapon is gone now but it's still an effective weapon.", 
        WT_SWORD, WSZ_MEDIUM);
    public var B_WIDOW(default, never) : Weapon = try cast(new Weapon(
                                                "BWidow", "B. Widow", "black widow rapier", "a black widow rapier", "slash", 60, 9600, 
                                                "A rapier that used to belong a deceitful noblewoman, made in a strange, purple metal. Its pommel design looks similar to that of a spiderweb, while the blade and hilt are decorated with amethysts and arachnid-looking engravings.", 
                                                WT_DUELING, WSZ_MEDIUM).withTags(I_LEGENDARY, W_RAPIER).withEffect(IELib.ArmorPenetration, 100).withEffect(IELib.AttackBonus_Fem, 1 / 10).withEffect(IELib.AttackBonus_Cor, 1 / 10).withEffect(IELib.ScaleAttack_Spe, 100), Weapon) catch(e:Dynamic) null;
    public var BCLAWS(default, never) : BlizzardClaws = new BlizzardClaws();
    public var BFGAUNT(default, never) : BigFuckingGauntlets = new BigFuckingGauntlets();
    public var BFTHSWORD(default, never) : Weapon = try cast(new Weapon("BFTHSword", "BFTHSword", "big fucking two-handed sword", "a big fucking two-handed sword", "slash", 100, 4000, "Big Fucking Two-Handed Sword - if the best solution for a tiny e-pen complex at this side of the Mareth not work take this one! This 2H 4 meters long sword requires 250 strength to fully unleash it power.", WT_SWORD, WSZ_MASSIVE).withTag(W_LGWRATH).withEffect(IELib.ScaleAttack_StrXL, 250), Weapon) catch(e:Dynamic) null;
    public var BFSWORD(default, never) : Weapon = try cast(new Weapon("BFSword", "B.F.Sword", "big fucking sword", "a big fucking sword", "slash", 50, 2000, "Big Fucking Sword - the best solution for a tiny e-pen complex at this side of the Mareth!  This 2H 2,5 meters long sword requires 150 strength to fully unleash it power.", WT_SWORD, WSZ_LARGE).withTag(W_LGWRATH).withEffect(IELib.ScaleAttack_Str, 150), Weapon) catch(e:Dynamic) null;
    public var BFWHIP(default, never) : Weapon = try cast(new Weapon("BFWhip", "B.F.Whip", "big fucking whip", "a big fucking whip", "whipping", 36, 1440, "Big Fucking Whip - the best solution for master tiny e-pen complex at this side of the Mareth!  This 2H 5 meters long whip requires 225 (strength+speed) to fully unleash it power.", WT_WHIP, WSZ_LARGE).withBuffs({
                                    teasedmg : 50
                                }).withEffect(IELib.ScaleAttack_StrSpe, 225).withTags(W_WHIPPING, W_LGWRATH), Weapon) catch(e:Dynamic) null;
    public var BLETTER(default, never) : Weapon = try cast(new Weapon(
                                "BLDLetter", "Blood Letter", "bloodletter katana", "a bloodletter katana", "slash", 132, 10560, 
                                "This dark blade is as beautiful as it is deadly, made in black metal and decorated with crimson ruby gemstones. Lending its power to a corrupt warrior, it will strike with an unholy force, albeit, draining some blood from its wielder on the process.", WT_DUELING, WSZ_LARGE).withTags(I_LEGENDARY, W_CORRUPT_TYPE).withEffect(IELib.AttackBonus_Cor, 3 / 5).withEffect(IELib.ScaleAttack_Spe, 100), Weapon) catch(e:Dynamic) null;
    public var CATGLOV(default, never) : BlackCatGlove = new BlackCatGlove();
    public var CHAOSEA(default, never) : Weapon = try cast(new Weapon(
                                "Chaosea", "Chaoseater", "Chaoseater", "a Chaoseater", "slash", 410, 65600, 
                                "It's incredibly large blade with jagged edges on both sides along with the skulls engraved within the middle of the blade. Requires 500 strength to fully unleash it power.", 
                                WT_SWORD, WSZ_MASSIVE).withTags(W_MGWRATH, I_LEGENDARY, W_CORRUPT_TYPE).withEffect(IELib.AttackBonus_Cor, 1 / 2).withEffect(IELib.ScaleAttack_StrXL, 500), Weapon) catch(e:Dynamic) null;
    public var CLAWS(default, never) : GauntletWithClaws = new GauntletWithClaws();
    public var CLAYMOR(default, never) : Weapon = findCommonDynamicWeapon("claymore");
    //przerobić na high grade wrath weapon?
    public var CNTWHIP(default, never) : Weapon = try cast(new Weapon(
                                "CNTWhip", "CatONineTailWhip", "Bastet Whip", "a Bastet Whip", "whipping", 45, 1080, 
                                "A rope made from unknown magic beast fur that unravelled into three small ropes, each of which is unravelled again designed to whip and cut your foes into submission.", 
                                WT_WHIP, WSZ_LARGE).withTag(W_WHIPPING).withEffect(IELib.Bleed, 25).withEffect(IELib.ScaleAttack_StrSpe, 225), Weapon) catch(e:Dynamic) null;
    public var C_BLADE(default, never) : Weapon = try cast(new Weapon(
                                "ChaosBlade", "Chaos Blade", "Chaos Blade", "a Chaos Blade", "slash", 135, 10800, 
                                "This dark blade is as beautiful as it is deadly, made in black metal and decorated with a single crimson ruby gemstones. Lending its power to a corrupt warrior, it will strike with an unholy force, albeit, draining some blood from its wielder on the process as this weapon is not meant to be wielded by mortals.", 
                                WT_DUELING, WSZ_MEDIUM).withTags(W_HYBRID, I_LEGENDARY, W_CORRUPT_TYPE).withEffect(IELib.AttackBonus_Cor, 3 / 5).withEffect(IELib.ScaleAttack_Spe, 100), Weapon) catch(e:Dynamic) null;
    public var D_KAMA(default, never) : Weapon = try cast(new Weapon(
                "D.Kama", "D.Kama", "dual kama", "a dual kama", "stab", 4, 640, 
                "A pair of kama. Preferred weapon for the ninja fans.", 
                WT_SCYTHE, WSZ_SMALL, true).withEffect(IELib.Bleed, 10), Weapon) catch(e:Dynamic) null;
    public var DAGGER(default, never) : DynamicWeapon = findCommonDynamicWeapon("dagger");
    public var DAGWHIP(default, never) : Weapon = try cast(new Weapon(
                        "DagWhip", "DaggerWhip", "dagger whip", "a dagger whip", "whip-like slash", 5, 200, 
                        "A small blade that is tied to the wrist by an 8 ft. cloth.  Could be used to attack few enemies at once.", 
                        WT_DAGGER, WSZ_SMALL).withBuffs({
                            teasedmg : 30
                        }).withTags(W_WHIPPING), Weapon) catch(e:Dynamic) null;
    public var DAISHO(default, never) : Weapon = try cast(new Weapon(
                        "Daisho ", "Daisho", "daisho", "a daisho", "keen cut", 15, 1360, 
                        "Set of katana & wakizashi that cuts through flesh with the greatest of ease.", 
                        WT_DUELING, WSZ_MEDIUM).withTag(W_HYBRID).withEffect(IELib.ArmorReduction, 10), Weapon) catch(e:Dynamic) null;
    public var DBFSWO(default, never) : Weapon = try cast(new Weapon(
                        "DBFSwo", "D.B.F.Sword", "dual big fucking swords", "a pair of big fucking swords", "slash", 50, 4000, 
                        "Big Fucking Swords - the best solution for a tiny e-pen complex at this side of the Mareth!  This pair of 2H 2,5 meters long swords requires 150 strength to fully unleash their power.", 
                        WT_SWORD, WSZ_LARGE, true).withTags(W_LGWRATH).withEffect(IELib.ScaleAttack_Str, 150), Weapon) catch(e:Dynamic) null;
    public var DBFTHSWO(default, never) : Weapon = try cast(new Weapon(
                        "DBFTHSwo", "DBFTHSword", "dual big fucking two-handed swords", "a pair of big fucking two-handed swords", "slash", 100, 8000, 
                        "Big Fucking Two-Handed Swords - if the best solution for a tiny e-pen complex at this side of the Mareth not work take this one! This pair of 2H 4 meters long swords requires 250 strength to fully unleash their power.", 
                        WT_SWORD, WSZ_MASSIVE, true).withTags(W_LGWRATH).withEffect(IELib.ScaleAttack_StrXL, 250), Weapon) catch(e:Dynamic) null;
    public var DBFWHIP(default, never) : Weapon = try cast(new Weapon(
                                "DBFWhip", "D.B.F.Whip", "dual big fucking whips", "a pair of big fucking whips", "whipping", 45, 2880, 
                                "Big Fucking Whips - the best solution for master tiny e-pen complex at this side of the Mareth!  This pair of 2H 5 meters long whips requires 225 (strength+speed) to fully unleash it power.", WT_WHIP, WSZ_LARGE, true).withBuffs({
                                    teasedmg : 50
                                }).withEffect(IELib.ScaleAttack_StrSpe, 225).withTags(W_WHIPPING), Weapon) catch(e:Dynamic) null;
    public var DBSWORD(default, never) : Weapon = try cast(new Weapon(
                        "DBSword", "DB.Sword", "dual beautiful swords", "a dual beautiful shining swords", "slash", 17, 1120, 
                        "Those beautiful swords shines brilliantly in the light, showing the flawless craftsmanship of their blades.  The pommel and guard are heavily decorated in gold and brass.  Some craftsman clearly poured his heart and soul into those blade.", 
                        WT_SWORD, WSZ_MEDIUM, true).withEffect(IELib.Require_CorBelow, 33).withEffect(IELib.AttackBonus_Cor, -1 / 3), Weapon) catch(e:Dynamic) null;
    public var DDAGGER(default, never) : Weapon = new Weapon(
        "DDagger", "D.Daggers", "dual daggers", "a dual daggers", "stab", 3, 240, 
        "A pair of small blades.  Preferred weapons for the rogues.", 
        WT_DAGGER, WSZ_SMALL, true);
    public var DDAGWHIP(default, never) : Weapon = try cast(new Weapon(
                "DDagWhip", "DualDaggerWhip", "dual dagger whip", "a dual dagger whip", "whip-like slash", 5, 400, 
                "Two small blades that is tied to the wrist by an 8 ft. cloth each.  Could be used to attack few enemies at once.", 
                WT_DAGGER, WSZ_SMALL, true).withTags(W_WHIPPING), Weapon) catch(e:Dynamic) null;
    public var DEMSCYT(default, never) : Weapon = try cast(new Weapon(
                                        "DemScyt", "D.Scythe", "demonic scythe", "a demonic scythe", "slash", 20, 4000, 
                                        "A magic catalyst of unknown origin ornamented with a blade mounted on a skull. This magical scythe is both charged with powerful energy and extremely sharp. The letters A.S are engraved in the weapon.", 
                                        WT_SCYTHE, WSZ_LARGE).withBuff("spellpower", +1.0).withTags(W_WHIRLWIND, W_STAFFPART).withEffect(IELib.Bleed, 10).withEffect(IELib.AttackBonus_Cor, 1 / 20), Weapon) catch(e:Dynamic) null;
    public var DEPRAVA(default, never) : Weapon = try cast(new Weapon(
                "Depravatio", "Depravatio", "Depravatio", "Depravatio, Element of Corruption", "smack", 12, 1920, 
                "This staff is made from sacred wood, infused with Marae’s bark. Tentacles run along the staff, and attempt to grope you when they think you’re not watching. The top has an odd zigzag shape, with clear crystals adorning the recesses. The staff seethes with corruption. (-15% spell cost, x2.5 black spellpower / he" +
                "alpower)", WT_STAFF, WSZ_LARGE).withBuff("spellpower", 0.6), Weapon) catch(e:Dynamic) null;
    public var DEXCALI(default, never) : Weapon = try cast(new Weapon(
                                "DExcalib", "DualExcalibur", "Dual Excalibur", "a Dual Excalibur", "slash", 40, 1600, 
                                "A legendary dual swords said to have been made by Marae for her champion. Those weapon radiates divine power, purifying its wielder and protecting them from impurity.", 
                                WT_SWORD, WSZ_MEDIUM, true).withEffect(IELib.Require_CorBelow, 33).withEffect(IELib.AttackBonus_Cor, -1 / 3).withTag(I_LEGENDARY), Weapon) catch(e:Dynamic) null;
    public var DE_GAXE(default, never) : Weapon = try cast(new Weapon(
                                "D.GAXE", "Demon G.Axe", "demonic greataxe", "a demonic greataxe", "cleave", 80, 8000, 
                                "A greataxe made in black metal and imbued with unholy power. Its shaft is wrapped in bat wings made of darkened bronze. Its deadly blade seems to always aim for the enemy necks.", 
                                WT_AXE, WSZ_LARGE).withTags(I_LEGENDARY, W_CORRUPT_TYPE).withEffect(IELib.AttackBonus_Cor, 1 / 5).withEffect(IELib.ScaleAttack_Str, 100), Weapon) catch(e:Dynamic) null;
    public var DKATANA(default, never) : Weapon = try cast(new Weapon(
                "D.Katana", "D.Katana", "dual katana", "a dual katana", "keen cut", 15, 1360, 
                "A pair of curved bladed weapons that cuts through flesh with the greatest of ease.", 
                WT_DUELING, WSZ_LARGE, true).withEffect(IELib.ArmorReduction, 10), Weapon) catch(e:Dynamic) null;
    public var DNODACHI(default, never) : Weapon = try cast(new Weapon(
                "DNodachi", "DualNodachi", "dual nodachi", "a dual nodachi", "keen cut", 65, 5200, 
                "Pair of curved over 3m long bladed weapons that cuts through flesh with the greatest of ease.", 
                WT_DUELING, WSZ_MASSIVE, true).withEffect(IELib.ScaleAttack_StrXL, 250), Weapon) catch(e:Dynamic) null;
    public var DORSOUL(default, never) : Weapon = try cast(new Weapon(
                                "DorSoul", "DorcSouls", "Dorc Souls", "a Dorc Souls", "slash", 160, 14400, 
                                "Said to have been the favored weapon of a mad god named Dorc these corrupted swords heals the wielder on swings.", 
                                WT_SWORD, WSZ_LARGE, true).withTags(W_LGWRATH, I_LEGENDARY).withEffect(IELib.ScaleAttack_Str, 250).withEffect(IELib.AttackBonus_Cor, 1 / 5), Weapon) catch(e:Dynamic) null;
    public var DRAPIER(default, never) : Weapon = try cast(new Weapon(
                "DRapier", "DRapier", "dragon rapier", "Dragon's Rapier", "slash", 18, 1440, 
                "Ancient looking rapier forged in dragon fire. Tales saying that some of the dragon fire could still linger inside of it.  Still blade is piece of an extraordinatry quality and perfect for stabbing.", 
                WT_DUELING, WSZ_MEDIUM).withTags(W_RAPIER), Weapon) catch(e:Dynamic) null;
    public var DWARWA(default, never) : Weapon = try cast(new Weapon(
                        "DwarWA", "DwarvenWaraxe", "dwarven waraxe", "a dwarven waraxe", "cleave", 53, 2120, 
                        "A dwarven waraxe has a large, ornate head mounted to a thick handle, making it too large to use in one hand without special training.", 
                        WT_AXE, WSZ_LARGE).withTags(W_LGWRATH).withEffect(IELib.ScaleAttack_Str, 160), Weapon) catch(e:Dynamic) null;
    public var D_FLAIL(default, never) : Weapon = try cast(new Weapon(
                                                "D.Flail", "D.Flail", "Demon flail", "a Demon flail", "smash", 20, 8000, 
                                                "A leather-coated steel whip ending in a wide, heavy spiked ball of the same material. It reeks of corruption and its core seems to exude strong aphrodisiac that cover the blunt spikes of the ball, which look quite adapted to fit a whole range of orifices. Only the strongest warriors would be able to use such a large weapon, but it can deal tremendous damage as well as inspire lust.", 
                                                WT_MACE_HAMMER, WSZ_LARGE).withBuffs({
                                                    teasedmg : 35
                                                }).withTag(W_WHIRLWIND).withEffect(IELib.Stun, 10).withEffect(IELib.ScaleAttack_Str, 75).withEffect(IELib.AttackBonus_Cor, 1 / 20), Weapon) catch(e:Dynamic) null;
    public var D_WHAM_(default, never) : Weapon = try cast(new Weapon(
                                "D.WHam", "D.WarHam", "dual huge warhammer", "a dual huge warhammer", "smash", 15, 2400, 
                                "A pair of huge war-hammers made almost entirely of steel that only the strongest warriors could use.  Getting hit with this might stun the victim.", 
                                WT_MACE_HAMMER, WSZ_LARGE, true).withTags(W_WHIRLWIND).withEffect(IELib.Stun, 10).withEffect(IELib.ScaleAttack_Str, 80), Weapon) catch(e:Dynamic) null;
    public var D_LANCE(default, never) : Weapon = try cast(new Weapon(
                        "D.Lance", "D.Lance", "dual lance", "a dual lances", "piercing stab", 12, 960, 
                        "A pair of long wooden shafts with a pointed metal heads, used as a weapon by knights and cavalry soldiers in charging.  They would ignore most armors.  Req. 100+ speed to unleash full attack power.", 
                        WT_SPEAR, WSZ_MEDIUM, true).withEffect(IELib.ArmorPenetration, 100).withEffect(IELib.ScaleAttack_Spe, 100), Weapon) catch(e:Dynamic) null;
    public var DL_AXE_(default, never) : Weapon = try cast(new Weapon(
                "D.L.Axe", "D.L.Axe", "dual large axes", "a pair of axes large enough for a minotaur", "cleaves", 18, 1440, 
                "This pair of massive axes once belonged to a minotaur.  It'd be hard for anyone smaller than a giant to wield effectively.  Those axes are double-bladed and deadly-looking.  Requires height of 6'6\".", 
                WT_AXE, WSZ_LARGE, true).withEffect(IELib.ScaleAttack_Str, 120), Weapon) catch(e:Dynamic) null;
    public var DL_WHIP(default, never) : Weapon = try cast(new Weapon(
                        "DL.Whip", "DL.Whip", "twin flaming whips", "a dual flaming whips once belonging to Lethice", "whip-crack", 20, 3200, 
                        "Those whips once belonged to Lethice who was defeated at your hands. It gives off flames when you crack those whips.", 
                        WT_WHIP, WSZ_MEDIUM, true).withBuffs({
                            teasedmg : 50
                        }).withTags(W_WHIPPING, W_FIRE_TYPE), Weapon) catch(e:Dynamic) null;
    public var DOCDEST(default, never) : Weapon = try cast(new Weapon(
                                        "DOCDest", "DOCDestroyer", "Defiled Oni Chieftain Destroyer", "a Defiled Oni Chieftain Destroyer", "smash", 160, 16800, 
                                        "This unrealistically large two handed mace was clearly made for some legendary oni chieftain to wield. Even bigger than the standard oni tetsubo this thing could topple buildings. You likely will need some absurd strength just to lift it.", 
                                        WT_MACE_HAMMER, WSZ_LARGE).withTags(W_WHIRLWIND, W_LGWRATH, W_TETSUBO, I_LEGENDARY).withEffect(IELib.Stun, 15).withEffect(IELib.ScaleAttack_Str, 270).withEffect(IELib.AttackBonus_Cor, 1 / 2), Weapon) catch(e:Dynamic) null;
    public var DSWORD_(default, never) : Weapon = new Weapon(
        "DSwords", "DualSwords", "dual swords", "a pair of swords", "slashes", 10, 800, 
        "A pair of swords made of the finest steel usefull for fight groups of enemies.", 
        WT_SWORD, WSZ_MEDIUM, true);
    public var DSSPEAR(default, never) : Weapon = try cast(new Weapon(
                                        "DSSpear", "Demon Sn Spear", "demon snake spear", "a demon snake spear", "piercing stab", 60, 4800, 
                                        "A dark steel spear imbued with corruption. Along the handle is a snake-like decoration with ruby eyes, from the mouth of which the spear tip emerges. The spear head is poisoned with an unknown venom.", 
                                        WT_SPEAR, WSZ_MEDIUM).withTags(I_LEGENDARY, W_CORRUPT_TYPE).withEffect(IELib.ArmorPenetration, 100).withEffect(IELib.ScaleAttack_Str, 100).withEffect(IELib.AttackBonus_Cor, 1 / 5), Weapon) catch(e:Dynamic) null;
    public var E_STAFF(default, never) : Weapon = try cast(new Weapon(
                "E.Staff", "E.Staff", "eldritch staff", "an eldritch staff", "thwack", 10, 800, 
                "This eldritch staff once belonged to the Harpy Queen, who was killed after her defeat at your hands.  It fairly sizzles with magical power.", 
                WT_STAFF, WSZ_LARGE).withBuff("spellpower", +0.6), Weapon) catch(e:Dynamic) null;
    public var EBNYBLD(default, never) : Weapon = try cast(new Weapon(
                                "EBNYBlade", "Ebony Destroyer", "ebony destroyer", "an ebony destroyer", "slash", 160, 7200, 
                                "This massive weapon, made of the darkest metal seems to seethe with unseen malice. Its desire to destroy and hurt the pure is so strong that it’s wielder must be wary, lest the blade take control of their body to fulfill its gruesome desires.", 
                                WT_SWORD, WSZ_LARGE).withTags(I_LEGENDARY, W_CORRUPT_TYPE).withEffect(IELib.AttackBonus_Cor, 1 / 5).withEffect(IELib.ScaleAttack_Str, 250), Weapon) catch(e:Dynamic) null;
    public var ERIBBON(default, never) : Weapon = try cast(new Weapon(
                        "ERibbon", "ERibbon", "eldritch ribbon", "an eldritch ribbon", "whip-like slash", 5, 400, 
                        "A long ribbon made of fine silk that despite its seemingly fragile appearance can deal noticeable damage to several enemies at once.  It is inscribed with arcane runes, allowing it to facilitate spellcasting.", 
                        WT_RIBBON, WSZ_MEDIUM).withBuff("spellpower", +0.4).withTags(W_WHIPPING), Weapon) catch(e:Dynamic) null;
    public var EXCALIB(default, never) : Weapon = try cast(new Weapon(
                                "Excalib", "Excalibur", "Excalibur", "an Excalibur", "slash", 40, 800, 
                                "A legendary sword said to have been made by Marae for her champion. This weapon radiates divine power, purifying its wielder and protecting them from impurity.", 
                                WT_SWORD, WSZ_MEDIUM).withTag(I_LEGENDARY).withEffect(IELib.Require_CorBelow, 33).withEffect(IELib.AttackBonus_Cor, -1 / 3), Weapon) catch(e:Dynamic) null;
    public var FLAIL(default, never) : Weapon = findCommonDynamicWeapon("flail");
    public var FLYINGC(default, never) : Weapon = try cast(new Weapon(
                                "FlyingC", "FlyingClaw", "Flying Claw", "a flying claw", "rend", 4, 640, "A metal claws that is tied to the wrist by an 8 ft. cloth.  Could be used to attack few enemies at once.", WT_EXOTIC, WSZ_SMALL).withBuffs({
                                    psoulskillpower : +0.2
                                }).withEffect(IELib.Bleed, 10).withTags(W_WHIPPING), Weapon) catch(e:Dynamic) null;
    public var FLYWHIS(default, never) : Weapon = try cast(new Weapon(
                "FlyWhis", "FlyWhisk", "Fly-Whisk", "a Fly-Whisk", "slash", 0, 400, 
                "This strange Daoist tool is a small wooden rod, with a prominently displayed ‘tail’ of plant fibers attached to the tip. Simply holding it seems to focus your concentration and empower your Soulforce!", 
                WT_EXOTIC, WSZ_MEDIUM).withBuffs({
                    psoulskillpower : +0.2,
                    msoulskillpower : +0.2
                }), Weapon) catch(e:Dynamic) null;
    public var FRTAXE(default, never) : Weapon = try cast(new Weapon(
                "Fr.T.Axe", "Fr.T.Axe", "Francisca throwing axe", "a Francisca throwing axe", "cleave", 25, 2000, 
                "A foreign axe, made in polished steel and decorated with hunting reliefs in gold and silver. It’s unusually light for its size, so you may be able to manage it with a single hand. Some runes engraved on the handle assure that it will return to you once it has hit your opponent.", 
                WT_AXE, WSZ_LARGE).withTags(W_THROWN), Weapon) catch(e:Dynamic) null;
    public var CHAKRAM(default, never) : Weapon = try cast(new Weapon(
                "chakram", "chakram", "chakram", "a chakram", "slash", 12, 960, 
                "The chakram is a simple, elegant, and highly portable thrown weapon. It is a flat, open-centered metal discus with a sharpened edge.", 
                WT_EXOTIC, WSZ_MEDIUM).withTags(W_THROWN), Weapon) catch(e:Dynamic) null;
    public var G_ROD(default, never) : Weapon = new Weapon(
        "G. Rod", "G. Rod", "Golemancer Rod", "a Golemancer Rod", "smack", 0, 100, 
        "This metal rod seems to empower golems through energy influx.", 
        WT_WAND, WSZ_MEDIUM);
    public var G_SHURI(default, never) : Weapon = try cast(new Weapon(
                        "G.Shuri", "GiantShuriken", "Giant Shuriken", "a Giant Shuriken", "slash", 52, 2080, 
                        "An inordinately large shuriken. Capable of being thrown by those strong enough to properly hold it.", 
                        WT_EXOTIC, WSZ_MASSIVE).withTags(W_THROWN).withEffect(IELib.ScaleAttack_StrXL, 250), Weapon) catch(e:Dynamic) null;
    public var GGRAVEA(default, never) : Weapon = try cast(new Weapon("GGravea", "GlacialGraveaxe", "Glacial Graveaxe", "a Glacial Graveaxe", "cleave", 160, 160, "The titanic greataxe you found in the tundra, most of the weapon seems to have been carved from bedrock, with the head being made of solid, dense, ice from the heart of a glacier. The ice is light, razor sharp, and appears to never melt. The stone’s slightly discolored, as if carvings had once adorned its surface…However, such decoration seems to have been lost to time.", WT_AXE, WSZ_MASSIVE).withTag(W_LGWRATH).withEffect(IELib.ScaleAttack_StrXL, 800), Weapon) catch(e:Dynamic) null;
    public var GUANDAO(default, never) : Weapon = try cast(new Weapon(
                                "GuanDao", "GuanDao", "Guan Dao", "a Guan Dao", "slash", 75, 3000, 
                                "Made of a 7 foot long wooden pole, attached on top is an imposing sword blade measuring about 21 inches long, gleaming with a sharp light. You figure this weapon should be effective versus groups of foes.  Req. 300 strength to unleash full attack power.", 
                                WT_POLEARM, WSZ_MASSIVE).withTag(W_WHIRLWIND).withEffect(IELib.ArmorPenetration, 60).withEffect(IELib.ScaleAttack_StrXL, 300), Weapon) catch(e:Dynamic) null;
    public var G_SPEAR(default, never) : Weapon = try cast(new Weapon(
                "G.Spear", "G.Spear", "Guard's Spear", "a guard's spear", "thrust", 16, 450, 
                "A very sturdy and well-made spear\n", 
                WT_SPEAR, WSZ_MEDIUM).withEffect(IELib.ArmorPenetration, 45), Weapon) catch(e:Dynamic) null;
    public var H_GAUNT(default, never) : HookedGauntlets = new HookedGauntlets();
    public var HALBERD(default, never) : Weapon = findCommonDynamicWeapon("halberd");
    public var HATWINSCY(default, never) : Weapon = try cast(new Weapon(
                                        "HATWINSCY", "H.A.TwinScythe", "half of twin scythe", "Half of Alvina Twin Scythe", "slash", 20, 6000, 
                                        "One half of Alvina’s beloved twin weapons. This scythe was used to slay rival mages. The black flame which blaze along this cursed item’s blade burns the victim’s magic like fuel. Alvina rarely ever used this item to its full extent, only pulling it out as a trump card against her deadliest opponents when magic alone proved insufficient.", 
                                        WT_SCYTHE, WSZ_LARGE).withBuff("spellpower", +0.9).withTags(W_WHIRLWIND, W_STAFFPART, W_FIRE_TYPE).withEffect(IELib.Bleed, 10).withEffect(IELib.AttackBonus_Cor, 1 / 20), Weapon) catch(e:Dynamic) null;
    public var HELRAIS(default, never) : Weapon = try cast(new Weapon(
                                                "Helrais", "Hellraiser", "Hellraiser", "a Hellraiser", "slash", 80, 14400, 
                                                "An infamous weapon not from this world. Rumors has it that fiends from the void forged it. Many unscruppulous spellcaster used this unholy weapon through the ages.", 
                                                WT_SCYTHE, WSZ_LARGE).withBuff("spellpower", +2).withEffect(IELib.Bleed, 10).withEffect(IELib.ScaleAttack_Str, 100).withEffect(IELib.AttackBonus_Cor, 0.1).withTags(W_STAFFPART, W_WHIRLWIND, I_LEGENDARY), Weapon) catch(e:Dynamic) null;
    public var HNTCANE(default, never) : Weapon = new HuntsmansCane();
    public var HSWORDS(default, never) : Weapon = try cast(new Weapon(
                "HSwords", "HookSwords", "hook swords", "a pair of hook swords", "slashes", 20, 1600, 
                "Dual swords with wrist guards and an outwards-facing \"hook\" on the sword tip, useful for parrying and disarming opponents.", 
                WT_SWORD, WSZ_MEDIUM, true).withPerk(PerkLib.DexterousSwordsmanship), Weapon) catch(e:Dynamic) null;
    public var JRAPIER(default, never) : Weapon = try cast(new Weapon(
                        "JRapier", "JRapier", "jeweled rapier", "a jeweled rapier", "slash", 13, 1040, 
                        "This jeweled rapier is ancient but untarnished.  The hilt is wonderfully made, and fits your hand like a tailored glove.  The blade is shiny and perfectly designed for stabbing.", 
                        WT_DUELING, WSZ_MEDIUM).withEffect(IELib.ArmorPenetration, 100).withTags(W_RAPIER), Weapon) catch(e:Dynamic) null;
    public var JUDGE_S(default, never) : Weapon = try cast(new Weapon(
                "Judge S", "JudgeStaff", "Judge staff", "a Judge staff", "smack", 10, 1600, 
                "An ornamental staff favored by the desert anubi. A remnant of the god of death fate, these staves allowed their wielders to judge the weight of a soul or so legend says. Greatly empower soul skills but also improve spells.", 
                WT_STAFF, WSZ_LARGE).withBuffs({
                    spellpower : +0.2,
                    msoulskillpower : +0.8
                }), Weapon) catch(e:Dynamic) null;
    public var KAMA(default, never) : Weapon = findCommonDynamicWeapon("kama");
    public var KAMAWHIP(default, never) : Weapon = try cast(new Weapon(
                        "KamaWhip", "KamaWhip", "kama whip", "a kama whip", "whip-like slash", 3, 240, 
                        "A small kama-like weapon with two scythe blades that is tied to the wrist by an 8 ft. cloth.  Could be used to attack few enemies at once.", 
                        WT_SCYTHE, WSZ_SMALL).withBuffs({
                            teasedmg : 30
                        }).withTags(W_WHIPPING, W_THROWN), Weapon) catch(e:Dynamic) null;
    public var KARMTOU(default, never) : KarmicTouch = new KarmicTouch();
    public var KATANA(default, never) : Weapon = findCommonDynamicWeapon("katana");
    public var KIHAAXE(default, never) : Weapon = new Weapon(
        "KihaAxe", "Greataxe", "fiery double-bladed axe", "a fiery double-bladed axe", "fiery cleave", 22, 880, 
        "This large, double-bladed axe matches Kiha's axe. It's constantly flaming.", 
        WT_AXE, WSZ_LARGE);
    public var L__AXE(default, never) : Weapon = try cast(new Weapon(
                "L. Axe ", "L. Axe", "large axe", "an axe large enough for a minotaur", "cleave", 18, 720, 
                "This massive axe once belonged to a minotaur.  It'd be hard for anyone smaller than a giant to wield effectively.  The axe is double-bladed and deadly-looking.", 
                WT_AXE, WSZ_LARGE).withEffect(IELib.ScaleAttack_Str, 60), Weapon) catch(e:Dynamic) null;
    public var L_CLAWS(default, never) : LustyClaws = new LustyClaws();
    public var L_DAGGR(default, never) : Weapon = new Weapon(
        "L.Daggr", "L.Daggr", "lust-enchanted dagger", "an aphrodisiac-coated dagger", "stab", 3, 240, 
        "A dagger with a short blade in a wavy pattern.  Its edge seems to have been enchanted to always be covered in a light aphrodisiac to arouse anything cut with it.", 
        WT_DAGGER, WSZ_SMALL);
    public var L_HAMMR(default, never) : Weapon = try cast(new Weapon(
                        "L.Hammr", "L.Hammr", "large hammer", "Marble's large hammer", "smash", 18, 720, 
                        "This two-handed warhammer looks pretty devastating.  You took it from Marble after she refused your advances.", 
                        WT_MACE_HAMMER, WSZ_LARGE).withTags(W_WHIRLWIND).withEffect(IELib.ScaleAttack_Str, 60), Weapon) catch(e:Dynamic) null;
    public var L_STAFF(default, never) : Weapon = try cast(new Weapon(
                "L.Staff", "Lthc. Staff", "lethicite staff", "a lethicite staff", "smack", 14, 1337, 
                "This staff is made of a dark material and seems to tingle to the touch.  The top consists of a glowing lethicite orb.  It once belonged to Lethice who was defeated in your hands.", 
                WT_STAFF, WSZ_LARGE).withBuff("spellpower", +1.6), Weapon) catch(e:Dynamic) null;
    public var L_WHIP(default, never) : Weapon = try cast(new Weapon(
                        "L. Whip", "L. Whip", "flaming whip", "a flaming whip once belonged to Lethice", "whip-crack", 20, 1600, 
                        "This whip once belonged to Lethice who was defeated at your hands. It gives off flames when you crack this whip.", 
                        WT_WHIP, WSZ_MEDIUM).withBuffs({
                            teasedmg : 50
                        }).withTags(W_WHIPPING, W_FIRE_TYPE), Weapon) catch(e:Dynamic) null;
    public var LANCE(default, never) : Weapon = try cast(new Weapon(
                        "Lance", "Lance", "deadly lance", "a deadly lance", "piercing stab", 12, 480, 
                        "A long wooden shaft with a pointed metal head, used as a weapon by knights and cavalry soldiers in charging.  This would ignore most armors.  Req. 100+ speed to unleash full attack power.", 
                        WT_SPEAR, WSZ_MEDIUM).withEffect(IELib.ArmorPenetration, 100).withEffect(IELib.ScaleAttack_Spe, 100), Weapon) catch(e:Dynamic) null;
    public var LHSCYTH(default, never) : Weapon = try cast(new Weapon("LifScyt", "L.Scythe", "lifehunt scythe", "a lifehunt scythe", "slash", 90, 14400, 
                                        "This enchanted scythe is made of a white metal, and its surface is decorated with ruby gemstones and silver engravings depicting dragons. It seems to drink in the opponents blood use it to heal its user’s wounds.", 
                                        WT_SCYTHE, WSZ_LARGE).withBuff("spellpower", +1.0).withTags(W_STAFFPART, W_WHIRLWIND, I_LEGENDARY).withEffect(IELib.ScaleAttack_Str, 100).withEffect(IELib.AttackBonus_Cor, -1 / 10), Weapon) catch(e:Dynamic) null;
    public var LRAPIER(default, never) : Weapon = try cast(new Weapon(
                "LRapier", "LRapier", "lust rapier", "lust-coated rapier", "slash", 8, 640, 
                "A rapier with edge that seems to have been enchanted to always be covered in a light aphrodisiac to arouse anything cut with it.", 
                WT_DUELING, WSZ_MEDIUM).withTags(W_RAPIER), Weapon) catch(e:Dynamic) null;
    public var MACE(default, never) : Weapon = findCommonDynamicWeapon("mace");
    public var MACGRSW(default, never) : Weapon = try cast(new Weapon(
                        "Macgrsw", "Mach.greatsword", "Machine Greatsword", "a Machine Greatsword", "slash", 19, 2720, 
                        "This greatsword is half invention and half weapon. Instead of a sharp straight blade, the weapon’s sides are a set of metal teeth that constantly move in order to properly saw through flesh and more solid matter, creating grievous wounds. Very good for cutting down trees too.", 
                        WT_EXOTIC, WSZ_LARGE).withEffect(IELib.Bleed, 100).withTags(W_HTECHWEAPON), Weapon) catch(e:Dynamic) null;
    public var MACSPEA(default, never) : Weapon = try cast(new Weapon(
                        "Macspea", "Mach.spear", "Machine Spear", "a Machine Spear", "piercing stab", 19, 2720, 
                        "This spear is half invention and half weapon. Instead of a standard run of the mill spearhead, the weapon tip is a massive screw that spins on itself continually to burrow into the opponent’s flesh. Any decisive hit you will land with this thing will possibly be fatal.", 
                        WT_EXOTIC, WSZ_LARGE).withEffect(IELib.ArmorPenetration, 100).withTags(W_HTECHWEAPON), Weapon) catch(e:Dynamic) null;
    public var MASAMUN(default, never) : Weapon = try cast(new Weapon(
                                "masamune", "Masamune", "masamune katana", "a masamune katana", "slash", 112, 8960, 
                                "This blessed katana is made in shining steel and heavily decorated with silver and blue sapphires. When used by a pure-hearted knight, the divine will within guides each strike, making it much deadlier.", 
                                WT_DUELING, WSZ_LARGE).withTags(I_LEGENDARY, W_PURE_TYPE).withEffect(IELib.ScaleAttack_Spe, 100).withEffect(IELib.AttackBonus_Cor, -2 / 5), Weapon) catch(e:Dynamic) null;
    public var MASTGLO(default, never) : MasterGloves = new MasterGloves();
    public var MCLAWS(default, never) : MoonlightClaws = new MoonlightClaws();
    public var MGSWORD(default, never) : Weapon = try cast(new Weapon(
                "MGsword", "MoonlightGreatsword", "moonlight greatsword", "a moonlight greatsword", "cleaving sword-slash", 25, 3000, 
                "This two-handed sword is imbued with his magic, which shall be unleashed as a wave of moonlight. The magic within this will grant greated boon when charged with magic.", 
                WT_SWORD, WSZ_LARGE).withEffect(IELib.ScaleAttack_Str, 50), Weapon) catch(e:Dynamic) null;
    public var MOONLIT(default, never) : Weapon = try cast(new Weapon(
                                "Moonlit Snow", "Moonlit Snow", "Moonlit Snow", "a Moonlit Snow", "slash", 115, 9200, 
                                "This blessed katana is made in shining steel and heavily decorated with silver and blue sapphires. When used by a pure-hearted knight, the divine will within guides each strike, making it much deadlier.", 
                                WT_DUELING, WSZ_MEDIUM).withTags(W_HYBRID, I_LEGENDARY, W_PURE_TYPE).withEffect(IELib.AttackBonus_Cor, -2 / 5).withEffect(IELib.ScaleAttack_Spe, 100), Weapon) catch(e:Dynamic) null;
    public var N_STAFF(default, never) : Weapon = new NocturnusStaff();
    public var NRSABER(default, never) : Weapon = try cast(new Weapon(
                "NRSaber", "NineRingedSaber", "Nine-ringed Saber", "a nine-ringed saber", "slash", 14, 1120, 
                "This saber, with added nine rings is capable of delivering deep, jagged wounds.", 
                WT_SWORD, WSZ_MEDIUM).withEffect(IELib.Bleed, 10), Weapon) catch(e:Dynamic) null;
    public var NTWHIP(default, never) : Weapon = try cast(new Weapon(
                                "NTWhip ", "NineTailWhip", "nine tail whip", "a nine tail whip", "whipping", 18, 720, 
                                "A rope that unravelled into three small ropes, each of which is unravelled again designed to whip your foes into submission.", 
                                WT_WHIP, WSZ_LARGE).withBuffs({
                                    teasedmg : 40
                                }).withTags(W_WHIPPING).withEffect(IELib.ScaleAttack_StrSpe, 100), Weapon) catch(e:Dynamic) null;
    public var NODACHI(default, never) : Weapon = findCommonDynamicWeapon("nodachi");
    public var NORTHIP(default, never) : Weapon = try cast(new Weapon("NorthIP", "North.I.P.", "Northerner ice picks", "a Northerner ice picks", "stabs", 5, 800, "These items are normally used by climbers to move across vertical icy surfaces. While these were not to be originally used as weapons this pair of pickaxes easily pierces through armors and hides.", 
                WT_EXOTIC, WSZ_SMALL, true).withEffect(IELib.ArmorPenetration, 100), Weapon) catch(e:Dynamic) null;
    public var NPHBLDE(default, never) : Weapon = try cast(new Weapon(
                                "NPHMBlade", "Nephilim Blade", "nephilim blade", "a nephilim blade", "slash", 180, 7200, 
                                "A long lost sword, made in a shining metal, that once belonged to the demigod Nephilim. This masterfully crafted blade seeks and destroys corruption wherever it might find it, and will periodically cleanse their user body and soul.", 
                                WT_SWORD, WSZ_LARGE).withTags(I_LEGENDARY, W_LGWRATH, W_PURE_TYPE).withEffect(IELib.AttackBonus_Cor, -1 / 5).withEffect(IELib.ScaleAttack_Str, 250), Weapon) catch(e:Dynamic) null;
    public var OTETSU(default, never) : Weapon = try cast(new Weapon("O.Tetsu", "OniTetsubo", "Oni Tetsubo", "an Oni Tetsubo", "smash", 45, 3600, "This unrealistically large two handed mace was clearly made for Oni warriors to wield. You likely will need some ridiculous strength just to lift it.", WT_MACE_HAMMER, WSZ_LARGE).withTags(W_TETSUBO, W_WHIRLWIND, W_LGWRATH).withEffect(IELib.Stun, 10).withEffect(IELib.ScaleAttack_Str, 180), Weapon) catch(e:Dynamic) null;
    public var PARACEL(default, never) : Weapon = new Paracelsus();
    public var PHALLUS(default, never) : Weapon = new ThePhalluspear();
    public var PHALUSS(default, never) : Weapon = new ThePhalluspears();
    //public const RCHEEP:Weapon = new ReaperCheep(); TODO: finish!
    public var PIPE(default, never) : Weapon = new Weapon(
        "Pipe   ", "Pipe", "pipe", "a pipe", "smash", 2, 80, 
        "This is a simple rusted pipe of unknown origins.  It's hefty and could probably be used as an effective bludgeoning tool.", 
        WT_MACE_HAMMER, WSZ_MEDIUM);
    public var POCDEST(default, never) : Weapon = try cast(new Weapon(
                                        "POCDest", "POCDestroyer", "Purified Oni Chieftain Destroyer", "a Purified Oni Chieftain Destroyer", "smash", 210, 16800, 
                                        "This unrealistically large two handed mace was clearly made for some legendary oni chieftain to wield. Even bigger than the standard oni tetsubo this thing could topple buildings. You likely will need some absurd strength just to lift it.", 
                                        WT_MACE_HAMMER, WSZ_LARGE).withEffect(IELib.Stun, 15).withEffect(IELib.AttackBonus_Cor, -1 / 2).withEffect(IELib.ScaleAttack_Str, 270).withTags(W_TETSUBO, W_WHIRLWIND, W_LGWRATH, ItemConstants.I_LEGENDARY), Weapon) catch(e:Dynamic) null;
    public var PRURUMI(default, never) : Weapon = try cast(new Weapon(
                "PrUrumi ", "Pr.Urumi", "Prithviraj urumi", "a Prithviraj urumi", "slash", 24, 4800, 
                "This urumi is a weapon made of four sharp blades of shining silver-blue steel put together so as to appear like a single blade when not in use. Its handle has a motif of elephants on lacquered ivory, decorated with blue sapphires.", 
                WT_SWORD, WSZ_LARGE).withEffect(IELib.ScaleAttack_Str, 24), Weapon) catch(e:Dynamic) null;
    public var PSWHIP(default, never) : Weapon = try cast(new Weapon(
                        "PSWhip", "P.SucWhip", "pair of succubi whips", "a pair of succubi whips", "sexy whipping", 10, 800, 
                        "This pair of coiled length of midnight-black leather practically exudes lust.  Though it looks like it could do a lot of damage, the feel of that slick leather impacting flesh is sure to inspire lust.  However, it might slowly warp the mind of wielder.", 
                        WT_WHIP, WSZ_MEDIUM, true).withBuffs({
                            teasedmg : 90
                        }).withTags(W_WHIPPING), Weapon) catch(e:Dynamic) null;
    public var PTCHFRK(default, never) : Weapon = new Weapon(
        "PtchFrk", "Pitchfork", "pitchfork", "a pitchfork", "stab", 10, 400, 
        "This is a pitchfork.  Intended for farm work but also useful as stabbing weapon.", 
        WT_SPEAR, WSZ_MEDIUM);
    public var PWHIP(default, never) : Weapon = try cast(new Weapon(
                        "P.Whip ", "P.Whip", "pair of coiled whips", "a pair of coiled whips", "whip-crack", 5, 400, 
                        "A pair of coiled length of leather designed to lash your foes into submission.  There's a chance the bondage inclined might enjoy it!", 
                        WT_WHIP, WSZ_MEDIUM, true).withBuffs({
                            teasedmg : 30
                        }).withTags(W_WHIPPING), Weapon) catch(e:Dynamic) null;
    public var PURITAS(default, never) : Weapon = try cast(new Weapon(
                "Puritas", "Puritas", "Puritas", "Puritas, Element of Purity", "smack", 12, 1920, 
                "This staff is made from sacred wood, infused with Marae’s bark. Vines run along the staff, grown out of the wood itself. The top has an odd zigzag shape, with clear crystals adorning the recesses. The staff glows with power, radiating purity. (-15% spell cost, x2.5 white spellpower / healpower)", 
                WT_STAFF, WSZ_LARGE).withBuff("spellpower", +0.6), Weapon) catch(e:Dynamic) null;
    public var Q_GUARD(default, never) : Weapon = try cast(new Weapon(
                                                "Q.Guard", "Q. Guard", "queen's guard rapier", "a queen's guard rapier", "slash", 80, 9600, 
                                                " An elegant rapier made in brass and gold, with the seal of Mareth’s former nobility. The ruby gemstones running among the blade and the intricate engravings in gold identify it as belonging to the old kingdom knighthoods orders.", 
                                                WT_DUELING, WSZ_MEDIUM).withTags(I_LEGENDARY, W_RAPIER).withEffect(IELib.ArmorPenetration, 100).withEffect(IELib.ScaleAttack_Spe, 100).withEffect(IELib.AttackBonus_Cor, -1 / 10).withEffect(IELib.AttackBonus_Fem, 1 / 10), Weapon) catch(e:Dynamic) null;
    public var R_STAFF(default, never) : Weapon = try cast(new Weapon(
                "R.Staff", "R. Staff", "ruby staff", "a ruby staff", "smack", 2, 240, 
                "This staff is made of very old wood and seems to tingle to the touch.  The top has ruby embedded in it, and the wood is worn smooth from lots of use.  It probably belonged to a wizard at some point and would aid magic use.", 
                WT_STAFF, WSZ_LARGE).withBuff("spellpower", +0.2), Weapon) catch(e:Dynamic) null;
    public var RCLAYMO(default, never) : Weapon = try cast(new Weapon(
                "RClaymo", "R.Claymore", "ruby claymore", "a ruby claymore", "cleaving sword-slash", 15, 1200, 
                "This two-handed sword is made of crimson metal and richly decorated with rubies and gold engravings. The magic within this crimson blade will flare up with magical flames when charged with magic.", 
                WT_SWORD, WSZ_LARGE).withEffect(IELib.ScaleAttack_Str, 40), Weapon) catch(e:Dynamic) null;
    public var RDAGGER(default, never) : Weapon = new Weapon(
        "RDagger", "R.Dagger", "ruby dagger", "a ruby dagger", "stab", 3, 240, 
        "This dagger is made of crimson metal and richly decorated with rubies and gold engravings. The magic within this crimson blade will flare up with magical flames when charged with magic.", 
        WT_DAGGER, WSZ_SMALL);
    public var RIBBON(default, never) : Weapon = findCommonDynamicWeapon("ribbon");
    public var RIDINGC(default, never) : Weapon = try cast(new Weapon(
                "RidingC", "RidingC", "riding crop", "a riding crop", "whip-crack", 5, 200, 
                "This riding crop appears to be made of black leather, and could be quite a painful (or exciting) weapon.", 
                WT_WHIP, WSZ_MEDIUM).withBuffs({
                    teasedmg : 30
                }), Weapon) catch(e:Dynamic) null;
    public var RIPPER1(default, never) : Weapon = try cast(new Weapon(
                        "Ripper1", "Ripper1.0", "Ripper 1.0", "a Ripper 1.0", "slash", 24, 8260, 
                        "Similar to the machine Greatsword, this weapon is highly mechanical. Instead of a sharp straight blade, the weapon’s sides are a set of sharp metal teeth that constantly move in order to properly saw through flesh and more solid matter, creating grievous wounds. Very good for cutting down trees too.", 
                        WT_EXOTIC, WSZ_LARGE).withEffect(IELib.Bleed, 100).withTags(W_HTECHWEAPON), Weapon) catch(e:Dynamic) null;
    public var RIPPER2(default, never) : Weapon = try cast(new Weapon(
                        "Ripper2", "Ripper2.0", "Ripper 2.0", "a Ripper 2.0", "slash", 29, 17360, 
                        "Similar to the machine Greatsword, this weapon is highly mechanical. Instead of a sharp straight blade, the weapon’s sides are a set of sharp metal teeth that constantly move in order to properly saw through flesh and more solid matter, creating grievous wounds. The blades movement is so fast it creates heat along the length and thanks to a small system set, the saw is constantly aflame. Aside of cutting fleshy things in half, it is very good for taking down trees.", 
                        WT_EXOTIC, WSZ_LARGE).withEffect(IELib.Bleed, 100).withTags(W_HTECHWEAPON), Weapon) catch(e:Dynamic) null;
    public var RRAPIER(default, never) : Weapon = try cast(new Weapon(
                "RRapier", "RRapier", "vulpine rapier", "Raphael's vulpine rapier", "slash", 8, 640, 
                "He's bound it with his red sash around the length like a ribbon, as though he has now gifted it to you.  Perhaps it is his way of congratulating you.", 
                WT_DUELING, WSZ_MEDIUM).withTags(W_RAPIER), Weapon) catch(e:Dynamic) null;
    public var RULER(default, never) : Weapon = try cast(new Weapon(
                        "Ruler  ", "Ruler", "ruler", "a ruler", "smash", 16, 2560, "The flat, wide rod has a center ridge on one side, flat on the other. The handle consists of a thick tang with a heavy iron bolster on either side.", 
                        WT_MACE_HAMMER, WSZ_LARGE).withBuffs({
                            psoulskillpower : +0.2
                        }).withEffect(IELib.Stun, 10), Weapon) catch(e:Dynamic) null;
    public var SWORD(default, never) : Weapon = findCommonDynamicWeapon("sword");
    public var S_BLADE(default, never) : Weapon = try cast(new Weapon(
                        "S.Blade", "S.Blade", "inscribed spellblade", "a spellblade", "slash", 8, 640, 
                        "Forged not by a swordsmith but a sorceress, this arcane-infused blade amplifies your magic. Unlike the wizard staves it is based on, this weapon also has a sharp edge, a technological innovation which has proven historically useful in battle.", 
                        WT_SWORD, WSZ_MEDIUM).withBuff("spellpower", +0.5).withTags(W_STAFFPART), Weapon) catch(e:Dynamic) null;
    public var S_GAUNT(default, never) : SpikedGauntlet = new SpikedGauntlet();
    public var S_RULER(default, never) : Weapon = try cast(new Weapon(
                                "S.Ruler", "S.Ruler", "Storm Ruler", "a Storm Ruler", "smash", 15, 4800, 
                                "A greatword with a broken blade, still possessing the residual power of lightning. Also known as the 'Giantslayer', for bringing giants to their knees. Deals increased damage to large enemies.", 
                                WT_MACE_HAMMER, WSZ_LARGE).withBuffs({
                                    psoulskillpower : +0.2
                                }).withEffect(IELib.Stun, 10).withTags(W_LIGHTNING_TYPE), Weapon) catch(e:Dynamic) null;
    public var S_STAFF(default, never) : Weapon = try cast(new Weapon(
                "S.Staff", "S. Staff", "sapphire staff", "a sapphire staff", "smack", 2, 240, 
                "This staff is made of very old wood and seems to tingle to the touch.  The top has sapphire embedded in it, and the wood is worn smooth from lots of use.  It probably belonged to a wizard at some point and would aid magic use.", 
                WT_STAFF, WSZ_LARGE).withBuff("spellpower", +0.2), Weapon) catch(e:Dynamic) null;
    public var SCARBLD(default, never) : Weapon = new ScarredBlade();
    public var SCECOMM(default, never) : Weapon = new Weapon(
        "SceComm", "SceptreOfCom", "Sceptre of Command", "a Sceptre of Command", "smack", 4, 600, 
        "This enchanted scepter empowers the abilities and control of summoners and tamers over their minions.", 
        WT_WAND, WSZ_MEDIUM);
    public var SCIMITR(default, never) : Weapon = findCommonDynamicWeapon("scimitar");
    public var SCLAYMO(default, never) : Weapon = try cast(new Weapon(
                "SClaymo", "S.Claymore", "sapphire claymore", "a sapphire claymore", "cleaving sword-slash", 15, 1200, 
                "This two-handed sword is made of azure metal and richly decorated with sapphires and silver engravings. The magic within this azure blade will radiate magical frost when charged with magic.", 
                WT_SWORD, WSZ_LARGE).withEffect(IELib.ScaleAttack_Str, 40), Weapon) catch(e:Dynamic) null;
    public var SDAGGER(default, never) : Weapon = new Weapon(
        "SDagger", "S.Dagger", "sapphire dagger", "a sapphire dagger", "stab", 3, 240, 
        "This dagger is made of azure metal and richly decorated with sapphires and silver engravings. The magic within this azure blade will radiate magical frost when charged with magic.", 
        WT_DAGGER, WSZ_SMALL);
    public var SESPEAR(default, never) : Weapon = try cast(new Weapon("SeSpear", "Seraph Spear", "seraph spear", "a seraph spear", "piercing stab", 60, 4800, 
                                        "A silvery spear imbued with holy power and decorated with blue sapphire gemstones. Engraved in the handle is an ancient runic spell made to ward evil. This blessed equipment seems to slowly heal its wielder’s wounds.", 
                                        WT_SPEAR, WSZ_MEDIUM).withTags(I_LEGENDARY, W_PURE_TYPE).withEffect(IELib.ArmorPenetration, 100).withEffect(IELib.ScaleAttack_Str, 100).withEffect(IELib.AttackBonus_Cor, -1 / 10), Weapon) catch(e:Dynamic) null;
    public var SIM_SPR(default, never) : Weapon = try cast(new Weapon(
                "Sim_Spr", "Sim.Spear", "simple spear", "a simple spear", "thrust", 10, 250, 
                "A fairly crude-looking spear.", 
                WT_SPEAR, WSZ_MEDIUM).withEffect(IELib.ArmorPenetration, 30), Weapon) catch(e:Dynamic) null;
    public var SIM_STF(default, never) : Weapon = try cast(new Weapon(
                "Sim_Stf", "Sim.Staff", "simple staff", "a simple staff", "smack", 11, 75, 
                "A simple staff, faint pure energy emanates from it.\n", 
                WT_STAFF, WSZ_LARGE).withBuff("spellpower", +0.1), Weapon) catch(e:Dynamic) null;
    public var SKYPIER(default, never) : Weapon = try cast(new Weapon(
                                        "Skypier", "Skypiercer", "Skypiercer", "a Skypiercer", "piercing stab", 55, 3840, 
                                        "Tales has it that this spear tip is so sharp it is said it could pierce through the sky.  Req. 300+ speed and 100+ strength to unleash full attack power", 
                                        WT_SPEAR, WSZ_LARGE).withTags(W_LGWRATH).withEffect(IELib.ArmorPenetration, 100).withEffect(IELib.ScaleAttack_Str, 100).withEffect(IELib.ScaleAttack_Spe, 300), Weapon) catch(e:Dynamic) null;
    public var SNAKESW(default, never) : Weapon = try cast(new Weapon(
                "SnakeSw", "SnakeSword", "Snake Sword", "a Snake Sword", "whip-slash", 20, 800, 
                "This unassuming double-edged sword is comprised of segmented pieces which, when swung, will lash out akin to a whip.", 
                WT_SWORD, WSZ_MEDIUM).withTags(W_WHIPPING), Weapon) catch(e:Dynamic) null;
    public var SDRILL(default, never) : Weapon = new SoulDrill();
    public var SPEAR(default, never) : Weapon = try cast(new Weapon(
                        "Spear", "Spear", "deadly spear", "a deadly spear", "piercing stab", 10, 400, 
                        "A staff with a sharp blade at the tip designed to pierce through the toughest armor.  This would ignore most armors.  Req. 75+ speed to unleash full attack power.", 
                        WT_SPEAR, WSZ_MEDIUM).withEffect(IELib.ArmorPenetration, 100).withEffect(IELib.ScaleAttack_Spe, 75), Weapon) catch(e:Dynamic) null;
    public var SUCWHIP(default, never) : Weapon = try cast(new Weapon(
                        "SucWhip", "SucWhip", "succubi whip", "a succubi whip", "sexy whipping", 10, 400, 
                        "This coiled length of midnight-black leather practically exudes lust.  Though it looks like it could do a lot of damage, the feel of that slick leather impacting flesh is sure to inspire lust.  However, it might slowly warp the mind of wielder.", 
                        WT_WHIP, WSZ_MEDIUM).withBuffs({
                            teasedmg : 45
                        }).withTags(W_WHIPPING), Weapon) catch(e:Dynamic) null;
    public var T_HEART(default, never) : Weapon = try cast(new Weapon(
                                "T.Heart", "T.Heart", "Trull Heart", "a Trull Heart", "slash", 180, 14400, 
                                "This pair of oversized swords is said to have once belonged to a legendary giant. The owner wounds seems to recover when those pure blades are used.", WT_SWORD, WSZ_LARGE, true).withTags(W_LGWRATH, I_LEGENDARY).withEffect(IELib.ScaleAttack_Str, 250).withEffect(IELib.AttackBonus_Cor, -1 / 5), Weapon) catch(e:Dynamic) null;
    public var T_STAFF(default, never) : Weapon = try cast(new Weapon(
                "T.Staff", "T. Staff", "topaz staff", "a topaz staff", "smack", 2, 240, 
                "This staff is made of very old wood and seems to tingle to the touch.  The top has topaz embedded in it, and the wood is worn smooth from lots of use.  It probably belonged to a wizard at some point and would aid magic use.", 
                WT_STAFF, WSZ_LARGE).withBuff("spellpower", +0.2), Weapon) catch(e:Dynamic) null;
    public var TB_SCYT(default, never) : Weapon = try cast(new Weapon(
                        "TBScyt", "T.B.Scythe", "two bladed scythe", "a two bladed scythe", "slash", 30, 2400, 
                        "The Two Bladed Scythe resembles a scythe with a long thin blue grip, and two blades at the tip.", 
                        WT_SCYTHE, WSZ_LARGE).withEffect(IELib.Bleed, 25).withTags(W_WHIRLWIND), Weapon) catch(e:Dynamic) null;
    public var TCLAYMO(default, never) : Weapon = try cast(new Weapon(
                "TClaymo", "T.Claymore", "topaz claymore", "a topaz claymore", "cleaving sword-slash", 15, 1200, 
                "This two-handed sword is made of eversteel and richly decorated with yellow topazes and copper engravings. The magic within this shining blade will oversaturate the metal with electricity when charged with magic.", 
                WT_SWORD, WSZ_LARGE).withEffect(IELib.ScaleAttack_Str, 40), Weapon) catch(e:Dynamic) null;
    public var TDAGGER(default, never) : Weapon = try cast(new Weapon(
                "TDagger", "ThrowDagger", "throwing dagger", "a throwing dagger", "stab", 2, 160, 
                "A small blade that could be thrown. Preferred weapon for the rogues.", 
                WT_DAGGER, WSZ_SMALL).withTags(W_THROWN), Weapon) catch(e:Dynamic) null;
    public var TIDAR(default, never) : Weapon = new Tidarion();
    public var TKNIVES(default, never) : Weapon = new TaintlessKnives();
    public var TMACGRSW(default, never) : Weapon = try cast(new Weapon(
                        "TMacgrsw", "T.Mach.greatsword", "Twin Machine Greatswords", "a Twin Machine Greatswords", "slash", 19, 5440, 
                        "This twin greatswords are half invention and half weapon. Instead of a sharp straight blade, the weapon’s sides are a set of metal teeth that constantly move in order to properly saw through flesh and more solid matter, creating grievous wounds. Very good for cutting down trees too.", 
                        WT_EXOTIC, WSZ_LARGE, true).withEffect(IELib.Bleed, 100).withTags(W_HTECHWEAPON), Weapon) catch(e:Dynamic) null;
    public var TODAGGER(default, never) : Weapon = new Weapon(
        "ToDagger", "T.Dagger", "topaz dagger", "a topaz dagger", "stab", 3, 240, 
        "This dagger is made of eversteel and richly decorated with yellow topazes and copper engravings. The magic within this shining blade will oversaturate the metal with electricity when charged with magic.", 
        WT_DAGGER, WSZ_SMALL);
    public var TRASAXE(default, never) : Weapon = new Weapon(
        "TraSAxe", "Train.S.Axe", "training soul axe", "a training soul axe", "cleave", 1, 80, 
        "This axe was specialy forged and enhanted to help novice soul cultivatiors to train their soulforce.  Still if situation calls for it it could be used as a normal weapon.", 
        WT_AXE, WSZ_MEDIUM);
    public var TRIDAG(default, never) : Weapon = try cast(new Weapon(
                "TriDag ", "TriDagger", "tri-dagger", "a tri-dagger", "stab", 4, 320, 
                "A dagger whose blade is shaped like a perfect equilateral triangle.  It has chance to leave bleeding wounds.", 
                WT_DAGGER, WSZ_SMALL).withEffect(IELib.Bleed, 25), Weapon) catch(e:Dynamic) null;
    public var TRIDENT(default, never) : Weapon = try cast(new Weapon(
                "Trident", "Trident", "deadly trident", "a deadly trident", "piercing stab", 12, 480, 
                "A very ordinary trident. This weapon has a decent reach and can be used to impale foes. It is capable of piercing armor just as well as any other spear.  Req. 75+ speed to unleash full attack power.", 
                WT_SPEAR, WSZ_LARGE).withEffect(IELib.ScaleAttack_Spe, 100), Weapon) catch(e:Dynamic) null;
    public var TRIPPER1(default, never) : Weapon = try cast(new Weapon(
                        "TRipper1", "T.Ripper1.0", "Twin Ripper 1.0", "a Twin Ripper 1.0", "slash", 24, 16520, 
                        "Similar to the machine Greatsword, those weapons are highly mechanical. Instead of a sharp straight blade, the weapon’s sides are a set of sharp metal teeth that constantly move in order to properly saw through flesh and more solid matter, creating grievous wounds. Very good for cutting down trees too.", 
                        WT_EXOTIC, WSZ_LARGE, true).withEffect(IELib.Bleed, 100).withTags(W_HTECHWEAPON), Weapon) catch(e:Dynamic) null;
    public var TRIPPER2(default, never) : Weapon = try cast(new Weapon(
                        "TRipper2", "T.Ripper2.0", "Twin Ripper 2.0", "a Twin Ripper 2.0", "slash", 29, 34720, 
                        "Similar to the machine Greatsword, those weapons are highly mechanical. Instead of a sharp straight blade, the weapon’s sides are a set of sharp metal teeth that constantly move in order to properly saw through flesh and more solid matter, creating grievous wounds. The blades movement is so fast it creates heat along the length and thanks to a small system set, the saws are constantly aflame. Aside of cutting fleshy things in half, it is very good for taking down trees.", 
                        WT_EXOTIC, WSZ_LARGE, true).withEffect(IELib.Bleed, 100).withTags(W_HTECHWEAPON), Weapon) catch(e:Dynamic) null;
    public var TRSTSWO(default, never) : Weapon = new Weapon(
        "TrStSwo", "TruestrikeSword", "Truestrike sword", "a Truestrike sword", "slash", 5, 400, 
        "Lia will write desc of it...soon.", 
        WT_SWORD, WSZ_MEDIUM);
    public var TACLAYM(default, never) : Weapon = try cast(new Weapon(
                "TAClaym", "T.A.Claymore", "twin amethyst claymores", "a twin amethyst claymores", "cleaving sword-slash", 15, 2400, 
                "Those twin two-handed swords are made of obsidian and grotesquely decorated with amethysts and lead engravings. The magic within those murky blades will bleed unnatural darkness when charged with magic.", 
                WT_SWORD, WSZ_LARGE, true).withEffect(IELib.ScaleAttack_Str, 40), Weapon) catch(e:Dynamic) null;
    public var TRCLAYM(default, never) : Weapon = try cast(new Weapon(
                "TRClaym", "T.R.Claymore", "twin ruby claymores", "a twin ruby claymores", "cleaving sword-slash", 15, 2400, 
                "Those twin two-handed swords are made of crimson metal and richly decorated with rubies and gold engravings. The magic within those crimson blades will flare up with magical flames when charged with magic.", 
                WT_SWORD, WSZ_LARGE, true).withEffect(IELib.ScaleAttack_Str, 40), Weapon) catch(e:Dynamic) null;
    public var TSRULER(default, never) : Weapon = try cast(new Weapon(
                                "TSRuler", "T.S.Rulers", "Twin Storm Rulers", "a pair of Storm Rulers", "smash", 15, 9600, 
                                "A pair of greatwords with broken blades, still possessing the residual power of lightning. Also known as the 'Giantslayer', for bringing giants to their knees. Deals increased damage to large enemies.", 
                                WT_MACE_HAMMER, WSZ_LARGE, true).withBuffs({
                                    psoulskillpower : +0.4
                                }).withEffect(IELib.Stun, 10).withTags(W_LIGHTNING_TYPE), Weapon) catch(e:Dynamic) null;
    public var TSCLAYM(default, never) : Weapon = try cast(new Weapon(
                "TSClaym", "T.S.Claymore", "twin sapphire claymores", "a twin sapphire claymores", "cleaving sword-slash", 15, 2400, 
                "Those twin two-handed swords are made of azure metal and richly decorated with sapphires and silver engravings. The magic within those azure blades will radiate magical frost when charged with magic.", 
                WT_SWORD, WSZ_LARGE, true).withEffect(IELib.ScaleAttack_Str, 40), Weapon) catch(e:Dynamic) null;
    public var TTCLAYM(default, never) : Weapon = try cast(new Weapon(
                "TTClaym", "T.T.Claymore", "twin topaz claymores", "a twin topaz claymores", "cleaving sword-slash", 15, 2400, 
                "Those twin two-handed swords are made of eversteel and richly decorated with yellow topazes and copper engravings. The magic within those shining blades will oversaturate the metal with electricity when charged with magic.", 
                WT_SWORD, WSZ_LARGE, true).withEffect(IELib.ScaleAttack_Str, 40), Weapon) catch(e:Dynamic) null;
    public var U_STAFF(default, never) : Weapon = new UnicornStaff();
    public var UDKDEST(default, never) : Weapon = try cast(new Weapon(
                                "UDKDest", "UDKDestroyer", "Undefeated King's Destroyer", "an Undefeated King's Destroyer", "smash", 75, 9000, 
                                "This unrealistically large two handed mace belonged in the past to the king, which claimed to be undefeated. To just lift it you will need some absurd strength and know special technique to wield such type of weapons.", 
                                WT_MACE_HAMMER, WSZ_MASSIVE).withTags(W_WHIRLWIND, W_LGWRATH).withEffect(IELib.Stun, 20).withEffect(IELib.ScaleAttack_StrXL, 250), Weapon) catch(e:Dynamic) null;
    public var UGATANA(default, never) : Weapon = findCommonDynamicWeapon("uchigatana");
    public var URTAHLB(default, never) : Weapon = try cast(new Weapon("UrtaHlb", "UrtaHlb", "halberd", "a halberd", "slash", 50, 2000, "Urta's halberd. How did you manage to get this?", WT_POLEARM, WSZ_LARGE).withTags(W_WHIRLWIND), Weapon) catch(e:Dynamic) null;
    public var VBLADE(default, never) : Weapon = new Weapon(
        "V.Blade", "V.Blade", "V.Blade", "a V.Blade", "slash", 28, 2240, 
        "A peculiar sword. The letter V is engraved into the blade perhaps its former owner name.", 
        WT_SWORD, WSZ_MEDIUM);
    public var VENCLAW(default, never) : Venoclaw = new Venoclaw();
    public var VGRAVEH(default, never) : Weapon = try cast(new Weapon("VGraveh", "VolcanicGravehammer", "Volcanic Gravehammer", "a Volcanic Gravehammer", "smash", 160, 160, "The titanic greathammer you found in the ashlands. This weapon seems to have been hewn from perpetually molten bedrock from deep within a volcano. How it remains this way is unknown to you, but you wonder if it was enchanted to be as such, or if it's just a natural property of the materials it's been crafted from.", WT_MACE_HAMMER, WSZ_MASSIVE).withTag(W_LGWRATH).withEffect(IELib.ScaleAttack_StrXL, 800), Weapon) catch(e:Dynamic) null;
    public var W_STAFF(default, never) : Weapon = try cast(new Weapon(
                "W.Staff", "W. Staff", "wizard's staff", "a wizard's staff", "smack", 3, 240, 
                "This staff is made of very old wood and seems to tingle to the touch.  The top has an odd zig-zag shape to it, and the wood is worn smooth from lots of use.  It probably belonged to a wizard at some point and would aid magic use.", 
                WT_STAFF, WSZ_LARGE).withBuff("spellpower", +0.4), Weapon) catch(e:Dynamic) null;
    public var WARHAMR(default, never) : Weapon = findCommonDynamicWeapon("warhammer");
    public var WHIP(default, never) : Weapon = findCommonDynamicWeapon("whip");
    public var WG_GAXE(default, never) : Weapon = try cast(new Weapon(
                                "W.GAXE", "Winged G.Axe", "winged greataxe", "a winged greataxe", "cleave", 100, 8000, 
                                "A greataxe made in untarnished steel and imbued with holy power. Its shaft is wrapped in feathery wings made of brass and gold. This holy artifact was created to execute demonic fiends, always finding their weakest spot.", 
                                WT_AXE, WSZ_LARGE).withTags(I_LEGENDARY, W_PURE_TYPE).withEffect(IELib.ScaleAttack_Str, 100).withEffect(IELib.AttackBonus_Cor, -1 / 20), Weapon) catch(e:Dynamic) null;
    public var WDBLADE(default, never) : Weapon = try cast(new Weapon(
                        "WDBlade", "WardensBlade", "Warden’s blade", "a Warden’s blade", "slash", 15, 1200, 
                        "Wrought from alchemy, not the forge, this sword is made from sacred wood and resonates with Yggdrasil’s song.", 
                        WT_SWORD, WSZ_MEDIUM).withBuffs({
                            psoulskillpower : +0.4
                        }).withPerk(PerkLib.BladeWarden), Weapon) catch(e:Dynamic) null;
    public var WDSTAFF(default, never) : Weapon = try cast(new Weapon(
                        "WDStaff", "WardensStaff", "Warden’s staff", "a Warden’s staff", "smack", 10, 1600, 
                        "This staff looks ordinary up until the crystal at its tip, which is attached by tendrils grown from the staff’s body. The sacred wood faintly seethes with arcane power, and the light within the crystal pulses to the tempo of Yggdrasil's song.", 
                        WT_STAFF, WSZ_LARGE).withBuffs({
                            spellpower : +0.6,
                            msoulskillpower : +0.4
                        }).withPerk(PerkLib.MageWarden), Weapon) catch(e:Dynamic) null;
    public var WGSWORD(default, never) : Weapon = try cast(new Weapon(
                                "WGSword", "WardenGSword", "Warden’s greatsword", "a Warden’s greatsword", "slash", 30, 2400, "Wrought from alchemy, not the forge, this sword is made from sacred wood and resonates with Yggdrasil’s song.", 
                                WT_SWORD, WSZ_LARGE).withBuffs({
                                    psoulskillpower : +0.4,
                                    msoulskillpower : +0.4
                                }).withPerk(PerkLib.StrifeWarden).withEffect(IELib.ScaleAttack_Str, 100), Weapon) catch(e:Dynamic) null;
    public var YAMARG(default, never) : YamaRajaGrasp = new YamaRajaGrasp();
    public var ZWNDER(default, never) : Weapon = findCommonDynamicWeapon("zweihander");
    //Spellcasting weapon
    public var S_SWORD(default, never) : Weapon = try cast(new Weapon(
                        "S.Sword", "S.Sword", "Sorcerer sword", "a sorcerer sword", "slash", 25, 2000, "This weapon was forged by elven wizards. It is both an excelent catalyst and a deadly blade.", WT_SWORD, WSZ_MEDIUM).withBuff("spellpower", +0.40).withTags(W_STAFFPART), Weapon) catch(e:Dynamic) null;
    public var A_WAND(default, never) : Weapon = try cast(new Weapon(
                "A.Wand", "A.Wand", "Apprentice wand", "an apprentice wand", "smack", 1, 80, "A low quality wand. Light and cheap it is commonly used by young apprentices who have started learning magic. Seeing as beginners tend to cause their catalyst to explode this is the perfect weapon for them.", WT_WAND, WSZ_MEDIUM).withBuff("spellpower", +0.30), Weapon) catch(e:Dynamic) null;
    public var O_WAND(default, never) : Weapon = try cast(new Weapon(
                "O.Wand", "O.Wand", "Old wand", "an old wand", "smack", 1, 500, "An old wand. It seems to be broken or worn out, perhaps it can be repaired by a skilled wizard? It is not very useful in its current state but may be able to boost your spellpower if repaired.", WT_WAND, WSZ_MEDIUM).withBuff("spellpower", +0.10), Weapon) catch(e:Dynamic) null;
    public var R_WAND(default, never) : Weapon = try cast(new Weapon(
                "R.Wand", "R.Wand", "Repaired Old wand", "an old wand repaired by alvina", "smack", 1, 800, "An old wand that has been repaired for you by Alvina. It boosts your spellpower, though not as much as if it were made specifically for you.", WT_WAND, WSZ_MEDIUM).withBuff("spellpower", +0.80), Weapon) catch(e:Dynamic) null;
    public var H_WAND(default, never) : Weapon = try cast(new Weapon(
                "H.Wand", "H.Wand", "hellcat wand", "a hellcat wand", "smack", 1, 500, "A hellcat witch wand. Commonly used by hellcats to deliver their iconic fire magic.", WT_WAND, WSZ_MEDIUM).withBuff("spellpower", +1), Weapon) catch(e:Dynamic) null;
    public var WDAGGER(default, never) : Weapon = try cast(new Weapon(
                        "WDagger", "W.Dagger", "witch dagger", "a witch dagger", "stab", 3, 500, "A dagger engraved with magical runes. While not the best catalyst around it is light, discreet and excelent for delivering spells.", WT_DAGGER, WSZ_SMALL).withBuff("spellpower", +0.20).withTags(W_STAFFPART), Weapon) catch(e:Dynamic) null;
    public var SFLUTTE(default, never) : Weapon = try cast(new Weapon(
                                "SFlute", "S.Flute", "Satyr Flute", "a Satyr Flute", "smack", 1, 160, "A musical instrument favored by satyr. This flute can draw beautiful desire inspiring notes and even magic in the hands of someone with an affinity for music.", WT_MACE_HAMMER, WSZ_SMALL).withBuff("spellpower", +0.50).withPerk(PerkLib.PerformancePower, 0.5, 0, 0, 0).withTags(W_MUSICINSTR), Weapon) catch(e:Dynamic) null;
    public var PFLUTTE(default, never) : Weapon = try cast(new Weapon(
                                "PFlute", "P.Flute", "Pan Flute", "a Pan Flute", "smack", 1, 160, "A musical instrument favored by Pan the satyr lord who guards the edge labyrinth of the twilight grove. It was made out from the wood of a tentacle tree. Pan was considered a paragon amongst his people, his fabled music able to plunge his target into lewd waking dreams or horrifying nightmares.", WT_MACE_HAMMER, WSZ_SMALL).withBuff("spellpower", +0.50).withPerk(PerkLib.PerformancePower, 1, 0, 0, 0).withTags(W_MUSICINSTR), Weapon) catch(e:Dynamic) null;
    public var HELLCAL(default, never) : Weapon = try cast(new Weapon(
                                "Hellcaller", "Hellcaller", "Hellcaller", "a Hellcaller", "smack", 1, 640, "Pan flute further infused with the power of corruption. Its depraved notes invite the listener to act of wanton debauchery or self destruction. This is an instrument of ruin not of creation.", WT_MACE_HAMMER, WSZ_SMALL).withBuff("spellpower", +1.50).withPerk(PerkLib.PerformancePower, 1.5, 0, 0, 0).withTags(W_MUSICINSTR, I_LEGENDARY, W_CORRUPT_TYPE), Weapon) catch(e:Dynamic) null;
    public var ELYSIUM(default, never) : Weapon = try cast(new Weapon(
                                "Elysium", "Elysium", "Elysium", "a Elysium", "smack", 1, 640, "Pan flute purified and strengthened by holy magic. The allure of good and beauty of pure innocent love can be transmitted through its notes granting a glimpse of the designs of creation to its listeners.", WT_MACE_HAMMER, WSZ_SMALL).withBuff("spellpower", +1.50).withPerk(PerkLib.PerformancePower, 1.5, 0, 0, 0).withTags(W_MUSICINSTR, I_LEGENDARY, W_PURE_TYPE), Weapon) catch(e:Dynamic) null;
    public var OCCULUS(default, never) : Weapon = new Occulus();
    public var ECLIPSE(default, never) : Weapon = new Eclipse();
    public var NEXUS(default, never) : Weapon = new Nexus();  //We may need to add a special event or forge for this item  
    public var NECROWA(default, never) : Weapon = new NecroWand();
    
    //===================//
    // Single/Dual pairs //
    //===================//
    
    public var SingleDualPairList(default, never) : Array<Dynamic> = [
        [KAMA, D_KAMA], 
        [DAGGER, DDAGGER], 
        [ANGSTD1, ANGSTD], 
        [DAGWHIP, DDAGWHIP], 
        [BFSWORD, DBFSWO], 
        [BFTHSWORD, DBFTHSWO], 
        [BFWHIP, DBFWHIP], 
        [NODACHI, DNODACHI], 
        [WHIP, PWHIP], 
        [WARHAMR, D_WHAM_], 
        [SUCWHIP, PSWHIP], 
        [KATANA, DKATANA], 
        [L__AXE, DL_AXE_], 
        [MACGRSW, TMACGRSW], 
        [RIPPER1, TRIPPER1], 
        [RIPPER2, TRIPPER2], 
        [ACLAYMO, TACLAYM], 
        [RCLAYMO, TRCLAYM], 
        [SCLAYMO, TSCLAYM], 
        [TCLAYMO, TTCLAYM], 
        [S_RULER, TSRULER], 
        [PHALLUS, PHALUSS], 
        [L_WHIP, DL_WHIP], 
        [B_SWORD, DBSWORD], 
        [EXCALIB, DEXCALI], 
        [HATWINSCY, ATWINSCY]
    ];

    public function new()
    {
        super();
    }
}

