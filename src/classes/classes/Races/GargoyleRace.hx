package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.PerkLib;
import classes.Race;
import classes.scenes.nPCs.Forgefather;

class GargoyleRace extends Race
{
    public static var GargoyleHairColors : Array<Dynamic> = ["light gray", "quartz white", "gray", "dark gray", "black", "caramel"];
    public static var GargoyleSkinColors : Array<Dynamic> = ["light gray", "quartz white", "gray", "dark gray", "black", "caramel"];
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
        super("Gargoyle", id, []);
    }
    
    override public function setup() : Void
    // custom name to avoid "gargoyle or gargoyle arms" phrase
    {
        addScores().hairColor1(cast((GargoyleHairColors), ANY), +1).skinColor1(cast((GargoyleSkinColors), ANY), +1).hairType(Hair.NORMAL, +1).skinBaseType(Skin.STONE, +1).hornType(Horns.GARGOYLE, +1).eyeType(Eyes.GEMSTONES, +1).earType(Ears.ELFIN, +1).faceType(Face.DEVIL_FANGS, +1).tongueType(Tongue.DEMONIC, +1).armType(ANY(Arms.GARGOYLE, Arms.GARGOYLE_2), +1, 0, "gargoyle arms").tailType(ANY(Tail.GARGOYLE, Tail.GARGOYLE_2), +1).legType(ANY(LowerBody.GARGOYLE, LowerBody.GARGOYLE_2), +1).wingType(ANY(Wings.GARGOYLE_LIKE_LARGE, Wings.FEATHERED_LARGE), +4).noGills(+1).noRearBody(+1).noAntennae(+1).hasAnyPerk([PerkLib.GargoylePure, PerkLib.GargoyleCorrupted], +1).hasPerk(PerkLib.TransformationImmunity, +5);
        
        buildTier(22, "gargoyle").customNamingFunction(
                                function(body : BodyData) : String
                                {
                                    if (body.player.hasPerk(PerkLib.GargoylePure))
                                    {
                                        return "pure gargoyle";
                                    }
                                    else if (body.player.hasPerk(PerkLib.GargoyleCorrupted))
                                    {
                                        return "corrupted gargoyle";
                                    }
                                    else
                                    {
                                        return "gargoyle"  // to display the tier name in race db  ;
                                    }
                                }
                ).withDynamicBuffs("Material-dependent bonuses", calcBuffs).end();
    }
    
    private function calcBuffs(body : BodyData) : Dynamic
    {
        var strBuff : Int = 0;
        var touBuff : Int = 0;
        var speBuff : Int = 0;
        var intBuff : Int = 0;
        var wisBuff : Int = 0;
        var libBuff : Int = 0;
        var sensBuff : Int = 0;
        var _sw0_ = (Forgefather.material);        

        switch (_sw0_)
        {
            case "stone":
                var _sw1_ = (Forgefather.refinement);                

                switch (_sw1_)
                {
                    case 0:
                        strBuff += 50;
                        touBuff += 50;
                        speBuff += 50;
                        intBuff += 50;
                        wisBuff += 50;
                        libBuff += 50;
                    case 1:
                        strBuff += 75;
                        touBuff += 75;
                        speBuff += 75;
                        intBuff += 75;
                        wisBuff += 75;
                        libBuff += 75;
                    case 2:
                        strBuff += 100;
                        touBuff += 100;
                        speBuff += 100;
                        intBuff += 100;
                        wisBuff += 100;
                        libBuff += 100;
                }
            case "alabaster":
            //Alabaster - Magic (Int+100%, +20% max mana, +15% spell dmg)
            var _sw2_ = (Forgefather.refinement);            

            switch (_sw2_)
            {
                case 0:
                    intBuff += 100;
                    wisBuff += 50;
                    strBuff -= 10;
                    touBuff -= 10;
                case 1:
                    intBuff += 150;
                    wisBuff += 75;
                    strBuff -= 15;
                    touBuff -= 15;
                case 2:
                    intBuff += 200;
                    wisBuff += 100;
                    strBuff -= 20;
                    touBuff -= 20;
                case 3:
                    intBuff += 200;
                    wisBuff += 100;
                    strBuff -= 20;
                    touBuff -= 20;
                case 4:
                    intBuff += 500;
                    wisBuff += 250;
                    strBuff -= 30;
                    touBuff -= 30;
            }
            case "marble":
                var _sw3_ = (Forgefather.refinement);                

                switch (_sw3_)
                {
                    case 0:
                        wisBuff += 100;
                        strBuff += 50;
                        intBuff -= 10;
                    case 1:
                        wisBuff += 150;
                        strBuff += 75;
                        intBuff -= 15;
                    case 2:
                        wisBuff += 200;
                        strBuff += 100;
                        intBuff -= 20;
                    case 3:
                        wisBuff += 200;
                        strBuff += 100;
                        intBuff -= 20;
                    case 4:
                        wisBuff += 500;
                        strBuff += 200;
                        intBuff -= 30;
                }
            case "granite":
                var _sw4_ = (Forgefather.refinement);                

                switch (_sw4_)
                {
                    case 0:
                        touBuff += 100;
                        strBuff += 50;
                        intBuff -= 10;
                        wisBuff -= 10;
                    case 1:
                        touBuff += 150;
                        strBuff += 75;
                        intBuff -= 15;
                        wisBuff -= 15;
                    case 2:
                        touBuff += 200;
                        strBuff += 100;
                        intBuff -= 20;
                        wisBuff -= 20;
                    case 3:
                        touBuff += 200;
                        strBuff += 100;
                        intBuff -= 20;
                        wisBuff -= 20;
                    case 4:
                        touBuff += 500;
                        strBuff += 250;
                        intBuff -= 30;
                        wisBuff -= 30;
                }
            case "ebony":
                var _sw5_ = (Forgefather.refinement);                

                switch (_sw5_)
                {
                    case 0:
                        strBuff += 100;
                        speBuff += 50;
                        intBuff -= 10;
                        wisBuff -= 10;
                    case 1:
                        strBuff += 150;
                        speBuff += 75;
                        intBuff -= 15;
                        wisBuff -= 15;
                    case 2:
                        strBuff += 200;
                        speBuff += 100;
                        intBuff -= 20;
                        wisBuff -= 20;
                    case 3:
                        strBuff += 200;
                        speBuff += 100;
                        intBuff -= 20;
                        wisBuff -= 20;
                    case 4:
                        strBuff += 500;
                        speBuff += 250;
                        intBuff -= 30;
                        wisBuff -= 30;
                }
            case "sandstone":
                var _sw6_ = (Forgefather.refinement);                

                switch (_sw6_)
                {
                    case 0:
                        speBuff += 100;
                        strBuff += 25;
                        intBuff += 25;
                        wisBuff -= 10;
                    case 1:
                        speBuff += 150;
                        strBuff += 35;
                        intBuff += 35;
                        wisBuff -= 15;
                    case 2:
                        speBuff += 200;
                        strBuff += 50;
                        intBuff += 50;
                        wisBuff -= 20;
                    case 3:
                        speBuff += 200;
                        strBuff += 50;
                        intBuff += 50;
                        wisBuff -= 20;
                    case 4:
                        speBuff += 500;
                        strBuff += 125;
                        intBuff += 125;
                        wisBuff -= 30;
                }
        }
        if (body.player.hasPerk(PerkLib.GargoylePure))
        {
            wisBuff += 130;
            libBuff -= 20;
            sensBuff -= 10;
        }
        if (body.player.hasPerk(PerkLib.GargoyleCorrupted))
        {
            wisBuff -= 20;
            libBuff += 140;
        }
        var _sw7_ = (Forgefather.channelInlay);        

        switch (_sw7_)
        {
            case "emerald":
                if (Forgefather.refinement == 4)
                {
                    speBuff += 100;
                }
                else if (Forgefather.refinement == 3)
                {
                    speBuff += 50;
                }
        }
        var _sw8_ = (Forgefather.gem);        

        switch (_sw8_)
        {
            case "emerald":
                if (Forgefather.refinement == 4)
                {
                    speBuff += 50;
                }
                else if (Forgefather.refinement == 3)
                {
                    speBuff += 25;
                }
        }
        return {
            str.mult : strBuff / 100,
            tou.mult : touBuff / 100,
            spe.mult : speBuff / 100,
            int.mult : intBuff / 100,
            wis.mult : wisBuff / 100,
            lib.mult : libBuff / 100,
            sens : sensBuff
        };
    }
}

