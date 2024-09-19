package classes.transformations;

import classes.bodyParts.*;
import classes.CockTypesEnum;
import classes.items.MutationsHelper;
import classes.transformations.transformations.*;
import classes.internals.EnumValue;

class TransformationLib extends MutationsHelper
{
    public function new()
    {
        super();
        //	printAlchemyTable();
        
    }
    
    // VARIABLE NAMING: <body part> + <what to do> + <flavour>
    // e.g. "grow 9th fox tail" -> TailFox9
    // Complex TF should have prefix "Complex" or "Tiered" and can have any naming
    
    // Template - copy and fill
    // "is possible" function is optional default is "possible if not present"
    /*
public const NAME:Transformation = new SimpleTransformation("Tf Name",
			// apply effect
			function (doOutput:Boolean):void {
				if (doOutput) {
					outputText("TF Effect")
				}
				apply_TF
			},
			// is present
			function():Boolean {
				return true_if_TF_already_present_on_player
			},
			// is possible
			function():Boolean {
				return true_if_TF_can_be_applied_to_player
			}
);
*/
    
    
    /***
*    ███████ ███████ ███████ ███████  ██████ ████████ ███████
*    ██      ██      ██      ██      ██         ██    ██
*    █████   █████   █████   █████   ██         ██    ███████
*    ██      ██      ██      ██      ██         ██         ██
*    ███████ ██      ██      ███████  ██████    ██    ███████
*
*
*/
    // Template for non-tf effects and tf effects that cannot be "present" (ex. enlarge cock)
    // "is possible" function is optional, default always possible
    /*
public const NAME:PossibleEffect = new SimpleEffect("Effect name",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				if (doOutput) outputText(desc);
				apply_effect
			},
			// is possible?
			function ():Boolean {
				return true_if_effect_can_be_applied_to_player
			}
);
*/
    
    /*
	*/
    public var mutagenEffect : MutagenEffectTransformations = new MutagenEffectTransformations();
    public var MutagenSpeSpider(default, never) : PossibleEffect = mutagenEffect.MutagenSpeSpider;
    public var MutagenCurseSpeSpider(default, never) : PossibleEffect = mutagenEffect.MutagenCurseSpeSpider;
    public var MutagenTouSpider(default, never) : PossibleEffect = mutagenEffect.MutagenTouSpider;
    public var MutagenCurseStrSpider(default, never) : PossibleEffect = mutagenEffect.MutagenCurseStrSpider;
    public var MutagenLibSpider(default, never) : PossibleEffect = mutagenEffect.MutagenLibSpider;
    public var MutagenSpdCat(default, never) : PossibleEffect = mutagenEffect.MutagenSpdCat;
    public var MutagenStrCat(default, never) : PossibleEffect = mutagenEffect.MutagenStrCat;
    public var MutagenIntCat(default, never) : PossibleEffect = mutagenEffect.MutagenIntCat;
    public var MutagenCurseTouCat(default, never) : PossibleEffect = mutagenEffect.MutagenCurseTouCat;
    public var MutagenLibSensCat(default, never) : PossibleEffect = mutagenEffect.MutagenLibSensCat;
    public var MutagenSpeKanga(default, never) : PossibleEffect = mutagenEffect.MutagenSpeKanga;
    public var MutagenCurseIntKanga(default, never) : PossibleEffect = mutagenEffect.MutagenCurseIntKanga;
    
    public var SensUpSpider(default, never) : PossibleEffect = mutagenEffect.SensUpSpider;
    public var VenomRechargeSpider(default, never) : PossibleEffect = mutagenEffect.VenomRechargeSpider;
    public var VaginaTightenAndMutagenLib(default, never) : PossibleEffect = mutagenEffect.VaginaTightenAndMutagenLib;
    public var AssholeTightenAndMutagenLib(default, never) : PossibleEffect = mutagenEffect.AssholeTightenAndMutagenLib;
    public var CocksThickenAll(default, never) : PossibleEffect = mutagenEffect.CocksThickenAll;
    public var ShrinkClit(default, never) : PossibleEffect = mutagenEffect.ShrinkClit.registerEffect(AS_CLIT, AE_SHRINK);
    public var ShrinkBalls(default, never) : Transformation = mutagenEffect.ShrinkBalls.registerTf(AS_BALLS, AE_SHRINK);
    
    //ANTENNAE
    //======================================================================================================================
    //                                                                                                                    ==
    //    █████  ███    ██ ████████ ███████ ███    ██ ███    ██  █████  ███████                                           ==
    //   ██   ██ ████   ██    ██    ██      ████   ██ ████   ██ ██   ██ ██                                                ==
    //   ███████ ██ ██  ██    ██    █████   ██ ██  ██ ██ ██  ██ ███████ █████                                             ==
    //   ██   ██ ██  ██ ██    ██    ██      ██  ██ ██ ██  ██ ██ ██   ██ ██                                                ==
    //   ██   ██ ██   ████    ██    ███████ ██   ████ ██   ████ ██   ██ ███████                                           ==
    //                                                                                                                    ==
    //======================================================================================================================
    public var antennae : AntennaeTransformations = new AntennaeTransformations();
    public var AntennaeNone(default, never) : Transformation = antennae.AntennaeNone.registerTf(AS_ANTENNAE, AE_REMOVE);
    public var AntennaeAnt(default, never) : Transformation = antennae.AntennaeAnt.registerTf(AS_ANTENNAE, AE_ANT);
    public var AntennaeBee(default, never) : Transformation = antennae.AntennaeBee.registerTf(AS_ANTENNAE, AE_BEE);
    public var AntennaeCentipede(default, never) : Transformation = antennae.AntennaeCentipede.registerTf(AS_ANTENNAE, AE_CENTIPEDE);
    public var AntennaeFireSnail(default, never) : Transformation = antennae.AntennaeFireSnail.registerTf(AS_ANTENNAE, AE_FIRE_SNAIL);
    public var AntennaeJabberwocky(default, never) : Transformation = antennae.AntennaeJabberwocky.registerTf(AS_ANTENNAE, AE_JABBERWOCKY);
    public var AntennaeMantis(default, never) : Transformation = antennae.AntennaeMantis.registerTf(AS_ANTENNAE, AE_MANTIS);
    public var AntennaeSeaDragon(default, never) : Transformation = antennae.AntennaeSeaDragon.registerTf(AS_ANTENNAE, AE_SEA_DRAGON);
    public var AntennaeMoth(default, never) : Transformation = antennae.AntennaeMoth.registerTf(AS_ANTENNAE, AE_MOTH);
    
    //ARMS
    //======================================================================================================================
    //  .                                                                                                                 ==
    //    █████  ██████  ███      ███ ███████                                                                             ==
    //   ██   ██ ██   ██ ████    ████ ██                                                                                  ==
    //   ███████ ██████  ██  ████  ██ ███████                                                                             ==
    //   ██   ██ ██   ██ ██   ██   ██      ██                                                                             ==
    //   ██   ██ ██   ██ ██        ██ ███████                                                                             ==
    //                                                                                                                    ==
    //======================================================================================================================
    public var arms : ArmsTransformations = new ArmsTransformations();
    public var ArmsHuman(default, never) : Transformation = arms.ArmsHuman.registerTf(AS_ARMS, AE_HUMAN);
    public var ArmsAnt(default, never) : Transformation = arms.ArmsAnt.registerTf(AS_ARMS, AE_ANT);
    public var ArmsAtlach(default, never) : Transformation = arms.ArmsAtlach.registerTf(AS_ARMS, AE_ATLACH_NACHA);
    public var ArmsAvian(default, never) : Transformation = arms.ArmsAvian.registerTf(AS_ARMS, AE_AVIAN);
    public var ArmsBatWing(default, never) : Transformation = arms.ArmsBatWing.registerTf(AS_ARMS, AE_BAT);
    public var ArmsBear(default, never) : Transformation = arms.ArmsBear.registerTf(AS_ARMS, AE_BEAR);
    public var ArmsBee(default, never) : Transformation = arms.ArmsBee.registerTf(AS_ARMS, AE_BEE);
    public var ArmsBoar(default, never) : Transformation = arms.ArmsBoar.registerTf(AS_ARMS, AE_BOAR);
    public var ArmsCat(default, never) : Transformation = arms.ArmsCat.registerTfMultiple(AS_ARMS, AE_CAT, AE_DRAGONNE);
    public var ArmsCaveWyrm(default, never) : Transformation = arms.ArmsCaveWyrm.registerTf(AS_ARMS, AE_CAVE_WYRM);
    public var ArmsCentipede(default, never) : Transformation = arms.ArmsCentipede.registerTf(AS_ARMS, AE_CENTIPEDE);
    public var ArmsDevil(default, never) : Transformation = arms.ArmsDevil.registerTf(AS_ARMS, AE_DEVIL);
    public var ArmsDisplacer(default, never) : Transformation = arms.ArmsDisplacer.registerTf(AS_ARMS, AE_DISPLACER_BEAST);
    public var ArmsDraconic(default, never) : Transformation = arms.ArmsDraconic.registerTf(AS_ARMS, AE_DRAGON);
    public var ArmsFeyDraconic(default, never) : Transformation = arms.ArmsFeyDraconic.registerTf(AS_ARMS, AE_FAERIE_DRAGON);
    public var ArmsElf(default, never) : Transformation = arms.ArmsElf.registerTf(AS_ARMS, AE_ELF);
    public var ArmsFox(default, never) : Transformation = arms.ArmsFox.registerTf(AS_ARMS, AE_FOX);
    public var ArmsFrostwyrm(default, never) : Transformation = arms.ArmsFrostwyrm.registerTf(AS_ARMS, AE_FROST_WYRM);
    public var ArmsGazer(default, never) : Transformation = arms.ArmsGazer.registerTf(AS_ARMS, AE_GAZER);
    public var ArmsGhost(default, never) : Transformation = arms.ArmsGhost.registerTf(AS_ARMS, AE_GHOST);
    public var ArmsGoo(default, never) : Transformation = arms.ArmsGoo.registerTf(AS_ARMS, AE_GOO);
    public var ArmsGryphon(default, never) : Transformation = arms.ArmsGryphon.registerTf(AS_ARMS, AE_GRYPHON);
    public var ArmsHarpy(default, never) : Transformation = arms.ArmsHarpy.registerTf(AS_ARMS, AE_HARPY);
    public var ArmsHinezumi(default, never) : Transformation = arms.ArmsHinezumi.registerTf(AS_ARMS, AE_HINEZUMI);
    public var ArmsHydra(default, never) : Transformation = arms.ArmsHydra.registerTf(AS_ARMS, AE_HYDRA);
    public var ArmsJabberwocky(default, never) : Transformation = arms.ArmsJabberwocky.registerTf(AS_ARMS, AE_JABBERWOCKY);
    public var ArmsJiangshi(default, never) : Transformation = arms.ArmsJiangshi.registerTf(AS_ARMS, AE_JIANGSHI);
    public var ArmsKamaitachi(default, never) : Transformation = arms.ArmsKamaitachi.registerTf(AS_ARMS, AE_KAMAITACHI);
    public var ArmsKitsune(default, never) : Transformation = arms.ArmsKitsune.registerTf(AS_ARMS, AE_KITSUNE);
    public var ArmsKraken(default, never) : Transformation = arms.ArmsKraken.registerTf(AS_ARMS, AE_KRAKEN);
    public var ArmsLion(default, never) : Transformation = arms.ArmsLion.registerTfMultiple(AS_ARMS, AE_LION, AE_DRAGONNE);
    public var ArmsLizard(default, never) : Transformation = arms.ArmsLizard.registerTf(AS_ARMS, AE_LIZARD);
    public var ArmsMantis(default, never) : Transformation = arms.ArmsMantis.registerTf(AS_ARMS, AE_MANTIS);
    public var ArmsMelkie(default, never) : Transformation = arms.ArmsMelkie.registerTf(AS_ARMS, AE_MELKIE);
    public var ArmsOni(default, never) : Transformation = arms.ArmsOni.registerTf(AS_ARMS, AE_ONI);
    public var ArmsOrc(default, never) : Transformation = arms.ArmsOrc.registerTf(AS_ARMS, AE_ORC);
    public var ArmsOrca(default, never) : Transformation = arms.ArmsOrca.registerTf(AS_ARMS, AE_ORCA);
    public var ArmsPhoenix(default, never) : Transformation = arms.ArmsPhoenix.registerTf(AS_ARMS, AE_PHOENIX);
    public var ArmsPig(default, never) : Transformation = arms.ArmsPig.registerTf(AS_ARMS, AE_PIG);
    public var ArmsPlant(default, never) : Transformation = arms.ArmsPlant.registerTf(AS_ARMS, AE_PLANT);
    public var ArmsPlant2(default, never) : Transformation = arms.ArmsPlant2.registerTf(AS_ARMS, AE_YGGDRASIL);
    public var ArmsRaccoon(default, never) : Transformation = arms.ArmsRaccoon.registerTf(AS_ARMS, AE_RACCOON);
    public var ArmsRaiju(default, never) : Transformation = arms.ArmsRaiju.registerTf(AS_ARMS, AE_RAIJU);
    public var ArmsRaijuPaws(default, never) : Transformation = arms.ArmsRaijuPaws.registerTf(AS_ARMS, AE_RAIJU);
    public var ArmsRedPanda(default, never) : Transformation = arms.ArmsRedPanda.registerTf(AS_ARMS, AE_RED_PANDA);
    public var ArmsSalamander(default, never) : Transformation = arms.ArmsSalamander.registerTf(AS_ARMS, AE_SALAMANDER);
    public var ArmsSeaDragon(default, never) : Transformation = arms.ArmsSeaDragon.registerTf(AS_ARMS, AE_SEA_DRAGON);
    public var ArmsShark(default, never) : Transformation = arms.ArmsShark.registerTfMultiple(AS_ARMS, AE_SHARK, AE_WERESHARK);
    public var ArmsSphinx(default, never) : Transformation = arms.ArmsSphinx.registerTf(AS_ARMS, AE_SPHINX);
    public var ArmsSpider(default, never) : Transformation = arms.ArmsSpider.registerTf(AS_ARMS, AE_SPIDER);
    public var ArmsSquirrel(default, never) : Transformation = arms.ArmsSquirrel.registerTf(AS_ARMS, AE_SQUIRREL);
    public var ArmsUshiOni(default, never) : Transformation = arms.ArmsUshiOni.registerTf(AS_ARMS, AE_USHI_ONI);
    public var ArmsWeasel(default, never) : Transformation = arms.ArmsWeasel.registerTf(AS_ARMS, AE_WEASEL);
    public var ArmsWendigo(default, never) : Transformation = arms.ArmsWendigo.registerTf(AS_ARMS, AE_WENDIGO);
    public var ArmsWolf(default, never) : Transformation = arms.ArmsWolf.registerTf(AS_ARMS, AE_WOLF);
    public var ArmsHound(default, never) : Transformation = arms.ArmsHound.registerTf(AS_ARMS, AE_CERBERUS);
    public var ArmsYeti(default, never) : Transformation = arms.ArmsYeti.registerTf(AS_ARMS, AE_YETI);
    public var ArmsYukiOnna(default, never) : Transformation = arms.ArmsYukiOnna.registerTf(AS_ARMS, AE_YUKI_ONNA);
    public var ArmsTiny(default, never) : Transformation = arms.ArmsTiny.registerTf(AS_ARMS, AE_IMP);
    public var ArmsCanine(default, never) : Transformation = arms.ArmsCanine.registerTf(AS_ARMS, AE_ANUBIS);
    public var ArmsAbyssalShark(default, never) : Transformation = arms.ArmsAbyssalShark.registerTf(AS_ARMS, AE_ABYSSAL_SHARK);
    public var ArmsArigean(default, never) : Transformation = arms.ArmsArigean.registerTf(AS_ARMS, AE_ARIGEAN);
    public var ArmsDemon(default, never) : Transformation = arms.ArmsDemon.registerTf(AS_ARMS, AE_DEMON);
    public var ArmsDeer(default, never) : Transformation = arms.ArmsDeer.registerTf(AS_ARMS, AE_DEER);
    public var ArmsReindeer(default, never) : Transformation = arms.ArmsReindeer.registerTf(AS_ARMS, AE_REINDEER);
    public var ArmsMoth(default, never) : Transformation = arms.ArmsMoth.registerTf(AS_ARMS, AE_MOTH);
    public var ArmsSatyr(default, never) : Transformation = arms.ArmsSatyr.registerTf(AS_ARMS, AE_SATYR);
    public var ArmsTroll(default, never) : Transformation = arms.ArmsTroll.registerTf(AS_ARMS, AE_TROLL);
    public var ArmsGlacialTroll(default, never) : Transformation = arms.ArmsGlacialTroll.registerTf(AS_ARMS, AE_GLACIAL_TROLL);
    
    
    //ASS
    //======================================================================================================================
    //                                                                                                                    ==
    //     █████  ███████ ███████                                                                                         ==
    //    ██   ██ ██      ██                                                                                              ==
    //    ███████ ███████ ███████                                                                                         ==
    //    ██   ██      ██      ██                                                                                         ==
    //    ██   ██ ███████ ███████                                                                                         ==
    //                                                                                                                    ==
    //======================================================================================================================
    public var AssGrowUpTo11(default, never) : Transformation = new SimpleTransformation("Grow ass up to 11", 
                // apply
                function(doOutput : Bool) : Void
                {
                    var desc : String = "";
                    
                    desc += "You look over your shoulder at your [ass] only to see it expand just slightly. You gape in confusion before looking back at the remaining silk in your hands. You finish it anyway. Dammit!";
                    
                    if (doOutput)
                    {
                        outputText(desc);
                    }
                    player.butt.type++;
                }, 
                // is present
                function() : Bool
                {
                    return player.butt.type < 11;
                }).registerTf(AS_ASS, AE_GROW);
    
    
    //BALLS
    //======================================================================================================================
    //                                                                                                                    ==
    //   ██████   █████  ██     ██     ███████                                                                            ==
    //   ██   ██ ██   ██ ██     ██     ████                                                                               ==
    //   ██████  ███████ ██     ██     ███████                                                                            ==
    //   ██   ██ ██   ██ ██     ██          ██                                                                            ==
    //   ██████  ██   ██ ██████ ██████ ███████                                                                            ==
    //                                                                                                                    ==
    //======================================================================================================================
    public var balls : BallsTransformations = new BallsTransformations();
    public var BallsNone(default, never) : Transformation = balls.BallsNone.registerTf(AS_BALLS, AE_REMOVE);
    public var BallsDuo(default, never) : Transformation = balls.BallsDuo;
    public function BallsQuad(size : Int = 1, forceQuad : Bool = false) : Transformation
    {
        return balls.BallsQuad(size, forceQuad);
    }
    public var BallsTrap(default, never) : Transformation = balls.BallsTrap.registerTf(AS_BALLS, AE_SAND_TRAP);
    
    
    //BREASTS
    //======================================================================================================================
    //                                                                                                                    ==
    //   ██████  ██████  ███████  █████  ███████ ████████ ███████                                                         ==
    //   ██   ██ ██   ██ ██      ██   ██ ██         ██    ██                                                              ==
    //   ██████  ██████  █████   ███████ ███████    ██    ███████                                                         ==
    //   ██   ██ ██   ██ ██      ██   ██      ██    ██         ██                                                         ==
    //   ██████  ██   ██ ███████ ██   ██ ███████    ██    ███████                                                         ==
    //                                                                                                                    ==
    //======================================================================================================================
    public var breasts : BreastsTransformations = new BreastsTransformations();
    public function UnlockBreasts() : Void
    {
        return breasts.UnlockBreasts();
    }
    public var BreastsGrowUpToDD(default, never) : Transformation = breasts.BreastsGrowUpToDD.registerTf(AS_BREASTS, AE_GROW);
    public var BreastsShrinkToNothing(default, never) : Transformation = breasts.BreastsShrinkToNothing.registerTf(AS_BREASTS, AE_SHRINK);
    public var BreastRowsRemoveToOne(default, never) : Transformation = breasts.BreastRowsRemoveToOne.registerTf(AS_BREASTS, AE_REMOVE);
    public var BreastRowsOne(default, never) : Transformation = breasts.BreastRowsOne;
    public var BreastRowsTwo(default, never) : Transformation = breasts.BreastRowsTwo;
    public var BreastRowsThree(default, never) : Transformation = breasts.BreastRowsThree;
    public var BreastRowsFour(default, never) : Transformation = breasts.BreastRowsFour;
    public function CreateBreastRow(size : Int = 2) : Transformation
    {
        return breasts.CreateBreastRow(size);
    }
    public function CopyBreastRow(keepSize : Bool = false) : Transformation
    {
        return breasts.CopyBreastRow(keepSize);
    }
    public var NipplesPerBreastOne(default, never) : Transformation = breasts.NipplesPerBreastOne.registerTf(AS_BREASTS, AE_HUMAN);
    public var NipplesPerBreastFour(default, never) : Transformation = breasts.NipplesPerBreastFour.registerTf(AS_BREASTS, AE_COW);
    public var NipplesFuckableForce(default, never) : Transformation = breasts.NipplesFuckableForce;
    public var NipplesFuckable(default, never) : Transformation = breasts.NipplesFuckable.registerTf(AS_NIPPLES, AE_DEMON);
    public var NipplesUnfuck(default, never) : Transformation = breasts.NipplesUnfuck;
    public var StartLactation(default, never) : Transformation = breasts.StartLactation;
    public var RemoveLactation(default, never) : Transformation = breasts.RemoveLactation;
    public var NipplesNoColor(default, never) : Transformation = breasts.NipplesNoColor;
    public var NipplesBlack(default, never) : Transformation = breasts.NipplesBlack.registerTfMultiple(AS_NIPPLES, AE_SPIDER, AE_SAND_TRAP);
    public var NipplesGlowing(default, never) : Transformation = breasts.NipplesGlowing.registerTf(AS_NIPPLES, AE_CAVE_WYRM);
    public var NipplessHumanize(default, never) : Transformation = new TransformationGroupAll("Humanize nipples", [NipplesUnfuck, NipplesNoColor]).registerTf(AS_NIPPLES, AE_HUMAN);
    
    
    //COCK
    //======================================================================================================================
    //                                                                                                                    ==
    //	  ██████  ██████   ██████ ██    ██                                                                                ==
    //   ██      ██    ██ ██      ██  ██                                                                                  ==
    //	 ██      ██    ██ ██      ████                                                                                    ==
    //	 ██      ██    ██ ██      ██  ██                                                                                  ==
    //	  ██████  ██████   ██████ ██    ██                                                                                ==
    //                                                                                                                    ==
    //======================================================================================================================
    public var cocks : CockTransformations = new CockTransformations();
    public function UnlockCocks() : Void
    {
        return cocks.UnlockCocks();
    }
    public function CockNone(cock : Int = 0) : Transformation
    {
        return cocks.CockNone(cock);
    }
    public var CockRemoveRandom(default, never) : Transformation = cast((-1), CockNone).registerTf(AS_COCK, AE_REMOVE);
    public function CockHuman(cock : Int = 0, length : Float = 5.5, thickness : Float = 1) : Transformation
    {
        return cocks.CockHuman(cock, length, thickness);
    }
    public var CockAnyHuman(default, never) : Transformation = cast((-1), CockHuman).registerTf(AS_COCK, AE_HUMAN);
    public function CockHorse(cock : Int = 0, length : Float = 5.5, thickness : Float = 1) : Transformation
    {
        return cocks.CockHorse(cock, length, thickness);
    }
    public var CockAnyHorse(default, never) : Transformation = cast((-1), CockHorse).registerTfMultiple(AS_COCK, AE_HORSE, AE_ALICORN, AE_UNICORN);
    public function CockKirin(cock : Int = 0, length : Float = 5.5, thickness : Float = 1) : Transformation
    {
        return cocks.CockKirin(cock, length, thickness);
    }
    public var CockAnyKirin(default, never) : Transformation = cast((-1), CockKirin).registerTf(AS_COCK, AE_KIRIN);
    public function CockDog(cock : Int = 0, length : Float = 5.5, thickness : Float = 1, knot : Float = 1.4) : Transformation
    {
        return cocks.CockDog(cock, length, thickness, knot);
    }
    public var CockAnyDog(default, never) : Transformation = cast((-1), CockDog).registerTf(AS_COCK, AE_DOG);
    public function CockDemon(cock : Int = 0, length : Float = 5.5, thickness : Float = 1) : Transformation
    {
        return cocks.CockDemon(cock, length, thickness);
    }
    public var CockAnyDemon(default, never) : Transformation = cast((-1), CockDemon).registerTf(AS_COCK, AE_DEMON);
    public function CockTentacle(cock : Int = 0, length : Float = 5.5, thickness : Float = 1) : Transformation
    {
        return cocks.CockTentacle(cock, length, thickness);
    }
    public var CockAnyTentacle(default, never) : Transformation = cast((-1), CockTentacle).registerTf(AS_COCK, AE_PLANT);
    public function CockScylla(cock : Int = 0, length : Float = 5.5, thickness : Float = 1) : Transformation
    {
        return cocks.CockScylla(cock, length, thickness);
    }
    public var CockAnyScylla(default, never) : Transformation = cast((-1), CockScylla).registerTf(AS_COCK, AE_SCYLLA);
    public function CockCat(cock : Int = 0, length : Float = 5.5, thickness : Float = 1) : Transformation
    {
        return cocks.CockCat(cock, length, thickness);
    }
    public var CockAnyCat(default, never) : Transformation = cast((-1), CockCat).registerTf(AS_COCK, AE_CAT);
    public function CockCancer(cock : Int = 0, length : Float = 5.5, thickness : Float = 1) : Transformation
    {
        return cocks.CockCancer(cock, length, thickness);
    }
    public var CockAnyCancer(default, never) : Transformation = cast((-1), CockCancer).registerTf(AS_COCK, AE_CANCER);
    public function CockLizard(cock : Int = 0, length : Float = 5.5, thickness : Float = 1) : Transformation
    {
        return cocks.CockLizard(cock, length, thickness);
    }
    public var CockAnyLizard(default, never) : Transformation = cast((-1), CockLizard).registerTf(AS_COCK, AE_LIZARD);
    public function CockCaveWyrm(cock : Int = 0, length : Float = 5.5, thickness : Float = 1) : Transformation
    {
        return cocks.CockCaveWyrm(cock, length, thickness);
    }
    public var CockAnyCaveWyrm(default, never) : Transformation = cast((-1), CockCaveWyrm).registerTf(AS_COCK, AE_CAVE_WYRM);
    public function CockAnemone(cock : Int = 0, length : Float = 5.5, thickness : Float = 1) : Transformation
    {
        return cocks.CockAnemone(cock, length, thickness);
    }
    public var CockAnyAnemone(default, never) : Transformation = cast((-1), CockAnemone).registerTf(AS_COCK, AE_ANEMONE);
    public function CockKangaroo(cock : Int = 0, length : Float = 5.5, thickness : Float = 1) : Transformation
    {
        return cocks.CockKangaroo(cock, length, thickness);
    }
    public var CockAnyKangaroo(default, never) : Transformation = cast((-1), CockKangaroo).registerTf(AS_COCK, AE_KANGAROO);
    public function CockDragon(cock : Int = 0, length : Float = 5.5, thickness : Float = 1) : Transformation
    {
        return cocks.CockDragon(cock, length, thickness);
    }
    public var CockAnyDragon(default, never) : Transformation = cast((-1), CockDragon).registerTf(AS_COCK, AE_DRAGON);
    public function CockDisplacer(cock : Int = 0, length : Float = 5.5, thickness : Float = 1, knot : Float = 1.5) : Transformation
    {
        return cocks.CockDisplacer(cock, length, thickness, knot);
    }
    public var CockAnyDisplacer(default, never) : Transformation = cast((-1), CockDisplacer).registerTf(AS_COCK, AE_DISPLACER_BEAST);
    public function CockFox(cock : Int = 0, length : Float = 5.5, thickness : Float = 1, knot : Float = 1.25) : Transformation
    {
        return cocks.CockFox(cock, length, thickness, knot);
    }
    public var CockAnyFox(default, never) : Transformation = cast((-1), CockFox).registerTf(AS_COCK, AE_FOX);
    public function CockBee(cock : Int = 0, length : Float = 5.5, thickness : Float = 1) : Transformation
    {
        return cocks.CockBee(cock, length, thickness);
    }
    public var CockAnyBee(default, never) : Transformation = cast((-1), CockBee).registerTf(AS_COCK, AE_BEE);
    public function CockPig(cock : Int = 0, length : Float = 5.5, thickness : Float = 1) : Transformation
    {
        return cocks.CockPig(cock, length, thickness);
    }
    public var CockAnyPig(default, never) : Transformation = cast((-1), CockPig).registerTf(AS_COCK, AE_PIG);
    public function CockAvian(cock : Int = 0, length : Float = 5.5, thickness : Float = 1) : Transformation
    {
        return cocks.CockAvian(cock, length, thickness);
    }
    public var CockAnyAvian(default, never) : Transformation = cast((-1), CockAvian).registerTf(AS_COCK, AE_AVIAN);
    public function CockRhino(cock : Int = 0, length : Float = 5.5, thickness : Float = 1, inBlackCock : Bool = false) : Transformation
    {
        return cocks.CockRhino(cock, length, thickness, inBlackCock);
    }
    public var CockAnyRhino(default, never) : Transformation = cast((-1), CockRhino).registerTf(AS_COCK, AE_RHINO);
    public function CockEchidna(cock : Int = 0, length : Float = 5.5, thickness : Float = 1, inBlackCock : Bool = false) : Transformation
    {
        return cocks.CockEchidna(cock, length, thickness, inBlackCock);
    }
    public var CockAnyEchidna(default, never) : Transformation = cast((-1), CockEchidna).registerTf(AS_COCK, AE_ECHIDNA);
    public function CockWolf(cock : Int = 0, length : Float = 5.5, thickness : Float = 1, knot : Float = 1.1) : Transformation
    {
        return cocks.CockWolf(cock, length, thickness, knot);
    }
    public var CockAnyWolf(default, never) : Transformation = cast((-1), CockWolf).registerTf(AS_COCK, AE_WOLF);
    public function CockStamen(cock : Int = 0, length : Float = 5.5, thickness : Float = 1) : Transformation
    {
        return cocks.CockStamen(cock, length, thickness);
    }
    public var CockAnyStamen(default, never) : Transformation = cast((-1), CockStamen).registerTf(AS_COCK, AE_ALRAUNE);
    public function CockRedPanda(cock : Int = 0, length : Float = 5.5, thickness : Float = 1) : Transformation
    {
        return cocks.CockRedPanda(cock, length, thickness);
    }
    public var CockAnyRedPanda(default, never) : Transformation = cast((-1), CockRedPanda).registerTf(AS_COCK, AE_RED_PANDA);
    public function CockGryphon(cock : Int = 0, length : Float = 5.5, thickness : Float = 1) : Transformation
    {
        return cocks.CockGryphon(cock, length, thickness);
    }
    public var CockAnyGryphon(default, never) : Transformation = cast((-1), CockGryphon).registerTf(AS_COCK, AE_GRYPHON);
    public function CockCentipede(cock : Int = 0, length : Float = 5.5, thickness : Float = 1) : Transformation
    {
        return cocks.CockCentipede(cock, length, thickness);
    }
    public var CockAnyCentipede(default, never) : Transformation = cast((-1), CockCentipede).registerTf(AS_COCK, AE_CENTIPEDE);
    public function CockRaiju(cock : Int = 0, length : Float = 5.5, thickness : Float = 1) : Transformation
    {
        return cocks.CockRaiju(cock, length, thickness);
    }
    public var CockAnyRaiju(default, never) : Transformation = cast((-1), CockRaiju).registerTf(AS_COCK, AE_RAIJU);
    public function CockUshiOni(cock : Int = 0, length : Float = 5.5, thickness : Float = 1) : Transformation
    {
        return cocks.CockUshiOni(cock, length, thickness);
    }
    public var CockAnyUshiOni(default, never) : Transformation = cast((-1), CockUshiOni).registerTf(AS_COCK, AE_USHI_ONI);
    public function CockInsect(cock : Int = 0, length : Float = 5.5, thickness : Float = 1) : Transformation
    {
        return cocks.CockInsect(cock, length, thickness);
    }
    public var CockAnyInsect(default, never) : Transformation = cast((-1), CockInsect).registerTfMultiple(AS_COCK, AE_BEE, AE_ANT, AE_MANTIS);
    public function CockArigean(cock : Int = 0, length : Float = 5.5, thickness : Float = 1) : Transformation
    {
        return cocks.CockArigean(cock, length, thickness);
    }
    public var CockAnyArigean(default, never) : Transformation = cast((-1), CockArigean).registerTf(AS_COCK, AE_ARIGEAN);
    public function GrowKnot(cock : Int = 0, crit : Float = 1, mod : Float = 1, div : Float = 20) : Transformation
    {
        return cocks.GrowKnot(cock, crit, mod, div);
    }
    public function CockChangeType(type : CockTypesEnum, grow : Bool, oneByOne : Bool = false) : Transformation
    {
        return cocks.CockChangeType(type, grow, oneByOne);
    }
    
    
    //EARS
    //======================================================================================================================
    //  .                                                                                                                 ==
    //   ███████  █████  ██████  ███████                                                                                  ==
    //   ██      ██   ██ ██   ██ ██                                                                                       ==
    //   █████   ███████ ██████  ███████                                                                                  ==
    //   ██      ██   ██ ██   ██      ██                                                                                  ==
    //   ███████ ██   ██ ██   ██ ███████                                                                                  ==
    //                                                                                                                    ==
    //======================================================================================================================
    public var ears : EarsTransformations = new EarsTransformations();
    public var EarsHuman(default, never) : Transformation = ears.EarsHuman.registerTf(AS_EARS, AE_HUMAN);
    public var EarsLion(default, never) : Transformation = ears.EarsLion.registerTf(AS_EARS, AE_LION);
    public var EarsDisplacer(default, never) : Transformation = ears.EarsDisplacer.registerTf(AS_EARS, AE_DISPLACER_BEAST);
    public var EarsCat(default, never) : Transformation = ears.EarsCat.registerTfMultiple(AS_EARS, AE_CAT, AE_DRAGONNE);
    public var EarsRedPanda(default, never) : Transformation = ears.EarsRedPanda.registerTf(AS_EARS, AE_RED_PANDA);
    public var EarsHorse(default, never) : Transformation = ears.EarsHorse.registerTf(AS_EARS, AE_HORSE);
    public var EarsKirin(default, never) : Transformation = ears.EarsKirin.registerTf(AS_EARS, AE_KIRIN);
    public var EarsPig(default, never) : Transformation = ears.EarsPig.registerTf(AS_EARS, AE_PIG);
    public var EarsVampire(default, never) : Transformation = ears.EarsVampire.registerTf(AS_EARS, AE_VAMPIRE);
    public var EarsBat(default, never) : Transformation = ears.EarsBat.registerTf(AS_EARS, AE_BAT);
    public var EarsWeasel(default, never) : Transformation = ears.EarsWeasel.registerTf(AS_EARS, AE_WEASEL);
    public var EarsOni(default, never) : Transformation = ears.EarsOni.registerTf(AS_EARS, AE_ONI);
    public var EarsElven(default, never) : Transformation = ears.EarsElven.registerTf(AS_EARS, AE_ELF);
    public var EarsGoat(default, never) : Transformation = ears.EarsGoat.registerTf(AS_EARS, AE_GOAT);
    public var EarsCow(default, never) : Transformation = ears.EarsCow.registerTf(AS_EARS, AE_COW);
    public var EarsDraconic(default, never) : Transformation = ears.EarsDraconic.registerTf(AS_EARS, AE_DRAGON);
    public var EarsSnake(default, never) : Transformation = ears.EarsSnake.registerTf(AS_EARS, AE_SNAKE);
    public var EarsOrca(default, never) : Transformation = ears.EarsOrca.registerTf(AS_EARS, AE_ORCA);
    public var EarsOrca2(default, never) : Transformation = ears.EarsOrca2.registerTf(AS_EARS, AE_ORCA);
    public var EarsLizard(default, never) : Transformation = ears.EarsLizard.registerTf(AS_EARS, AE_LIZARD);
    public var EarsInsect(default, never) : Transformation = ears.EarsInsect.registerTf(AS_EARS, AE_BEE);
    public var EarsFox(default, never) : Transformation = ears.EarsFox.registerTf(AS_EARS, AE_FOX);
    public var EarsElfin(default, never) : Transformation = ears.EarsElfin.registerTfMultiple(AS_EARS, AE_IMP, AE_GOBLIN);
    public var EarsWolf(default, never) : Transformation = ears.EarsWolf.registerTf(AS_EARS, AE_WOLF);
    public var EarsDog(default, never) : Transformation = ears.EarsDog.registerTf(AS_EARS, AE_DOG);
    public var EarsGremlin(default, never) : Transformation = ears.EarsGremlin.registerTf(AS_EARS, AE_GREMLIN);
    public var EarsShark(default, never) : Transformation = ears.EarsShark.registerTfMultiple(AS_EARS, AE_SHARK, AE_WERESHARK);
    public var EarsCaveWyrm(default, never) : Transformation = ears.EarsCaveWyrm.registerTf(AS_EARS, AE_CAVE_WYRM);
    public var EarsBunny(default, never) : Transformation = ears.EarsBunny.registerTf(AS_EARS, AE_BUNNY);
    public var EarsAvian(default, never) : Transformation = ears.EarsAvian.registerTf(AS_EARS, AE_AVIAN);
    public var EarsGryphon(default, never) : Transformation = ears.EarsGryphon.registerTf(AS_EARS, AE_GRYPHON);
    public var EarsKangaroo(default, never) : Transformation = ears.EarsKangaroo.registerTf(AS_EARS, AE_KANGAROO);
    public var EarsRaiju(default, never) : Transformation = ears.EarsRaiju.registerTf(AS_EARS, AE_RAIJU);
    public var EarsSquirrel(default, never) : Transformation = ears.EarsSquirrel.registerTf(AS_EARS, AE_SQUIRREL);
    public var EarsRaccoon(default, never) : Transformation = ears.EarsRaccoon.registerTf(AS_EARS, AE_RACCOON);
    public var EarsMouse(default, never) : Transformation = ears.EarsMouse.registerTf(AS_EARS, AE_MOUSE);
    public var EarsFerret(default, never) : Transformation = ears.EarsFerret.registerTf(AS_EARS, AE_FERRET);
    public var EarsYeti(default, never) : Transformation = ears.EarsYeti.registerTf(AS_EARS, AE_YETI);
    public var EarsBear(default, never) : Transformation = ears.EarsBear.registerTf(AS_EARS, AE_BEAR);
    public var EarsPanda(default, never) : Transformation = ears.EarsPanda.registerTf(AS_EARS, AE_PANDA);
    public var EarsMelkie(default, never) : Transformation = ears.EarsMelkie.registerTf(AS_EARS, AE_MELKIE);
    public var EarsDeer(default, never) : Transformation = ears.EarsDeer.registerTfMultiple(AS_EARS, AE_DEER, AE_REINDEER);
    public var EarsBig(default, never) : Transformation = ears.EarsBig.registerTfMultiple(AS_EARS, AE_GOBLIN, AE_IMP);
    public var EarsFennecFox(default, never) : Transformation = ears.EarsFennecFox.registerTf(AS_EARS, AE_WEREFOX);
    public var EarsJackal(default, never) : Transformation = ears.EarsJackal.registerTf(AS_EARS, AE_ANUBIS);
    public var EarsTroll(default, never) : Transformation = ears.EarsTroll.registerTf(AS_EARS, AE_TROLL);
    public var EarsGlacialTroll(default, never) : Transformation = ears.EarsGlacialTroll.registerTf(AS_EARS, AE_GLACIAL_TROLL);
    
    
    //EYES
    //======================================================================================================================
    //  .                                                                                                                 ==
    //   ███████ ██   ██ ███████ ███████                                                                                  ==
    //   ██	      ██ ██	 ██		 ██                                                                                       ==
    //   █████	   ██    ██████	 ███████                                                                                  ==
    //   ██		   ██	 ██		      ██                                                                                  ==
    //   ███████   ██	 ███████ ███████                                                                                  ==
    //                                                                                                                    ==
    //======================================================================================================================
    public var eyes : EyesTransformations = new EyesTransformations();
    public var EyesCat(default, never) : Transformation = eyes.EyesCat.registerTfMultiple(AS_EYES, AE_CAT, AE_DRAGONNE);
    public var EyesDevil(default, never) : Transformation = eyes.EyesDevil.registerTf(AS_EYES, AE_DEVIL);
    public var EyesDisplacer(default, never) : Transformation = eyes.EyesDisplacer.registerTf(AS_EYES, AE_DISPLACER_BEAST);
    public var EyesDraconic(default, never) : Transformation = eyes.EyesDraconic.registerTf(AS_EYES, AE_DRAGON);
    public var EyesElf(default, never) : Transformation = eyes.EyesElf.registerTf(AS_EYES, AE_ELF);
    public var EyesFairy(default, never) : Transformation = eyes.EyesFairy.registerTf(AS_EYES, AE_FAIRY);
    public var EyesGorgon(default, never) : Transformation = eyes.EyesGorgon.registerTf(AS_EYES, AE_GORGON);
    public var EyesOni(default, never) : Transformation = eyes.EyesOni.registerTf(AS_EYES, AE_ONI);
    public var EyesBear(default, never) : Transformation = eyes.EyesBear.registerTf(AS_EYES, AE_BEAR);
    public var EyesCancer(default, never) : Transformation = eyes.EyesCancer.registerTf(AS_EYES, AE_CANCER);
    public var EyesCaveWyrm(default, never) : Transformation = eyes.EyesCaveWyrm.registerTf(AS_EYES, AE_CAVE_WYRM);
    public var EyesCentipede(default, never) : Transformation = eyes.EyesCentipede.registerTf(AS_EYES, AE_CENTIPEDE);
    public var EyesDead(default, never) : Transformation = eyes.EyesDead.registerTf(AS_EYES, AE_WENDIGO);
    public var EyesFenrir(default, never) : Transformation = eyes.EyesFenrir.registerTf(AS_EYES, AE_FENRIR);
    public var EyesFiendish(default, never) : Transformation = eyes.EyesFiendish.registerTf(AS_EYES, AE_DARK_SLIME);
    public var EyesFireSnail(default, never) : Transformation = eyes.EyesFireSnail.registerTf(AS_EYES, AE_FIRE_SNAIL);
    public var EyesFeral(default, never) : Transformation = eyes.EyesFeral.registerTfMultiple(AS_EYES, AE_WEREWOLF, AE_WEREFOX, AE_WERESHARK);
    public var EyesFox(default, never) : Transformation = eyes.EyesFox.registerTf(AS_EYES, AE_FOX);
    public var EyesFrostwyrm(default, never) : Transformation = eyes.EyesFrostwyrm.registerTf(AS_EYES, AE_FROST_WYRM);
    public var EyesGoat(default, never) : Transformation = eyes.EyesGoat.registerTf(AS_EYES, AE_GOAT);
    public var EyesGhost(default, never) : Transformation = eyes.EyesGhost.registerTf(AS_EYES, AE_GHOST);
    public var EyesGryphon(default, never) : Transformation = eyes.EyesGryphon.registerTfMultiple(AS_EYES, AE_GRYPHON, AE_PEAFOWL, AE_AVIAN);
    public var EyesHinezumi(default, never) : Transformation = eyes.EyesHinezumi.registerTf(AS_EYES, AE_HINEZUMI);
    public var EyesHuman(default, never) : Transformation = eyes.EyesHuman.registerTf(AS_EYES, AE_HUMAN);
    public var EyesInfernal(default, never) : Transformation = eyes.EyesInfernal.registerTf(AS_EYES, AE_HELLCAT);
    public var EyesJiangshi(default, never) : Transformation = eyes.EyesJiangshi.registerTf(AS_EYES, AE_JIANGSHI);
    public var EyesKraken(default, never) : Transformation = eyes.EyesKraken.registerTf(AS_EYES, AE_KRAKEN);
    public var EyesLizard(default, never) : Transformation = eyes.EyesLizard.registerTf(AS_EYES, AE_LIZARD);
    public var EyesManticore(default, never) : Transformation = eyes.EyesManticore.registerTf(AS_EYES, AE_MANTICORE);
    public var EyesMonoeye(default, never) : Transformation = eyes.EyesMonoeye.registerTf(AS_EYES, AE_GAZER);
    public var EyesOrc(default, never) : Transformation = eyes.EyesOrc.registerTf(AS_EYES, AE_ORC);
    public var EyesRaiju(default, never) : Transformation = eyes.EyesRaiju.registerTf(AS_EYES, AE_RAIJU);
    public var EyesRatatoskr(default, never) : Transformation = eyes.EyesRatatoskr.registerTf(AS_EYES, AE_SQUIRREL);
    public var EyesSandTrap(default, never) : Transformation = eyes.EyesSandTrap.registerTf(AS_EYES, AE_SAND_TRAP);
    public var EyesSnake(default, never) : Transformation = eyes.EyesSnake.registerTf(AS_EYES, AE_SNAKE);
    public var EyesSnakeFiendish(default, never) : Transformation = eyes.EyesSnakeFiendish.registerTf(AS_EYES, AE_APOPHIS);
    public var EyesSpider(default, never) : Transformation = eyes.EyesSpider.registerTf(AS_EYES, AE_SPIDER);
    public var EyesWeasel(default, never) : Transformation = eyes.EyesWeasel.registerTf(AS_EYES, AE_WEASEL);
    public var EyesVampire(default, never) : Transformation = eyes.EyesVampire.registerTf(AS_EYES, AE_VAMPIRE);
    public var EyesArigean(default, never) : Transformation = eyes.EyesArigean.registerTf(AS_EYES, AE_ARIGEAN);
    public var EyesDemon(default, never) : Transformation = eyes.EyesDemon.registerTf(AS_EYES, AE_DEMON);
    public var EyesMoth(default, never) : Transformation = eyes.EyesMoth.registerTf(AS_EYES, AE_MOTH);
    public var EyesGremlin(default, never) : Transformation = eyes.EyesGremlin.registerTf(AS_EYES, AE_GREMLIN);
    //=================================
    //                                =
    //   EYE COLORS                   =
    //                                =
    //=================================
    public function EyesChangeColor(colors : Array<Dynamic>) : Transformation
    {
        return eyes.EyesChangeColor(colors);
    }
    
    public var EyesAlrauneColors(default, never) : Transformation = eyes.EyesAlrauneColors;
    public var EyesAlicornColors(default, never) : Transformation = eyes.EyesAlicornColors;
    public var EyesAtlachColors(default, never) : Transformation = eyes.EyesAtlachColors;
    public var EyesOniColors(default, never) : Transformation = eyes.EyesOniColors;
    public var EyesPlantColors(default, never) : Transformation = eyes.EyesPlantColors;
    public var EyesGoblinColors(default, never) : Transformation = eyes.EyesGoblinColors;
    public var EyesGremlinColors(default, never) : Transformation = eyes.EyesGremlinColors;
    public var EyesRaijuColors(default, never) : Transformation = eyes.EyesRaijuColors;
    public var EyesKirinColors(default, never) : Transformation = eyes.EyesKirinColors;
    public var EyesKamaitachiColors(default, never) : Transformation = eyes.EyesKamaitachiColors;
    public var EyesRatatoskrColors(default, never) : Transformation = eyes.EyesRatatoskrColors;
    public var EyesRaccoonColors(default, never) : Transformation = eyes.EyesRaccoonColors;
    public var EyesKrakenColors(default, never) : Transformation = eyes.EyesKrakenColors;
    public var EyesSeadragonColors(default, never) : Transformation = eyes.EyesSeadragonColors;
    public var EyesFireSnailColors(default, never) : Transformation = eyes.EyesFireSnailColors;
    public var EyesFenrirColor(default, never) : Transformation = eyes.EyesFenrirColor;
    public var EyesDemonColors(default, never) : Transformation = eyes.EyesDemonColors;
    public var EyesSpiderAndMutagenInt(default, never) : Transformation = eyes.EyesSpiderAndMutagenInt;
    
    
    //FACE
    //======================================================================================================================
    //                                                                                                                    ==
    //   ███████  █████   ██████ ███████                                                                                  ==
    //   ██      ██   ██ ██      ██                                                                                       ==
    //   █████   ███████ ██      █████                                                                                    ==
    //   ██      ██   ██ ██      ██                                                                                       ==
    //   ██      ██   ██  ██████ ███████                                                                                  ==
    //                                                                                                                    ==
    //======================================================================================================================
    public var face : FaceTransformations = new FaceTransformations();
    public var FaceHuman(default, never) : Transformation = face.FaceHuman.registerTf(AS_FACE, AE_HUMAN);
    public var FaceHorse(default, never) : Transformation = face.FaceHorse.registerTf(AS_FACE, AE_HORSE);
    public var FaceCerberus(default, never) : Transformation = face.FaceCerberus.registerTf(AS_FACE, AE_CERBERUS);
    public var FaceDog(default, never) : Transformation = face.FaceDog.registerTf(AS_FACE, AE_DOG);
    public var FaceCowMinotaur(default, never) : Transformation = face.FaceCowMinotaur.registerTf(AS_FACE, AE_COW);
    public var FaceSharkTeeth(default, never) : Transformation = face.FaceSharkTeeth.registerTfMultiple(AS_FACE, AE_SHARK < AE_WERESHARK);
    public var FaceSnakeFangs(default, never) : Transformation = face.FaceSnakeFangs.registerTf(AS_FACE, AE_SNAKE);
    public var FaceCat(default, never) : Transformation = face.FaceCat.registerTfMultiple(AS_FACE, AE_CAT, AE_DRAGONNE);
    public var FaceCatCanines(default, never) : Transformation = face.FaceCatCanines.registerTfMultiple(AS_FACE, AE_CAT, AE_DRAGONNE);
    public var FaceLizard(default, never) : Transformation = face.FaceLizard.registerTf(AS_FACE, AE_LIZARD);
    public var FaceBunny(default, never) : Transformation = face.FaceBunny.registerTf(AS_FACE, AE_BUNNY);
    public var FaceKangaroo(default, never) : Transformation = face.FaceKangaroo.registerTf(AS_FACE, AE_KANGAROO);
    public var FaceSpiderFangs(default, never) : Transformation = face.FaceSpiderFangs.registerTf(AS_FACE, AE_SPIDER);
    public var FaceFox(default, never) : Transformation = face.FaceFox.registerTf(AS_FACE, AE_FOX);
    public var FaceDragon(default, never) : Transformation = face.FaceDragon.registerTf(AS_FACE, AE_DRAGON);
    public var FaceDragonFangs(default, never) : Transformation = face.FaceDragonFangs.registerTf(AS_FACE, AE_DRAGON);
    public var FaceRaccoonMask(default, never) : Transformation = face.FaceRaccoonMask.registerTf(AS_FACE, AE_RACCOON);
    public var FaceRaccoon(default, never) : Transformation = face.FaceRaccoon.registerTf(AS_FACE, AE_RACCOON);
    public var FaceBuckteeth(default, never) : Transformation = face.FaceBuckteeth.registerTf(AS_FACE, AE_MOUSE);
    public var FaceMouse(default, never) : Transformation = face.FaceMouse.registerTf(AS_FACE, AE_MOUSE);
    public var FaceFerretMask(default, never) : Transformation = face.FaceFerretMask.registerTf(AS_FACE, AE_FERRET);
    public var FaceFerret(default, never) : Transformation = face.FaceFerret.registerTf(AS_FACE, AE_FERRET);
    public var FacePig(default, never) : Transformation = face.FacePig.registerTf(AS_FACE, AE_PIG);
    public var FaceBoar(default, never) : Transformation = face.FaceBoar.registerTf(AS_FACE, AE_BOAR);
    public var FaceRhino(default, never) : Transformation = face.FaceRhino.registerTf(AS_FACE, AE_RHINO);
    public var FaceEchidna(default, never) : Transformation = face.FaceEchidna.registerTf(AS_FACE, AE_ECHIDNA);
    public var FaceDeer(default, never) : Transformation = face.FaceDeer.registerTfMultiple(AS_FACE, AE_DEER, AE_REINDEER);
    public var FaceWolf(default, never) : Transformation = face.FaceWolf.registerTf(AS_FACE, AE_WOLF);
    public var FaceManticore(default, never) : Transformation = face.FaceManticore.registerTf(AS_FACE, AE_MANTICORE);
    public var FaceSalamanderFangs(default, never) : Transformation = face.FaceSalamanderFangs.registerTf(AS_FACE, AE_SALAMANDER);
    public var FaceYetiFangs(default, never) : Transformation = face.FaceYetiFangs.registerTf(AS_FACE, AE_YETI);
    public var FaceOrca(default, never) : Transformation = face.FaceOrca.registerTf(AS_FACE, AE_ORCA);
    public var FacePlantDragon(default, never) : Transformation = face.FacePlantDragon.registerTf(AS_FACE, AE_YGGDRASIL);
    public var FaceDevilFangs(default, never) : Transformation = face.FaceDevilFangs.registerTf(AS_FACE, AE_DEVIL);
    public var FaceInnocent(default, never) : Transformation = face.FaceInnocent.registerTf(AS_FACE, AE_AZAZEL);
    public var FaceOniTeeth(default, never) : Transformation = face.FaceOniTeeth.registerTf(AS_FACE, AE_ONI);
    public var FaceWeasel(default, never) : Transformation = face.FaceWeasel.registerTf(AS_FACE, AE_WEASEL);
    public var FaceVampire(default, never) : Transformation = face.FaceVampire.registerTf(AS_FACE, AE_VAMPIRE);
    public var FaceBucktooth(default, never) : Transformation = face.FaceBucktooth.registerTf(AS_FACE, AE_JABBERWOCKY);
    public var FaceJabberwocky(default, never) : Transformation = face.FaceJabberwocky.registerTf(AS_FACE, AE_JABBERWOCKY);
    public var FaceRedPanda(default, never) : Transformation = face.FaceRedPanda.registerTf(AS_FACE, AE_RED_PANDA);
    public var FaceCheshire(default, never) : Transformation = face.FaceCheshire.registerTf(AS_FACE, AE_CHESHIRE);
    public var FaceCheshireSmile(default, never) : Transformation = face.FaceCheshireSmile.registerTf(AS_FACE, AE_CHESHIRE);
    public var FaceAvian(default, never) : Transformation = face.FaceAvian.registerTf(AS_FACE, AE_AVIAN);
    public var FaceWolfFangs(default, never) : Transformation = face.FaceWolfFangs.registerTf(AS_FACE, AE_WOLF);
    public var FaceOrcFangs(default, never) : Transformation = face.FaceOrcFangs.registerTf(AS_FACE, AE_ORC);
    public var FaceAnimalTeeth(default, never) : Transformation = face.FaceAnimalTeeth.registerTfMultiple(AS_FACE, AE_CENTIPEDE, AE_CYCLOP, AE_DEMON, AE_GAZER, AE_FROST_WYRM, AE_GOBLIN, AE_HARPY, AE_IMP, AE_KITSUNE, AE_MELKIE, AE_OOMUKADE, AE_WENDIGO, AE_WOLF).withAlchemyNames("Canines", "Sharp canines");
    public var FaceBear(default, never) : Transformation = face.FaceBear.registerTf(AS_FACE, AE_BEAR);
    public var FacePanda(default, never) : Transformation = face.FacePanda.registerTf(AS_FACE, AE_PANDA);
    public var FaceFireSnail(default, never) : Transformation = face.FaceFireSnail.registerTf(AS_FACE, AE_FIRE_SNAIL);
    public var FaceGhost(default, never) : Transformation = face.FaceGhost.registerTf(AS_FACE, AE_GHOST);
    public var FaceJiangshi(default, never) : Transformation = face.FaceJiangshi.registerTf(AS_FACE, AE_JIANGSHI);
    public var FaceYukiOnna(default, never) : Transformation = face.FaceYukiOnna.registerTf(AS_FACE, AE_YUKI_ONNA);
    public var FaceKudere(default, never) : Transformation = face.FaceKudere.registerTf(AS_FACE, AE_CANCER);
    public var FaceUshiOniOnna(default, never) : Transformation = face.FaceUshiOniOnna.registerTf(AS_FACE, AE_USHI_ONI);
    public var FaceFairy(default, never) : Transformation = face.FaceFairy.registerTf(AS_FACE, AE_FAIRY);
    public var FaceCrazy(default, never) : Transformation = face.FaceCrazy.registerTf(AS_FACE, AE_GREMLIN);
    public var FaceSmug(default, never) : Transformation = face.FaceSmug.registerTf(AS_FACE, AE_SQUIRREL);
    public var FaceSquirrel(default, never) : Transformation = face.FaceSquirrel.registerTf(AS_FACE, AE_SQUIRREL);
    public var FaceElf(default, never) : Transformation = face.FaceElf.registerTf(AS_FACE, AE_ELF);
    public var FaceAnt(default, never) : Transformation = face.FaceAnt.registerTf(AS_FACE, AE_ANT);
    public var FaceFoxFangs(default, never) : Transformation = face.FaceFoxFangs.registerTf(AS_FACE, AE_WEREFOX);
    public var FaceAbyssalShark(default, never) : Transformation = face.FaceAbyssalShark.registerTf(AS_FACE, AE_ABYSSAL_SHARK);
    public var FaceArigean(default, never) : Transformation = face.FaceArigean.registerTf(AS_FACE, AE_ARIGEAN);
    public var FaceDemon(default, never) : Transformation = face.FaceDemon.registerTf(AS_FACE, AE_DEMON);
    public var FaceTroll(default, never) : Transformation = face.FaceTroll.registerTf(AS_FACE, AE_TROLL);
    public var FaceGlacialTroll(default, never) : Transformation = face.FaceGlacialTroll.registerTf(AS_FACE, AE_GLACIAL_TROLL);
    
    
    //GILLS
    //======================================================================================================================
    //                                                                                                                    ==
    //      ██████  ██ ██      ██      ███████                                                                            ==
    //     ██       ██ ██      ██      ██                                                                                 ==
    //     ██   ███ ██ ██      ██      ███████                                                                            ==
    //     ██    ██ ██ ██      ██           ██                                                                            ==
    //      ██████  ██ ███████ ███████ ███████                                                                            ==
    //                                                                                                                    ==
    //======================================================================================================================
    public var gills : GillsTransformations = new GillsTransformations();
    public var GillsNone(default, never) : Transformation = gills.GillsNone.registerTf(AS_GILLS, AE_REMOVE);
    public var GillsFish(default, never) : Transformation = gills.GillsFish.registerTfMultiple(AS_GILLS, AE_SHARK, AE_SIREN, AE_ABYSSAL_SHARK, AE_WERESHARK);
    public var GillsAnemone(default, never) : Transformation = gills.GillsAnemone.registerTf(AS_GILLS, AE_ANEMONE);
    public var GillsInTentacleLegs(default, never) : Transformation = gills.GillsInTentacleLegs.registerTf(AS_GILLS, AE_SCYLLA);
    
    
    //HAIR
    //======================================================================================================================
    //                                                                                                                    ==
    //    ██   ██  █████  ██████ ██████                                                                                   ==
    //    ██   ██ ██   ██   ██   ██   ██                                                                                  ==
    //    ███████ ███████   ██   ██████                                                                                   ==
    //    ██   ██ ██   ██   ██   ██   ██                                                                                  ==
    //    ██   ██ ██   ██ ██████ ██   ██                                                                                  ==
    //                                                                                                                    ==
    //======================================================================================================================
    public var hair : HairTransformations = new HairTransformations();
    public var HairHuman(default, never) : Transformation = hair.HairHuman.registerTf(AS_HAIR, AE_HUMAN);
    public var HairFeather(default, never) : Transformation = hair.HairFeather.registerTfMultiple(AS_HAIR, AE_AVIAN, AE_GRYPHON);
    public var HairGorgon(default, never) : Transformation = hair.HairGorgon.registerTf(AS_HAIR, AE_GORGON);
    public var HairSilky(default, never) : Transformation = hair.HairSilky.registerTf(AS_HAIR, AE_ELF);
    public var HairStorm(default, never) : Transformation = hair.HairStorm.registerTfMultiple(AS_HAIR, AE_RAIJU, AE_KIRIN, AE_THUNDERBIRD).withAlchemyNames("StormHair", "Storm hair");
    public var HairBurning(default, never) : Transformation = hair.HairBurning.registerTfMultiple(AS_HAIR, AE_FIRE_SNAIL, AE_HELLCAT, AE_HINEZUMI).withAlchemyNames("BurningHair", "Burning hair");
    public var HairSnowy(default, never) : Transformation = hair.HairSnowy.registerTf(AS_HAIR, AE_YUKI_ONNA);
    public var HairLeaf(default, never) : Transformation = hair.HairLeaf.registerTfMultiple(AS_HAIR, AE_PLANT, AE_ALRAUNE, AE_YGGDRASIL);
    public var HairGrass(default, never) : Transformation = hair.HairGrass.registerTfMultiple(AS_HAIR, AE_PLANT, AE_ALRAUNE, AE_YGGDRASIL);
    public var HairGoo(default, never) : Transformation = hair.HairGoo.registerTf(AS_HAIR, AE_GOO);
    public var HairGhost(default, never) : Transformation = hair.HairGhost.registerTf(AS_HAIR, AE_GHOST);
    public var HairRatatoskr(default, never) : Transformation = hair.HairRatatoskr.registerTf(AS_HAIR, AE_SQUIRREL);
    public var HairWindswept(default, never) : Transformation = hair.HairWindswept.registerTf(AS_HAIR, AE_KAMAITACHI);
    public var HairWild(default, never) : Transformation = hair.HairWild;
    public var HairAnemone(default, never) : Transformation = hair.HairAnemone.registerTf(AS_HAIR, AE_ANEMONE);
    public var HairFluffy(default, never) : Transformation = hair.HairFluffy.registerTf(AS_HAIR, AE_YETI);
    public var HairCrazy(default, never) : Transformation = hair.HairCrazy.registerTf(AS_HAIR, AE_GREMLIN);
    public var HairPrismatic(default, never) : Transformation = hair.HairPrismatic.registerTf(AS_HAIR, AE_SEA_DRAGON);
    public var HairQuill(default, never) : Transformation = hair.HairQuill.registerTf(AS_HAIR, AE_ECHIDNA);
    public var HairFairy(default, never) : Transformation = hair.HairFairy.registerTf(AS_HAIR, AE_FAIRY);
    public var HairCow(default, never) : Transformation = hair.HairCow.registerTf(AS_HAIR, AE_COW);
    public var HairDripping(default, never) : Transformation = hair.HairDripping.registerTf(AS_HAIR, AE_SAND_WORM);
    public var HairPeafowlFeather(default, never) : Transformation = hair.HairPeafowlFeather.registerTf(AS_HAIR, AE_PEAFOWL);
    public function HairChangeColor(colors : Array<Dynamic>) : Transformation
    {
        return hair.HairChangeColor(colors);
    }
    
    
    //HORNS
    //======================================================================================================================
    //                                                                                                                    ==
    //    ██    ██  ██████  ██████  ███    ██ ███████                                                                     ==
    //    ██    ██ ██    ██ ██   ██ ████   ██ ██                                                                          ==
    //    ████████ ██    ██ ██████  ██ ██  ██ ███████                                                                     ==
    //    ██    ██ ██    ██ ██   ██ ██  ██ ██      ██                                                                     ==
    //    ██    ██  ██████  ██   ██ ██   ████ ███████                                                                     ==
    //                                                                                                                    ==
    //======================================================================================================================
    public var horns : HornsTransformations = new HornsTransformations();
    public var HornsNone(default, never) : Transformation = horns.HornsNone.registerTfMultiple(AS_HORNS, AE_REMOVE, AE_KITSUNE);
    public var HornsBicorn(default, never) : Transformation = horns.HornsBicorn.registerTf(AS_HORNS, AE_BICORN);
    public var HornsUnicorn(default, never) : Transformation = horns.HornsUnicorn.registerTf(AS_HORNS, AE_UNICORN);
    public var HornsKirin(default, never) : Transformation = horns.HornsKirin.registerTf(AS_HORNS, AE_KIRIN);
    public var HornsOniDual(default, never) : Transformation = horns.HornsOniDual.registerTf(AS_HORNS, AE_ONI);
    public var HornsOni(default, never) : Transformation = horns.HornsOni.registerTf(AS_HORNS, AE_ONI);
    public var HornsGoat(default, never) : Transformation = horns.HornsGoat.registerTf(AS_HORNS, AE_GOAT);
    public var HornsGoatQuadruple(default, never) : Transformation = horns.HornsGoatQuadruple.registerTf(AS_HORNS, AE_GOAT);
    public var HornsDraconicQuadruple(default, never) : Transformation = horns.HornsDraconicQuadruple.registerTf(AS_HORNS, AE_DRAGON);
    public var HornsDraconicDual(default, never) : Transformation = horns.HornsDraconicDual.registerTf(AS_HORNS, AE_DRAGON);
    public var HornsCowMinotaur(default, never) : Transformation = horns.HornsCowMinotaur.registerTf(AS_HORNS, AE_COW);
    public var HornsDemonic(default, never) : Transformation = horns.HornsDemonic.registerTf(AS_HORNS, AE_DEMON);
    public var HornsAntlers(default, never) : Transformation = horns.HornsAntlers.registerTfMultiple(AS_HORNS, AE_DEER, AE_REINDEER, AE_WENDIGO);
    public var HornsAntlersWendigo(default, never) : Transformation = horns.HornsAntlersWendigo.registerTf(AS_HORNS, AE_WENDIGO);
    public var HornsGhostlyWisps(default, never) : Transformation = horns.HornsGhostlyWisps.registerTf(AS_HORNS, AE_GHOST);
    public var HornsOak(default, never) : Transformation = horns.HornsOak.registerTfMultiple(AS_HORNS, AE_PLANT, AE_YGGDRASIL);
    public var HornsOrchid(default, never) : Transformation = horns.HornsOrchid.registerTf(AS_HORNS, AE_PLANT);
    public var HornsKraken(default, never) : Transformation = horns.HornsKraken.registerTf(AS_HORNS, AE_KRAKEN);
    public var HornsSeadragon(default, never) : Transformation = horns.HornsSeadragon.registerTf(AS_HORNS, AE_SEA_DRAGON);
    public var HornsFrostwyrm(default, never) : Transformation = horns.HornsFrostwyrm.registerTf(AS_HORNS, AE_FROST_WYRM);
    public var HornsJabberwocky(default, never) : Transformation = horns.HornsJabberwocky.registerTf(AS_HORNS, AE_JABBERWOCKY);
    public var HornsUshiOni(default, never) : Transformation = horns.HornsUshiOni.registerTf(AS_HORNS, AE_USHI_ONI);
    public var HornsJiangshi(default, never) : Transformation = horns.HornsJiangshi.registerTf(AS_HORNS, AE_JIANGSHI);
    public var HornsArchImp(default, never) : Transformation = horns.HornsArchImp.registerTf(AS_HORNS, AE_IMP);
    
    
    //LOWER BODY ( LEGS )
    //======================================================================================================================
    //                                                                                                                    ==
    //  ██       ██████  ██       ██ ███████ ██████      ██████   ██████  ██████  ██    ██                                ==
    //  ██      ██    ██ ██       ██ ██      ██   ██     ██   ██ ██    ██ ██   ██  ██  ██                                 ==
    //  ██      ██    ██ ██  ███  ██ █████   ██████      ██████  ██    ██ ██   ██    ██                                   ==
    //  ██      ██    ██ ██ ██ ██ ██ ██      ██   ██     ██   ██ ██    ██ ██   ██    ██                                   ==
    //  ███████  ██████  ████   ████ ███████ ██   ██     ██████   ██████  ██████     ██                                   ==
    //                                                                                                                    ==
    //======================================================================================================================
    
    public var lowerBody : LowerBodyTransformations = new LowerBodyTransformations();
    public function LowerBodyTaur(lowerBodyType : Int = null) : Transformation
    {
        return lowerBody.LowerBodyTaur(lowerBodyType);
    }
    public function LowerBodyWolf(legCount : Int = null) : Transformation
    {
        return lowerBody.LowerBodyWolf(legCount);
    }
    public var LowerBodyWolfBipedal(default, never) : Transformation = cast((2), LowerBodyWolf).registerTf(AS_LEGS, AE_WOLF);
    public function LowerBodyWolfToggle(toggleTaur : Bool = false) : Transformation
    {
        return lowerBody.LowerBodyWolf(player.legCount, toggleTaur);
    }
    public function LowerBodyHoofed(legCount : Int = null) : Transformation
    {
        return lowerBody.LowerBodyHoofed(legCount);
    }
    public var LowerBodyHoofedBipedal(default, never) : Transformation = cast((2), LowerBodyHoofed).registerTf(AS_LEGS, AE_HORSE);
    public function LowerBodyHoofedToggle(toggleTaur : Bool = false) : Transformation
    {
        return lowerBody.LowerBodyHoofed(player.legCount, toggleTaur);
    }
    public function LowerBodyKirin(legCount : Int = null) : Transformation
    {
        return lowerBody.LowerBodyKirin(legCount);
    }
    public var LowerBodyKirinBipedal(default, never) : Transformation = cast((2), LowerBodyKirin).registerTf(AS_LEGS, AE_KIRIN);
    public function LowerBodyKirinToggle(toggleTaur : Bool = false) : Transformation
    {
        return lowerBody.LowerBodyKirin(player.legCount, toggleTaur);
    }
    public function LowerBodyCat(legCount : Int = null) : Transformation
    {
        return lowerBody.LowerBodyCat(legCount);
    }
    public var LowerBodyCatBipedal(default, never) : Transformation = cast((2), LowerBodyCat).registerTfMultiple(AS_LEGS, AE_CAT, AE_DRAGONNE);
    public function LowerBodyCatToggle(toggleTaur : Bool = false) : Transformation
    {
        return lowerBody.LowerBodyCat(player.legCount, toggleTaur);
    }
    public function LowerBodyLizard(legCount : Int = null) : Transformation
    {
        return lowerBody.LowerBodyLizard(legCount);
    }
    public var LowerBodyLizardBipedal(default, never) : Transformation = cast((2), LowerBodyLizard).registerTf(AS_LEGS, AE_LIZARD);
    public function LowerBodyLizardToggle(toggleTaur : Bool = false) : Transformation
    {
        return lowerBody.LowerBodyLizard(player.legCount, toggleTaur);
    }
    public function LowerBodyFox(legCount : Int = null) : Transformation
    {
        return lowerBody.LowerBodyFox(legCount);
    }
    public var LowerBodyFoxBipedal(default, never) : Transformation = cast((2), LowerBodyFox).registerTf(AS_LEGS, AE_FOX);
    public function LowerBodyFoxToggle(toggleTaur : Bool = false) : Transformation
    {
        return lowerBody.LowerBodyFox(player.legCount, toggleTaur);
    }
    public function LowerBodyDraconic(legCount : Int = null) : Transformation
    {
        return lowerBody.LowerBodyDraconic(legCount);
    }
    public var LowerBodyDraconicBipedal(default, never) : Transformation = cast((2), LowerBodyDraconic).registerTf(AS_LEGS, AE_DRAGON);
    public function LowerBodyDraconicToggle(toggleTaur : Bool = false) : Transformation
    {
        return lowerBody.LowerBodyDraconic(player.legCount, toggleTaur);
    }
    public function LowerBodyFeyDraconic(legCount : Int = null) : Transformation
    {
        return lowerBody.LowerBodyFeyDraconic(legCount);
    }
    public var LowerBodyFeyDraconicBipedal(default, never) : Transformation = cast((2), LowerBodyFeyDraconic).registerTf(AS_LEGS, AE_FAERIE_DRAGON);
    public function LowerBodyFeyDraconicToggle(toggleTaur : Bool = false) : Transformation
    {
        return lowerBody.LowerBodyFeyDraconic(player.legCount, toggleTaur);
    }
    public function LowerBodyClovenHoofed(legCount : Int = null) : Transformation
    {
        return lowerBody.LowerBodyClovenHoofed(legCount);
    }
    public var LowerBodyClovenHoofedBipedal(default, never) : Transformation = cast((2), LowerBodyClovenHoofed).registerTf(AS_LEGS, AE_DEER);
    public function LowerBodyClovenHoofedToggle(toggleTaur : Bool = false) : Transformation
    {
        return lowerBody.LowerBodyClovenHoofed(player.legCount, toggleTaur);
    }
    public function LowerBodyReindeer(legCount : Int = null) : Transformation
    {
        return lowerBody.LowerBodyReindeer(legCount);
    }
    public var LowerBodyReindeerBipedal(default, never) : Transformation = cast((2), LowerBodyReindeer).registerTf(AS_LEGS, AE_REINDEER);
    public function LowerBodyReindeerToggle(toggleTaur : Bool = false) : Transformation
    {
        return lowerBody.LowerBodyReindeer(player.legCount, toggleTaur);
    }
    public function LowerBodySalamander(legCount : Int = null) : Transformation
    {
        return lowerBody.LowerBodySalamander(legCount);
    }
    public var LowerBodySalamanderBipedal(default, never) : Transformation = cast((2), LowerBodySalamander).registerTf(AS_LEGS, AE_SALAMANDER);
    public function LowerBodySalamanderToggle(toggleTaur : Bool = false) : Transformation
    {
        return lowerBody.LowerBodySalamander(player.legCount, toggleTaur);
    }
    public function LowerBodyMantis(legCount : Int = null) : Transformation
    {
        return lowerBody.LowerBodyMantis(legCount);
    }
    public var LowerBodyMantisBipedal(default, never) : Transformation = cast((2), LowerBodyMantis).registerTf(AS_LEGS, AE_MANTIS);
    public function LowerBodyMantisToggle(toggleTaur : Bool = false) : Transformation
    {
        return lowerBody.LowerBodyMantis(player.legCount, toggleTaur);
    }
    public function LowerBodyShark(legCount : Int = null) : Transformation
    {
        return lowerBody.LowerBodyShark(legCount);
    }
    public var LowerBodySharkBipedal(default, never) : Transformation = cast((2), LowerBodyShark).registerTf(AS_LEGS, AE_SHARK);
    public function LowerBodySharkToggle(toggleTaur : Bool = false) : Transformation
    {
        return lowerBody.LowerBodyShark(player.legCount, toggleTaur);
    }
    public function LowerBodyLion(legCount : Int = null) : Transformation
    {
        return lowerBody.LowerBodyLion(legCount);
    }
    public var LowerBodyLionBipedal(default, never) : Transformation = cast((2), LowerBodyLion).registerTf(AS_LEGS, AE_LION);
    public function LowerBodyLionToggle(toggleTaur : Bool = false) : Transformation
    {
        return lowerBody.LowerBodyLion(player.legCount, toggleTaur);
    }
    public function LowerBodyOrca(legCount : Int = null) : Transformation
    {
        return lowerBody.LowerBodyOrca(legCount);
    }
    public var LowerBodyOrcaBipedal(default, never) : Transformation = cast((2), LowerBodyOrca).registerTf(AS_LEGS, AE_ORCA);
    public function LowerBodyOrcaToggle(toggleTaur : Bool = false) : Transformation
    {
        return lowerBody.LowerBodyOrca(player.legCount, toggleTaur);
    }
    public function LowerBodyRaiju(legCount : Int = null) : Transformation
    {
        return lowerBody.LowerBodyRaiju(legCount);
    }
    public var LowerBodyRaijuBipedal(default, never) : Transformation = cast((2), LowerBodyRaiju).registerTf(AS_LEGS, AE_RAIJU);
    public function LowerBodyRaijuToggle(toggleTaur : Bool = false) : Transformation
    {
        return lowerBody.LowerBodyRaiju(player.legCount, toggleTaur);
    }
    public function LowerBodyDog(legCount : Int = null) : Transformation
    {
        return lowerBody.LowerBodyDog(legCount);
    }
    public var LowerBodyDogBipedal(default, never) : Transformation = cast((2), LowerBodyDog).registerTf(AS_LEGS, AE_DOG);
    public function LowerBodyDogToggle(toggleTaur : Bool = false) : Transformation
    {
        return lowerBody.LowerBodyDog(player.legCount, toggleTaur);
    }
    public function LowerBodyWeasel(legCount : Int = null) : Transformation
    {
        return lowerBody.LowerBodyWeasel(legCount);
    }
    public var LowerBodyWeaselBipedal(default, never) : Transformation = cast((2), LowerBodyWeasel).registerTf(AS_LEGS, AE_WEASEL);
    public function LowerBodyWeaselToggle(toggleTaur : Bool = false) : Transformation
    {
        return lowerBody.LowerBodyWeasel(player.legCount, toggleTaur);
    }
    public function LowerBodyBear(legCount : Int = null) : Transformation
    {
        return lowerBody.LowerBodyBear(legCount);
    }
    public var LowerBodyBearBipedal(default, never) : Transformation = cast((2), LowerBodyBear).registerTf(AS_LEGS, AE_BEAR);
    public function LowerBodyBearToggle(toggleTaur : Bool = false) : Transformation
    {
        return lowerBody.LowerBodyBear(player.legCount, toggleTaur);
    }
    public function LowerBodySeaDragon(legCount : Int = null) : Transformation
    {
        return lowerBody.LowerBodySeaDragon(legCount);
    }
    public var LowerBodySeaDragonBipedal(default, never) : Transformation = cast((2), LowerBodySeaDragon).registerTf(AS_LEGS, AE_SEA_DRAGON);
    public function LowerBodySeaDragonToggle(toggleTaur : Bool = false) : Transformation
    {
        return lowerBody.LowerBodySeaDragon(player.legCount, toggleTaur);
    }
    public function LowerBodyGryphon(legCount : Int = null) : Transformation
    {
        return lowerBody.LowerBodyGryphon(legCount);
    }
    public var LowerBodyGryphonBipedal(default, never) : Transformation = cast((2), LowerBodyGryphon).registerTf(AS_LEGS, AE_GRYPHON);
    public function LowerBodyGryphonToggle(toggleTaur : Bool = false) : Transformation
    {
        return lowerBody.LowerBodyGryphon(player.legCount, toggleTaur);
    }
    public var LowerBodyAnt(default, never) : Transformation = lowerBody.LowerBodyAnt.registerTf(AS_LEGS, AE_ANT);
    public var LowerBodyAtlach(default, never) : Transformation = lowerBody.LowerBodyAtlach.registerTf(AS_LEGS, AE_ATLACH_NACHA);
    public var LowerBodyAtlachNacha(default, never) : Transformation = lowerBody.LowerBodyAtlachNacha.registerTf(AS_LEGS, AE_ATLACH_NACHA);
    public var LowerBodyBee(default, never) : Transformation = lowerBody.LowerBodyBee.registerTf(AS_LEGS, AE_BEE);
    public var LowerBodyBipedal(default, never) : Transformation = lowerBody.LowerBodyBipedal;
    public var LowerBodyCentipede(default, never) : Transformation = lowerBody.LowerBodyCentipede.registerTf(AS_LEGS, AE_CENTIPEDE);
    public var LowerBodyDemonClawed(default, never) : Transformation = lowerBody.LowerBodyDemonClawed.registerTf(AS_LEGS, AE_DEMON);
    public var LowerBodyDemonHighHeels(default, never) : Transformation = lowerBody.LowerBodyDemonHighHeels.registerTf(AS_LEGS, AE_DEMON);
    public var LowerBodyDrider(default, never) : Transformation = lowerBody.LowerBodyDrider.registerTf(AS_LEGS, AE_DRIDER);
    public var LowerBodyElf(default, never) : Transformation = lowerBody.LowerBodyElf.registerTf(AS_LEGS, AE_ELF);
    public var LowerBodyFerret(default, never) : Transformation = lowerBody.LowerBodyFerret.registerTf(AS_LEGS, AE_FERRET);
    public var LowerBodyGoo(default, never) : Transformation = lowerBody.LowerBodyGoo.registerTf(AS_LEGS, AE_GOO);
    public var LowerBodyHarpy(default, never) : Transformation = lowerBody.LowerBodyHarpy.registerTf(AS_LEGS, AE_HARPY);
    public var LowerBodyHuman(default, never) : Transformation = lowerBody.LowerBodyHuman.registerTf(AS_LEGS, AE_HUMAN);
    public var LowerBodyJiangshi(default, never) : Transformation = lowerBody.LowerBodyJiangshi.registerTf(AS_LEGS, AE_JIANGSHI);
    public var LowerBodyOni(default, never) : Transformation = lowerBody.LowerBodyOni.registerTf(AS_LEGS, AE_ONI);
    public var LowerBodyOrc(default, never) : Transformation = lowerBody.LowerBodyOrc.registerTf(AS_LEGS, AE_ORC);
    public var LowerBodyPlantFlower(default, never) : Transformation = lowerBody.LowerBodyPlantFlower.registerTf(AS_LEGS, AE_PLANT);
    public var LowerBodyPlantHighHeels(default, never) : Transformation = lowerBody.LowerBodyPlantHighHeels.registerTf(AS_LEGS, AE_PLANT);
    public var LowerBodyPlantRootClaws(default, never) : Transformation = lowerBody.LowerBodyPlantRootClaws.registerTf(AS_LEGS, AE_PLANT);
    public var LowerBodyRedPanda(default, never) : Transformation = lowerBody.LowerBodyRedPanda.registerTf(AS_LEGS, AE_RED_PANDA);
    public var LowerBodySpider(default, never) : Transformation = lowerBody.LowerBodySpider.registerTf(AS_LEGS, AE_SPIDER);
    public var LowerBodyWendigo(default, never) : Transformation = lowerBody.LowerBodyWendigo.registerTf(AS_LEGS, AE_WENDIGO);
    public var LowerBodyYukiOnna(default, never) : Transformation = lowerBody.LowerBodyYukiOnna.registerTf(AS_LEGS, AE_YUKI_ONNA);
    public var LowerBodyScylla(default, never) : Transformation = lowerBody.LowerBodyScylla.registerTf(AS_LEGS, AE_SCYLLA);
    public var LowerBodyKraken(default, never) : Transformation = lowerBody.LowerBodyKraken.registerTf(AS_LEGS, AE_KRAKEN);
    public var LowerBodyHydra(default, never) : Transformation = lowerBody.LowerBodyHydra.registerTf(AS_LEGS, AE_HYDRA);
    public var LowerBodyAvian(default, never) : Transformation = lowerBody.LowerBodyAvian.registerTf(AS_LEGS, AE_AVIAN);
    public var LowerBodyMelkie(default, never) : Transformation = lowerBody.LowerBodyMelkie.registerTf(AS_LEGS, AE_MELKIE);
    public var LowerBodyUshiOni(default, never) : Transformation = lowerBody.LowerBodyUshiOni.registerTf(AS_LEGS, AE_USHI_ONI);
    public var LowerBodyMouse(default, never) : Transformation = lowerBody.LowerBodyMouse.registerTf(AS_LEGS, AE_MOUSE);
    public var LowerBodyHinezumi(default, never) : Transformation = lowerBody.LowerBodyHinezumi.registerTf(AS_LEGS, AE_HINEZUMI);
    public var LowerBodyYeti(default, never) : Transformation = lowerBody.LowerBodyYeti.registerTf(AS_LEGS, AE_YETI);
    public var LowerBodyGhost(default, never) : Transformation = lowerBody.LowerBodyGhost.registerTf(AS_LEGS, AE_GHOST);
    public var LowerBodyGhost2(default, never) : Transformation = lowerBody.LowerBodyGhost2.registerTf(AS_LEGS, AE_GHOST);
    public var LowerBodyGazer(default, never) : Transformation = lowerBody.LowerBodyGazer.registerTf(AS_LEGS, AE_GAZER);
    public var LowerBodyFireSnail(default, never) : Transformation = lowerBody.LowerBodyFireSnail.registerTf(AS_LEGS, AE_FIRE_SNAIL);
    public var LowerBodyFrostwyrm(default, never) : Transformation = lowerBody.LowerBodyFrostwyrm.registerTf(AS_LEGS, AE_FROST_WYRM);
    public var LowerBodyRaccoon(default, never) : Transformation = lowerBody.LowerBodyRaccoon.registerTf(AS_LEGS, AE_RACCOON);
    public var LowerBodySquirrel(default, never) : Transformation = lowerBody.LowerBodySquirrel.registerTf(AS_LEGS, AE_SQUIRREL);
    public var LowerBodyKangaroo(default, never) : Transformation = lowerBody.LowerBodyKangaroo.registerTf(AS_LEGS, AE_KANGAROO);
    public var LowerBodyCaveWyrm(default, never) : Transformation = lowerBody.LowerBodyCaveWyrm.registerTf(AS_LEGS, AE_CAVE_WYRM);
    public var LowerBodyBunny(default, never) : Transformation = lowerBody.LowerBodyBunny.registerTf(AS_LEGS, AE_BUNNY);
    public var LowerBodyJabberwocky(default, never) : Transformation = lowerBody.LowerBodyJabberwocky.registerTf(AS_LEGS, AE_JABBERWOCKY);
    public var LowerBodyCrab(default, never) : Transformation = lowerBody.LowerBodyCrab.registerTf(AS_LEGS, AE_CANCER);
    public var LowerBodyCancer(default, never) : Transformation = lowerBody.LowerBodyCancer.registerTf(AS_LEGS, AE_CANCER);
    public var LowerBodySnake(default, never) : Transformation = lowerBody.LowerBodySnake.registerTf(AS_LEGS, AE_SNAKE);
    public var LowerBodyTiny(default, never) : Transformation = lowerBody.LowerBodyTiny.registerTf(AS_LEGS, AE_IMP);
    public var LowerBodyWorm(default, never) : Transformation = lowerBody.LowerBodyWorm.registerTf(AS_LEGS, AE_SAND_WORM);
    public var LowerBodyAbyssalShark(default, never) : Transformation = lowerBody.LowerBodyAbyssalShark.registerTf(AS_LEGS, AE_ABYSSAL_SHARK);
    public var LowerBodyWereshark(default, never) : Transformation = lowerBody.LowerBodyWereshark.registerTf(AS_LEGS, AE_WERESHARK);
    public var LowerBodyYgddrasilRootClaws(default, never) : Transformation = lowerBody.LowerBodyYgddrasilRootClaws.registerTf(AS_LEGS, AE_YGGDRASIL);
    public var LowerBodyArigean(default, never) : Transformation = lowerBody.LowerBodyArigean.registerTf(AS_LEGS, AE_ARIGEAN);
    public var LowerBodyDemonGracefulFeet(default, never) : Transformation = lowerBody.LowerBodyDemonGracefulFeet.registerTf(AS_LEGS, AE_DEMON);
    public var LowerBodyMoth(default, never) : Transformation = lowerBody.LowerBodyMoth.registerTf(AS_LEGS, AE_MOTH);
    public var LowerBodyTroll(default, never) : Transformation = lowerBody.LowerBodyTroll.registerTf(AS_LEGS, AE_TROLL);
    public var LowerBodyGlacialTroll(default, never) : Transformation = lowerBody.LowerBodyGlacialTroll.registerTf(AS_LEGS, AE_GLACIAL_TROLL);
    
    
    //OTHER ( SPECIAL )
    //======================================================================================================================
    //                                                                                                                    ==
    // 	   █████  ████████ ██    ██ ██████ ██████                                                                         ==
    // 	 ██    ██    ██    ██    ██ ██     ██   ██                                                                        ==
    // 	 ██    ██    ██    ████████ █████  ██████                                                                         ==
    // 	 ██    ██    ██    ██    ██ ██     ██   ██                                                                        ==
    // 	  ██████     ██    ██    ██ ██████ ██   ██                                                                        ==
    //                                                                                                                    ==
    //======================================================================================================================
    public var special : SpecialTransformations = new SpecialTransformations();
    public var RemoveOvipositor(default, never) : Transformation = special.RemoveOvipositor;
    public var GainOvipositor(default, never) : Transformation = special.GainOvipositor;
    public var OvipositorBee(default, never) : Transformation = special.OvipositorBee;
    public var OvipositorSpider(default, never) : Transformation = special.OvipositorSpider;
    public var OvipositorMantis(default, never) : Transformation = special.OvipositorMantis;
    public var OvipositorAnt(default, never) : Transformation = special.OvipositorAnt;
    public var RemoveOviposition(default, never) : Transformation = special.RemoveOviposition;
    public var GainOviposition(default, never) : Transformation = special.GainOviposition;
    public var AssholeGlowing(default, never) : Transformation = special.AssholeGlowing;
    public var AssholeNormal(default, never) : Transformation = special.AssholeNormal;
    
    
    //REAR BODY
    //======================================================================================================================
    //                                                                                                                    ==
    //   ██████  ███████  █████  ██████      ██████   ██████  ██████  ██    ██                                            ==
    //   ██   ██ ██      ██   ██ ██   ██     ██   ██ ██    ██ ██   ██  ██  ██                                             ==
    //   ██████  █████   ███████ ██████      ██████  ██    ██ ██   ██    ██                                               ==
    //   ██   ██ ██      ██   ██ ██   ██     ██   ██ ██    ██ ██   ██    ██                                               ==
    //   ██   ██ ███████ ██   ██ ██   ██     ██████   ██████  ██████     ██                                               ==
    //                                                                                                                    ==
    //======================================================================================================================
    public var rearBody : RearBodyTransformations = new RearBodyTransformations();
    public var RearBodyNone(default, never) : Transformation = rearBody.RearBodyNone.registerTf(AS_REAR, AE_NONE);
    public var RearBodyLionMane(default, never) : Transformation = rearBody.RearBodyLionMane.registerTfMultiple(AS_REAR, AE_LION, AE_DRAGONNE);
    public var RearBodyDisplacerTentacles(default, never) : Transformation = rearBody.RearBodyDisplacerTentacles.registerTf(AS_REAR, AE_DISPLACER_BEAST);
    public var RearBodyBatCollar(default, never) : Transformation = rearBody.RearBodyBatCollar.registerTf(AS_REAR, AE_BAT);
    public var RearBodyRaijuMane(default, never) : Transformation = rearBody.RearBodyRaijuMane.registerTf(AS_REAR, AE_RAIJU);
    public var RearBodyOrcaBlowhole(default, never) : Transformation = rearBody.RearBodyOrcaBlowhole.registerTf(AS_REAR, AE_ORCA);
    public var RearBodySharkFin(default, never) : Transformation = rearBody.RearBodySharkFin.registerTfMultiple(AS_REAR, AE_SHARK, AE_WERESHARK);
    public var RearBodyMetamorphicGoo(default, never) : Transformation = rearBody.RearBodyMetamorphicGoo.registerTf(AS_REAR, AE_GOO);
    public var RearBodyGhostlyAura(default, never) : Transformation = rearBody.RearBodyGhostlyAura.registerTf(AS_REAR, AE_GHOST);
    public var RearBodyTentacleEyestalks(default, never) : Transformation = rearBody.RearBodyTentacleEyestalks.registerTf(AS_REAR, AE_GAZER);
    public var RearBodyKraken(default, never) : Transformation = rearBody.RearBodyKraken.registerTf(AS_REAR, AE_KRAKEN);
    public var RearBodyYetiFur(default, never) : Transformation = rearBody.RearBodyYetiFur.registerTf(AS_REAR, AE_YETI);
    public var RearBodyGlacialAura(default, never) : Transformation = rearBody.RearBodyGlacialAura.registerTf(AS_REAR, AE_YUKI_ONNA);
    public var RearBodyFrostwyrm(default, never) : Transformation = rearBody.RearBodyFrostwyrm.registerTf(AS_REAR, AE_FROST_WYRM);
    public var RearBodySnailShell(default, never) : Transformation = rearBody.RearBodySnailShell.registerTf(AS_REAR, AE_FIRE_SNAIL);
    public var RearBodyCentipede(default, never) : Transformation = rearBody.RearBodyCentipede.registerTf(AS_REAR, AE_CENTIPEDE);
    public var RearBodyFenrirIceSpikes(default, never) : Transformation = rearBody.RearBodyFenrirIceSpikes.registerTf(AS_REAR, AE_FENRIR);
    public var RearBodyFurCoat(default, never) : Transformation = rearBody.RearBodyFurCoat.registerTf(AS_REAR, AE_WENDIGO);
    public var RearBodyAtlachNacha(default, never) : Transformation = rearBody.RearBodyAtlachNacha.registerTf(AS_REAR, AE_ATLACH_NACHA);
    public var RearBodyCobraHood(default, never) : Transformation = rearBody.RearBodyCobraHood.registerTf(AS_REAR, AE_APOPHIS);
    public var RearBodyWolfCollar(default, never) : Transformation = rearBody.RearBodyWolfCollar.registerTfMultiple(AS_REAR, AE_WOLF, AE_WEREWOLF, AE_WEREFOX);
    public var RearBodyHellhoundCollar(default, never) : Transformation = rearBody.RearBodyHellhoundCollar.registerTf(AS_REAR, AE_CERBERUS);
    public var RearBodyAbyssalSharkFin(default, never) : Transformation = rearBody.RearBodyAbyssalSharkFin.registerTf(AS_REAR, AE_ABYSSAL_SHARK);
    public var RearBodyArigeanAuraRed(default, never) : Transformation = rearBody.RearBodyArigeanAuraRed.registerTf(AS_REAR, AE_ARIGEAN);
    public var RearBodyArigeanAuraYellow(default, never) : Transformation = rearBody.RearBodyArigeanAuraYellow.registerTf(AS_REAR, AE_ARIGEAN);
    public var RearBodyMoth(default, never) : Transformation = rearBody.RearBodyMoth.registerTf(AS_REAR, AE_MOTH);
    
    
    //SKIN
    //======================================================================================================================
    //                                                                                                                    ==
    //   ███████ ██   ██ ██ ███    ██                                                                                     ==
    //   ██      ██  ██  ██ ████   ██                                                                                     ==
    //   ███████ █████   ██ ██ ██  ██                                                                                     ==
    //        ██ ██  ██  ██ ██  ██ ██                                                                                     ==
    //   ███████ ██   ██ ██ ██   ████                                                                                     ==
    //                                                                                                                    ==
    //======================================================================================================================
    public var skin : SkinTransformations = new SkinTransformations();
    public function SkinColor(colors : Array<Dynamic>) : Transformation
    {
        return skin.SkinColor(colors);
    }
    public var SkinPlain(default, never) : Transformation = skin.SkinPlain.registerTfMultiple(AS_SKIN, 
                        AE_HUMAN, AE_ELF, AE_FAIRY, AE_GAZER, AE_GOBLIN, AE_GREMLIN, AE_IMP, AE_KITSUNE, AE_OOMUKADE, AE_ORC, AE_ORCA
            ).withAlchemyNames("PlainSkin", "Plain skin");
    public var SkinSlippery(default, never) : Transformation = skin.SkinSlippery;
    public var SkinTransparent(default, never) : Transformation = skin.SkinTransparent.registerTfMultiple(AS_SKIN, 
                        AE_POLTERGEIST
            ).withAlchemyNames("Transp.Skin", "Transparent skin");
    /**
     * @param options = {color/colors,color2/colors2,pattern,adj,desc}
     */
    public function SkinFur(coverage : Int = Skin.COVERAGE_COMPLETE, options : Dynamic = null) : Transformation
    {
        return skin.SkinFur(coverage, options);
    }
    public function SkinFurGradual(coverage : Int = Skin.COVERAGE_COMPLETE, options : Dynamic = null) : Transformation
    {
        return skin.SkinFurGradual(coverage, options);
    }
    public var SkinFurGradualToFull(default, never) : Transformation = SkinFurGradual().registerTfMultiple(AS_SKIN, 
                        AE_AZAZEL, AE_BEAR, AE_BUNNY, AE_CAT, AE_CERBERUS, AE_COW, AE_DEER, AE_REINDEER, AE_DISPLACER_BEAST, AE_ECHIDNA, AE_FERRET, AE_FOX, AE_HELLCAT, AE_HORSE, AE_KAMAITACHI, AE_KANGAROO, AE_MELKIE, AE_MOUSE, AE_NEKOMATA, AE_PIG, AE_RACCOON, AE_SQUIRREL, AE_RED_PANDA, AE_SPHINX, AE_WENDIGO, AE_WEREWOLF, AE_WOLF, AE_YETI
            ).withAlchemyNames("Fur", "Fur");
    public function SkinScales(coverage : Int = Skin.COVERAGE_COMPLETE, options : Dynamic = null) : Transformation
    {
        return skin.SkinScales(coverage, options);
    }
    public function SkinScalesGradual(coverage : Int = Skin.COVERAGE_COMPLETE, options : Dynamic = null) : Transformation
    {
        return skin.SkinScalesGradual(coverage, options);
    }
    public var SkinScalesGradualToFull(default, never) : Transformation = SkinScalesGradual().registerTfMultiple(AS_SKIN, 
                        AE_APOPHIS, AE_COUATL, AE_CAVE_WYRM, AE_GORGON, AE_HYDRA, AE_LIZARD, AE_SNAKE, AE_PHOENIX, AE_SALAMANDER
            ).withAlchemyNames("Scale", "Scales");
    public function SkinDragonScales(coverage : Int = Skin.COVERAGE_COMPLETE, options : Dynamic = null) : Transformation
    {
        return skin.SkinDragonScales(coverage, options);
    }
    public var SkinDragonScalesToFull(default, never) : Transformation = SkinDragonScales().registerTfMultiple(AS_SKIN, 
                        AE_DRAGON, AE_FAERIE_DRAGON, AE_FROST_WYRM, AE_JABBERWOCKY, AE_KIRIN
            ).withAlchemyNames("DragonScales", "Dragon scales");
    public function SkinChitin(coverage : Int = Skin.COVERAGE_COMPLETE, options : Dynamic = null) : Transformation
    {
        return skin.SkinChitin(coverage, options);
    }
    public var SkinChitinToFull(default, never) : Transformation = SkinChitin().registerTfMultiple(AS_SKIN, 
                        AE_ANT, AE_BEE, AE_MANTIS, AE_SPIDER, AE_SCORPION, AE_ATLACH_NACHA
            ).withAlchemyNames("Chitin", "chitin");
    public function SkinAquaScales(coverage : Int = Skin.COVERAGE_HIGH, options : Dynamic = null) : Transformation
    {
        return skin.SkinAquaScales(coverage, options);
    }
    public var SkinAquaScalesToFull(default, never) : Transformation = SkinAquaScales().registerTfMultiple(AS_SKIN, AE_SHARK, AE_SIREN, AE_WERESHARK).withAlchemyNames("AquaScales", "Aqua scales");
    public function SkinBark(coverage : Int = Skin.COVERAGE_COMPLETE, options : Dynamic = null) : Transformation
    {
        return skin.SkinBark(coverage, options);
    }
    public var SkinBarkToFull(default, never) : Transformation = SkinBark().registerTf(AS_SKIN, AE_YGGDRASIL).withAlchemyNames("Bark", "Bark");
    public function SkinGoo(coverage : Int = Skin.COVERAGE_COMPLETE, type : Int = 0, options : Dynamic = null) : Transformation
    {
        return skin.SkinGoo(coverage, type, options);
    }
    public var SkinGooToFull(default, never) : Transformation = SkinGoo().registerTfMultiple(AS_SKIN, AE_GOO, AE_DARK_SLIME).withAlchemyNames("Goo", "Goo");
    
    
    //SKIN PATTERN
    //======================================================================================================================
    //                                                                                                                    ==
    //   ███████ ██   ██ ██ ███    ██ 		███████   █████  ████████ ████████ ███████ ██████  ███    ██                  ==
    //   ██      ██  ██  ██ ████   ██ 		██   ██  ██   ██    ██       ██    ██      ██   ██ ████   ██                  ==
    //   ███████ █████   ██ ██ ██  ██ 		███████  ███████    ██       ██    █████   ██████  ██ ██  ██                  ==
    //        ██ ██  ██  ██ ██  ██ ██ 		██		 ██   ██    ██       ██    ██      ██   ██ ██  ██ ██                  ==
    //   ███████ ██   ██ ██ ██   ████ 		██		 ██   ██    ██       ██    ███████ ██   ██ ██   ████                  ==
    //                                                                                                                    ==
    //======================================================================================================================
    public var SkinPatternNone(default, never) : Transformation = skin.SkinPatternNone.registerTfMultiple(AS_SKIN_PATTERN, AE_REMOVE, AE_HUMAN);
    public var SkinPatternOrc(default, never) : Transformation = skin.SkinPatternOrc.registerTf(AS_SKIN_PATTERN, AE_ORC);
    public var SkinPatternRaiju(default, never) : Transformation = skin.SkinPatternRaiju.registerTf(AS_SKIN_PATTERN, AE_RAIJU);
    public var SkinPatternOni(default, never) : Transformation = skin.SkinPatternOni.registerTf(AS_SKIN_PATTERN, AE_ONI);
    public var SkinPatternKitsune(default, never) : Transformation = skin.SkinPatternKitsune.registerTf(AS_SKIN_PATTERN, AE_KITSUNE);
    public var SkinPatternVenomousMarkings(default, never) : Transformation = skin.SkinPatternVenomousMarkings.registerTf(AS_SKIN_PATTERN, AE_OOMUKADE);
    public var SkinPatternWhiteBlackVeins(default, never) : Transformation = skin.SkinPatternWhiteBlackVeins.registerTf(AS_SKIN_PATTERN, AE_GHOST);
    public var SkinPatternOil(default, never) : Transformation = skin.SkinPatternOil.registerTf(AS_SKIN_PATTERN, AE_GAZER);
    public var SkinPatternScarWindswept(default, never) : Transformation = skin.SkinPatternScarWindswept.registerTf(AS_SKIN_PATTERN, AE_KAMAITACHI);
    public var SkinPatternUshiOniTattoo(default, never) : Transformation = skin.SkinPatternUshiOniTattoo.registerTf(AS_SKIN_PATTERN, AE_USHI_ONI);
    public var SkinPatternBeeStripes(default, never) : Transformation = skin.SkinPatternBeeStripes.registerTf(AS_SKIN_PATTERN, AE_BEE);
    public var SkinPatternTigerSharkStripes(default, never) : Transformation = skin.SkinPatternTigerSharkStripes.registerTf(AS_SKIN_PATTERN, AE_SHARK);
    public var SkinPatternOrca(default, never) : Transformation = skin.SkinPatternOrca.registerTf(AS_SKIN_PATTERN, AE_ORCA);
    public var SkinPatternSeaDragon(default, never) : Transformation = skin.SkinPatternSeaDragon.registerTf(AS_SKIN_PATTERN, AE_SEA_DRAGON);
    public var SkinPatternArchImp(default, never) : Transformation = skin.SkinPatternArchImp.registerTf(AS_SKIN_PATTERN, AE_IMP);
    public var SkinPatternAnubis(default, never) : Transformation = skin.SkinPatternAnubis.registerTf(AS_SKIN_PATTERN, AE_ANUBIS);
    public var SkinPatternBioluminescence(default, never) : Transformation = skin.SkinPatternBioluminescence.registerTf(AS_SKIN_PATTERN, AE_ABYSSAL_SHARK);  //TfMultiple(AS_  
    
    
    //TAIL
    //======================================================================================================================
    //                                                                                                                    ==
    //    ████████  █████  ██ ██                                                                                          ==
    //       ██    ██   ██ ██ ██                                                                                          ==
    //       ██    ███████ ██ ██                                                                                          ==
    //       ██    ██   ██ ██ ██                                                                                          ==
    //       ██    ██   ██ ██ ███████                                                                                     ==
    //                                                                                                                    ==
    //======================================================================================================================
    public var tail : TailTransformations = new TailTransformations();
    public var TailNone(default, never) : Transformation = tail.TailNone.registerTf(AS_TAIL, AE_REMOVE);
    public var TailScorpion(default, never) : Transformation = tail.TailScorpion.registerTf(AS_TAIL, AE_SCORPION);
    public var TailManticore(default, never) : Transformation = tail.TailManticore.registerTf(AS_TAIL, AE_MANTICORE);
    public var TailBurning(default, never) : Transformation = tail.TailBurning.registerTf(AS_TAIL, AE_HINEZUMI);
    public var TailTwinkasha(default, never) : Transformation = tail.TailTwinkasha.registerTf(AS_TAIL, AE_HELLCAT);
    public var TailCat(default, never) : Transformation = tail.TailCat.registerTfMultiple(AS_TAIL, AE_CAT < AE_DRAGONNE);
    public var TailNekomataOneThirdForked(default, never) : Transformation = tail.TailNekomataOneThirdForked.registerTf(AS_TAIL, AE_NEKOMATA);
    public var TailNekomataTwoThirdsForked(default, never) : Transformation = tail.TailNekomataTwoThirdsForked.registerTf(AS_TAIL, AE_NEKOMATA);
    public var TailCat2nd(default, never) : Transformation = tail.TailCat2nd.registerTf(AS_TAIL, AE_NEKOMATA);
    public var TailRedPanda(default, never) : Transformation = tail.TailRedPanda.registerTf(AS_TAIL, AE_RED_PANDA);
    public var TailHorse(default, never) : Transformation = tail.TailHorse.registerTf(AS_TAIL, AE_HORSE);
    public var TailKirin(default, never) : Transformation = tail.TailKirin.registerTf(AS_TAIL, AE_KIRIN);
    public var TailPig(default, never) : Transformation = tail.TailPig.registerTf(AS_TAIL, AE_PIG);
    public var TailRaiju(default, never) : Transformation = tail.TailRaiju.registerTf(AS_TAIL, AE_RAIJU);
    public var TailMantis(default, never) : Transformation = tail.TailMantis.registerTf(AS_TAIL, AE_MANTIS);
    public var TailGoat(default, never) : Transformation = tail.TailGoat.registerTf(AS_TAIL, AE_GOAT);
    public var TailCow(default, never) : Transformation = tail.TailCow.registerTf(AS_TAIL, AE_COW);
    public var TailDraconic(default, never) : Transformation = tail.TailDraconic.registerTf(AS_TAIL, AE_DRAGON);
    public var TailFeyDraconic(default, never) : Transformation = tail.TailFeyDraconic.registerTf(AS_TAIL, AE_FAERIE_DRAGON);
    public var TailOrca(default, never) : Transformation = tail.TailOrca.registerTf(AS_TAIL, AE_ORCA);
    public var TailSalamander(default, never) : Transformation = tail.TailSalamander.registerTf(AS_TAIL, AE_SALAMANDER);
    public var TailShark(default, never) : Transformation = tail.TailShark.registerTf(AS_TAIL, AE_SHARK);
    public var TailSpider(default, never) : Transformation = tail.TailSpider.registerTf(AS_TAIL, AE_SPIDER);
    public var TailHarpy(default, never) : Transformation = tail.TailHarpy.registerTf(AS_TAIL, AE_HARPY);
    public var TailBee(default, never) : Transformation = tail.TailBee.registerTf(AS_TAIL, AE_BEE);
    public var TailLizard(default, never) : Transformation = tail.TailLizard.registerTf(AS_TAIL, AE_LIZARD);
    public var TailDemonic(default, never) : Transformation = tail.TailDemonic.registerTf(AS_TAIL, AE_DEMON);
    public var TailAzazel(default, never) : Transformation = tail.TailAzazel.registerTf(AS_TAIL, AE_AZAZEL);
    public var TailWolf(default, never) : Transformation = tail.TailWolf.registerTf(AS_TAIL, AE_WOLF);
    public var TailDog(default, never) : Transformation = tail.TailDog.registerTf(AS_TAIL, AE_DOG);
    public var TailCaveWyrm(default, never) : Transformation = tail.TailCaveWyrm.registerTf(AS_TAIL, AE_CAVE_WYRM);
    public var TailRabbit(default, never) : Transformation = tail.TailRabbit.registerTf(AS_TAIL, AE_BUNNY);
    public var TailAvian(default, never) : Transformation = tail.TailAvian.registerTf(AS_TAIL, AE_AVIAN);
    public var TailGriffin(default, never) : Transformation = tail.TailGriffin.registerTf(AS_TAIL, AE_GRYPHON);
    public var TailKangaroo(default, never) : Transformation = tail.TailKangaroo.registerTf(AS_TAIL, AE_KANGAROO);
    public var TailThunderbird(default, never) : Transformation = tail.TailThunderbird.registerTf(AS_TAIL, AE_THUNDERBIRD);
    public var TailSquirrel(default, never) : Transformation = tail.TailSquirrel.registerTf(AS_TAIL, AE_SQUIRREL);
    public var TailWeasel(default, never) : Transformation = tail.TailWeasel.registerTf(AS_TAIL, AE_WEASEL);
    public var TailRaccoon(default, never) : Transformation = tail.TailRaccoon.registerTf(AS_TAIL, AE_RACCOON);
    public var TailMouse(default, never) : Transformation = tail.TailMouse.registerTf(AS_TAIL, AE_MOUSE);
    public var TailHinezumi(default, never) : Transformation = tail.TailHinezumi.registerTf(AS_TAIL, AE_HINEZUMI);
    public var TailFerret(default, never) : Transformation = tail.TailFerret.registerTf(AS_TAIL, AE_FERRET);
    public var TailBear(default, never) : Transformation = tail.TailBear.registerTf(AS_TAIL, AE_BEAR);
    public var TailUshiOni(default, never) : Transformation = tail.TailUshiOni.registerTf(AS_TAIL, AE_USHI_ONI);
    public var TailWendigo(default, never) : Transformation = tail.TailWendigo.registerTf(AS_TAIL, AE_WENDIGO);
    public var TailHydra(default, never) : Transformation = tail.TailHydra.registerTf(AS_TAIL, AE_HYDRA);
    public var TailSpinneretAtlach(default, never) : Transformation = tail.TailSpinneretAtlach.registerTf(AS_TAIL, AE_ATLACH_NACHA);
    public var TailDeer(default, never) : Transformation = tail.TailDeer.registerTf(AS_TAIL, AE_DEER);
    public var TailYgddrasil(default, never) : Transformation = tail.TailYgddrasil.registerTf(AS_TAIL, AE_YGGDRASIL);
    public var TailAbyssalShark(default, never) : Transformation = tail.TailAbyssalShark.registerTf(AS_TAIL, AE_ABYSSAL_SHARK);
    public var TailArigeanGreen(default, never) : Transformation = tail.TailArigeanGreen.registerTf(AS_TAIL, AE_ARIGEAN);
    public var TailArigeanRed(default, never) : Transformation = tail.TailArigeanRed.registerTf(AS_TAIL, AE_ARIGEAN);
    public var TailArigeanYellow(default, never) : Transformation = tail.TailArigeanYellow.registerTf(AS_TAIL, AE_ARIGEAN);
    public var TailMoth(default, never) : Transformation = tail.TailMoth.registerTf(AS_TAIL, AE_MOTH);
    public var TailTroll(default, never) : Transformation = tail.TailTroll.registerTf(AS_TAIL, AE_TROLL);
    public var TailGlacialTroll(default, never) : Transformation = tail.TailGlacialTroll.registerTf(AS_TAIL, AE_GLACIAL_TROLL);
    
    /**
	 * @param tailCount target tail count
	 * @param magnitude max. number of added/removed tails
	 * @param canRemove can remove tails (if false, this is "at least [tailCount] fox tails" TF)
	 */
    public function TailFox(tailCount : Int = 1, magnitude : Int = 9, canRemove : Bool = true) : Transformation
    {
        return tail.TailFox(tailCount, magnitude, canRemove);
    }
    public function TailKitshoo(tailCount : Int = 1) : Transformation
    {
        return tail.TailKitshoo(tailCount);
    }
    public var TailAnt(default, never) : Transformation = tail.TailAnt;
    
    
    //TONGUE
    //======================================================================================================================
    //                                                                                                                    ==
    //    ████████  ██████  ███    ██  ██████  ██    ██ ███████                                                           ==
    //       ██    ██    ██ ████   ██ ██       ██    ██ ██                                                                ==
    //       ██    ██    ██ ██ ██  ██ ██   ███ ██    ██ █████                                                             ==
    //       ██    ██    ██ ██  ██ ██ ██    ██ ██    ██ ██                                                                ==
    //       ██     ██████  ██   ████  ██████   ██████  ███████                                                           ==
    //                                                                                                                    ==
    //======================================================================================================================
    public var tongue : TongueTransformations = new TongueTransformations();
    public var TongueHuman(default, never) : Transformation = tongue.TongueHuman.registerTf(AS_TONGUE, AE_HUMAN);
    public var TongueCat(default, never) : Transformation = tongue.TongueCat.registerTfMultiple(AS_TONGUE, AE_CAT, AE_DRAGONNE);
    public var TongueDog(default, never) : Transformation = tongue.TongueDog.registerTf(AS_TONGUE, AE_DOG);
    public var TongueElf(default, never) : Transformation = tongue.TongueElf.registerTf(AS_TONGUE, AE_ELF);
    public var TongueDraconic(default, never) : Transformation = tongue.TongueDraconic.registerTf(AS_TONGUE, AE_DRAGON);
    public var TongueSnake(default, never) : Transformation = tongue.TongueSnake.registerTf(AS_TONGUE, AE_SNAKE);
    public var TongueDemonic(default, never) : Transformation = tongue.TongueDemonic.registerTf(AS_TONGUE, AE_DEMON);
    public var TongueRavenous(default, never) : Transformation = tongue.TongueRavenous.registerTf(AS_TONGUE, AE_WENDIGO);
    public var TongueCaveWyrm(default, never) : Transformation = tongue.TongueCaveWyrm.registerTf(AS_TONGUE, AE_CAVE_WYRM);
    public var TongueGhost(default, never) : Transformation = tongue.TongueGhost.registerTf(AS_TONGUE, AE_GHOST);
    public var TongueRatatoskr(default, never) : Transformation = tongue.TongueRatatoskr.registerTf(AS_TONGUE, AE_SQUIRREL);
    public var TongueMelkie(default, never) : Transformation = tongue.TongueMelkie.registerTf(AS_TONGUE, AE_MELKIE);
    public var TongueImp(default, never) : Transformation = tongue.TongueImp.registerTf(AS_TONGUE, AE_IMP);
    public var TongueArigean(default, never) : Transformation = tongue.TongueArigean.registerTf(AS_TONGUE, AE_ARIGEAN);
    
    
    //VAGINA
    //======================================================================================================================
    //                                                                                                                    ==
    //   ██       ██  █████   ██████  ██ ███   ██  █████                                                                  ==
    // 	  ██     ██  ██   ██ ██       ██ ████  ██ ██   ██                                                                 ==
    // 	   ██   ██   ███████ ██   ███ ██ ██ ██ ██ ███████                                                                 ==
    // 	    ██ ██    ██   ██ ██    ██ ██ ██  ████ ██   ██                                                                 ==
    //	     ███     ██   ██  ██████  ██ ██   ███ ██   ██                                                                 ==
    //                                                                                                                    ==
    //======================================================================================================================
    public var vaginas : VaginaTransformations = new VaginaTransformations();
    public function UnlockVagina() : Void
    {
        return vaginas.UnlockVagina();
    }
    public function VaginaNone(vagina : Int = 0) : Transformation
    {
        return vaginas.VaginaNone(vagina);
    }
    public var VaginaRemoveFirst(default, never) : Transformation = cast((0), VaginaNone).registerTf(AS_VAGINA, AE_REMOVE);
    public function CockToVagina(vagina : Int = 0) : Transformation
    {
        return vaginas.CockToVagina(vagina);
    }
    public var SecondVagina(default, never) : Transformation = vaginas.SecondVagina();
    public function VaginaHuman(vagina : Int = 0) : Transformation
    {
        return vaginas.VaginaHuman(vagina);
    }
    public var VaginaAnyHuman(default, never) : Transformation = cast((-1), VaginaHuman).registerTf(AS_VAGINA, AE_HUMAN);
    public function VaginaHorse(vagina : Int = 0) : Transformation
    {
        return vaginas.VaginaHorse(vagina);
    }
    public var VaginaAnyHorse(default, never) : Transformation = cast((-1), VaginaHorse).registerTf(AS_VAGINA, AE_HORSE);
    public function VaginaKirin(vagina : Int = 0) : Transformation
    {
        return vaginas.VaginaKirin(vagina);
    }
    public var VaginaAnyKirin(default, never) : Transformation = cast((-1), VaginaKirin).registerTf(AS_VAGINA, AE_KIRIN);
    public function VaginaSandTrap(vagina : Int = 0) : Transformation
    {
        return vaginas.VaginaSandTrap(vagina);
    }
    public var VaginaAnySandTrap(default, never) : Transformation = cast((-1), VaginaSandTrap).registerTf(AS_VAGINA, AE_SAND_TRAP);
    public function VaginaCaveWyrm(vagina : Int = 0) : Transformation
    {
        return vaginas.VaginaCaveWyrm(vagina);
    }
    public var VaginaAnyCaveWyrm(default, never) : Transformation = cast((-1), VaginaCaveWyrm).registerTf(AS_VAGINA, AE_CAVE_WYRM);
    public function VaginaCentipede(vagina : Int = 0) : Transformation
    {
        return vaginas.VaginaCentipede(vagina);
    }
    public var VaginaAnyCentipede(default, never) : Transformation = cast((-1), VaginaCentipede).registerTf(AS_VAGINA, AE_CENTIPEDE);
    public function VaginaManticore(vagina : Int = 0) : Transformation
    {
        return vaginas.VaginaManticore(vagina);
    }
    public var VaginaAnyManticore(default, never) : Transformation = cast((-1), VaginaManticore).registerTf(AS_VAGINA, AE_MANTICORE);
    public function VaginaCancer(vagina : Int = 0) : Transformation
    {
        return vaginas.VaginaCancer(vagina);
    }
    public var VaginaAnyCancer(default, never) : Transformation = cast((-1), VaginaCancer).registerTf(AS_VAGINA, AE_CANCER);
    public function VaginaDemonic(vagina : Int = 0) : Transformation
    {
        return vaginas.VaginaDemonic(vagina);
    }
    public var VaginaAnyDemonic(default, never) : Transformation = cast((-1), VaginaDemonic).registerTf(AS_VAGINA, AE_DEMON);
    public function VaginaScylla(vagina : Int = 0) : Transformation
    {
        return vaginas.VaginaScylla(vagina);
    }
    public var VaginaAnyScylla(default, never) : Transformation = cast((-1), VaginaScylla).registerTf(AS_VAGINA, AE_SCYLLA);
    public function VaginaNaga(vagina : Int = 0) : Transformation
    {
        return vaginas.VaginaNaga(vagina);
    }
    public var VaginaAnyNaga(default, never) : Transformation = cast((-1), VaginaNaga).registerTf(AS_VAGINA, AE_SNAKE);
    public function VaginaShark(vagina : Int = 0) : Transformation
    {
        return vaginas.VaginaShark(vagina);
    }
    public var VaginaAnyShark(default, never) : Transformation = cast((-1), VaginaShark).registerTfMultiple(AS_VAGINA, AE_SHARK, AE_WERESHARK);
    public function VaginaRaiju(vagina : Int = 0) : Transformation
    {
        return vaginas.VaginaRaiju(vagina);
    }
    public var VaginaAnyRaiju(default, never) : Transformation = cast((-1), VaginaRaiju).registerTf(AS_VAGINA, AE_RAIJU);
    public function VaginaAlraune(vagina : Int = 0) : Transformation
    {
        return vaginas.VaginaAlraune(vagina);
    }
    public var VaginaAnyAlraune(default, never) : Transformation = cast((-1), VaginaAlraune).registerTf(AS_VAGINA, AE_ALRAUNE);
    public function VaginaArigean(vagina : Int = 0) : Transformation
    {
        return vaginas.VaginaArigean(vagina);
    }
    public var VaginaAnyArigean(default, never) : Transformation = cast((-1), VaginaArigean).registerTf(AS_VAGINA, AE_ARIGEAN);
    
    
    //WINGS
    //======================================================================================================================
    //                                                                                                                    ==
    //   ██       ██ ██ ███    ██  ██████  ███████                                                                        ==
    //   ██       ██ ██ ████   ██ ██       ██                                                                             ==
    //   ██  ███  ██ ██ ██ ██  ██ ██   ███ ███████                                                                        ==
    //   ██ ██ ██ ██ ██ ██  ██ ██ ██    ██      ██                                                                        ==
    //   ████   ████ ██ ██   ████  ██████  ███████                                                                        ==
    //                                                                                                                    ==
    //======================================================================================================================
    public var wings : WingsTransformations = new WingsTransformations();
    public var WingsNone(default, never) : Transformation = wings.WingsNone.registerTf(AS_WINGS, AE_REMOVE);
    public var WingsBeeLarge(default, never) : Transformation = wings.WingsBeeLarge.registerTf(AS_WINGS, AE_BEE);
    public var WingsBeeSmall(default, never) : Transformation = wings.WingsBeeSmall.registerTf(AS_WINGS, AE_BEE);
    public var WingsCouatl(default, never) : Transformation = wings.WingsCouatl.registerTf(AS_WINGS, AE_COUATL);
    public var WingsDraconicHuge(default, never) : Transformation = wings.WingsDraconicHuge.registerTf(AS_WINGS, AE_DRAGON);
    public var WingsDraconicLarge(default, never) : Transformation = wings.WingsDraconicLarge.registerTf(AS_WINGS, AE_DRAGON);
    public var WingsDraconicSmall(default, never) : Transformation = wings.WingsDraconicSmall.registerTf(AS_WINGS, AE_DRAGON);
    public var WingsFairy(default, never) : Transformation = wings.WingsFairy.registerTf(AS_WINGS, AE_FAIRY);
    public var WingsFeatheredAlicorn(default, never) : Transformation = wings.WingsFeatheredAlicorn.registerTf(AS_WINGS, AE_ALICORN);
    public var WingsFeatheredLarge(default, never) : Transformation = wings.WingsFeatheredLarge.registerTfMultiple(AS_WINGS, AE_HARPY, AE_SIREN, AE_THUNDERBIRD);
    public var WingsFeatheredPhoenix(default, never) : Transformation = wings.WingsFeatheredPhoenix.registerTf(AS_WINGS, AE_PHOENIX);
    public var WingsFeatheredSphinx(default, never) : Transformation = wings.WingsFeatheredSphinx.registerTf(AS_WINGS, AE_SPHINX);
    public var WingsManticoreLarge(default, never) : Transformation = wings.WingsManticoreLarge.registerTf(AS_WINGS, AE_MANTICORE);
    public var WingsManticoreSmall(default, never) : Transformation = wings.WingsManticoreSmall.registerTf(AS_WINGS, AE_MANTICORE);
    public var WingsMantisLarge(default, never) : Transformation = wings.WingsMantisLarge.registerTf(AS_WINGS, AE_MANTIS);
    public var WingsMantisSmall(default, never) : Transformation = wings.WingsMantisSmall.registerTf(AS_WINGS, AE_MANTIS);
    public var WingsNightmare(default, never) : Transformation = wings.WingsNightmare.registerTf(AS_WINGS, AE_NIGHTMARE);
    public var WingsThunderousAura(default, never) : Transformation = wings.WingsThunderousAura.registerTfMultiple(AS_WINGS, AE_KIRIN, AE_RAIJU).withAlchemyNames("Thund.Aura", "Thunderous aura");
    public var WingsDemonicLarge(default, never) : Transformation = wings.WingsDemonicLarge.registerTf(AS_WINGS, AE_DEMON);
    public var WingsDemonicTiny(default, never) : Transformation = wings.WingsDemonicTiny.registerTf(AS_WINGS, AE_DEMON);
    public var WingsVampire(default, never) : Transformation = wings.WingsVampire.registerTf(AS_WINGS, AE_VAMPIRE);
    public var WingsFeatheredAvian(default, never) : Transformation = wings.WingsFeatheredAvian.registerTf(AS_WINGS, AE_AVIAN);
    public var WingsEthereal(default, never) : Transformation = wings.WingsEthereal.registerTf(AS_WINGS, AE_POLTERGEIST);
    public var WingsLevitation(default, never) : Transformation = wings.WingsLevitation.registerTfMultiple(AS_WINGS, AE_GAZER, AE_WENDIGO, AE_YUKI_ONNA).withAlchemyNames("Levitation", "Levitation");
    public var WingsWindyAura(default, never) : Transformation = wings.WingsWindyAura.registerTf(AS_WINGS, AE_KAMAITACHI);
    public var WingsGiantDragonfly(default, never) : Transformation = wings.WingsGiantDragonfly.registerTf(AS_WINGS, AE_SAND_TRAP);
    public var WingsSeaDragon(default, never) : Transformation = wings.WingsSeaDragon.registerTf(AS_WINGS, AE_SEA_DRAGON);
    public var WingsAntLarge(default, never) : Transformation = wings.WingsAntLarge.registerTf(AS_WINGS, AE_ANT);
    public var WingsAntSmall(default, never) : Transformation = wings.WingsAntSmall.registerTf(AS_WINGS, AE_ANT);
    public var WingsDevilfeather(default, never) : Transformation = wings.WingsDevilfeather.registerTf(AS_WINGS, AE_DEVIL);
    public var WingsPureDevilfeather(default, never) : Transformation = wings.WingsPureDevilfeather.registerTf(AS_WINGS, AE_DEVIL);
    public var WingsFeyDragon(default, never) : Transformation = wings.WingsFeyDragon.registerTf(AS_WINGS, AE_FAERIE_DRAGON);
    public var WingsJabberwocky(default, never) : Transformation = wings.WingsJabberwocky.registerTf(AS_WINGS, AE_JABBERWOCKY);
    public var WingsPlant(default, never) : Transformation = wings.WingsPlant.registerTf(AS_WINGS, AE_PLANT);
    public var WingsYggdrasilLarge(default, never) : Transformation = wings.WingsYggdrasilLarge.registerTf(AS_WINGS, AE_YGGDRASIL);
    public var WingsYggdrasilHuge(default, never) : Transformation = wings.WingsYggdrasilHuge.registerTf(AS_WINGS, AE_YGGDRASIL);
    public var WingsYggdrasilQuadrupleHuge(default, never) : Transformation = wings.WingsYggdrasilQuadrupleHuge.registerTf(AS_WINGS, AE_YGGDRASIL);
    public var WingsMothSmall(default, never) : Transformation = wings.WingsMothSmall.registerTf(AS_WINGS, AE_MOTH);
    public var WingsMothLarge(default, never) : Transformation = wings.WingsMothLarge.registerTf(AS_WINGS, AE_MOTH);
    
    
    
    //Warnings
    //======================================================================================================================
    //                                                                                                                    ==
    //   ██       ██  █████  ██████  ███    ██ ██ ███    ██  ██████  ███████                                              ==
    //   ██       ██ ██   ██ ██   ██ ████   ██ ██ ████   ██ ██       ██                                                   ==
    //   ██  ███  ██ ███████ ██████  ██ ██  ██ ██ ██ ██  ██ ██   ███ ███████                                              ==
    //   ██ ██ ██ ██ ██   ██ ██   ██ ██  ██ ██ ██ ██  ██ ██ ██    ██      ██                                              ==
    //   ████   ████ ██   ██ ██   ██ ██   ████ ██ ██   ████  ██████  ███████                                              ==
    //                                                                                                                    ==
    //======================================================================================================================
    
    /*
    */
    public var warnings : WarningTransformations = new WarningTransformations();
    //warnings dont work as yet, calling function needs to return if bad end triggered!
    public var CaninePepperWarning(default, never) : PossibleEffect = warnings.CaninePepperWarning;
    public var KangaFruitWarning(default, never) : PossibleEffect = warnings.KangaFruitWarning;
    /*
*/
    
    /*
*    ███████ ██████  ███████  ██████ ██  █████  ██          ████████ ███████ ███████
*    ██      ██   ██ ██      ██      ██ ██   ██ ██             ██    ██      ██
*    ███████ ██████  █████   ██      ██ ███████ ██             ██    █████   ███████
*         ██ ██      ██      ██      ██ ██   ██ ██             ██    ██           ██
*    ███████ ██      ███████  ██████ ██ ██   ██ ███████        ██    ██      ███████
*/
    
    
    /*
*    ████████ ██ ███████ ██████  ███████ ██████      ████████ ███████ ███████
*       ██    ██ ██      ██   ██ ██      ██   ██     	██    ██      ██
*       ██    ██ █████   ██████  █████   ██   ██        ██    █████   ███████
*       ██    ██ ██      ██   ██ ██      ██   ██        ██    ██           ██
*       ██    ██ ███████ ██   ██ ███████ ██████         ██    ██      ███████
*/
    
    /*
		*/
    public var TieredSpiderFace(default, never) : GradualTransformation = new GradualTransformation("Spider face (gradual)", [
        FaceHuman, 
        FaceSpiderFangs
    ]);
    /*
*/
    
    /*
*    ██      ██ ███████ ████████ ███████
*    ██      ██ ██         ██    ██
*    ██      ██ ███████    ██    ███████
*    ██      ██      ██    ██         ██
*    ███████ ██ ███████    ██    ███████
*/
    
    /*
		*/
    public var List_AtlachNacha(default, never) : Array<Dynamic> = [
        MutagenLibSpider, 
        MutagenTouSpider, 
        MutagenSpeSpider, 
        SensUpSpider, 
        
        VenomRechargeSpider, 
        VaginaTightenAndMutagenLib, 
        AssholeTightenAndMutagenLib, 
        CocksThickenAll, 
        BreastsGrowUpToDD, 
        AssGrowUpTo11, 
        
        EarsElfin, 
        SkinChitin(Skin.COVERAGE_LOW, {
                    color : "midnight purple"
                }), 
        TieredSpiderFace, 
        cast((["midnight purple"]), HairChangeColor), 
        new OrderedTransformation("EyesRedThenSpider", [
        cast((["red"]), EyesChangeColor), 
        EyesSpiderAndMutagenInt
    ]), 
        BreastRowsRemoveToOne, 
        NipplesPerBreastOne, 
        NipplesBlack, 
        ArmsAtlach, 
        LowerBodyAtlach, 
        TailSpinneretAtlach, 
        GillsNone, 
        RearBodyAtlachNacha
    ];
    /*
*/
    
    private function printAlchemyTable() : Void
    {
        var dump : Array<Dynamic> = [];
        var eid : Int;
        var sid : Int;
        for (eid in 0...Essences.length)
        {
            var ess : EnumValue = Essences[eid];
            if (eid == 0)
            {
                var row : Array<Dynamic> = ["Essences"];
            }
            else
            {
                if (ess == null)
                {
                    continue;
                }
                row = [ess.name];
            }
            for (sid in 1...Substances.length)
            {
                var sub : EnumValue = Substances[sid];
                if (sub == null)
                {
                    continue;
                }
                if (eid == 0)
                {
                    row.push(sub.short);
                }
                else
                {
                    var tf : PossibleEffect = Transformation.findSETf(sid, eid);
                    if (tf == null)
                    {
                        row.push("-");
                    }
                    else
                    {
                        row.push(tf.alchemyShortName);
                    }
                }
            }
            dump.push(row.join("\t"));
        }
        trace("\n" + dump.join("\n"));
    }
}

