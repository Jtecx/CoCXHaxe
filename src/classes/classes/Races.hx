package classes;

import flash.errors.Error;
import classes.races.*;
import classes.races.KirinRace;
import classes.scenes.monsters.Werespider;
import classes.scenes.monsters.WerespiderScene;
import classes.internals.race.RaceTierBuilder;

class Races
{
    /**
	 * All races, including disabled
	 */
    public static var AllRacesWithDisabled : Array<Dynamic> = [];
    /**
	 * All races except disabled; use this array to calc racial scores and apply bonuses
	 */
    public static var AllEnabledRaces : Array<Dynamic> = [];
    /**
	 * All races except disabled and hidden
	 */
    public static var AllVisibleRaces : Array<Dynamic> = [];
    /**
	 * All visible enabled races, sorted by name
	 */
    public static var AllRacesByName : Array<Dynamic> = [];
    
    public static var HUMAN : HumanRace = new HumanRace(1);
    public static var CAT : CatRace = new CatRace(2);
    public static var NEKOMATA : NekomataRace = new NekomataRace(3);
    public static var CHESHIRE : CheshireRace = new CheshireRace(4);
    public static var HELLCAT : HellcatRace = new HellcatRace(5);
    public static var DISPLACERBEAST : DisplacerBeastRace = new DisplacerBeastRace(6);
    public static var SPHINX : SphinxRace = new SphinxRace(7);
    public static var LIZARD : LizardRace = new LizardRace(8);
    public static var DRAGON : DragonRace = new DragonRace(9);
    public static var DRAGONNE : DragonneRace = new DragonneRace(10);
    public static var RACCOON : RaccoonRace = new RaccoonRace(11);
    public static var DOG : DogRace = new DogRace(12);
    public static var WOLF : WolfRace = new WolfRace(13);
    public static var WEREWOLF : WerewolfRace = new WerewolfRace(14);
    public static var FOX : FoxRace = new FoxRace(15);
    public static var FERRET : FerretRace = new FerretRace(16);
    public static var KITSUNE : KitsuneRace = new KitsuneRace(17);
    public static var KITSHOO : KitshooRace = new KitshooRace(18);
    public static var HORSE : HorseRace = new HorseRace(19);
    public static var UNICORN : UnicornRace = new UnicornRace(20);
    public static var CENTAUR : CentaurRace = new CentaurRace(21);
    public static var MINOTAUR : MinotaurRace = new MinotaurRace(22);
    public static var COW : CowRace = new CowRace(23);
    public static var SANDTRAP : SandTrapRace = new SandTrapRace(24);
    public static var BEE : BeeRace = new BeeRace(25);
    public static var GOBLIN : GoblinRace = new GoblinRace(26);
    public static var DEMON : DemonRace = new DemonRace(27);
    public static var DEVIL : DevilRace = new DevilRace(28);
    public static var SHARK : SharkRace = new SharkRace(29);
    public static var ORCA : OrcaRace = new OrcaRace(30);
    public static var OOMUKADE : OomukadeRace = new OomukadeRace(31);
    public static var ONI : OniRace = new OniRace(32);
    public static var ELF : ElfRace = new ElfRace(33);
    public static var ORC : OrcRace = new OrcRace(34);
    public static var RAIJU : RaijuRace = new RaijuRace(35);
    public static var THUNDERBIRD : ThunderbirdRace = new ThunderbirdRace(365);
    public static var BUNNY : BunnyRace = new BunnyRace(37);
    public static var HARPY : HarpyRace = new HarpyRace(38);
    public static var SPIDER : SpiderRace = new SpiderRace(39);
    public static var KANGAROO : KangarooRace = new KangarooRace(40);
    public static var MOUSE : MouseRace = new MouseRace(41);
    public static var SCORPION : ScorpionRace = new ScorpionRace(42);
    public static var MANTIS : MantisRace = new MantisRace(43);
    public static var SALAMANDER : SalamanderRace = new SalamanderRace(44);
    public static var CAVEWYRM : CaveWyrmRace = new CaveWyrmRace(45);
    public static var NAGA : NagaRace = new NagaRace(46);
    public static var GORGON : GorgonRace = new GorgonRace(47);
    public static var VOUIVRE : VouivreRace = new VouivreRace(48);
    public static var COUATL : CouatlRace = new CouatlRace(49);
    public static var HYDRA : HydraRace = new HydraRace(50);
    public static var FIRESNAILS : FireSnailRace = new FireSnailRace(51);
    public static var PHOENIX : PhoenixRace = new PhoenixRace(52);
    public static var SCYLLA : ScyllaRace = new ScyllaRace(53);
    public static var PLANT : PlantRace = new PlantRace(54);
    public static var ALRAUNE : AlrauneRace = new AlrauneRace(55);
    public static var YGGDRASIL : YgddrasilRace = new YgddrasilRace(56);
    public static var PIG : PigRace = new PigRace(57);
    public static var SATYR : SatyrRace = new SatyrRace(58);
    public static var RHINO : RhinoRace = new RhinoRace(59);
    public static var ECHIDNA : EchidnaRace = new EchidnaRace(60);
    public static var DEER : DeerRace = new DeerRace(61);
    public static var MANTICORE : ManticoreRace = new ManticoreRace(62);
    public static var REDPANDA : RedPandaRace = new RedPandaRace(63);
    public static var BEARANDPANDA : BearRace = new BearRace(64);
    public static var SIREN : SirenRace = new SirenRace(65);
    public static var YETI : YetiRace = new YetiRace(66);
    public static var YUKIONNA : YukiOnnaRace = new YukiOnnaRace(67);
    public static var BAT : BatRace = new BatRace(68);
    public static var VAMPIRE : VampireRace = new VampireRace(69);
    public static var JABBERWOCKY : JabberwockyRace = new JabberwockyRace(70);
    public static var AVIAN : AvianRace = new AvianRace(71);
    public static var GARGOYLE : GargoyleRace = new GargoyleRace(72);
    public static var SLIME : SlimeRace = new SlimeRace(73);
    public static var MAGMASLIME : MagmaSlimeRace = new MagmaSlimeRace(74);
    public static var DARKSLIME : DarkSlimeRace = new DarkSlimeRace(75);
    public static var JIANGSHI : JiangshiRace = new JiangshiRace(76);
    public static var POLTERGEIST : PoltergeistRace = new PoltergeistRace(77);
    public static var BANSHEE : BansheeRace = new BansheeRace(78);
    public static var MELKIE : MelkieRace = new MelkieRace(79);
    public static var EASTERBUNNY : EasterBunnyRace = new EasterBunnyRace(80);
    public static var CENTIPEDE : CentipedeRace = new CentipedeRace(81);
    public static var FROSTWYRM : FrostWyrmRace = new FrostWyrmRace(82);
    public static var CANCER : CancerRace = new CancerRace(83);
    public static var USHIONNA : UshiOniRace = new UshiOniRace(84);
    public static var FAIRY : FairyRace = new FairyRace(85);
    public static var GREMLIN : GremlinRace = new GremlinRace(86);
    public static var KAMAITACHI : KamaitachiRace = new KamaitachiRace(87);
    public static var GAZER : GazerRace = new GazerRace(88);
    public static var RATATOSKR : RatatoskrRace = new RatatoskrRace(89);
    public static var WENDIGO : WendigoRace = new WendigoRace(90);
    public static var TROLL : TrollRace = new TrollRace(91);
    public static var ATLACH_NACHA : AtlachNachaRace = new AtlachNachaRace(92);
    public static var WOODELF : WoodElfRace = new WoodElfRace(93);
    public static var SEA_DRAGON : SeaDragonRace = new SeaDragonRace(94);
    public static var FMINDBREAKER : FemaleMindbreakerRace = new FemaleMindbreakerRace(95);
    public static var MMINDBREAKER : MaleMindbreakerRace = new MaleMindbreakerRace(96);
    public static var ELEMENTALFUSION : ElementalRace = new ElementalRace(97);
    public static var GRYPHON : GryphonRace = new GryphonRace(98);
    public static var PEACOCK : PeacockRace = new PeacockRace(99);
    public static var ANGEL : AngelRace = new AngelRace(100);
    public static var APOPHIS : ApophisRace = new ApophisRace(101);
    public static var CYCLOP : CyclopRace = new CyclopRace(102);
    public static var ALICORN : AlicornRace = new AlicornRace(103);
    public static var ANT : AntRace = new AntRace(104);
    public static var KIRIN : KirinRace = new KirinRace(105);
    public static var FAERIEDRAGON : FaerieDragonRace = new FaerieDragonRace(106);
    public static var AZAZEL : AzazelRace = new AzazelRace(107);
    public static var CERBERUS : CerberusRace = new CerberusRace(108);
    public static var IMP : ImpRace = new ImpRace(109);
    public static var SANDWORM : SandWormRace = new SandWormRace(110);
    public static var RAISUNE : RaisuneRace = new RaisuneRace(111);
    public static var WEREFOX : WerefoxRace = new WerefoxRace(112);
    public static var ANUBIS : AnubisRace = new AnubisRace(113);
    public static var WERESPIDER : WerespiderRace = new WerespiderRace(114);
    public static var WERESHARK : WeresharkRace = new WeresharkRace(115);
    public static var ABYSSAL_SHARK : AbyssalSharkRace = new AbyssalSharkRace(116);
    public static var ARIGEAN : ArigeanRace = new ArigeanRace(117);
    public static var DRACULA : DraculaRace = new DraculaRace(118);
    public static var MOTH : MothRace = new MothRace(119);
    public static var GLACIAL_TROLL : GlacialTrollRace = new GlacialTrollRace(120);
    public static var LAQUINE : LaquineRace = new LaquineRace(121);
    
    // Racial groups
    public static var CatlikeRaces : Array<Dynamic> = [
        CAT, NEKOMATA, DISPLACERBEAST, HELLCAT, CHESHIRE, SPHINX, MANTICORE, DRAGONNE
    ];
    public static var SnakelikeRaces : Array<Dynamic> = [
        NAGA, GORGON, VOUIVRE, COUATL, HYDRA, APOPHIS
    ];
    public static var InsectRaces : Array<Dynamic> = [
        BEE, MANTIS, SCORPION, SPIDER, ANT, OOMUKADE, CANCER, ATLACH_NACHA, SANDWORM, WERESPIDER, MOTH
    ];
    public static var GoblinoidRaces : Array<Dynamic> = [
        GOBLIN, GREMLIN
    ];
    public static var HarpylikeRaces : Array<Dynamic> = [
        HARPY, THUNDERBIRD, PHOENIX
    ];
    public static var KitsunelikeRaces : Array<Dynamic> = [
        KITSUNE, KITSHOO, RAISUNE
    ];
    public static var RacesForRandomEnchantments : Array<Dynamic> = [];
    // Don't use these races when generating random enchantment
    private static var RacesExcludedFromRandomEnchantments : Array<Dynamic> = [
        ELEMENTALFUSION
    ];
    
    private function new()
    {
    }
    
    public static function load() : Void
    {
        RaceTierBuilder.ensureEndCalled();
        // log scary numbers for fun
        var nreq : Int = 0;
        var nt : Int = 0;
        var nr : Int = 0;
        
        for (id in Reflect.fields(Race.RaceById))
        {
            var race : Race = Race.RaceById[id];
            AllRacesWithDisabled.push(race);
            try
            {
                race.setup();
            }
            catch (e : Error)
            {
                trace("[ERROR] Error initializing race " + race.name);
                trace(e.getStackTrace());
                continue;
            }
            if (race.disabled)
            {
                trace("Race " + race.name + " (#" + race.id + ") is disabled");
                continue;
            }
            else if (race.tiers.length == 0)
            {
                trace("[ERROR] Race " + race.name + " has no tiers, disabling it");
                race.disabled = true;
                continue;
            }
            nr++;
            nreq += race.requirements.length;
            nt += race.tiers.length;
            AllEnabledRaces.push(race);
            if (race.hidden)
            {
                trace("Race " + race.name + " (#" + race.id + ") is hidden");
                continue;
            }
            AllVisibleRaces.push(race);
            if (Lambda.indexOf(RacesExcludedFromRandomEnchantments, race) == -1)
            {
                RacesForRandomEnchantments.push(race);
            }
        }
        trace("Loaded " + nr + " races, " + nt + " tiers, " + nreq + " requirements");
        
        AllRacesByName = AllVisibleRaces.copy().sortOn("name", Array.CASEINSENSITIVE);
    }
}

