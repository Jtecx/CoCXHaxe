package classes.scenes.combat;

import classes.scenes.combat.spellsBlack.*;
import classes.scenes.combat.spellsGreen.*;
import classes.scenes.combat.spellsWhite.*;
import classes.scenes.combat.spellsHex.*;
import classes.scenes.combat.spellsDivine.*;
import classes.scenes.combat.spellsNecro.*;
import classes.scenes.combat.spellsGrey.*;
import classes.scenes.combat.spellsBlood.*;
import classes.scenes.combat.soulskills.*;
import classes.scenes.combat.specialsMagic.*;
import classes.scenes.combat.general.*;

class CombatAbilities
{
    
    public static var FlyingSwordAttack : FlyingSwordSkill = new FlyingSwordSkill();
    public static var WillOfTheWisp : WillOfTheWispSkill = new WillOfTheWispSkill();
    public static var MummyAttack : MummyAttackSkill = new MummyAttackSkill();
    public static var Tease : TeaseSkill = new TeaseSkill();
    public static var GoblinLustBomb : GoblinLustBombSkill = new GoblinLustBombSkill();
    public static var ALL_GENERAL_SKILLS : Array<Dynamic> = [
        FlyingSwordAttack, 
        WillOfTheWisp, 
        MummyAttack, 
        Tease, 
        GoblinLustBomb
    ];
    
    public static var Whitefire : WhitefireSpell = new WhitefireSpell();
    public static var WhitefireEx : WhitefireSpell = new WhitefireSpell(true);
    public static var PyreBurst : PyreBurstSpell = new PyreBurstSpell();
    public static var PyreBurstEx : PyreBurstSpell = new PyreBurstSpell(true);
    public static var LightningBolt : LightningBoltSpell = new LightningBoltSpell();
    public static var LightningBoltEx : LightningBoltSpell = new LightningBoltSpell(true);
    public static var ChainLightning : ChainLightningSpell = new ChainLightningSpell();
    public static var ChainLightningEx : ChainLightningSpell = new ChainLightningSpell(true);
    public static var Blind : BlindSpell = new BlindSpell();
    public static var ChargeWeapon : ChargeWeaponSpell = new ChargeWeaponSpell();
    public static var ChargeRWeapon : ChargeRangeWeaponSpell = new ChargeRangeWeaponSpell();
    public static var ChargeArmor : ChargeArmorSpell = new ChargeArmorSpell();
    public static var Heal : HealSpell = new HealSpell();
    public static var Blizzard : BlizzardSpell = new BlizzardSpell();
    public static var MentalShield : MentalShieldSpell = new MentalShieldSpell();
    public static var Cure : CureSpell = new CureSpell();
    public static var FireStorm : FireStormSpell = new FireStormSpell();
    public static var MeteorShower : MeteorShowerSpell = new MeteorShowerSpell();
    public static var WhitefireSwiftcast : WhitefireSwiftcastSpell = new WhitefireSwiftcastSpell();
    public static var LightningBoltSwiftcast : LightningBoltSwiftcastSpell = new LightningBoltSwiftcastSpell();
    public static var ALL_WHITE_SPELLS : Array<Dynamic> = [
        Whitefire, 
        WhitefireEx, 
        PyreBurst, 
        PyreBurstEx, 
        LightningBolt, 
        LightningBoltEx, 
        ChainLightning, 
        ChainLightningEx, 
        Blind, 
        ChargeWeapon, 
        ChargeRWeapon, 
        ChargeArmor, 
        Heal, 
        Blizzard, 
        MentalShield, 
        Cure, 
        FireStorm, 
        MeteorShower, 
        WhitefireSwiftcast, 
        LightningBoltSwiftcast
    ];
    
    public static var IceSpike : IceSpikeSpell = new IceSpikeSpell();
    public static var IceSpikeEx : IceSpikeSpell = new IceSpikeSpell(true);
    public static var ArcticGale : ArcticGaleSpell = new ArcticGaleSpell();
    public static var ArcticGaleEx : ArcticGaleSpell = new ArcticGaleSpell(true);
    public static var DarknessShard : DarknessShardSpell = new DarknessShardSpell();
    public static var DarknessShardEx : DarknessShardSpell = new DarknessShardSpell(true);
    public static var DuskWave : DuskWaveSpell = new DuskWaveSpell();
    public static var DuskWaveEx : DuskWaveSpell = new DuskWaveSpell(true);
    public static var Arouse : ArouseSpell = new ArouseSpell();
    public static var WaveOfEcstasy : WaveOfEcstasySpell = new WaveOfEcstasySpell();
    public static var Might : MightSpell = new MightSpell();
    public static var Blink : BlinkSpell = new BlinkSpell();
    public static var Regenerate : RegenerateSpell = new RegenerateSpell();
    public static var IceRain : IceRainSpell = new IceRainSpell();
    public static var Nosferatu : NosferatuSpell = new NosferatuSpell();
    public static var PolarMidnight : PolarMidnightSpell = new PolarMidnightSpell();
    public static var IceSpikeSwiftcast : IceSpikeSwiftcastSpell = new IceSpikeSwiftcastSpell();
    public static var DarknessShardSwiftcast : DarknessShardSwiftcastSpell = new DarknessShardSwiftcastSpell();
    public static var ALL_BLACK_SPELLS : Array<Dynamic> = [
        IceSpike, 
        IceSpikeEx, 
        ArcticGale, 
        ArcticGaleEx, 
        DarknessShard, 
        DarknessShardEx, 
        DuskWave, 
        DuskWaveEx, 
        Arouse, 
        WaveOfEcstasy, 
        Might, 
        Blink, 
        Regenerate, 
        IceRain, 
        Nosferatu, 
        PolarMidnight, 
        IceSpikeSwiftcast, 
        DarknessShardSwiftcast
    ];
    
    public static var Lifetap : LifetapSpell = new LifetapSpell();
    public static var LifeSiphon : LifeSiphonSpell = new LifeSiphonSpell();
    public static var ConsumingDarkness : ConsumingDarknessSpell = new ConsumingDarknessSpell();
    public static var CurseOfDesire : CurseOfDesireSpell = new CurseOfDesireSpell();
    public static var CurseOfWeeping : CurseOfWeepingSpell = new CurseOfWeepingSpell();
    
    public static var ALL_HEX_SPELLS : Array<Dynamic> = [
        Lifetap, 
        LifeSiphon, 
        ConsumingDarkness, 
        CurseOfDesire, 
        CurseOfWeeping
    ];
    
    public static var Aegis : AegisSpell = new AegisSpell();
    public static var Exorcise : ExorciseSpell = new ExorciseSpell();
    public static var DivineShield : DivineShieldSpell = new DivineShieldSpell();
    public static var Thunderstorm : ThunderstormSpell = new ThunderstormSpell();
    public static var TearsOfDenial : TearsOfDenialSpell = new TearsOfDenialSpell();
    
    public static var ALL_DIVINE_SPELLS : Array<Dynamic> = [
        Aegis, 
        Exorcise, 
        DivineShield, 
        Thunderstorm, 
        TearsOfDenial
    ];
    
    public static var BoneSpirit : BoneSpiritSpell = new BoneSpiritSpell();
    public static var BoneArmor : BoneArmorSpell = new BoneArmorSpell();
    public static var Boneshatter : BoneshatterSpell = new BoneshatterSpell();
    public static var NecroticRot : NecroticRotSpell = new NecroticRotSpell();
    public static var CorpseExplosion : CorpseExplosionSpell = new CorpseExplosionSpell();
    public static var BloodShower : BloodShowerSpell = new BloodShowerSpell();
    
    public static var ALL_NECRO_SPELLS : Array<Dynamic> = [
        BoneSpirit, 
        BoneArmor, 
        Boneshatter, 
        NecroticRot, 
        CorpseExplosion, 
        BloodShower
    ];
    
    public static var ManaShield : ManaShieldSpell = new ManaShieldSpell();
    public static var EnergyDrain : EnergyDrainSpell = new EnergyDrainSpell();
    public static var Restore : RestoreSpell = new RestoreSpell();
    public static var BalanceOfLife : BalanceOfLifeSpell = new BalanceOfLifeSpell();
    public static var ClearMind : ClearMindSpell = new ClearMindSpell();
    public static var WaterSphere : WaterSphereSpell = new WaterSphereSpell();
    public static var WaterSphereEx : WaterSphereSpell = new WaterSphereSpell(true);
    public static var WaterBall : WaterBallSpell = new WaterBallSpell();
    public static var WaterBallEx : WaterBallSpell = new WaterBallSpell(true);
    public static var WindBullet : WindBulletSpell = new WindBulletSpell();
    public static var WindBulletEx : WindBulletSpell = new WindBulletSpell(true);
    public static var WindBlast : WindBlastSpell = new WindBlastSpell();
    public static var WindBlastEx : WindBlastSpell = new WindBlastSpell(true);
    public static var Stalagmite : StalagmiteSpell = new StalagmiteSpell();
    public static var StalagmiteEx : StalagmiteSpell = new StalagmiteSpell(true);
    public static var Shatterstone : ShatterstoneSpell = new ShatterstoneSpell();
    public static var ShatterstoneEx : ShatterstoneSpell = new ShatterstoneSpell(true);
    public static var AcidSpray : AcidSpraySpell = new AcidSpraySpell();
    public static var AcidSprayEx : AcidSpraySpell = new AcidSpraySpell(true);
    public static var CorrosiveWave : CorrosiveWaveSpell = new CorrosiveWaveSpell();
    public static var CorrosiveWaveEx : CorrosiveWaveSpell = new CorrosiveWaveSpell(true);
    public static var HydroAcid : HydroAcidSpell = new HydroAcidSpell();
    public static var AcidRain : AcidRainSpell = new AcidRainSpell();
    public static var WaterBallSwiftcast : WaterBallSwiftcastSpell = new WaterBallSwiftcastSpell();
    public static var WindBulletSwiftcast : WindBulletSwiftcastSpell = new WindBulletSwiftcastSpell();
    public static var StalagmiteSwiftcast : StalagmiteSwiftcastSpell = new StalagmiteSwiftcastSpell();
    public static var AcidSpraySwiftcast : AcidSpraySwiftcastSpell = new AcidSpraySwiftcastSpell();
    //	if (player.hasStatusEffect(StatusEffects.KnowsWereBeast)) buttons.add("Were-beast",	were-beast spell goes here
    
    public static var ALL_GREY_SPELLS : Array<Dynamic> = [
        ManaShield, 
        EnergyDrain, 
        Restore, 
        BalanceOfLife, 
        ClearMind, 
        WaterSphere, 
        WaterSphereEx, 
        WaterBall, 
        WaterBallEx, 
        WindBullet, 
        WindBulletEx, 
        WindBlast, 
        WindBlastEx, 
        Stalagmite, 
        StalagmiteEx, 
        Shatterstone, 
        ShatterstoneEx, 
        AcidSpray, 
        AcidSprayEx, 
        CorrosiveWave, 
        CorrosiveWaveEx, 
        HydroAcid, 
        AcidRain, 
        WaterBallSwiftcast, 
        WindBulletSwiftcast, 
        StalagmiteSwiftcast, 
        AcidSpraySwiftcast
    ];
    
    public static var BloodMissiles : BloodMissilesSpell = new BloodMissilesSpell();
    public static var BloodShield : BloodShieldSpell = new BloodShieldSpell();
    public static var BloodExplosion : BloodExplosionSpell = new BloodExplosionSpell();
    public static var BloodChains : BloodChainsSpell = new BloodChainsSpell();
    public static var BloodWave : BloodWaveSpell = new BloodWaveSpell();
    public static var LifestealEnchantment : LifestealEnchantmentSpell = new LifestealEnchantmentSpell();
    public static var BloodField : BloodFieldSpell = new BloodFieldSpell();
    
    public static var ALL_BLOOD_SPELLS : Array<Dynamic> = [
        BloodMissiles, 
        BloodShield, 
        BloodExplosion, 
        BloodChains, 
        BloodWave, 
        LifestealEnchantment, 
        BloodField
    ];
    
    public static var PlantGrowth : PlantGrowthSpell = new PlantGrowthSpell();
    public static var PlantBloom : PlantBloomSpell = new PlantBloomSpell();
    public static var Entangle : EntangleSpell = new EntangleSpell();
    public static var Briarthorn : BriarthornSpell = new BriarthornSpell();
    public static var DeathBlossom : DeathBlossomSpell = new DeathBlossomSpell();
    
    public static var ALL_GREEN_SPELLS : Array<Dynamic> = [
        PlantGrowth, 
        PlantBloom, 
        Entangle, 
        Briarthorn, 
        DeathBlossom
    ];
    
    public static var ALL_SPELLS : Array<Dynamic> = [].concat(ALL_WHITE_SPELLS).concat(ALL_BLACK_SPELLS).concat(ALL_HEX_SPELLS).concat(ALL_DIVINE_SPELLS).concat(ALL_NECRO_SPELLS).concat(ALL_GREY_SPELLS).concat(ALL_BLOOD_SPELLS).concat(ALL_GREEN_SPELLS);
    
    public static var CleansingPalm : CleansingPalmSkill = new CleansingPalmSkill();
    public static var IceFist : IceFistSkill = new IceFistSkill();
    public static var FirePunch : FirePunchSkill = new FirePunchSkill();
    public static var HurricaneDance : HurricaneDanceSkill = new HurricaneDanceSkill();
    public static var EarthStance : EarthStanceSkill = new EarthStanceSkill();
    public static var PunishingKick : PunishingKickSkill = new PunishingKickSkill();
    public static var SoulBlast : SoulBlastSkill = new SoulBlastSkill();
    public static var Overlimit : OverlimitSkill = new OverlimitSkill();
    public static var TripleThrust : MultiThrustSkill = new MultiThrustSkill(1);
    public static var SextupleThrust : MultiThrustSkill = new MultiThrustSkill(2);
    public static var NonupleThrust : MultiThrustSkill = new MultiThrustSkill(3);
    public static var DracoSweep : DracoSweepSkill = new DracoSweepSkill();
    public static var FlamesOfLove : FlamesOfLoveSkill = new FlamesOfLoveSkill();
    public static var IciclesOfLove : IciclesOfLoveSkill = new IciclesOfLoveSkill();
    public static var StormOfSisterhood : StormOfSisterhoodSkill = new StormOfSisterhoodSkill();
    public static var NightOfBrotherhood : NightOfBrotherhoodSkill = new NightOfBrotherhoodSkill();
    public static var Devourer : DevourerSkill = new DevourerSkill();
    public static var ManyBirds : ManyBirdsSkill = new ManyBirdsSkill();
    public static var ResonanceVolley : ResonanceVolleySkill = new ResonanceVolleySkill();
    public static var AvatarOfTheSong : AvatarOfTheSongSkill = new AvatarOfTheSongSkill();
    public static var BeatOfWar : BeatOfWarSkill = new BeatOfWarSkill();
    public static var Comet : CometSkill = new CometSkill();
    public static var BladeDance : BladeDanceSkill = new BladeDanceSkill();
    public static var HailOfBlades : BladeHailSkill = new BladeHailSkill(1);
    public static var GrandioseHailOfBlades : BladeHailSkill = new BladeHailSkill(2);
    public static var GrandioseHailOfMoonBlades : BladeHailSkill = new BladeHailSkill(3);
    public static var ElementAir : CreateElementSkill = new CreateElementSkill("Air", 1);
    public static var ElementEarth : CreateElementSkill = new CreateElementSkill("Earth", 1);
    public static var ElementFire : CreateElementSkill = new CreateElementSkill("Fire", 1);
    public static var ElementWater : CreateElementSkill = new CreateElementSkill("Water", 1);
    public static var ElementIce : CreateElementSkill = new CreateElementSkill("Ice", 2);
    public static var ElementLightning : CreateElementSkill = new CreateElementSkill("Lightning", 2);
    public static var ElementDarkness : CreateElementSkill = new CreateElementSkill("Darkness", 2);
    public static var Sunrise : SunriseSkill = new SunriseSkill();
    public static var SoulDrain : SoulDrainSkill = new SoulDrainSkill();
    public static var Trance : TranceSkill = new TranceSkill();
    public static var VioletPupilTransformation : VioletPupilTransformationSkill = new VioletPupilTransformationSkill();
    public static var FingerOfDeath : FingerOfDeathSkill = new FingerOfDeathSkill();
    public static var BloodSwipe : BloodSwipeSkill = new BloodSwipeSkill();
    public static var BloodSwipeSF : BloodSwipeSkill = new BloodSwipeSkill(true);
    public static var BloodDewdrops : BloodDewdropsSkill = new BloodDewdropsSkill();
    public static var BloodDewdropsSF : BloodDewdropsSkill = new BloodDewdropsSkill(true);
    public static var HeartSeeker : HeartSeekerSkill = new HeartSeekerSkill();
    public static var HeartSeekerSF : HeartSeekerSkill = new HeartSeekerSkill(true);
    public static var BloodRequiem : BloodReqiuemSkill = new BloodReqiuemSkill();
    public static var BloodRequiemSF : BloodReqiuemSkill = new BloodReqiuemSkill(true);
    public static var ScarletSpiritCharge : ScarletSpiritChargeSkill = new ScarletSpiritChargeSkill();
    public static var KillingIntent : KillingIntentSkill = new KillingIntentSkill();
    
    
    
    public static var ALL_SOULSKILLS : Array<Dynamic> = [
        CleansingPalm, 
        IceFist, 
        FirePunch, 
        HurricaneDance, 
        EarthStance, 
        PunishingKick, 
        SoulBlast, 
        Overlimit, 
        TripleThrust, 
        SextupleThrust, 
        NonupleThrust, 
        DracoSweep, 
        FlamesOfLove, 
        IciclesOfLove, 
        StormOfSisterhood, 
        NightOfBrotherhood, 
        Devourer, 
        ManyBirds, 
        ResonanceVolley, 
        AvatarOfTheSong, 
        BeatOfWar, 
        Comet, 
        BladeDance, 
        HailOfBlades, 
        GrandioseHailOfBlades, 
        GrandioseHailOfMoonBlades, 
        ElementAir, 
        ElementDarkness, 
        ElementEarth, 
        ElementFire, 
        ElementIce, 
        ElementLightning, 
        ElementWater, 
        Sunrise, 
        SoulDrain, 
        Trance, 
        VioletPupilTransformation, 
        FingerOfDeath, 
        BloodSwipe, 
        BloodSwipeSF, 
        BloodDewdrops, 
        BloodDewdropsSF, 
        HeartSeeker, 
        HeartSeekerSF, 
        BloodRequiem, 
        BloodRequiemSF, 
        ScarletSpiritCharge, 
        KillingIntent
    ];
    
    public static var BPBloodSwipe : BloodSwipePuppiesSkill = new BloodSwipePuppiesSkill();
    public static var BPBloodDewdrops : BloodDewdropsPuppiesSkill = new BloodDewdropsPuppiesSkill();
    public static var BPHeartSeeker : HeartSeekerPuppiesSkill = new HeartSeekerPuppiesSkill();
    
    public static var ALL_BLOOD_PUPPY_SOULSKILLS : Array<Dynamic> = [
        BPBloodSwipe, 
        BPBloodDewdrops, 
        BPHeartSeeker
    ];
    
    public static var EAspectFire : EAspectFireSkill = new EAspectFireSkill();
    public static var EAspectAir : EAspectAirSkill = new EAspectAirSkill();
    public static var EAspectEarth : EAspectEarthSkill = new EAspectEarthSkill();
    public static var EAspectWater : EAspectWaterSkill = new EAspectWaterSkill();
    public static var EAspectEther : EAspectEtherSkill = new EAspectEtherSkill();
    public static var EAspectWood : EAspectWoodSkill = new EAspectWoodSkill();
    public static var EAspectMetal : EAspectMetalSkill = new EAspectMetalSkill();
    public static var EAspectIce : EAspectIceSkill = new EAspectIceSkill();
    public static var EAspectLightning : EAspectLightningSkill = new EAspectLightningSkill();
    public static var EAspectDarkness : EAspectDarknessSkill = new EAspectDarknessSkill();
    public static var EAspectPoison : EAspectPoisonSkill = new EAspectPoisonSkill();
    public static var EAspectPurity : EAspectPuritySkill = new EAspectPuritySkill();
    public static var EAspectCorruption : EAspectCorruptionSkill = new EAspectCorruptionSkill();
    
    public static var ALL_ELEMENTAL_ASPECTS : Array<Dynamic> = [
        EAspectFire, 
        EAspectAir, 
        EAspectEarth, 
        EAspectWater, 
        EAspectEther, 
        EAspectWood, 
        EAspectMetal, 
        EAspectIce, 
        EAspectLightning, 
        EAspectDarkness, 
        EAspectPoison, 
        EAspectPurity, 
        EAspectCorruption
    ];
    
    public static var FusionSpecial1st : FusionSpecial1stSkill = new FusionSpecial1stSkill();
    public static var FusionSpecial2nd : FusionSpecial2ndSkill = new FusionSpecial2ndSkill();
    public static var TrueEvasion : FusionSpecialTrueEvasionSkill = new FusionSpecialTrueEvasionSkill();
    public static var AdamantineShell : FusionSpecialAdamantineShellSkill = new FusionSpecialAdamantineShellSkill();
    public static var FieryRage : FusionSpecialFieryRageSkill = new FusionSpecialFieryRageSkill();
    public static var MomentofClarity : FusionSpecialMomentofClaritySkill = new FusionSpecialMomentofClaritySkill();
    public static var FusionSpecial4th : FusionSpecial4thSkill = new FusionSpecial4thSkill();
    public static var FusionSpecial5th : FusionSpecial5thSkill = new FusionSpecial5thSkill();
    
    
    public static var ALL_ELEMENTAL_FUSION_ATTACKS : Array<Dynamic> = [
        FusionSpecial1st, 
        FusionSpecial2nd, 
        TrueEvasion, 
        AdamantineShell, 
        MomentofClarity, 
        FusionSpecial4th, 
        FusionSpecial5th
    ];
    
    public static var ALL_MAGICAL_SPECIALS : Array<Dynamic> = [].concat(ALL_ELEMENTAL_FUSION_ATTACKS);
    
    
    /*
	 * Difference from CombatAbility.Registry:
	 * These arrays are for player menu construction. They can skip or re-order abilities.
	 * CombatAbility.Registry is internal and must have *ALL* abilities.
	 */
    public static var ALL : Array<Dynamic> = [].concat(ALL_SPELLS).concat(ALL_SOULSKILLS).concat(ALL_MAGICAL_SPECIALS).concat(ALL_ELEMENTAL_ASPECTS).concat(ALL_BLOOD_PUPPY_SOULSKILLS).concat(ALL_GENERAL_SKILLS);
    
    private function new()
    {
    }
}
