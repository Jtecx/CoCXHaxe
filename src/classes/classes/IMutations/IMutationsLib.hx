/**
 * Based on PerkLib, created by Aimozg
 * Created by JTecx
 * V2 on 21.08.21
 * V3 on 31.03.22
 */
package classes.IMutations;

import classes.CoC;
import classes.IMutationPerkType;

/**
 * The goal of Mutations 3.0 is to allow for everything related to the mutation itself to be hosted within its own file, and to reduce the number of perks being created for the player.
 *
 * Addendum: The fundamental reason for Mutations3.0 is to clearly define the "perks" that are limited by the organ slots, as well as being obtained by Evangeline only.
 * PermTF, or PermTF Adjacent races, with mutations such as Mindbreaker/HellhoundFireBalls/FeyArcaneBloodstream, have a "True" Variant, in which their buffs are significantly stronger,
 * to offset the penalty of not being able to obtain other mutations form other races.
 *
 * Mutations 3.0 Handles perk creation slightly differently in a few ways.
 *
 * First, .withBuffs is not used here, instead, buffs are created in a pBuffs function within the mutation file itself, and must return an object.
 *
 * Requirements, as seen below compared to PerkLib/MutationsLib, are also not handled below, and are instead dynamically created, via pReqs function, also stored within the mutations file itself.
 * These can be checked seperately, or when sent to createDynamicPerks, will handle it as well.
 *
 * Mutations are themselves handling their iterations via v1 checks.
 * V2 is used for the Mutations to track any special conditions for upgrading, as in cases such as HellHoundFireBalls.
 * V3 is used to track if the user has the regular (0) or the True (1) variant of the Mutation.
 *
 * Refer to Basecontent's createDynamicPerk function to see how they are used.
 *
 * Refer to Basecontent's updateDynamicPerkBuff function to see how to update buffs associated with perks created by createDynamicBuffs.
 */
class IMutationsLib
{
    public var game(get, never) : CoC;

    private function get_game() : CoC
    {
        return CoC.instance;
    }
    //Example -v
    //This one does nothing, and is simply to showcase and used as a dummy mutation to use for buffs..
    public static var MutationsTemplateIM : IMutationPerkType = new MutationTemplate();
    //Disabled mutations here. The contents are not filled. Please fill them in first.
    public static var NekomataThyroidGlandIM : IMutationPerkType = new NekomataThyroidGlandMutation();
    public static var HellcatParathyroidGlandsIM : IMutationPerkType = new HellcatParathyroidGlandMutation();
    public static var HengeyokaiBirthrightIM : IMutationPerkType = new HengeyokaiBirthrightMutation();
    public static var AnanasaBirthrightIM : IMutationPerkType = new AnanasaBirthrightMutation();
    public static var DraconicBonesIM : IMutationPerkType = new DraconicBonesMutation();
    public static var DraconicHeartIM : IMutationPerkType = new DraconicHeartMutation();
    public static var DraconicLungIM : IMutationPerkType = new DraconicLungMutation();
    //Mutations start here.
    public static var AlphaHowlIM : IMutationPerkType = new AlphaHowlMutation();
    public static var AnubiHeartIM : IMutationPerkType = new AnubiHeartMutation();
    public static var ArachnidBookLungIM : IMutationPerkType = new ArachnidBookLungMutation();
    public static var ArigeanAssociationCortexIM : IMutationPerkType = new ArigeanAssociationCortexMutation();
    public static var BlackHeartIM : IMutationPerkType = new BlackHeartMutation();
    public static var BlazingHeartIM : IMutationPerkType = new BlazingHeartMutation();
    public static var CatLikeNimblenessIM : IMutationPerkType = new CatLikeNimblenessMutation();
    public static var CaveWyrmLungsIM : IMutationPerkType = new CaveWyrmLungsMutation();
    public static var DiamondHeartIM : IMutationPerkType = new DiamondHeartMutation();
    public static var DisplacerMetabolismIM : IMutationPerkType = new DisplacerMetabolismMutation();
    public static var DrakeBloodIM : IMutationPerkType = new DrakeBloodMutation();
    public static var DrakeBonesIM : IMutationPerkType = new DrakeBonesMutation();
    public static var DrakeHeartIM : IMutationPerkType = new DrakeHeartMutation();
    public static var DrakeLungsIM : IMutationPerkType = new DrakeLungMutation();
    public static var EasterBunnyEggBagIM : IMutationPerkType = new EasterBunnyEggBagMutation();
    public static var EclipticMindIM : IMutationPerkType = new EclipticMindMutation();
    public static var ElvishPeripheralNervSysIM : IMutationPerkType = new ElvishPeripheralNervSysMutation();
    public static var EquineMuscleIM : IMutationPerkType = new EquineMuscleMutation();
    public static var EyeOfTheTigerIM : IMutationPerkType = new EyeOfTheTigerMutation();
    public static var FerasBirthrightIM : IMutationPerkType = new FerasBirthrightMutation();
    public static var FeyArcaneBloodstreamIM : IMutationPerkType = new FeyArcaneBloodstreamMutation();
    public static var FiendishBallsIM : IMutationPerkType = new FiendishBallsMutation();
    public static var FiendishMetabolismIM : IMutationPerkType = new FiendishMetabolismMutation();
    public static var FiendishOvariesIM : IMutationPerkType = new FiendishOvariesMutation();
    public static var FloralOvariesIM : IMutationPerkType = new FloralOvariesMutation();
    public static var FrozenHeartIM : IMutationPerkType = new FrozenHeartMutation();
    public static var GazerEyesIM : IMutationPerkType = new GazerEyesMutation();
    public static var GoblinOvariesIM : IMutationPerkType = new GoblinOvariesMutation();
    public static var GorgonEyesIM : IMutationPerkType = new GorgonEyesMutation();
    public static var HarpyHollowBonesIM : IMutationPerkType = new HarpyHollowBonesMutation();
    public static var HeartOfTheStormIM : IMutationPerkType = new HeartOfTheStormMutation();
    public static var HellhoundFireBallsIM : IMutationPerkType = new HellHoundFireBallsMutation();
    public static var HinezumiBurningBloodIM : IMutationPerkType = new HinezumiBurningBloodMutation();
    public static var HollowFangsIM : IMutationPerkType = new HollowFangsMutation();
    public static var HumanAdrenalGlandsIM : IMutationPerkType = new HumanAdrenalGlandsMutation();
    public static var HumanBloodstreamIM : IMutationPerkType = new HumanBloodstreamMutation();
    public static var HumanBonesIM : IMutationPerkType = new HumanBonesMutation();
    public static var HumanDigestiveTractIM : IMutationPerkType = new HumanDigestiveTractMutation();
    public static var HumanEyesIM : IMutationPerkType = new HumanEyesMutation();
    public static var HumanFatIM : IMutationPerkType = new HumanFatMutation();
    public static var HumanMetabolismIM : IMutationPerkType = new HumanMetabolismMutation();
    public static var HumanMusculatureIM : IMutationPerkType = new HumanMusculatureMutation();
    public static var HumanOvariesIM : IMutationPerkType = new HumanOvariesMutation();
    public static var HumanParathyroidGlandIM : IMutationPerkType = new HumanParathyroidGlandMutation();
    public static var HumanSmartsIM : IMutationPerkType = new HumanSmartsMutation();
    public static var HumanTesticlesIM : IMutationPerkType = new HumanTesticlesMutation();
    public static var HumanThyroidGlandIM : IMutationPerkType = new HumanThyroidGlandMutation();
    public static var HumanVersatilityIM : IMutationPerkType = new HumanVersatilityMutation();
    public static var HydraBloodIM : IMutationPerkType = new HydraBloodMutation();
    public static var KitsuneParathyroidGlandsIM : IMutationPerkType = new KitsuneParathyroidGlandMutation();
    public static var KitsuneThyroidGlandIM : IMutationPerkType = new KitsuneThyroidGlandMutation();
    public static var LactaBovinaOvariesIM : IMutationPerkType = new LactaBovinaOvariesMutation();
    public static var LizanMarrowIM : IMutationPerkType = new LizanMarrowMutation();
    public static var ManticoreMetabolismIM : IMutationPerkType = new ManticoreMetabolismMutation();
    public static var MantislikeAgilityIM : IMutationPerkType = new MantislikeAgilityMutation();
    public static var MelkieLungIM : IMutationPerkType = new MelkieLungMutation();
    public static var MightyLegsIM : IMutationPerkType = new MightyLegsMutation();
    public static var MightyLowerHalfIM : IMutationPerkType = new MightyLowerHalfMutation();
    public static var MinotaurTesticlesIM : IMutationPerkType = new MinotaurTesticlesMutation();
    public static var NaturalPunchingBagIM : IMutationPerkType = new NaturalPunchingBagMutation();
    public static var NukiNutsIM : IMutationPerkType = new NukiNutsMutation();
    public static var ObsidianHeartIM : IMutationPerkType = new ObsidianHeartMutation();
    public static var OniMusculatureIM : IMutationPerkType = new OniMusculatureMutation();
    public static var OrcAdrenalGlandsIM : IMutationPerkType = new OrcAdrenalGlandsMutation();
    public static var PigBoarFatIM : IMutationPerkType = new PigBoarFatMutation();
    public static var PoisonGlandIM : IMutationPerkType = new PoisonGlandMutation();
    public static var RaijuCathodeIM : IMutationPerkType = new RaijuCathodeMutation();
    public static var RatatoskrSmartsIM : IMutationPerkType = new RatatoskrSmartsMutation();
    public static var SalamanderAdrenalGlandsIM : IMutationPerkType = new SalamanderAdrenalGlandsMutation();
    public static var ScyllaInkGlandsIM : IMutationPerkType = new ScyllaInkGlandsMutation();
    public static var SharkOlfactorySystemIM : IMutationPerkType = new SharkOlfactorySystemMutation();
    public static var SlimeFluidIM : IMutationPerkType = new SlimeFluidMutation();
    public static var SlimeMetabolismIM : IMutationPerkType = new SlimeMetabolismMutation();
    public static var TrachealSystemIM : IMutationPerkType = new TrachealSystemMutation();
    public static var TwinHeartIM : IMutationPerkType = new TwinHeartMutation();
    public static var VampiricBloodstreamIM : IMutationPerkType = new VampiricBloodstreamMutation();
    public static var VenomGlandsIM : IMutationPerkType = new VenomGlandsMutation();
    public static var WhaleFatIM : IMutationPerkType = new WhaleFatMutation();
    public static var WhiteFacedOneBirthrightIM : IMutationPerkType = new WhiteFacedOneBirthrightMutation();
    public static var YetiFatIM : IMutationPerkType = new YetiFatMutation();
    
    /**
		 * Returns an array of arrays of mutation body parts in PerkType type.
		 * Can be specified to specific parts with the first argument.
		 * Must update here with an extra push to all mutations points.
		 * This feeds the Perks/Mutations DB and Evangeline's Mutations information.
		 * @param spec any of the IMutationPerkType.SLOT_XXX constants, "" for all obtainable mutations, "All" for all mutations including deprecated
		 * @return IMutationPerkType[]
		 */
    public static function mutationsArray(spec : String = "") : Array<Dynamic>
    {
        var list : Array<Dynamic> = [];
        if (spec != null && Lambda.has(IMutationPerkType.MutationsBySlot, spec))
        {
            list = IMutationPerkType.MutationsBySlot[spec].slice();
        }
        else
        {
            for (slot in Reflect.fields(IMutationPerkType.MutationsBySlot))
            {
                if (slot == "" && spec != "All")
                {
                    continue;
                }
                list = list.concat(IMutationPerkType.MutationsBySlot[slot]);
            }
        }
        return list;
    }

    public function new()
    {
    }
}
