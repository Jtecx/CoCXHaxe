package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.geneticMemories.RaceMem;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

class ElfRace extends Race
{
    public static var ElfHairColors : Array<Dynamic> = ["black", "leaf green", "golden blonde", "silver"];
    public static var ElfSkinColors : Array<Dynamic> = ["dark", "light", "tan", "olive"];
    public static var RaceBody : Array<Dynamic> = [
        /*Antenna*/"Human", 
        /*Arms*/"Elf", 
        /*Balls*/"Human", 
        /*Breasts*/"Human", 
        /*Nips*/"Human", 
        /*Ears*/"Elven", 
        /*Eyes*/"Elf", 
        /*Face*/"Elf", 
        /*Gills*/"None", 
        /*Hair*/"Elf", 
        /*Horns*/"Human", 
        /*LowerBody*/"Elf", 
        /*RearBody*/"Human", 
        /*Skin*/"Elf", 
        /*Ovipositor*/"Human", 
        /*Oviposition*/"Human", 
        /*GlowingAss*/"Human", 
        /*Tail*/"Human", 
        /*Tongue*/"Elf", 
        /*Wings*/"Human", 
        /*Penis*/"Human", 
        /*Vagina*/"Human", 
        /*Perks*/"Elf"
    ];
    
    public function new(id : Int)
    {
        super("Elf", id, RaceBody);
    }
    
    override public function setup() : Void
    {
        addScores().earType(Ears.ELVEN, +1).eyeType(Eyes.ELF, +1).faceType(Face.ELF, +1).tongueType(Tongue.ELF, +1).armType(Arms.ELF, +1).legType(LowerBody.ELF, +1).hairType(Hair.SILKEN, +1).hairColor1(cast((ElfHairColors), ANY), +1).skinColor1(cast((ElfSkinColors), ANY), +1).noWings(+1).tone(cast((60), AT_MOST), +1).thickness(cast((50), AT_MOST), +1).plainSkinOfAdj("flawless", +1).hasPerk(PerkLib.FlawlessBody, +1).hasPerk(PerkLib.ElvenSense, +1).hasPerk(PerkLib.NaturalSpellcasting, +1).customRequirement("", "small cock", 
                                function(body : BodyData) : Bool
                                {
                                    return body.hasCock && body.biggestCockSize < 6;
                                }, +1
                ).customRequirement("", "vagina and big tits", 
                        function(body : BodyData) : Bool
                        {
                            return body.hasVagina && body.biggestTitSize >= 3;
                        }, +1
            ).customRequirement("", "not a wood elf", 
                function(body : BodyData) : Bool
                {
                    return !body.player.hasPerk(PerkLib.BlessingOfTheAncestorTree);
                }, 0, -1000
        );
        
        addBloodline(PerkLib.ElfsDescendant, PerkLib.BloodlineElf);
        addMutation(IMutationsLib.ElvishPeripheralNervSysIM);
        
        buildTier(11, "elf").namesTauric("elf", "elf-taur").require("elf ears", function(body : BodyData) : Bool
                                {
                                    return body.earType == Ears.ELVEN;
                                }).buffs({
                            str.mult : -0.10,
                            tou.mult : -0.15,
                            spe.mult : +0.80,
                            int.mult : +0.80,
                            wis.mult : +0.60,
                            maxmana_mult : +0.2,
                            sens : +30
                        }).end();
        buildTier(17, "high elf").namesTauric("high elf", "high elf-taur").requirePreviousTier().buffs({
                            str.mult : -0.20,
                            tou.mult : -0.30,
                            spe.mult : +1.60,
                            int.mult : +1.60,
                            wis.mult : +1.20,
                            maxmana_mult : +0.4,
                            sens : +60
                        }).end();
    }
}

