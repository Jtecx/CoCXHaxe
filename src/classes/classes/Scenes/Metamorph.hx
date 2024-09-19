/**
 * ...
 * @author Ormael
 */
package classes.scenes;

import classes.*;
import classes.geneticMemories.VaginaCountMem;
import classes.globalFlags.KFLAGS;
import classes.scenes.areas.ocean.Scylla;
import classes.internals.SaveableState;
import classes.bodyParts.Hair;
import classes.bodyParts.Antennae;
import classes.bodyParts.Arms;
import classes.bodyParts.Ears;
import classes.bodyParts.Eyes;
import classes.bodyParts.Face;
import classes.bodyParts.Gills;
import classes.bodyParts.Horns;
import classes.bodyParts.LowerBody;
import classes.bodyParts.RearBody;
import classes.bodyParts.Skin;
import classes.bodyParts.Tail;
import classes.bodyParts.Tongue;
import classes.bodyParts.Wings;
import classes.races.*;
import classes.geneticMemories.*;

class Metamorph extends BaseContent implements SaveableState
{
    
    public static var GeneticMemoryStorage : Dynamic;
    public static var PermanentMemoryStorage : Dynamic;
    public static var TriggerUpdate : Bool;
    
    public function stateObjectName() : String
    {
        return "GeneticMemoryStorage";
    }
    
    public function resetState() : Void
    {
        GeneticMemoryStorage = { };
        if (PermanentMemoryStorage == null)
        {
            PermanentMemoryStorage = { };
        }
        
        // Generic value for TFs unlocked from the beginning
        Reflect.setField(GeneticMemoryStorage, "Unlocked Metamorph", true);
    }
    
    public function saveToObject() : Dynamic
    {
        return {
            genetic memory storage : GeneticMemoryStorage,
            permanent memory storage : PermanentMemoryStorage
        };
    }
    
    public function loadFromObject(o : Dynamic, ignoreErrors : Bool) : Void
    {
        if (o != null)
        {
            GeneticMemoryStorage = { };
            var storage : Dynamic = Reflect.field(o, "genetic memory storage");
            for (k in Reflect.fields(storage))
            {
                if (storage.exists(k))
                {
                    Reflect.setField(GeneticMemoryStorage, k, !!Reflect.field(storage, k));
                }
            }
            
            if (Reflect.field(o, "permanent memory storage") == null)
            {
                TriggerUpdate = true;
            }
            
            PermanentMemoryStorage = { };
            var storage2 : Dynamic = Reflect.field(o, "permanent memory storage");
            for (k2 in Reflect.fields(storage2))
            {
                if (storage2.exists(k2))
                {
                    Reflect.setField(PermanentMemoryStorage, k2, !!Reflect.field(storage2, k2));
                }
            }
            var permedMetamorphCount : Int = Metamorph.PermanentMemoryStorage.length;
            player.removeStatusEffect(StatusEffects.TranscendentalGeneticMemory);
            player.createStatusEffect(StatusEffects.TranscendentalGeneticMemory, 15 * player.perkv1(PerkLib.AscensionTrancendentalGeneticMemoryStageX), permedMetamorphCount, 0, 0);
        }
        // Migration from old save
        else
        {
            
            resetState();
            TriggerUpdate = true;
        }
    }
    
    private static function refundAscMetamorph() : Bool
    {
        var refunded : Bool = player.hasStatusEffect(StatusEffects.TranscendentalGeneticMemory);
        
        // Refunding Ascension Perk Points for each permanent Metamorph, including costlier human parts, and enable opening Ascension menu
        /*
				*/
        // Non-human permanent Metamorphs cost 5 points each
        player.ascensionPerkPoints += player.statusEffectv2(StatusEffects.TranscendentalGeneticMemory) * 5;
        player.removeStatusEffect(StatusEffects.TranscendentalGeneticMemory);
        
        // Upgrade prices
        if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage1))
        {
            player.removePerk(PerkLib.AscensionTranscendentalGeneticMemoryStage1);
            player.ascensionPerkPoints += 15;
        }
        if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage2))
        {
            player.removePerk(PerkLib.AscensionTranscendentalGeneticMemoryStage2);
            player.ascensionPerkPoints += 30;
        }
        if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage3))
        {
            player.removePerk(PerkLib.AscensionTranscendentalGeneticMemoryStage3);
            player.ascensionPerkPoints += 45;
        }
        if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage4))
        {
            player.removePerk(PerkLib.AscensionTranscendentalGeneticMemoryStage4);
            player.ascensionPerkPoints += 60;
        }
        if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage5))
        {
            player.removePerk(PerkLib.AscensionTranscendentalGeneticMemoryStage5);
            player.ascensionPerkPoints += 75;
        }
        if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage6))
        {
            player.removePerk(PerkLib.AscensionTranscendentalGeneticMemoryStage6);
            player.ascensionPerkPoints += 90;
        }
        
        // Human permanent Metamorphs cost 25 each, but 5 was already refunded, leaving 20
        if (player.statusEffectv4(StatusEffects.UnlockedHumanHair) == 9000)
        {
            player.ascensionPerkPoints += 20;
        }
        player.removeStatusEffect(StatusEffects.UnlockedHumanHair);
        if (player.statusEffectv4(StatusEffects.UnlockedHumanFace) == 9000)
        {
            player.ascensionPerkPoints += 20;
        }
        player.removeStatusEffect(StatusEffects.UnlockedHumanFace);
        if (player.statusEffectv4(StatusEffects.UnlockedHumanEyes) == 9000)
        {
            player.ascensionPerkPoints += 20;
        }
        player.removeStatusEffect(StatusEffects.UnlockedHumanEyes);
        if (player.statusEffectv4(StatusEffects.UnlockedHumanTongue) == 9000)
        {
            player.ascensionPerkPoints += 20;
        }
        player.removeStatusEffect(StatusEffects.UnlockedHumanTongue);
        if (player.statusEffectv4(StatusEffects.UnlockedHumanEars) == 9000)
        {
            player.ascensionPerkPoints += 20;
        }
        player.removeStatusEffect(StatusEffects.UnlockedHumanEars);
        if (player.statusEffectv4(StatusEffects.UnlockedHumanArms) == 9000)
        {
            player.ascensionPerkPoints += 20;
        }
        player.removeStatusEffect(StatusEffects.UnlockedHumanArms);
        if (player.statusEffectv4(StatusEffects.UnlockedHumanLowerBody) == 9000)
        {
            player.ascensionPerkPoints += 20;
        }
        player.removeStatusEffect(StatusEffects.UnlockedHumanLowerBody);
        if (player.statusEffectv4(StatusEffects.UnlockedHumanNoHorns) == 9000)
        {
            player.ascensionPerkPoints += 20;
        }
        player.removeStatusEffect(StatusEffects.UnlockedHumanNoHorns);
        if (player.statusEffectv4(StatusEffects.UnlockedHumanNoWings) == 9000)
        {
            player.ascensionPerkPoints += 20;
        }
        player.removeStatusEffect(StatusEffects.UnlockedHumanNoWings);
        if (player.statusEffectv4(StatusEffects.UnlockedHumanSkin) == 9000)
        {
            player.ascensionPerkPoints += 20;
        }
        player.removeStatusEffect(StatusEffects.UnlockedHumanSkin);
        if (player.statusEffectv4(StatusEffects.UnlockedHumanNoSkinPattern) == 9000)
        {
            player.ascensionPerkPoints += 20;
        }
        player.removeStatusEffect(StatusEffects.UnlockedHumanNoSkinPattern);
        if (player.statusEffectv4(StatusEffects.UnlockedHumanNoAntennae) == 9000)
        {
            player.ascensionPerkPoints += 20;
        }
        player.removeStatusEffect(StatusEffects.UnlockedHumanNoAntennae);
        if (player.statusEffectv4(StatusEffects.UnlockedHumanNoGills) == 9000)
        {
            player.ascensionPerkPoints += 20;
        }
        player.removeStatusEffect(StatusEffects.UnlockedHumanNoGills);
        if (player.statusEffectv4(StatusEffects.UnlockedHumanNoRearBody) == 9000)
        {
            player.ascensionPerkPoints += 20;
        }
        player.removeStatusEffect(StatusEffects.UnlockedHumanNoRearBody);
        if (player.statusEffectv4(StatusEffects.UnlockedHumanNoTail) == 9000)
        {
            player.ascensionPerkPoints += 20;
        }
        player.removeStatusEffect(StatusEffects.UnlockedHumanNoTail);
        /*
			*/
        
        return refunded;
    }
    
    private static function convertUnlockMetamorphFlags() : Void
    // Converting Unlocked flags into Genetic Memory Storage (Human flags are dealt with separately)
    {
        
        /*
				*/
        if (player.hasStatusEffect(StatusEffects.UnlockedHarpyHair))
        {
            Reflect.setField(GeneticMemoryStorage, "Feather Hair", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedHarpyHair);
        if (player.hasStatusEffect(StatusEffects.UnlockedGorgonHair))
        {
            Reflect.setField(GeneticMemoryStorage, "Gorgon Hair", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedGorgonHair);
        if (player.hasStatusEffect(StatusEffects.UnlockedElfHair))
        {
            Reflect.setField(GeneticMemoryStorage, "Silky Hair", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedElfHair);
        trace("LOADED");
        trace(player.hasStatusEffect(StatusEffects.UnlockedRaijuHair));
        if (player.hasStatusEffect(StatusEffects.UnlockedRaijuHair))
        {
            Reflect.setField(GeneticMemoryStorage, "Storm Hair", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedRaijuHair);
        if (player.hasStatusEffect(StatusEffects.UnlockedHellcatBurningHair))
        {
            Reflect.setField(GeneticMemoryStorage, "Burning Hair", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedHellcatBurningHair);
        if (player.hasStatusEffect(StatusEffects.UnlockedHorseFace))
        {
            Reflect.setField(GeneticMemoryStorage, "Horse Face", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedHorseFace);
        if (player.hasStatusEffect(StatusEffects.UnlockedCowMinotaurFace))
        {
            Reflect.setField(GeneticMemoryStorage, "Cow Minotaur Face", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedCowMinotaurFace);
        if (player.hasStatusEffect(StatusEffects.UnlockedSharkTeeth))
        {
            Reflect.setField(GeneticMemoryStorage, "Shark Teeth Face", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedSharkTeeth);
        if (player.hasStatusEffect(StatusEffects.UnlockedSnakeFangs))
        {
            Reflect.setField(GeneticMemoryStorage, "Snake Fangs Face", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedSnakeFangs);
        if (player.hasStatusEffect(StatusEffects.UnlockedCatFace))
        {
            Reflect.setField(GeneticMemoryStorage, "Cat Face", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedCatFace);
        if (player.hasStatusEffect(StatusEffects.UnlockedCatFangs))
        {
            Reflect.setField(GeneticMemoryStorage, "Cat Canines Face", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedCatFangs);
        if (player.hasStatusEffect(StatusEffects.UnlockedLizardFace))
        {
            Reflect.setField(GeneticMemoryStorage, "Lizard Face", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedLizardFace);
        if (player.hasStatusEffect(StatusEffects.UnlockedSpiderFangs))
        {
            Reflect.setField(GeneticMemoryStorage, "Spider Fangs Face", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedSpiderFangs);
        if (player.hasStatusEffect(StatusEffects.UnlockedFoxFace))
        {
            Reflect.setField(GeneticMemoryStorage, "Fox Face", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedFoxFace);
        if (player.hasStatusEffect(StatusEffects.UnlockedPigFace))
        {
            Reflect.setField(GeneticMemoryStorage, "Pig Face", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedPigFace);
        if (player.hasStatusEffect(StatusEffects.UnlockedBoarFace))
        {
            Reflect.setField(GeneticMemoryStorage, "Boar Face", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedBoarFace);
        if (player.hasStatusEffect(StatusEffects.UnlockedManticoreFace))
        {
            Reflect.setField(GeneticMemoryStorage, "Manticore Face", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedManticoreFace);
        if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderFace))
        {
            Reflect.setField(GeneticMemoryStorage, "Salamander Fangs Face", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedSalamanderFace);
        if (player.hasStatusEffect(StatusEffects.UnlockedOrcaFace))
        {
            Reflect.setField(GeneticMemoryStorage, "Orca Face", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedOrcaFace);
        if (player.hasStatusEffect(StatusEffects.UnlockedDraconicFace))
        {
            Reflect.setField(GeneticMemoryStorage, "Draconic Face", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDraconicFace);
        if (player.hasStatusEffect(StatusEffects.UnlockedDraconicFangs))
        {
            Reflect.setField(GeneticMemoryStorage, "Draconic Fangs Face", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDraconicFangs);
        if (player.hasStatusEffect(StatusEffects.UnlockedDevilFangs))
        {
            Reflect.setField(GeneticMemoryStorage, "Devil Fangs Face", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDevilFangs);
        if (player.hasStatusEffect(StatusEffects.UnlockedOniFace))
        {
            Reflect.setField(GeneticMemoryStorage, "Oni Teeth Face", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedOniFace);
        if (player.hasStatusEffect(StatusEffects.UnlockedRaijuFace))
        {
            Reflect.setField(GeneticMemoryStorage, "Weasel Face", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedRaijuFace);
        if (player.hasStatusEffect(StatusEffects.UnlockedVampireFace))
        {
            Reflect.setField(GeneticMemoryStorage, "Vampire Face", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedVampireFace);
        if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaFace))
        {
            Reflect.setField(GeneticMemoryStorage, "Red Panda Face", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedRedPandaFace);
        if (player.hasStatusEffect(StatusEffects.UnlockedCheshireFace))
        {
            Reflect.setField(GeneticMemoryStorage, "Cheshire Face", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedCheshireFace);
        if (player.hasStatusEffect(StatusEffects.UnlockedCheshireSmile))
        {
            Reflect.setField(GeneticMemoryStorage, "Cheshire Smile Face", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedCheshireSmile);
        if (player.hasStatusEffect(StatusEffects.UnlockedOrcFangs))
        {
            Reflect.setField(GeneticMemoryStorage, "Orc Fangs Face", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedOrcFangs);
        if (player.hasStatusEffect(StatusEffects.UnlockedSpiderFourEyes))
        {
            Reflect.setField(GeneticMemoryStorage, "Spider Eyes", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedSpiderFourEyes);
        if (player.hasStatusEffect(StatusEffects.UnlockedCatEyes))
        {
            Reflect.setField(GeneticMemoryStorage, "Cat Eyes", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedCatEyes);
        if (player.hasStatusEffect(StatusEffects.UnlockedGorgonEyes))
        {
            Reflect.setField(GeneticMemoryStorage, "Gorgon Eyes", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedGorgonEyes);
        if (player.hasStatusEffect(StatusEffects.UnlockedManticoreEyes))
        {
            Reflect.setField(GeneticMemoryStorage, "Manticore Eyes", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedManticoreEyes);
        if (player.hasStatusEffect(StatusEffects.UnlockedFoxEyes))
        {
            Reflect.setField(GeneticMemoryStorage, "Fox Eyes", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedFoxEyes);
        if (player.hasStatusEffect(StatusEffects.UnlockedLizardEyes))
        {
            Reflect.setField(GeneticMemoryStorage, "Lizard Eyes", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedLizardEyes);
        if (player.hasStatusEffect(StatusEffects.UnlockedSnakeEyes))
        {
            Reflect.setField(GeneticMemoryStorage, "Snake Eyes", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedSnakeEyes);
        if (player.hasStatusEffect(StatusEffects.UnlockedDraconicEyes))
        {
            Reflect.setField(GeneticMemoryStorage, "Draconic Eyes", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDraconicEyes);
        if (player.hasStatusEffect(StatusEffects.UnlockedDevilEyes))
        {
            Reflect.setField(GeneticMemoryStorage, "Devil Eyes", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDevilEyes);
        if (player.hasStatusEffect(StatusEffects.UnlockedOniEyes))
        {
            Reflect.setField(GeneticMemoryStorage, "Oni Eyes", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedOniEyes);
        if (player.hasStatusEffect(StatusEffects.UnlockedElfEyes))
        {
            Reflect.setField(GeneticMemoryStorage, "Elf Eyes", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedElfEyes);
        if (player.hasStatusEffect(StatusEffects.UnlockedRaijuEyes))
        {
            Reflect.setField(GeneticMemoryStorage, "Raiju Eyes", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedRaijuEyes);
        if (player.hasStatusEffect(StatusEffects.UnlockedVampireEyes))
        {
            Reflect.setField(GeneticMemoryStorage, "Vampire Eyes", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedVampireEyes);
        if (player.hasStatusEffect(StatusEffects.UnlockedHellcatInfernalEyes))
        {
            Reflect.setField(GeneticMemoryStorage, "Infernal Eyes", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedHellcatInfernalEyes);
        if (player.hasStatusEffect(StatusEffects.UnlockedOrcEyes))
        {
            Reflect.setField(GeneticMemoryStorage, "Orc Eyes", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedOrcEyes);
        if (player.hasStatusEffect(StatusEffects.UnlockedDisplacerEyes))
        {
            Reflect.setField(GeneticMemoryStorage, "Displacer Eyes", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDisplacerEyes);
        if (player.hasStatusEffect(StatusEffects.UnlockedSnakeTongue))
        {
            Reflect.setField(GeneticMemoryStorage, "Snake Tongue", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedSnakeTongue);
        if (player.hasStatusEffect(StatusEffects.UnlockedDemonTonuge))
        {
            Reflect.setField(GeneticMemoryStorage, "Demonic Tongue", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDemonTonuge);
        if (player.hasStatusEffect(StatusEffects.UnlockedDraconicTongue))
        {
            Reflect.setField(GeneticMemoryStorage, "Draconic Tongue", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDraconicTongue);
        if (player.hasStatusEffect(StatusEffects.UnlockedCatTongue))
        {
            Reflect.setField(GeneticMemoryStorage, "Cat Tongue", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedCatTongue);
        if (player.hasStatusEffect(StatusEffects.UnlockedElfTongue))
        {
            Reflect.setField(GeneticMemoryStorage, "Elf Tongue", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedElfTongue);
        if (player.hasStatusEffect(StatusEffects.UnlockedHorseEars))
        {
            Reflect.setField(GeneticMemoryStorage, "Horse Ears", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedHorseEars);
        if (player.hasStatusEffect(StatusEffects.UnlockedCowEars))
        {
            Reflect.setField(GeneticMemoryStorage, "Cow Ears", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedCowEars);
        if (player.hasStatusEffect(StatusEffects.UnlockedElfinEars))
        {
            Reflect.setField(GeneticMemoryStorage, "Elfin Ears", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedElfinEars);
        if (player.hasStatusEffect(StatusEffects.UnlockedCatEars))
        {
            Reflect.setField(GeneticMemoryStorage, "Cat Ears", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedCatEars);
        if (player.hasStatusEffect(StatusEffects.UnlockedLizardEars))
        {
            Reflect.setField(GeneticMemoryStorage, "Lizard Ears", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedLizardEars);
        if (player.hasStatusEffect(StatusEffects.UnlockedFoxEars))
        {
            Reflect.setField(GeneticMemoryStorage, "Fox Ears", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedFoxEars);
        if (player.hasStatusEffect(StatusEffects.UnlockedDraconicEars))
        {
            Reflect.setField(GeneticMemoryStorage, "Draconic Ears", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDraconicEars);
        if (player.hasStatusEffect(StatusEffects.UnlockedPigEars))
        {
            Reflect.setField(GeneticMemoryStorage, "Pig Ears", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedPigEars);
        if (player.hasStatusEffect(StatusEffects.UnlockedLionEars))
        {
            Reflect.setField(GeneticMemoryStorage, "Lion Ears", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedLionEars);
        if (player.hasStatusEffect(StatusEffects.UnlockedOrcaEars))
        {
            Reflect.setField(GeneticMemoryStorage, "Orca Ears", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedOrcaEars);
        if (player.hasStatusEffect(StatusEffects.UnlockedSnakeEars))
        {
            Reflect.setField(GeneticMemoryStorage, "Snake Ears", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedSnakeEars);
        if (player.hasStatusEffect(StatusEffects.UnlockedGoatEars))
        {
            Reflect.setField(GeneticMemoryStorage, "Goat Ears", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedGoatEars);
        if (player.hasStatusEffect(StatusEffects.UnlockedOniEars))
        {
            Reflect.setField(GeneticMemoryStorage, "Oni Ears", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedOniEars);
        if (player.hasStatusEffect(StatusEffects.UnlockedElfEars))
        {
            Reflect.setField(GeneticMemoryStorage, "Elven Ears", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedElfEars);
        if (player.hasStatusEffect(StatusEffects.UnlockedRaijuEars))
        {
            Reflect.setField(GeneticMemoryStorage, "Weasel Ears", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedRaijuEars);
        if (player.hasStatusEffect(StatusEffects.UnlockedBatEars))
        {
            Reflect.setField(GeneticMemoryStorage, "Bat Ears", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedBatEars);
        if (player.hasStatusEffect(StatusEffects.UnlockedVampireEars))
        {
            Reflect.setField(GeneticMemoryStorage, "Vampire Ears", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedVampireEars);
        if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaEars))
        {
            Reflect.setField(GeneticMemoryStorage, "Red Panda Ears", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedRedPandaEars);
        if (player.hasStatusEffect(StatusEffects.UnlockedDisplacerEars))
        {
            Reflect.setField(GeneticMemoryStorage, "Displacer Ears", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDisplacerEars);
        if (player.hasStatusEffect(StatusEffects.UnlockedDemonHorns))
        {
            Reflect.setField(GeneticMemoryStorage, "Demon Horns", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDemonHorns);
        if (player.hasStatusEffect(StatusEffects.UnlockedCowMinotaurHorns))
        {
            Reflect.setField(GeneticMemoryStorage, "Cow Minotaur Horns", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedCowMinotaurHorns);
        if (player.hasStatusEffect(StatusEffects.UnlockedDraconicX2))
        {
            Reflect.setField(GeneticMemoryStorage, "Draconic Dual Horns", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDraconicX2);
        if (player.hasStatusEffect(StatusEffects.UnlockedDraconicX4))
        {
            Reflect.setField(GeneticMemoryStorage, "Draconic Quadruple Horns", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDraconicX4);
        if (player.hasStatusEffect(StatusEffects.UnlockedGoatHorns))
        {
            Reflect.setField(GeneticMemoryStorage, "Goat Horns", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedGoatHorns);
        if (player.hasStatusEffect(StatusEffects.UnlockedUnicornHorn))
        {
            Reflect.setField(GeneticMemoryStorage, "Unicorn Horn", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedUnicornHorn);
        if (player.hasStatusEffect(StatusEffects.UnlockedOniSingleHorn))
        {
            Reflect.setField(GeneticMemoryStorage, "Oni Horn", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedOniSingleHorn);
        if (player.hasStatusEffect(StatusEffects.UnlockedOniTwinHorns))
        {
            Reflect.setField(GeneticMemoryStorage, "Oni Dual Horns", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedOniTwinHorns);
        if (player.hasStatusEffect(StatusEffects.UnlockedBicornHorns))
        {
            Reflect.setField(GeneticMemoryStorage, "Bicorn Horns", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedBicornHorns);
        if (player.hasStatusEffect(StatusEffects.UnlockedHarpyArms))
        {
            Reflect.setField(GeneticMemoryStorage, "Harpy Arms", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedHarpyArms);
        if (player.hasStatusEffect(StatusEffects.UnlockedSpiderArms))
        {
            Reflect.setField(GeneticMemoryStorage, "Spider Arms", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedSpiderArms);
        if (player.hasStatusEffect(StatusEffects.UnlockedMantisArms))
        {
            Reflect.setField(GeneticMemoryStorage, "Mantis Arms", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedMantisArms);
        if (player.hasStatusEffect(StatusEffects.UnlockedBeeArms))
        {
            Reflect.setField(GeneticMemoryStorage, "Bee Arms", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedBeeArms);
        if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderArms))
        {
            Reflect.setField(GeneticMemoryStorage, "Salamander Arms", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedSalamanderArms);
        if (player.hasStatusEffect(StatusEffects.UnlockedPhoenixArms))
        {
            Reflect.setField(GeneticMemoryStorage, "Phoenix Arms", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedPhoenixArms);
        if (player.hasStatusEffect(StatusEffects.UnlockedSharkArms))
        {
            Reflect.setField(GeneticMemoryStorage, "Shark Arms", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedSharkArms);
        if (player.hasStatusEffect(StatusEffects.UnlockedLionArms))
        {
            Reflect.setField(GeneticMemoryStorage, "Lion Arms", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedLionArms);
        if (player.hasStatusEffect(StatusEffects.UnlockedFoxArms))
        {
            Reflect.setField(GeneticMemoryStorage, "Fox Arms", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedFoxArms);
        if (player.hasStatusEffect(StatusEffects.UnlockedKitsuneArms))
        {
            Reflect.setField(GeneticMemoryStorage, "Kitsune Arms", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedKitsuneArms);
        if (player.hasStatusEffect(StatusEffects.UnlockedLizardArms))
        {
            Reflect.setField(GeneticMemoryStorage, "Lizard Arms", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedLizardArms);
        if (player.hasStatusEffect(StatusEffects.UnlockedDraconicArms))
        {
            Reflect.setField(GeneticMemoryStorage, "Draconic Arms", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDraconicArms);
        if (player.hasStatusEffect(StatusEffects.UnlockedOrcaArms))
        {
            Reflect.setField(GeneticMemoryStorage, "Orca Arms", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedOrcaArms);
        if (player.hasStatusEffect(StatusEffects.UnlockedDevilArms))
        {
            Reflect.setField(GeneticMemoryStorage, "Devil Arms", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDevilArms);
        if (player.hasStatusEffect(StatusEffects.UnlockedOniArms))
        {
            Reflect.setField(GeneticMemoryStorage, "Oni Arms", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedOniArms);
        if (player.hasStatusEffect(StatusEffects.UnlockedElfArms))
        {
            Reflect.setField(GeneticMemoryStorage, "Elf Arms", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedElfArms);
        if (player.hasStatusEffect(StatusEffects.UnlockedRaijuArms))
        {
            Reflect.setField(GeneticMemoryStorage, "Raiju Arms", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedRaijuArms);
        if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaArms))
        {
            Reflect.setField(GeneticMemoryStorage, "Red Panda Arms", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedRedPandaArms);
        if (player.hasStatusEffect(StatusEffects.UnlockedCatArms))
        {
            Reflect.setField(GeneticMemoryStorage, "Cat Arms", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedCatArms);
        if (player.hasStatusEffect(StatusEffects.UnlockedSphinxArms))
        {
            Reflect.setField(GeneticMemoryStorage, "Sphinx Arms", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedSphinxArms);
        if (player.hasStatusEffect(StatusEffects.UnlockedPigArms))
        {
            Reflect.setField(GeneticMemoryStorage, "Pig Arms", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedPigArms);
        if (player.hasStatusEffect(StatusEffects.UnlockedBoarArms))
        {
            Reflect.setField(GeneticMemoryStorage, "Boar Arms", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedBoarArms);
        if (player.hasStatusEffect(StatusEffects.UnlockedOrcArms))
        {
            Reflect.setField(GeneticMemoryStorage, "Orc Arms", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedOrcArms);
        if (player.hasStatusEffect(StatusEffects.UnlockedDisplacerArms))
        {
            Reflect.setField(GeneticMemoryStorage, "Displacer Arms", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDisplacerArms);
        if (player.hasStatusEffect(StatusEffects.UnlockedRaijuArms2))
        {
            Reflect.setField(GeneticMemoryStorage, "Raiju Paws Arms", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedRaijuArms2);
        if (player.hasStatusEffect(StatusEffects.UnlockedBatWings))
        {
            Reflect.setField(GeneticMemoryStorage, "Bat Wing Arms", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedBatWings);
        if (player.hasStatusEffect(StatusEffects.UnlockedBeeWingsSmall))
        {
            Reflect.setField(GeneticMemoryStorage, "Bee Small Wings", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedBeeWingsSmall);
        if (player.hasStatusEffect(StatusEffects.UnlockedBeeWingsLarge))
        {
            Reflect.setField(GeneticMemoryStorage, "Bee Large Wings", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedBeeWingsLarge);
        if (player.hasStatusEffect(StatusEffects.UnlockedDemonTinyBatWings))
        {
            Reflect.setField(GeneticMemoryStorage, "Demonic Tiny Wings", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDemonTinyBatWings);
        if (player.hasStatusEffect(StatusEffects.UnlockedDemonLargeBatWings))
        {
            Reflect.setField(GeneticMemoryStorage, "Demonic Large Wings", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDemonLargeBatWings);
        if (player.hasStatusEffect(StatusEffects.UnlockedDemonLargeBatWings2))
        {
            Reflect.setField(GeneticMemoryStorage, "Demonic Large Quadruple Wings", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDemonLargeBatWings2);
        if (player.hasStatusEffect(StatusEffects.UnlockedHarpyWings))
        {
            Reflect.setField(GeneticMemoryStorage, "Feathered Large Wings", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedHarpyWings);
        if (player.hasStatusEffect(StatusEffects.UnlockedDraconicWingsSmall))
        {
            Reflect.setField(GeneticMemoryStorage, "Draconic Small Wings", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDraconicWingsSmall);
        if (player.hasStatusEffect(StatusEffects.UnlockedDraconicWingsLarge))
        {
            Reflect.setField(GeneticMemoryStorage, "Draconic Large Wings", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDraconicWingsLarge);
        if (player.hasStatusEffect(StatusEffects.UnlockedDraconicWingsHuge))
        {
            Reflect.setField(GeneticMemoryStorage, "Draconic Huge Wings", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDraconicWingsHuge);
        if (player.hasStatusEffect(StatusEffects.UnlockedPhoenixWings))
        {
            Reflect.setField(GeneticMemoryStorage, "Feathered Phoenix Wings", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedPhoenixWings);
        if (player.hasStatusEffect(StatusEffects.UnlockedAlicornWings))
        {
            Reflect.setField(GeneticMemoryStorage, "Feathered Alicorn Wings", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedAlicornWings);
        if (player.hasStatusEffect(StatusEffects.UnlockedMantisWingsSmall))
        {
            Reflect.setField(GeneticMemoryStorage, "Mantis Small Wings", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedMantisWingsSmall);
        if (player.hasStatusEffect(StatusEffects.UnlockedMantisWingsLarge))
        {
            Reflect.setField(GeneticMemoryStorage, "Mantis Large Wings", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedMantisWingsLarge);
        if (player.hasStatusEffect(StatusEffects.UnlockedManticoreWingsSmall))
        {
            Reflect.setField(GeneticMemoryStorage, "Manticore Small Wings", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedManticoreWingsSmall);
        if (player.hasStatusEffect(StatusEffects.UnlockedManticoreWingsLarge))
        {
            Reflect.setField(GeneticMemoryStorage, "Manticore Large Wings", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedManticoreWingsLarge);
        if (player.hasStatusEffect(StatusEffects.UnlockedVampireWings))
        {
            Reflect.setField(GeneticMemoryStorage, "Vampire Wings", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedVampireWings);
        if (player.hasStatusEffect(StatusEffects.UnlockedNightmareWings))
        {
            Reflect.setField(GeneticMemoryStorage, "Nightmare Wings", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedNightmareWings);
        if (player.hasStatusEffect(StatusEffects.UnlockedSphinxWings))
        {
            Reflect.setField(GeneticMemoryStorage, "Feathered Sphinx Wings", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedSphinxWings);
        if (player.hasStatusEffect(StatusEffects.UnlockedRaijuThunderousAura))
        {
            Reflect.setField(GeneticMemoryStorage, "Thunderous Aura (Wings)", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedRaijuThunderousAura);
        if (player.hasStatusEffect(StatusEffects.UnlockedFur))
        {
            Reflect.setField(GeneticMemoryStorage, "Fur Skin", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedFur);
        if (player.hasStatusEffect(StatusEffects.UnlockedScales))
        {
            Reflect.setField(GeneticMemoryStorage, "Scales Skin", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedScales);
        if (player.hasStatusEffect(StatusEffects.UnlockedChitin))
        {
            Reflect.setField(GeneticMemoryStorage, "Chitin Skin", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedChitin);
        if (player.hasStatusEffect(StatusEffects.UnlockedDragonScales))
        {
            Reflect.setField(GeneticMemoryStorage, "Dragon Scales Skin", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDragonScales);
        if (player.hasStatusEffect(StatusEffects.UnlockedTattoed))
        {
            Reflect.setField(GeneticMemoryStorage, "Kitsune Skin Pattern", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedTattoed);
        if (player.hasStatusEffect(StatusEffects.UnlockedBattleTattoed))
        {
            Reflect.setField(GeneticMemoryStorage, "Oni Skin Pattern", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedBattleTattoed);
        if (player.hasStatusEffect(StatusEffects.UnlockedLightningTattoed))
        {
            Reflect.setField(GeneticMemoryStorage, "Raiju Skin Pattern", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedLightningTattoed);
        if (player.hasStatusEffect(StatusEffects.UnlockedScarTattoed))
        {
            Reflect.setField(GeneticMemoryStorage, "Orc Skin Pattern", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedScarTattoed);
        if (player.hasStatusEffect(StatusEffects.UnlockedMantisAntennae))
        {
            Reflect.setField(GeneticMemoryStorage, "Mantis Antennae", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedMantisAntennae);
        if (player.hasStatusEffect(StatusEffects.UnlockedBeeAntennae))
        {
            Reflect.setField(GeneticMemoryStorage, "Bee Antennae", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedBeeAntennae);
        if (player.hasStatusEffect(StatusEffects.UnlockedFishGills))
        {
            Reflect.setField(GeneticMemoryStorage, "Fish Gills", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedFishGills);
        if (player.hasStatusEffect(StatusEffects.UnlockedLionMane))
        {
            Reflect.setField(GeneticMemoryStorage, "Lion Mane Rear Body", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedLionMane);
        if (player.hasStatusEffect(StatusEffects.UnlockedSharkFin))
        {
            Reflect.setField(GeneticMemoryStorage, "Shark Fin Rear Body", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedSharkFin);
        if (player.hasStatusEffect(StatusEffects.UnlockedOrcaBlowhole))
        {
            Reflect.setField(GeneticMemoryStorage, "Orca Blowhole Rear Body", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedOrcaBlowhole);
        if (player.hasStatusEffect(StatusEffects.UnlockedRaijuMane))
        {
            Reflect.setField(GeneticMemoryStorage, "Raiju Mane Rear Body", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedRaijuMane);
        if (player.hasStatusEffect(StatusEffects.UnlockedBatCollar))
        {
            Reflect.setField(GeneticMemoryStorage, "Bat Collar Rear Body", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedBatCollar);
        if (player.hasStatusEffect(StatusEffects.UnlockedDisplacerBTentacles))
        {
            Reflect.setField(GeneticMemoryStorage, "Displacer Tentacles Rear Body", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDisplacerBTentacles);
        if (player.hasStatusEffect(StatusEffects.UnlockedHorseTail))
        {
            Reflect.setField(GeneticMemoryStorage, "Horse Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedHorseTail);
        if (player.hasStatusEffect(StatusEffects.UnlockedDemonTail))
        {
            Reflect.setField(GeneticMemoryStorage, "Demonic Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDemonTail);
        if (player.hasStatusEffect(StatusEffects.UnlockedCowTail))
        {
            Reflect.setField(GeneticMemoryStorage, "Cow Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedCowTail);
        if (player.hasStatusEffect(StatusEffects.UnlockedSpiderTail))
        {
            Reflect.setField(GeneticMemoryStorage, "Spider Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedSpiderTail);
        if (player.hasStatusEffect(StatusEffects.UnlockedBeeTail))
        {
            Reflect.setField(GeneticMemoryStorage, "Bee Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedBeeTail);
        if (player.hasStatusEffect(StatusEffects.UnlockedSharkTail))
        {
            Reflect.setField(GeneticMemoryStorage, "Shark Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedSharkTail);
        if (player.hasStatusEffect(StatusEffects.UnlockedLizardTail))
        {
            Reflect.setField(GeneticMemoryStorage, "Lizard Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedLizardTail);
        if (player.hasStatusEffect(StatusEffects.UnlockedHarpyTail))
        {
            Reflect.setField(GeneticMemoryStorage, "Harpy Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedHarpyTail);
        if (player.hasStatusEffect(StatusEffects.UnlockedDraconicTail))
        {
            Reflect.setField(GeneticMemoryStorage, "Draconic Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDraconicTail);
        if (player.hasStatusEffect(StatusEffects.UnlockedPigTail))
        {
            Reflect.setField(GeneticMemoryStorage, "Pig Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedPigTail);
        if (player.hasStatusEffect(StatusEffects.UnlockedScorpionTail))
        {
            Reflect.setField(GeneticMemoryStorage, "Scorpion Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedScorpionTail);
        if (player.hasStatusEffect(StatusEffects.UnlockedManticoreTail))
        {
            Reflect.setField(GeneticMemoryStorage, "Manticore Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedManticoreTail);
        if (player.hasStatusEffect(StatusEffects.UnlockedGoatTail))
        {
            Reflect.setField(GeneticMemoryStorage, "Goat Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedGoatTail);
        if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderTail))
        {
            Reflect.setField(GeneticMemoryStorage, "Salamander Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedSalamanderTail);
        if (player.hasStatusEffect(StatusEffects.UnlockedMantisTail))
        {
            Reflect.setField(GeneticMemoryStorage, "Mantis Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedMantisTail);
        if (player.hasStatusEffect(StatusEffects.UnlockedOrcaTail))
        {
            Reflect.setField(GeneticMemoryStorage, "Orca Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedOrcaTail);
        if (player.hasStatusEffect(StatusEffects.UnlockedRaijuTail))
        {
            Reflect.setField(GeneticMemoryStorage, "Raiju Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedRaijuTail);
        if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaTail))
        {
            Reflect.setField(GeneticMemoryStorage, "Red Panda Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedRedPandaTail);
        if (player.hasStatusEffect(StatusEffects.UnlockedHellcatBurningTail))
        {
            Reflect.setField(GeneticMemoryStorage, "Burning Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedHellcatBurningTail);
        if (player.hasStatusEffect(StatusEffects.UnlockedCatTail))
        {
            Reflect.setField(GeneticMemoryStorage, "Cat Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedCatTail);
        if (player.hasStatusEffect(StatusEffects.UnlockedNekomataForkedTail1))
        {
            Reflect.setField(GeneticMemoryStorage, "Forked 1/3 Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedNekomataForkedTail1);
        if (player.hasStatusEffect(StatusEffects.UnlockedNekomataForkedTail2))
        {
            Reflect.setField(GeneticMemoryStorage, "Forked 2/3 Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedNekomataForkedTail2);
        if (player.hasStatusEffect(StatusEffects.UnlockedCatTail2nd))
        {
            Reflect.setField(GeneticMemoryStorage, "Cat 2nd Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedCatTail2nd);
        if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail))
        {
            Reflect.setField(GeneticMemoryStorage, "Fox Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedFoxTail);
        if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail2nd))
        {
            Reflect.setField(GeneticMemoryStorage, "Fox 2nd Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedFoxTail2nd);
        if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail3rd))
        {
            Reflect.setField(GeneticMemoryStorage, "Fox 3rd Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedFoxTail3rd);
        if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail4th))
        {
            Reflect.setField(GeneticMemoryStorage, "Fox 4th Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedFoxTail4th);
        if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail5th))
        {
            Reflect.setField(GeneticMemoryStorage, "Fox 5th Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedFoxTail5th);
        if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail6th))
        {
            Reflect.setField(GeneticMemoryStorage, "Fox 6th Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedFoxTail6th);
        if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail7th))
        {
            Reflect.setField(GeneticMemoryStorage, "Fox 7th Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedFoxTail7th);
        if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail8th))
        {
            Reflect.setField(GeneticMemoryStorage, "Fox 8th Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedFoxTail8th);
        if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail9th))
        {
            Reflect.setField(GeneticMemoryStorage, "Fox 9th Tail", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedFoxTail9th);
        if (player.hasStatusEffect(StatusEffects.UnlockedHoofedLegs))
        {
            Reflect.setField(GeneticMemoryStorage, "Hoofed Lower Body", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedHoofedLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedSnakeLowerBody))
        {
            Reflect.setField(GeneticMemoryStorage, "Snake Lower Body", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedSnakeLowerBody);
        if (player.hasStatusEffect(StatusEffects.UnlockedDemonHighHeels))
        {
            Reflect.setField(GeneticMemoryStorage, "Demon High Heels Lower Body", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDemonHighHeels);
        if (player.hasStatusEffect(StatusEffects.UnlockedDemonClawedLegs))
        {
            Reflect.setField(GeneticMemoryStorage, "Demon Clawed Lower Body", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDemonClawedLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedBeeLegs))
        {
            Reflect.setField(GeneticMemoryStorage, "Bee Lower Body", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedBeeLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedCatLegs))
        {
            Reflect.setField(GeneticMemoryStorage, "Cat Lower Body", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedCatLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedLizardLegs))
        {
            Reflect.setField(GeneticMemoryStorage, "Lizard Lower Body", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedLizardLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedHarpyLegs))
        {
            Reflect.setField(GeneticMemoryStorage, "Harpy Lower Body", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedHarpyLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedSpiderLegs))
        {
            Reflect.setField(GeneticMemoryStorage, "Spider Lower Body", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedSpiderLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedDriderLegs))
        {
            Reflect.setField(GeneticMemoryStorage, "Drider Lower Body", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDriderLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedFoxLowerBody))
        {
            Reflect.setField(GeneticMemoryStorage, "Fox Lower Body", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedFoxLowerBody);
        if (player.hasStatusEffect(StatusEffects.UnlockedDraconicLegs))
        {
            Reflect.setField(GeneticMemoryStorage, "Draconic Lower Body", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedDraconicLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedClovenHoofedLegs))
        {
            Reflect.setField(GeneticMemoryStorage, "Cloven Hoofed Lower Body", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedClovenHoofedLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderLegs))
        {
            Reflect.setField(GeneticMemoryStorage, "Salamander Lower Body", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedSalamanderLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedMantisLegs))
        {
            Reflect.setField(GeneticMemoryStorage, "Mantis Lower Body", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedMantisLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedSharkLegs))
        {
            Reflect.setField(GeneticMemoryStorage, "Shark Lower Body", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedSharkLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedLionLegs))
        {
            Reflect.setField(GeneticMemoryStorage, "Lion Lower Body", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedLionLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedOrcaLegs))
        {
            Reflect.setField(GeneticMemoryStorage, "Orca Lower Body", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedOrcaLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedOniLegs))
        {
            Reflect.setField(GeneticMemoryStorage, "Oni Lower Body", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedOniLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedElfLegs))
        {
            Reflect.setField(GeneticMemoryStorage, "Elf Lower Body", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedElfLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedRaijuLegs))
        {
            Reflect.setField(GeneticMemoryStorage, "Raiju Lower Body", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedRaijuLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaLegs))
        {
            Reflect.setField(GeneticMemoryStorage, "Red Panda Lower Body", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedRedPandaLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedOrcLegs))
        {
            Reflect.setField(GeneticMemoryStorage, "Orc Lower Body", true);
        }
        player.removeStatusEffect(StatusEffects.UnlockedOrcLegs);
        /*
			*/
        
        // Previous code didn't unlock more than 2 tails for Enlightened Kitsunes, migration fix
        /*
				*/
        if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance))
        {
            Reflect.setField(GeneticMemoryStorage, "Fox 7th Tail", true);
            Reflect.setField(GeneticMemoryStorage, "Fox 8th Tail", true);
            Reflect.setField(GeneticMemoryStorage, "Fox 9th Tail", true);
        }
        if (player.hasPerk(PerkLib.EnlightenedKitsune) || player.hasPerk(PerkLib.CorruptedKitsune))
        {
            Reflect.setField(GeneticMemoryStorage, "Fox Tail", true);
            Reflect.setField(GeneticMemoryStorage, "Fox 2nd Tail", true);
            Reflect.setField(GeneticMemoryStorage, "Fox 3rd Tail", true);
            Reflect.setField(GeneticMemoryStorage, "Fox 4th Tail", true);
            Reflect.setField(GeneticMemoryStorage, "Fox 5th Tail", true);
            Reflect.setField(GeneticMemoryStorage, "Fox 6th Tail", true);
        }
        //noinspection FallThroughInSwitchStatementJS
        if (player.tailType == Tail.FOX && player.tailCount < 7)
        {
            var _sw16_ = (player.tailCount);            

            switch (_sw16_)
            {
                case 6, 5, 4, 3, 2, 1:

                    switch (_sw16_)
                    {case 6:
                            Reflect.setField(GeneticMemoryStorage, "Fox 6th Tail", true);
                    }

                    switch (_sw16_)
                    {case 5:
                            Reflect.setField(GeneticMemoryStorage, "Fox 5th Tail", true);
                    }

                    switch (_sw16_)
                    {case 4:
                            Reflect.setField(GeneticMemoryStorage, "Fox 4th Tail", true);
                    }

                    switch (_sw16_)
                    {case 3:
                            Reflect.setField(GeneticMemoryStorage, "Fox 3rd Tail", true);
                    }

                    switch (_sw16_)
                    {case 2:
                            Reflect.setField(GeneticMemoryStorage, "Fox 2nd Tail", true);
                    }
                    Reflect.setField(GeneticMemoryStorage, "Fox Tail", true);
            }
        }
    }
    
    public static function update() : Void
    {
        TriggerUpdate = false;
        convertUnlockMetamorphFlags();
        if (refundAscMetamorph())
        {
            CoC.instance.charCreation.updateAscension("<b>The way Metamorph saves TFs has been completely changed, and so all Perks related to it, with the exception of Natural Metamorph, have been taken away from the player and refunded to ensure a safer transition. Feel free to spend your points to reobtain them, and perhaps buy something else as well, before returning to your game.</b>\n\n");
        }
    }
    
    public function new()
    {
        super();
        Saves.registerSaveableState(this);
    }
    
    public static function resetMetamorph() : Void
    {
        GeneticMemoryStorage = { };
        // Generic value for TFs unlocked from the beginning
        Reflect.setField(GeneticMemoryStorage, "Unlocked Metamorph", true);
        for (id in Reflect.fields(PermanentMemoryStorage))
        {
            Reflect.setField(GeneticMemoryStorage, id, true);
        }
    }
    
    public static function registerPermanentMetamorphs() : Void
    {
        for (id in Reflect.fields(PermanentMemoryStorage))
        {
            if (Reflect.field(GeneticMemoryStorage, id) == null)
            {
                Reflect.setField(GeneticMemoryStorage, id, true);
            }
        }
    }
    
    // Controls the main Metamorph menu's page without having to carry the value through functions
    public var mainMetamorphMenuPage : Int = 0;
    
    // Resets the main Metamorph menu's page when accessing Metamorph
    public function openMetamorph() : Void
    {
        mainMetamorphMenuPage = 0;
        accessMetamorphMenu();
    }
    
    public function accessMetamorphMenu(currentPage : Int = -1) : Void
    {
        if (currentPage < 0)
        {
            currentPage = mainMetamorphMenuPage;
        }
        else
        {
            mainMetamorphMenuPage = currentPage;
        }
        
        clearOutput();
        statScreenRefresh();
        var BtMS : Float = (50 * (1 + player.perkv1(PerkLib.Metamorph)));
        if (player.hasPerk(PerkLib.MetamorphEx))
        {
            BtMS += (100 * player.perkv1(PerkLib.MetamorphEx));
        }
        //if (player.hasPerk(PerkLib.MetamorphMastery)) BtMS += (100 * player.perkv1(PerkLib.MetamorphMastery));
        outputText("<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph</u></font>\n");
        outputText("You calm your thoughts and take a moment to center yourself, recalling your past experiences. The transformations you have experienced so far have left their mark, not so easily forgotten even when undone and replaced innumerable times. When you focus, you can feel the threads in place, echoes of the many bodies you called your own, of limbs you once owned and skins you wore as comfortably as your current one.");
        outputText("\n\nWith a little effort, you could imprint some of those recollections upon yourself. Powerful wings which carried you above the clouds, attentive ears which alerted you of danger; any such memories could return to you just as easily as they left, still rightfully yours.\n\nAs such, is there anything you would like to change about your current form?");
        outputText("\n\n<b>Bonus to Max Soulforce:</b> " + BtMS);
        
        menu();
        
        var menusList : Array<Dynamic> = [
        {
            name : "Hair",
            func : accessHairMenu
        }, 
        {
            name : "Face",
            func : accessFaceMenu
        }, 
        {
            name : "Eyes",
            func : accessEyesMenu
        }, 
        {
            name : "Tongue",
            func : accessTongueMenu
        }, 
        {
            name : "Ears",
            func : accessEarsMenu
        }, 
        {
            name : "Arms",
            func : accessArmsMenu
        }, 
        {
            name : "Lower Body",
            func : accessLowerBodyMenu
        }, 
        {
            name : "Rear Body",
            func : accessRearBodyMenu
        }, 
        {
            name : "Skin",
            func : accessSkinMenu
        }, 
        {
            name : "Patterns",
            func : accessSkinPatternsMenu
        }, 
        {
            name : "Antennae",
            func : accessAntennaeMenu
        }, 
        {
            name : "Horns",
            func : accessHornsMenu
        }, 
        {
            name : "Gills",
            func : accessGillsMenu
        }, 
        {
            name : "Wings",
            func : accessWingsMenu
        }, 
        {
            name : "Tail",
            func : accessTailMenu
        }
    ];
        
        if (player.hasPerk(PerkLib.MetamorphEx))
        {
            menusList.push({
                        name : "Breasts",
                        func : accessBreastsMenu
                    });
            menusList.push({
                        name : "Vagina",
                        func : accessVaginasMenu
                    });
            menusList.push({
                        name : "Penis",
                        func : accessCocksMenu
                    });
            menusList.push({
                        name : "Balls",
                        func : accessBallsMenu
                    });
            menusList.push({
                        name : "Special",
                        func : accessSexSpecialMenu
                    });
        }
        
        
        //			if (player.hasPerk(PerkLib.MetamorphMastery)) {
        //				menusList.push({
        //					name: "Complete",
        //					func: accessCompleteMenu
        //				});
        //			}
        
        var menusPerPage : Int = (menusList.length > 14) ? 12 : 14;
        
        var lastPage : Int = as3hx.Compat.parseInt(Math.ceil(menusList.length / menusPerPage) - 1);
        
        var pageMenus : Array<Dynamic> = menusList.slice(currentPage * menusPerPage, (currentPage * menusPerPage) + menusPerPage);
        
        var currentButton : Int = 0;
        
        for (menuObj in pageMenus)
        {
            if (menuObj.hint)
            {
                addButton(currentButton, menuObj.name, menuObj.func).hint(menuObj.hint);
            }
            else
            {
                addButton(currentButton, menuObj.name, menuObj.func);
            }
            currentButton++;
        }
        
        if (lastPage > 0)
        {
            if (currentPage > 0)
            {
                addButton(12, "Prev Page", accessMetamorphMenu, currentPage - 1);
            }
            else
            {
                addButtonDisabled(12, "Prev Page");
            }
            if (currentPage < lastPage)
            {
                addButton(13, "Next Page", accessMetamorphMenu, currentPage + 1);
            }
            else
            {
                addButtonDisabled(13, "Next Page");
            }
        }
        
        if (player.hasPerk(PerkLib.JobSoulCultivator) && !player.hasPerk(PerkLib.Soulless))
        {
            addButton(14, "Back", SceneLib.soulforce.accessSoulforceMenu);
        }
        else if (player.hasPerk(PerkLib.Soulless))
        {
            addButton(14, "Back", SceneLib.soulforce.accessDemonicEnergyMenu);
        }
        else
        {
            addButton(14, "Back", playerMenu);
        }
    }
    
    private function accessCompleteMenu(currentPage : Int = 0) : Void
    {
        var title : String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Full Body</u></font>\n";
        
        clearOutput();
        outputText(title);
        
        outputText("[pg]Don't feel like yourself? Perhaps you'd like to revert to a single race?");
        
        openPaginatedMenu(title, accessCompleteMenu, currentPage, RaceMem.Memories.sortOn("id"));
    }
    
    
    private function accessHornsMenu(currentPage : Int = 0) : Void
    {
        var title : String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Horns</u></font>\n";
        
        clearOutput();
        outputText(title);
        
        var hornsDesc : String = Horns.getAppearanceDescription(player);
        outputText((hornsDesc != null) ? hornsDesc : "You have no horns.");
        outputText("[pg]Perhaps you'd like to change this?");
        
        openPaginatedMenu(title, accessHornsMenu, currentPage, HornsMem.Memories);
    }
    
    private function accessHairMenu(currentPage : Int = 0) : Void
    {
        var title : String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Hair</u></font>\n";
        
        clearOutput();
        outputText(title);
        
        outputText(Hair.getAppearanceDescription(player) + "[pg]Perhaps you'd like to change this?");
        
        openPaginatedMenu(title, accessHairMenu, currentPage, HairMem.Memories);
    }
    
    private function accessFaceMenu(currentPage : Int = 0) : Void
    {
        var title : String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Face</u></font>\n";
        
        clearOutput();
        outputText(title);
        
        outputText(Face.getAppearanceDescription(player) + "[pg]Perhaps you'd like to change this?");
        
        openPaginatedMenu(title, accessFaceMenu, currentPage, FaceMem.Memories);
    }
    
    private function accessEyesMenu(currentPage : Int = 0) : Void
    {
        var title : String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Eyes</u></font>\n";
        
        clearOutput();
        outputText(title);
        
        outputText(Eyes.getAppearanceDescription(player) + "[pg]Perhaps you'd like to change this?");
        
        openPaginatedMenu(title, accessEyesMenu, currentPage, EyesMem.Memories);
    }
    
    private function accessTongueMenu(currentPage : Int = 0) : Void
    {
        var title : String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Tongue</u></font>\n";
        
        clearOutput();
        outputText(title);
        
        outputText(Tongue.getAppearanceDescription(player) + "[pg]Perhaps you'd like to change this?");
        
        openPaginatedMenu(title, accessTongueMenu, currentPage, TongueMem.Memories);
    }
    
    private function accessEarsMenu(currentPage : Int = 0) : Void
    {
        var title : String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Ears</u></font>\n";
        
        clearOutput();
        outputText(title);
        
        outputText(Ears.getAppearanceDescription(player) + "[pg]Perhaps you'd like to change this?");
        
        openPaginatedMenu(title, accessEarsMenu, currentPage, EarsMem.Memories);
    }
    
    private function accessArmsMenu(currentPage : Int = 0) : Void
    {
        var title : String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Arms</u></font>\n";
        
        clearOutput();
        outputText(title);
        
        outputText(Arms.getAppearanceDescription(player) + "[pg]Perhaps you'd like to change this?");
        
        openPaginatedMenu(title, accessArmsMenu, currentPage, ArmsMem.Memories);
    }
    
    private function accessWingsMenu(currentPage : Int = 0) : Void
    {
        var title : String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Wings</u></font>\n";
        
        clearOutput();
        outputText(title);
        
        var wingsDesc : String = Wings.getAppearanceDescription(player);
        outputText((wingsDesc != null) ? wingsDesc : "You have no wings.");
        outputText("[pg]Perhaps you'd like to change this?");
        
        openPaginatedMenu(title, accessWingsMenu, currentPage, WingsMem.Memories);
    }
    
    private function accessLowerBodyMenu(currentPage : Int = 0) : Void
    {
        var title : String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Lower Body</u></font>\n";
        
        clearOutput();
        outputText(title);
        
        outputText(LowerBody.getAppearanceDescription(player) + "[pg]Perhaps you'd like to change this?");
        
        openPaginatedMenu(title, accessLowerBodyMenu, currentPage, LowerBodyMem.Memories);
    }
    
    private function accessSkinMenu(currentPage : Int = 0) : Void
    {
        var title : String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Skin</u></font>\n";
        
        clearOutput();
        outputText(title);
        
        outputText(Skin.getSkinAppearanceDescription(player) + "[pg]Perhaps you'd like to change this?");
        
        openPaginatedSkinMenu(title, currentPage);
    }
    
    private function accessRearBodyMenu(currentPage : Int = 0) : Void
    {
        var title : String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Rear Body</u></font>\n";
        
        clearOutput();
        outputText(title);
        
        var rearBodyDesc : String = RearBody.getAppearanceDescription(player);
        outputText((rearBodyDesc != null) ? rearBodyDesc : "You have no rear body.");
        outputText("[pg]Perhaps you'd like to change this?");
        
        openPaginatedMenu(title, accessRearBodyMenu, currentPage, RearBodyMem.Memories);
    }
    
    private function accessAntennaeMenu(currentPage : Int = 0) : Void
    {
        var title : String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Antennae</u></font>\n";
        
        clearOutput();
        outputText(title);
        
        var antennaeDesc : String = Antennae.getAppearanceDescription(player);
        outputText((antennaeDesc != null) ? antennaeDesc : "You have no antennae.");
        outputText("[pg]Perhaps you'd like to change this?");
        
        openPaginatedMenu(title, accessAntennaeMenu, currentPage, AntennaeMem.Memories);
    }
    
    private function accessSkinPatternsMenu(currentPage : Int = 0) : Void
    {
        var title : String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Skin Patterns</u></font>\n";
        
        clearOutput();
        outputText(title);
        
        var skinPatternDesc : String = Skin.getSkinPatternAppearanceDescription(player);
        outputText((skinPatternDesc != null) ? skinPatternDesc : "You have no skin pattern.");
        outputText("[pg]Perhaps you'd like to change this?");
        
        openPaginatedMenu(title, accessSkinPatternsMenu, currentPage, SkinPatternMem.Memories);
    }
    
    private function accessGillsMenu(currentPage : Int = 0) : Void
    {
        var title : String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Gills</u></font>\n";
        
        clearOutput();
        outputText(title);
        
        var gillsDesc : String = Gills.getAppearanceDescription(player);
        outputText((gillsDesc != null) ? gillsDesc + "[pg]Perhaps you'd like to change this?" : "You have no gills. Perhaps you'd like to grow some?");
        
        openPaginatedMenu(title, accessGillsMenu, currentPage, GillsMem.Memories);
    }
    
    private function accessTailMenu(currentPage : Int = 0) : Void
    {
        var title : String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Tail</u></font>\n";
        
        clearOutput();
        outputText(title);
        
        var tailDesc : String = Tail.getAppearanceDescription(player);
        outputText((tailDesc != null) ? tailDesc : "You have no tail.");
        outputText("[pg]Perhaps you'd like to change this?");
        
        openPaginatedMenu(title, accessTailMenu, currentPage, TailMem.Memories);
    }
    
    private function accessBreastsMenu(currentPage : Int = 0) : Void
    {
        var title : String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Breasts</u></font>\n";
        
        clearOutput();
        outputText(title);
        
        var breastsDesc : String = CoC.instance.playerAppearance.describeBreasts();
        outputText((player.hasBreasts()) ? breastsDesc : "You have no Breasts.");
        outputText("[pg]Perhaps you'd like to change this?");
        
        addButton(14, "Back", accessMetamorphMenu);
        openPaginatedMenu(title, accessBreastsMenu, currentPage, BreastMem.Memories);
    }
    
    private function accessCocksMenu(currentPage : Int = 0) : Void
    {
        var title : String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Cocks</u></font>\n";
        
        clearOutput();
        outputText(title);
        
        var cocksDesc : String = CoC.instance.playerAppearance.describeCocks();
        outputText((player.hasCock()) ? cocksDesc : "You have no cock.");
        outputText("[pg]Perhaps you'd like to change this?");
        
        var totCock : Int = player.cockTotal();
        if (totCock == 0 && Reflect.field(GeneticMemoryStorage, Std.string(CockCountMem.Memories[0].id)) != null)
        {
            openPaginatedMenu(title, accessCockMenu, currentPage, CockMem.Memories, 0);
        }
        else
        {
            menu();
            
            for (i in 0...totCock)
            {
                addButton(i, "Cock " + (i + 1), accessCockMenu, 0, i).hint(player.cockDescript(i));
            }
            if (totCock < 10)
            {
                var cockUnlocked : Bool = Reflect.field(GeneticMemoryStorage, Std.string(CockCountMem.Memories[totCock].id)) && true;
                addButtonIfTrue(totCock, "New Cock", curry(accessCockMenu, 0, totCock), "You need to get a cock first", cockUnlocked, "Add a cock");
            }
            
            addButton(14, "Back", accessMetamorphMenu);
        }
    }
    
    private function accessCockMenu(currentPage : Int = 0, cock : Int = 0) : Void
    {
        var title : String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Cock</u></font>\n";
        clearOutput();
        outputText(title);
        
        var cockDesc : String = ((cock == player.cockTotal()) ? "Add a new cock" : CoC.instance.playerAppearance.describeCock(cock));
        outputText(cockDesc);
        outputText("[pg]Perhaps you'd like to change this?");
        
        openPaginatedMenu(title, accessCockMenu, currentPage, CockMem.Memories, cock);
    }
    
    private function accessBallsMenu(currentPage : Int = 0) : Void
    {
        var title : String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Balls</u></font>\n";
        
        clearOutput();
        outputText(title);
        
        var ballsDesc : String = CoC.instance.playerAppearance.describeBalls();
        outputText((player.hasBalls()) ? ballsDesc : "You have no balls.");
        outputText("[pg]Perhaps you'd like to change this?");
        
        openPaginatedMenu(title, accessBallsMenu, currentPage, BallsMem.Memories);
    }
    
    private function accessSexSpecialMenu(currentPage : Int = 0) : Void
    {
        var title : String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Genitals Special</u></font>\n";
        
        clearOutput();
        outputText(title);
        
        var desc : String = "Ovipositors and other stuff";
        outputText((desc != null) ? desc : "You have no specials.");
        
        openPaginatedMenu(title, accessSexSpecialMenu, currentPage, SpecialsMem.Memories);
    }
    
    private function accessVaginasMenu(currentPage : Int = 0) : Void
    {
        var title : String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Vagina</u></font>\n";
        
        clearOutput();
        outputText(title);
        outputText((player.hasVagina()) ? CoC.instance.playerAppearance.describePussies() : "You have no vagina.");
        outputText("[pg]Perhaps you'd like to change this?");
        
        var totVag : Int = player.vaginas.length;
        if (totVag == 0 && Reflect.field(GeneticMemoryStorage, Std.string(VaginaCountMem.Memories[0].id)) != null)
        {
            openPaginatedMenu(title, accessVaginaMenu, currentPage, VaginaMem.Memories, 0);
        }
        else
        {
            menu();
            
            for (i in 0...totVag)
            {
                addButton(i, "Vagina " + (i + 1), accessVaginaMenu, 0, i).hint(player.vaginaDescript(i));
            }
            if (totVag < 2)
            {
                var vaginaUnlocked : Bool = Reflect.field(GeneticMemoryStorage, Std.string(VaginaCountMem.Memories[totVag].id)) && true;
                addButtonIfTrue(totVag, "New Vagina", curry(accessVaginaMenu, 0, totVag), "You need to get a vagina first", vaginaUnlocked, "Add a vagina");
            }
            
            addButton(14, "Back", accessMetamorphMenu);
        }
    }
    
    private function accessVaginaMenu(currentPage : Int = 0, vagina : Int = 0) : Void
    {
        var title : String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Vagina</u></font>\n";
        
        clearOutput();
        outputText(title);
        
        var vaginaDesc : String = ((vagina == player.vagTotal()) ? "Add a new vagina." : CoC.instance.playerAppearance.describePussy(vagina));
        outputText(vaginaDesc);
        outputText("[pg]Perhaps you'd like to change this?");
        
        openPaginatedMenu(title, accessVaginaMenu, currentPage, VaginaMem.Memories, vagina);
    }
    
    private function openPaginatedMenu(title : String, thisMenu : Dynamic, currentPage : Int, memArray : Array<Dynamic>, index : Int = -9000) : Void
    {
        menu();
        
        memArray = memArray.filter(function(element : Dynamic, index : Int, array : Array<Dynamic>) : Bool
                        {
                            return !!(element && element.id != "Taur Lower Body");
                        });
        
        var memsPerPage : Int = (memArray.length > 14) ? 12 : 14;
        
        var lastPage : Int = as3hx.Compat.parseInt(Math.ceil(memArray.length / memsPerPage) - 1);
        
        var pageMems : Array<Dynamic> = memArray.slice(currentPage * memsPerPage, (currentPage * memsPerPage) + memsPerPage);
        
        var currentButton : Int = 0;
        
        for (genMem in pageMems)
        {
            var buttonStr : String = genMem.title || "";
            var unlocked : Bool = Reflect.field(GeneticMemoryStorage, Std.string(genMem.id)) && ((genMem.taurVariant) ? Reflect.field(GeneticMemoryStorage, "Taur Lower Body") : true);
            var partsInUse : Bool = (index == -(1) ? genMem.transformation().isPresent() : genMem.transformation(index).isPresent());
            var cost : Float = ((Std.is(genMem.cost, Function)) ? genMem.cost() : genMem.cost);
            var enoughSF : Bool = player.soulforce >= cost;
            var enoughMana : Bool = player.mana / player.maxMana() >= 0.1;
            
            if (unlocked && !partsInUse && (enoughSF || enoughMana))
            {
                addButton(currentButton++, buttonStr, doMetamorph, title, genMem, index).hint("Cost: " + cost + " SF" + ((genMem.info) ? "\n\n" + genMem.info : "") + " OR " + (player.maxMana() / 10) + " mana (for True Demons)");
            }
            else if (unlocked && partsInUse)
            {
                addButtonDisabled(currentButton++, buttonStr, !(genMem.hint) ? "You already have this, the metamorphosis would have no effect!" : genMem.hint);
            }
            else if (unlocked && !partsInUse && !enoughSF && !enoughMana)
            {
                addButtonDisabled(currentButton++, buttonStr, "Cost: " + cost + " SF (You don't have enough Soulforce for this metamorphosis!)" + " OR " + (player.maxMana() / 10) + " mana");
            }
            else if (!unlocked)
            {
                addButtonDisabled(currentButton++, buttonStr, "You haven't unlocked this metamorphosis yet!" + ((genMem.lockedInfo) ? "\n\n" + genMem.lockedInfo : ""));
            }
        }
        
        if (lastPage > 0)
        {
            if (currentPage > 0)
            {
                addButton(12, "Prev Page", thisMenu, currentPage - 1, index);
            }
            else
            {
                addButtonDisabled(12, "Prev Page");
            }
            if (currentPage < lastPage)
            {
                addButton(13, "Next Page", thisMenu, currentPage + 1, index);
            }
            else
            {
                addButtonDisabled(13, "Next Page");
            }
        }
        
        addButton(14, "Back", accessMetamorphMenu);
    }
    
    public static function checkTaurUnlock() : Bool
    {
        return !!Reflect.field(GeneticMemoryStorage, "Taur Lower Body");
    }
    
    private function doMetamorph(title : String, genMem : Dynamic, index : Int = -1) : Void
    {
        var genSFCost : Int = ((Std.is(genMem.cost, Function)) ? genMem.cost() : genMem.cost);
        var genManaCost : Int = Math.round(player.maxMana() / 10);
        
        if (player.hasPerk(PerkLib.Soulless))
        {
            mmPayment(2, genManaCost);
        }
        else
        {
            mmPayment(1, genSFCost);
        }
        
        var mmPayment : Int->Int->Void = function(costType : Int, costVal : Int) : Void
        {
            if (costType == 1)
            {
                player.soulforce -= costVal;
            }
            else
            {
                player.mana -= costVal;
            }
            executeMM();
        }
        
        var executeMM : Void->Void = function() : Void
        {
            clearOutput();
            outputText(title);
            if (index != -1)
            {
                genMem.transformation(index).applyEffect();
            }
            else
            {
                genMem.transformation().applyEffect();
            }
            
            CoC.instance.mainViewManager.updateCharviewIfNeeded();
            doNext(accessMetamorphMenu);
        }
    }
    
    private function openPaginatedSkinMenu(title : String, currentPage : Int) : Void
    {
        menu();
        
        var memArray : Array<Dynamic> = SkinMem.Memories;
        
        memArray = memArray.filter(function(element : Dynamic, index : Int, array : Array<Dynamic>) : Bool
                        {
                            return !!element;
                        });
        
        var memsPerPage : Int = (memArray.length > 14) ? 12 : 14;
        
        var lastPage : Int = as3hx.Compat.parseInt(Math.ceil(memArray.length / memsPerPage) - 1);
        
        var pageMems : Array<Dynamic> = memArray.slice(currentPage * memsPerPage, (currentPage * memsPerPage) + memsPerPage);
        
        var currentButton : Int = 0;
        
        for (genMem in pageMems)
        {
            var buttonStr : String = genMem.title || "";
            var unlocked : Bool = Reflect.field(GeneticMemoryStorage, Std.string(genMem.id));
            var enoughSF : Bool = player.soulforce >= genMem.cost;
            
            if (!genMem.transformationCoverage)
            {
                var partsInUse : Bool = genMem.transformation().isPresent();
                if (unlocked && !partsInUse && enoughSF)
                {
                    addButton(currentButton, buttonStr, doMetamorph, title, genMem).hint("Cost: " + genMem.cost + " SF" + ((genMem.info) ? "\n\n" + genMem.info : ""));
                }
                else if (unlocked && partsInUse)
                {
                    addButtonDisabled(currentButton, buttonStr, "You already have this, the metamorphosis would have no effect!");
                }
                else if (unlocked && !partsInUse && !enoughSF)
                {
                    addButtonDisabled(currentButton, buttonStr, "Cost: " + genMem.cost + " SF (You don't have enough Soulforce for this metamorphosis!)");
                }
                else if (!unlocked)
                {
                    addButtonDisabled(currentButton, buttonStr, "You haven't unlocked this metamorphosis yet!" + ((genMem.lockedInfo) ? "\n\n" + genMem.lockedInfo : ""));
                }
                currentButton++;
            }
            else
            {
                if (unlocked)
                {
                    addButton(currentButton, buttonStr, openCoverageMenu, genMem);
                }
                else if (!unlocked)
                {
                    addButtonDisabled(currentButton, buttonStr, "You haven't unlocked this metamorphosis yet!" + ((genMem.lockedInfo) ? "\n\n" + genMem.lockedInfo : ""));
                }
                currentButton++;
            }
        }
        
        if (lastPage > 0)
        {
            if (currentPage > 0)
            {
                addButton(12, "Prev Page", accessSkinMenu, currentPage - 1);
            }
            else
            {
                addButtonDisabled(12, "Prev Page");
            }
            if (currentPage < lastPage)
            {
                addButton(13, "Next Page", accessSkinMenu, currentPage + 1);
            }
            else
            {
                addButtonDisabled(13, "Next Page");
            }
        }
        
        addButton(14, "Back", accessMetamorphMenu);
    }
    
    private function openCoverageMenu(genMem : Dynamic) : Void
    {
        clearOutput();
        menu();
        outputText("<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - " + genMem.id.split(" Skin")[0] + " Coverage</u></font>\n");
        outputText("How much do you want your skin to be covered?");
        
        var coverages : Array<Dynamic> = [
        {
            name : "Low",
            value : Skin.COVERAGE_LOW
        }, 
        {
            name : "Medium",
            value : Skin.COVERAGE_MEDIUM
        }, 
        {
            name : "High",
            value : Skin.COVERAGE_HIGH
        }, 
        {
            name : "Complete",
            value : Skin.COVERAGE_COMPLETE
        }
    ];
        
        var currentButton : Int = 0;
        
        for (coverage in coverages)
        {
            if (InCollection(coverage.value, genMem.availableCoverages))
            {
                var cost : Int = as3hx.Compat.parseInt(genMem.cost * (Lambda.indexOf(coverages, coverage) + 1));
                var enoughSF : Bool = player.soulforce >= cost;
                var inEffect : Bool = genMem.transformationCoverage(coverage.value).isPresent();
                
                if (enoughSF && !inEffect)
                {
                    addButton(currentButton, coverage.name, doMetamorphSkin, genMem, coverage.value, cost).hint("Cost: " + cost + " SF");
                }
                else if (inEffect)
                {
                    addButtonDisabled(currentButton, coverage.name, "You already have this much coverage, the metamorphosis would have no effect!");
                }
                else
                {
                    addButtonDisabled(currentButton, coverage.name, "Cost: " + cost + " SF (You don't have enough Soulforce for this coverage!)");
                }
                currentButton++;
            }
        }
        
        addButton(14, "Back", accessSkinMenu);
    }
    
    private function doMetamorphSkin(genMem : Dynamic, coverage : Int, cost : Int) : Void
    {
        clearOutput();
        outputText("<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - " + genMem.id.split(" Skin")[0] + "</u></font>\n");
        
        genMem.transformationCoverage(coverage).applyEffect();
        player.soulforce -= cost;
        CoC.instance.mainViewManager.updateCharviewIfNeeded();
        doNext(accessMetamorphMenu);
    }
    
    private function accessPageEx1MetamorphMenu() : Void
    {
        menu();
        if (player.soulforce >= 300)
        {
            addButton(0, "Height +1", metamorphHeight1U);
        }
        else
        {
            addButtonDisabled(0, "Height +1", "You do not have enough Soulforce for this metamorphosis.");
        }
        if (player.soulforce >= 700)
        {
            addButton(1, "Height +2", metamorphHeight2U);
        }
        else
        {
            addButtonDisabled(1, "Height +2", "You do not have enough Soulforce for this metamorphosis.");
        }
        if (player.soulforce >= 100)
        {
            addButton(2, "Height -1", metamorphHeight1D);
        }
        else
        {
            addButtonDisabled(2, "Height -1", "You do not have enough Soulforce for this metamorphosis.");
        }
        if (player.soulforce >= 300)
        {
            addButton(3, "Height -2", metamorphHeight2D);
        }
        else
        {
            addButtonDisabled(3, "Height -2", "You do not have enough Soulforce for this metamorphosis.");
        }
        if (player.soulforce >= 300)
        {
            addButton(4, "Hair +1", metamorphHair1U);
        }
        else
        {
            addButtonDisabled(4, "Hair +1", "You do not have enough Soulforce for this metamorphosis.");
        }
        if (player.soulforce >= 100)
        {
            addButton(9, "Hair -1", metamorphHair1D);
        }
        else
        {
            addButtonDisabled(9, "Hair -1", "You do not have enough Soulforce for this metamorphosis.");
        }
        addButton(14, "Back", accessMetamorphMenu);
    }
    private function accessPageEx2MetamorphMenu() : Void
    {
        menu();
        addButton(0, "Back", accessMetamorphMenu);
        addButton(1, "Back", accessMetamorphMenu);
        addButton(2, "Back", accessMetamorphMenu);
        addButton(3, "Back", accessMetamorphMenu);
        addButton(4, "Back", accessMetamorphMenu);
        addButton(5, "Back", accessMetamorphMenu);
        addButton(6, "Back", accessMetamorphMenu);
        addButton(7, "Back", accessMetamorphMenu);
        addButton(8, "Back", accessMetamorphMenu);
        addButton(9, "Back", accessMetamorphMenu);
        addButton(10, "Back", accessMetamorphMenu);
        addButton(11, "Back", accessMetamorphMenu);
        addButton(12, "Back", accessMetamorphMenu);
        addButton(13, "Back", accessMetamorphMenu);
        addButton(14, "Back", accessMetamorphMenu);
    }
    private function accessPageEx3MetamorphMenu() : Void
    {
        menu();
        addButton(0, "Skin", accessMetamorphMenu);
        addButton(1, "Hair", accessMetamorphMenu);
        addButton(2, "Fur", accessMetamorphMenu);
        addButton(14, "Back", accessMetamorphMenu);
    }
    private function metamorphHeight1U() : Void
    {
        clearOutput();
        player.soulforce -= 300;
        outputText("\n\nWhoa wait did you just gain some height!? You indeed notice you've grown by an inch.");
        player.tallness += 1;
        if (player.basetallness >= 132)
        {
            player.tallness = 132;
        }
        doNext(accessPageEx1MetamorphMenu);
    }
    private function metamorphHeight2U() : Void
    {
        clearOutput();
        player.soulforce -= 700;
        outputText("\n\nWhoa wait did you just gain some height!? You indeed notice you've grown by two inches.");
        player.tallness += 2;
        if (player.basetallness >= 132)
        {
            player.tallness = 132;
        }
        doNext(accessPageEx1MetamorphMenu);
    }
    private function metamorphHeight1D() : Void
    {
        clearOutput();
        player.soulforce -= 100;
        outputText("\n\nWhoa wait did you just lost some height!? You indeed notice you've shrunk by an inch.");
        player.tallness -= 1;
        if (player.basetallness < 42)
        {
            player.tallness = 42;
        }
        doNext(accessPageEx1MetamorphMenu);
    }
    private function metamorphHeight2D() : Void
    {
        clearOutput();
        player.soulforce -= 300;
        outputText("\n\nWhoa wait did you just lost some height!? You indeed notice you've shrunk by two inches.");
        player.tallness -= 2;
        if (player.basetallness < 42)
        {
            player.tallness = 42;
        }
        doNext(accessPageEx1MetamorphMenu);
    }
    private function metamorphHair1U() : Void
    {
        clearOutput();
        player.soulforce -= 300;
        outputText("\n\nAs you focus, you feel more hair sprouting from your scalp. <b>Your hair is now about an inch longer.</b>");
        player.hairLength += 1;
        doNext(accessPageEx1MetamorphMenu);
    }
    private function metamorphHair2U() : Void
    {
        clearOutput();
        player.soulforce -= 300;
        outputText("\n\nAs you focus, you feel more hair sprouting from your scalp. <b>Your hair is now about two inches longer.</b>");
        player.hairLength += 2;
        doNext(accessPageEx1MetamorphMenu);
    }
    private function metamorphHair1D() : Void
    {
        clearOutput();
        player.soulforce -= 100;
        outputText("\n\nAs you focus, you feel it as your strands of hair are suddenly cut short at a specific length. <b>Your hair is now about one inch shorter.</b>");
        player.hairLength -= 1;
        if (player.hairLength < 0)
        {
            player.hairLength = 0;
        }
        doNext(accessPageEx1MetamorphMenu);
    }
    private function metamorphHair2D() : Void
    {
        clearOutput();
        player.soulforce -= 100;
        outputText("\n\nAs you focus, you feel it as your strands of hair are suddenly cut short at a specific length. <b>Your hair is now about two inches shorter.</b>");
        player.hairLength -= 2;
        if (player.hairLength < 0)
        {
            player.hairLength = 0;
        }
        doNext(accessPageEx1MetamorphMenu);
    }
    
    public static function unlockMetamorph(genMem : Dynamic) : Void
    {
        if (Reflect.field(GeneticMemoryStorage, Std.string(genMem.id)) == null && player.hasPerk(PerkLib.GeneticMemory))
        {
            Reflect.setField(GeneticMemoryStorage, Std.string(genMem.id), true);
            if (player.hasPerk(PerkLib.Metamorph))
            {
                outputText("\n\n<b>Genetic Memory Obtained: " + (genMem.name || genMem.id) + "!</b>");
            }
            if (genMem.unlockText)
            {
                outputText("\n<b>" + genMem.unlockText + "</b>");
            }
        }
    }
    
    public static function unlockMetamorphEx(genMem : Dynamic) : Void
    {
        if (Reflect.field(GeneticMemoryStorage, Std.string(genMem.id)) == null && player.hasPerk(PerkLib.GeneticMemory))
        {
            Reflect.setField(GeneticMemoryStorage, Std.string(genMem.id), true);
            if (player.hasPerk(PerkLib.MetamorphEx))
            {
                outputText("\n\n<b>Genetic Memory Obtained: " + (genMem.name || genMem.id) + "!</b>");
            }
            if (genMem.unlockText)
            {
                outputText("\n<b>" + genMem.unlockText + "</b>");
            }
        }
    }
    
    //		public static function unlockMetamorphMastery (genMem: *): void {
    //			if (!GeneticMemoryStorage[genMem.id] && player.hasPerk(PerkLib.GeneticMemory)) {
    //				GeneticMemoryStorage[genMem.id] = true;
    //				if (player.hasPerk(PerkLib.MetamorphMastery)) outputText("\n\n<b>Genetic Memory Obtained: " + (genMem.name || genMem.id) + "!</b>");
    //				if (genMem.unlockText) outputText("\n<b>" + genMem.unlockText +"</b>");
    //			}
    //		}
    
    public static function permMetamorph(genMem : Dynamic) : Void
    {
        Reflect.setField(PermanentMemoryStorage, Std.string(genMem.id), true);
        player.ascensionPerkPoints -= genMem.permCost || 5;
    }
    
    public static function runMetamorph(arr : Array<Dynamic>) : Void
    //TODO: Khovel - All the Functionality to do the TFs here
    {
        
        var _sw17_ = (arr[0]);        

        switch (_sw17_)
        {  // Antennae  
            case "Ant":CoC.instance.transformations.AntennaeAnt.applyEffect();
            case "Bee":CoC.instance.transformations.AntennaeBee.applyEffect();
            case "Centipede":CoC.instance.transformations.AntennaeCentipede.applyEffect();
            case "FireSnail":CoC.instance.transformations.AntennaeFireSnail.applyEffect();
            case "Human":CoC.instance.transformations.AntennaeNone.applyEffect();
            case "Jabberwocky":CoC.instance.transformations.AntennaeJabberwocky.applyEffect();
            case "Mantis":CoC.instance.transformations.AntennaeMantis.applyEffect();
            case "SeaDragon":CoC.instance.transformations.AntennaeFireSnail.applyEffect();
            default:CoC.instance.transformations.AntennaeNone.applyEffect();
        }
        var _sw18_ = (arr[1]);        

        switch (_sw18_)
        {  // Arms  
            case "Ant":CoC.instance.transformations.ArmsAnt.applyEffect();
            case "Atlach":CoC.instance.transformations.ArmsAtlach.applyEffect();
            case "Avian":CoC.instance.transformations.ArmsAvian.applyEffect();
            case "BatWing":CoC.instance.transformations.ArmsBatWing.applyEffect();
            case "Bear":CoC.instance.transformations.ArmsBear.applyEffect();
            case "Bee":CoC.instance.transformations.ArmsBee.applyEffect();
            case "Boar":CoC.instance.transformations.ArmsBoar.applyEffect();
            case "Canine":CoC.instance.transformations.ArmsCanine.applyEffect();
            case "Cat":CoC.instance.transformations.ArmsCat.applyEffect();
            case "CaveWyrm":CoC.instance.transformations.ArmsCaveWyrm.applyEffect();
            case "Centipede":CoC.instance.transformations.ArmsCentipede.applyEffect();
            case "Devil":CoC.instance.transformations.ArmsDevil.applyEffect();
            case "Displacer":CoC.instance.transformations.ArmsDisplacer.applyEffect();
            case "Dragon":CoC.instance.transformations.ArmsDraconic.applyEffect();
            case "Elf":CoC.instance.transformations.ArmsElf.applyEffect();
            case "Fox":CoC.instance.transformations.ArmsFox.applyEffect();
            case "Frostwyrm":CoC.instance.transformations.ArmsFrostwyrm.applyEffect();
            case "Gazer":CoC.instance.transformations.ArmsGazer.applyEffect();
            case "Ghost":CoC.instance.transformations.ArmsGhost.applyEffect();
            case "Goo":CoC.instance.transformations.ArmsGoo.applyEffect();
            case "Gryphon":CoC.instance.transformations.ArmsGryphon.applyEffect();
            case "Harpy":CoC.instance.transformations.ArmsHarpy.applyEffect();
            case "Hinezumi":CoC.instance.transformations.ArmsHinezumi.applyEffect();
            case "Human":CoC.instance.transformations.ArmsHuman.applyEffect();
            case "Hydra":CoC.instance.transformations.ArmsHydra.applyEffect();
            case "Jabberwocky":CoC.instance.transformations.ArmsJabberwocky.applyEffect();
            case "Jiangshi":CoC.instance.transformations.ArmsJiangshi.applyEffect();
            case "Kamaitachi":CoC.instance.transformations.ArmsKamaitachi.applyEffect();
            case "Kitsune":CoC.instance.transformations.ArmsKitsune.applyEffect();
            case "Kraken":CoC.instance.transformations.ArmsKraken.applyEffect();
            case "Lion":CoC.instance.transformations.ArmsLion.applyEffect();
            case "Lizard":CoC.instance.transformations.ArmsLizard.applyEffect();
            case "Mantis":CoC.instance.transformations.ArmsMantis.applyEffect();
            case "Melkie":CoC.instance.transformations.ArmsMelkie.applyEffect();
            case "Oni":CoC.instance.transformations.ArmsOni.applyEffect();
            case "Orc":CoC.instance.transformations.ArmsOrc.applyEffect();
            case "Orca":CoC.instance.transformations.ArmsOrca.applyEffect();
            case "Phoenix":CoC.instance.transformations.ArmsPhoenix.applyEffect();
            case "Pig":CoC.instance.transformations.ArmsPig.applyEffect();
            case "Plant":CoC.instance.transformations.ArmsPlant.applyEffect();
            case "Raccoon":CoC.instance.transformations.ArmsRaccoon.applyEffect();
            case "Raiju":CoC.instance.transformations.ArmsRaiju.applyEffect();
            case "RedPanda":CoC.instance.transformations.ArmsRedPanda.applyEffect();
            case "Salamander":CoC.instance.transformations.ArmsSalamander.applyEffect();
            case "SeaDragon":CoC.instance.transformations.ArmsSeaDragon.applyEffect();
            case "Shark":CoC.instance.transformations.ArmsShark.applyEffect();
            case "Sphinx":CoC.instance.transformations.ArmsSphinx.applyEffect();
            case "Spider":CoC.instance.transformations.ArmsSpider.applyEffect();
            case "Squirrel":CoC.instance.transformations.ArmsSquirrel.applyEffect();
            case "UshiOni":CoC.instance.transformations.ArmsUshiOni.applyEffect();
            case "Weasel":CoC.instance.transformations.ArmsWeasel.applyEffect();
            case "Wendigo":CoC.instance.transformations.ArmsWendigo.applyEffect();
            case "Wolf":CoC.instance.transformations.ArmsWolf.applyEffect();
            case "Yeti":CoC.instance.transformations.ArmsYeti.applyEffect();
            case "YukiOnna":CoC.instance.transformations.ArmsYukiOnna.applyEffect();
            default:CoC.instance.transformations.ArmsHuman.applyEffect();
        }
        var _sw19_ = (arr[2]);        

        switch (_sw19_)
        {  // Balls  
            case "Human":if (player.hasBalls() && player.balls != 2)
                {
                    CoC.instance.transformations.BallsDuo.applyEffect();
                }  // Shares similar requirement to Raccoon  
            case "Bunny", "Raccoon":if (!player.hasBalls())
                {
                    CoC.instance.transformations.BallsDuo.applyEffect();
                }
                player.ballSize = 6;
            case "Trap":if (!player.hasStatusEffect(StatusEffects.Uniball))
                {
                    CoC.instance.transformations.BallsTrap.applyEffect();
                }
            case "Duo":if (player.balls != 2)
                {
                    CoC.instance.transformations.BallsDuo.applyEffect();
                }
            case "None":if (player.hasBalls())
                {
                    CoC.instance.transformations.BallsNone.applyEffect();
                }
            default:if (player.hasBalls())
                {
                    CoC.instance.transformations.BallsDuo.applyEffect();
                }
        }
        var _sw20_ = (arr[3]);        

        switch (_sw20_)
        {  // Breasts  
            case "Normal":if (player.hasBreasts() && player.bRows() > 1)
                {
                    CoC.instance.transformations.BreastRowsRemoveToOne.applyEffect();
                }
                if (player.breastRows.length > 1)
                {
                    CoC.instance.transformations.BreastRowsRemoveToOne.applyEffect();
                }
            case "Bimbo":if (player.smallestTitSize() < 6)
                {
                    CoC.instance.transformations.BreastsGrowUpToDD.applyEffect();
                }
            case "Flat":if (player.hasBreasts())
                {
                    CoC.instance.transformations.BreastsShrinkToNothing.applyEffect();
                }
            case "Row2":if (player.bRows() != 2)
                {
                    CoC.instance.transformations.BreastRowsTwo.applyEffect();
                }
            case "Row3":if (player.bRows() != 3)
                {
                    CoC.instance.transformations.BreastRowsThree.applyEffect();
                }
            case "Row4":if (player.bRows() != 4)
                {
                    CoC.instance.transformations.BreastRowsFour.applyEffect();
                }
            default:if (player.hasBreasts() && player.bRows() > 1)
                {
                    CoC.instance.transformations.BreastRowsRemoveToOne.applyEffect();
                }
                if (player.breastRows.length > 1)
                {
                    CoC.instance.transformations.BreastRowsRemoveToOne.applyEffect();
                }
        }
        var _sw21_ = (arr[4]);        

        switch (_sw21_)
        {  // Nipples  
            case "Human":CoC.instance.transformations.NipplesPerBreastOne.applyEffect();
                CoC.instance.transformations.NipplesUnfuck.applyEffect();
                CoC.instance.transformations.NipplesNoColor.applyEffect();
            case "Cow":CoC.instance.transformations.NipplesPerBreastFour.applyEffect();
                CoC.instance.transformations.StartLactation.applyEffect();
                CoC.instance.transformations.NipplesNoColor.applyEffect();
            case "Fuckable":CoC.instance.transformations.NipplesFuckableForce.applyEffect();
            case "Black":CoC.instance.transformations.NipplesBlack.applyEffect();
            case "Glow":CoC.instance.transformations.NipplesGlowing.applyEffect();
            default:CoC.instance.transformations.NipplesPerBreastOne.applyEffect();
                CoC.instance.transformations.NipplesNoColor.applyEffect();
                CoC.instance.transformations.NipplesUnfuck.applyEffect();
                CoC.instance.transformations.RemoveLactation.applyEffect();
        }
        var _sw22_ = (arr[5]);        

        switch (_sw22_)
        {  // Ears  
            case "Avian":CoC.instance.transformations.EarsAvian.applyEffect();
            case "Bat":CoC.instance.transformations.EarsBat.applyEffect();
            case "Bear":CoC.instance.transformations.EarsBear.applyEffect();
            case "Bunny":CoC.instance.transformations.EarsBunny.applyEffect();
            case "Cat":CoC.instance.transformations.EarsCat.applyEffect();
            case "CaveWyrm":CoC.instance.transformations.EarsCaveWyrm.applyEffect();
            case "Cow":CoC.instance.transformations.EarsCow.applyEffect();
            case "Deer":CoC.instance.transformations.EarsDeer.applyEffect();
            case "Displacer":CoC.instance.transformations.EarsDisplacer.applyEffect();
            case "Dog":CoC.instance.transformations.EarsDog.applyEffect();
            case "Dragon":CoC.instance.transformations.EarsDraconic.applyEffect();
            case "Elfin":CoC.instance.transformations.EarsElfin.applyEffect();
            case "Elven":CoC.instance.transformations.EarsElven.applyEffect();
            case "FennecFox":CoC.instance.transformations.EarsFennecFox.applyEffect();
            case "Ferret":CoC.instance.transformations.EarsFerret.applyEffect();
            case "Fox":CoC.instance.transformations.EarsFox.applyEffect();
            case "Goat":CoC.instance.transformations.EarsGoat.applyEffect();
            case "Gremlin":CoC.instance.transformations.EarsGremlin.applyEffect();
            case "Gryphon":CoC.instance.transformations.EarsGryphon.applyEffect();
            case "Horse":CoC.instance.transformations.EarsHorse.applyEffect();
            case "Human":CoC.instance.transformations.EarsHuman.applyEffect();
            case "Insect":CoC.instance.transformations.EarsInsect.applyEffect();
            case "Jackal":CoC.instance.transformations.EarsJackal.applyEffect();
            case "Kangaroo":CoC.instance.transformations.EarsKangaroo.applyEffect();
            case "Kirin":CoC.instance.transformations.EarsKirin.applyEffect();
            case "Lion":CoC.instance.transformations.EarsLion.applyEffect();
            case "Lizard":CoC.instance.transformations.EarsLizard.applyEffect();
            case "Melkie":CoC.instance.transformations.EarsMelkie.applyEffect();
            case "Mouse":CoC.instance.transformations.EarsMouse.applyEffect();
            case "Oni":CoC.instance.transformations.EarsOni.applyEffect();
            case "Orca":CoC.instance.transformations.EarsOrca.applyEffect();
            case "Orca2":CoC.instance.transformations.EarsOrca2.applyEffect();
            case "Panda":CoC.instance.transformations.EarsPanda.applyEffect();
            case "Pig":CoC.instance.transformations.EarsPig.applyEffect();
            case "Raccoon":CoC.instance.transformations.EarsRaccoon.applyEffect();
            case "Raiju":CoC.instance.transformations.EarsRaiju.applyEffect();
            case "RedPanda":CoC.instance.transformations.EarsRedPanda.applyEffect();
            case "Shark":CoC.instance.transformations.EarsShark.applyEffect();
            case "Snake":CoC.instance.transformations.EarsSnake.applyEffect();
            case "Squirrel":CoC.instance.transformations.EarsSquirrel.applyEffect();
            case "Vampire":CoC.instance.transformations.EarsVampire.applyEffect();
            case "Weasel":CoC.instance.transformations.EarsWeasel.applyEffect();
            case "Wolf":CoC.instance.transformations.EarsWolf.applyEffect();
            case "Yeti":CoC.instance.transformations.EarsYeti.applyEffect();
            default:CoC.instance.transformations.EarsHuman.applyEffect();
        }
        var _sw23_ = (arr[6]);        

        switch (_sw23_)
        {  // Eyes & Color  
            case "Alicorn":CoC.instance.transformations.EyesHuman.applyEffect();
                CoC.instance.transformations.EyesAlicornColors.applyEffect();
            case "Alraune":CoC.instance.transformations.EyesAlrauneColors.applyEffect();
            case "AtlachNacha":CoC.instance.transformations.EyesSpider.applyEffect();
                CoC.instance.transformations.EyesAtlachColors.applyEffect();
            case "Bear":CoC.instance.transformations.EyesBear.applyEffect();
            case "Cancer":CoC.instance.transformations.EyesCancer.applyEffect();
            case "Cat":CoC.instance.transformations.EyesCat.applyEffect();
            case "CaveWyrm":CoC.instance.transformations.EyesCaveWyrm.applyEffect();
            case "Centipede":CoC.instance.transformations.EyesCentipede.applyEffect();
            case "Dead":CoC.instance.transformations.EyesDead.applyEffect();
            case "Devil":CoC.instance.transformations.EyesDevil.applyEffect();
            case "Displacer":CoC.instance.transformations.EyesDisplacer.applyEffect();
            case "Dragon":CoC.instance.transformations.EyesDraconic.applyEffect();
            case "Elf":CoC.instance.transformations.EyesElf.applyEffect();
            case "Fairy":CoC.instance.transformations.EyesFairy.applyEffect();
            case "Fenrir":CoC.instance.transformations.EyesFenrir.applyEffect();
                CoC.instance.transformations.EyesFenrirColor.applyEffect();
            case "Feral":CoC.instance.transformations.EyesFeral.applyEffect();
            case "Fiendish":CoC.instance.transformations.EyesFiendish.applyEffect();
            case "FireSnail":CoC.instance.transformations.EyesFireSnail.applyEffect();
            case "Fox":CoC.instance.transformations.EyesFox.applyEffect();
            case "Frostwyrm":CoC.instance.transformations.EyesFrostwyrm.applyEffect();
            case "Ghost":CoC.instance.transformations.EyesGhost.applyEffect();
            case "Goat":CoC.instance.transformations.EyesGoat.applyEffect();
            case "Goblin":CoC.instance.transformations.EyesGoblinColors.applyEffect();
            case "Gorgon":CoC.instance.transformations.EyesGorgon.applyEffect();
            case "Gremlin":CoC.instance.transformations.EyesGremlinColors.applyEffect();
            case "Gryphon":CoC.instance.transformations.EyesGryphon.applyEffect();
            case "Hinezumi":CoC.instance.transformations.EyesHinezumi.applyEffect();
            case "Human":CoC.instance.transformations.EyesHuman.applyEffect();
            case "Infernal":CoC.instance.transformations.EyesInfernal.applyEffect();
            case "Jiangshi":CoC.instance.transformations.EyesJiangshi.applyEffect();
            case "Kamaitachi":CoC.instance.transformations.EyesKamaitachiColors.applyEffect();
            case "Kirin":CoC.instance.transformations.EyesKirinColors.applyEffect();
            case "Kraken":CoC.instance.transformations.EyesKraken.applyEffect();
                CoC.instance.transformations.EyesKrakenColors.applyEffect();
            case "Lizard":CoC.instance.transformations.EyesLizard.applyEffect();
            case "Manticore":CoC.instance.transformations.EyesManticore.applyEffect();
            case "Monoeye":CoC.instance.transformations.EyesMonoeye.applyEffect();
            case "Oni":CoC.instance.transformations.EyesOni.applyEffect();
            case "OniColors":CoC.instance.transformations.EyesOniColors.applyEffect();
            case "Orc":CoC.instance.transformations.EyesOrc.applyEffect();
            case "Plant":CoC.instance.transformations.EyesPlantColors.applyEffect();
            case "Raccoon":CoC.instance.transformations.EyesRaccoonColors.applyEffect();
            case "Raiju":CoC.instance.transformations.EyesRaiju.applyEffect();
            case "Ratatoskr":CoC.instance.transformations.EyesRatatoskr.applyEffect();
            case "SandTrap":CoC.instance.transformations.EyesSandTrap.applyEffect();
            case "Seadragon":CoC.instance.transformations.EyesSeadragonColors.applyEffect();
            case "Snake":CoC.instance.transformations.EyesSnake.applyEffect();
            case "SnakeFiendish":CoC.instance.transformations.EyesSnakeFiendish.applyEffect();
            case "Spider":CoC.instance.transformations.EyesSpider.applyEffect();
            case "Vampire":CoC.instance.transformations.EyesVampire.applyEffect();
            case "Weasel":CoC.instance.transformations.EyesWeasel.applyEffect();
            default:CoC.instance.transformations.EyesHuman.applyEffect();
        }
        var _sw24_ = (arr[7]);        

        switch (_sw24_)
        {  // Face  
            case "AnimalTeeth":CoC.instance.transformations.FaceAnimalTeeth.applyEffect();
            case "Ant":CoC.instance.transformations.FaceAnt.applyEffect();
            case "Avian":CoC.instance.transformations.FaceAvian.applyEffect();
            case "Bear":CoC.instance.transformations.FaceBear.applyEffect();
            case "Boar":CoC.instance.transformations.FaceBoar.applyEffect();
            case "Buckteeth":CoC.instance.transformations.FaceBuckteeth.applyEffect();
            case "Bucktooth":CoC.instance.transformations.FaceBucktooth.applyEffect();
            case "Bunny":CoC.instance.transformations.FaceBunny.applyEffect();
            case "Cat":CoC.instance.transformations.FaceCat.applyEffect();
            case "CatCanines":CoC.instance.transformations.FaceCatCanines.applyEffect();
            case "Cheshire":CoC.instance.transformations.FaceCheshire.applyEffect();
            case "CheshireSmile":CoC.instance.transformations.FaceCheshireSmile.applyEffect();
            case "CowMinotaur":CoC.instance.transformations.FaceCowMinotaur.applyEffect();
            case "Crazy":CoC.instance.transformations.FaceCrazy.applyEffect();
            case "Deer":CoC.instance.transformations.FaceDeer.applyEffect();
            case "Dog":CoC.instance.transformations.FaceDog.applyEffect();
            case "DevilFangs":CoC.instance.transformations.FaceDevilFangs.applyEffect();
            case "Dragon":CoC.instance.transformations.FaceDragon.applyEffect();
            case "DragonFangs":CoC.instance.transformations.FaceDragonFangs.applyEffect();
            case "Echidna":CoC.instance.transformations.FaceEchidna.applyEffect();
            case "Elf":CoC.instance.transformations.FaceElf.applyEffect();
            case "Fairy":CoC.instance.transformations.FaceFairy.applyEffect();
            case "Ferret":CoC.instance.transformations.FaceFerret.applyEffect();
            case "FerretMask":CoC.instance.transformations.FaceFerretMask.applyEffect();
            case "FireSnail":CoC.instance.transformations.FaceFireSnail.applyEffect();
            case "Fox":CoC.instance.transformations.FaceFox.applyEffect();
            case "FoxFangs":CoC.instance.transformations.FaceFoxFangs.applyEffect();
            case "Ghost":CoC.instance.transformations.FaceGhost.applyEffect();
            case "Horse":CoC.instance.transformations.FaceHorse.applyEffect();
            case "Human":CoC.instance.transformations.FaceHuman.applyEffect();
            case "Jabberwocky":CoC.instance.transformations.FaceJabberwocky.applyEffect();
            case "Jiangshi":CoC.instance.transformations.FaceJiangshi.applyEffect();
            case "Kangaroo":CoC.instance.transformations.FaceKangaroo.applyEffect();
            case "Kudere":CoC.instance.transformations.FaceKudere.applyEffect();
            case "Lizard":CoC.instance.transformations.FaceLizard.applyEffect();
            case "Manticore":CoC.instance.transformations.FaceManticore.applyEffect();
            case "Mouse":CoC.instance.transformations.FaceMouse.applyEffect();
            case "OniTeeth":CoC.instance.transformations.FaceOniTeeth.applyEffect();
            case "Orca":CoC.instance.transformations.FaceOrca.applyEffect();
            case "OrcFangs":CoC.instance.transformations.FaceOrcFangs.applyEffect();
            case "Panda":CoC.instance.transformations.FacePanda.applyEffect();
            case "Pig":CoC.instance.transformations.FacePig.applyEffect();
            case "PlantDragon":CoC.instance.transformations.FacePlantDragon.applyEffect();
            case "Raccoon":CoC.instance.transformations.FaceRaccoon.applyEffect();
            case "RaccoonMask":CoC.instance.transformations.FaceRaccoonMask.applyEffect();
            case "RedPanda":CoC.instance.transformations.FaceRedPanda.applyEffect();
            case "Rhino":CoC.instance.transformations.FaceRhino.applyEffect();
            case "Salamander":CoC.instance.transformations.FaceSalamanderFangs.applyEffect();
            case "Shark":CoC.instance.transformations.FaceSharkTeeth.applyEffect();
            case "Smug":CoC.instance.transformations.FaceSmug.applyEffect();
            case "Snake":CoC.instance.transformations.FaceSnakeFangs.applyEffect();
            case "Spider":CoC.instance.transformations.FaceSpiderFangs.applyEffect();
            case "Squirrel":CoC.instance.transformations.FaceSquirrel.applyEffect();
            case "UshiOniOnna":CoC.instance.transformations.FaceUshiOniOnna.applyEffect();
            case "Vampire":CoC.instance.transformations.FaceVampire.applyEffect();
            case "Weasel":CoC.instance.transformations.FaceWeasel.applyEffect();
            case "Wolf":CoC.instance.transformations.FaceWolf.applyEffect();
            case "WolfFangs":CoC.instance.transformations.FaceWolfFangs.applyEffect();
            case "YetiFangs":CoC.instance.transformations.FaceYetiFangs.applyEffect();
            case "YukiOnna":CoC.instance.transformations.FaceYukiOnna.applyEffect();
            default:CoC.instance.transformations.FaceHuman.applyEffect();
        }
        var _sw25_ = (arr[8]);        

        switch (_sw25_)
        {  // Gills  
            case "None":CoC.instance.transformations.GillsNone.applyEffect();
            case "Human":CoC.instance.transformations.GillsNone.applyEffect();
            case "Fish":CoC.instance.transformations.GillsFish.applyEffect();
            case "Anemone":CoC.instance.transformations.GillsAnemone.applyEffect();
            case "Tentacle":CoC.instance.transformations.GillsInTentacleLegs.applyEffect();
            default:CoC.instance.transformations.GillsNone.applyEffect();
        }
        var _sw26_ = (arr[9]);        

        switch (_sw26_)
        {  //Hair  
            /*	CoC.instance.transformations.HairFeather.applyEffect();
				CoC.instance.transformations.HairBurning.applyEffect();
				CoC.instance.transformations.HairSnowy.applyEffect();
				CoC.instance.transformations.HairGrass.applyEffect();
				CoC.instance.transformations.HairGoo.applyEffect();
				CoC.instance.transformations.HairGhost.applyEffect();
				CoC.instance.transformations.HairRatatoskr.applyEffect();
				CoC.instance.transformations.HairWindswept.applyEffect();
				CoC.instance.transformations.HairAnemone.applyEffect();
				CoC.instance.transformations.HairFluffy.applyEffect();
				CoC.instance.transformations.HairCrazy.applyEffect();
				CoC.instance.transformations.HairPrismatic.applyEffect();
				CoC.instance.transformations.HairQuill.applyEffect();
				CoC.instance.transformations.HairFairy.applyEffect();
				CoC.instance.transformations.HairCow.applyEffect();
			*/
            case "Alicorn":CoC.instance.transformations.HairHuman.applyEffect();
                CoC.instance.transformations.HairChangeColor(["white"]).applyEffect();
            case "AtlachNacha":CoC.instance.transformations.HairHuman.applyEffect();
                CoC.instance.transformations.HairChangeColor(AtlachNachaRace.AtlachNachaHairColors).applyEffect();
            case "Elf":CoC.instance.transformations.HairSilky.applyEffect();
                CoC.instance.transformations.HairChangeColor(ElfRace.ElfHairColors).applyEffect();
            case "Fairy":CoC.instance.transformations.HairFairy.applyEffect();
            case "Goblin":CoC.instance.transformations.HairHuman.applyEffect();
                CoC.instance.transformations.HairChangeColor(GoblinRace.GoblinHairColors).applyEffect();
            case "Human":CoC.instance.transformations.HairHuman.applyEffect();
            case "Feather":CoC.instance.transformations.HairFeather.applyEffect();
            case "Ghost":CoC.instance.transformations.HairGhost.applyEffect();
            case "Gorgon":CoC.instance.transformations.HairGorgon.applyEffect();
            case "Kitsune":CoC.instance.transformations.HairHuman.applyEffect();
                CoC.instance.transformations.HairChangeColor(KitsuneRace.BasicKitsuneHairColors).applyEffect();
            case "Kitsumori":CoC.instance.transformations.HairHuman.applyEffect();
                CoC.instance.transformations.HairChangeColor(KitshooRace.KitshooHairColors).applyEffect();
            case "Plant":CoC.instance.transformations.HairLeaf.applyEffect();
                CoC.instance.transformations.HairChangeColor(AlrauneRace.AlrauneHairColor).applyEffect();
            case "Raccoon":CoC.instance.transformations.HairHuman.applyEffect();
                CoC.instance.transformations.HairChangeColor(RaccoonRace.RaccoonHairColors).applyEffect();
            case "Raiju":CoC.instance.transformations.HairStorm.applyEffect();
                CoC.instance.transformations.HairChangeColor(RaijuRace.RaijuHairColors).applyEffect();
            case "Shark":CoC.instance.transformations.HairHuman.applyEffect();
                CoC.instance.transformations.HairChangeColor(SharkRace.SharkHairColors).applyEffect();
            case "Wolf":CoC.instance.transformations.HairHuman.applyEffect();
                CoC.instance.transformations.HairChangeColor(WolfRace.BasicWolfHairColors).applyEffect();
            default:CoC.instance.transformations.HairHuman.applyEffect();
        }
        var _sw27_ = (arr[10]);        

        switch (_sw27_)
        {  // Horns  
            case "Bicorn":CoC.instance.transformations.HornsBicorn.applyEffect();
            case "Cow":CoC.instance.transformations.HornsCowMinotaur.applyEffect();
            case "Deer":CoC.instance.transformations.HornsAntlers.applyEffect();
            case "Demon":CoC.instance.transformations.HornsDemonic.applyEffect();
            case "DragonDual":CoC.instance.transformations.HornsDraconicDual.applyEffect();
            case "DragonQuad":CoC.instance.transformations.HornsDraconicQuadruple.applyEffect();
            case "Frostwyrm":CoC.instance.transformations.HornsFrostwyrm.applyEffect();
            case "Ghost":CoC.instance.transformations.HornsGhostlyWisps.applyEffect();
            case "GoatDual":CoC.instance.transformations.HornsGoat.applyEffect();
            case "GoatQuad":CoC.instance.transformations.HornsGoatQuadruple.applyEffect();
            case "Human":CoC.instance.transformations.HornsNone.applyEffect();
            case "Jabberwocky":CoC.instance.transformations.HornsJabberwocky.applyEffect();
            case "Jiangshi":CoC.instance.transformations.HornsJiangshi.applyEffect();
            case "Kirin":CoC.instance.transformations.HornsKirin.applyEffect();
            case "Kraken":CoC.instance.transformations.HornsKraken.applyEffect();
            case "Oak":CoC.instance.transformations.HornsOak.applyEffect();
            case "Oni":CoC.instance.transformations.HornsOni.applyEffect();
            case "OniDual":CoC.instance.transformations.HornsOniDual.applyEffect();
            case "Orchid":CoC.instance.transformations.HornsOrchid.applyEffect();
            case "Seadragon":CoC.instance.transformations.HornsSeadragon.applyEffect();
            case "Unicorn":CoC.instance.transformations.HornsUnicorn.applyEffect();
            case "UshiOni":CoC.instance.transformations.HornsUshiOni.applyEffect();
            case "Wendigo":CoC.instance.transformations.HornsAntlersWendigo.applyEffect();
            default:CoC.instance.transformations.HornsNone.applyEffect();
        }
        var _sw28_ = (arr[11]);        

        switch (_sw28_)
        {  // Lower Body ( Legs )  
            case "DemonHighHeels":CoC.instance.transformations.LowerBodyDemonHighHeels.applyEffect();
            case "DemonClawed":CoC.instance.transformations.LowerBodyDemonClawed.applyEffect();
            case "Bee":CoC.instance.transformations.LowerBodyBee.applyEffect();
            case "Spider":CoC.instance.transformations.LowerBodySpider.applyEffect();
            case "Drider":CoC.instance.transformations.LowerBodyDrider.applyEffect();
            case "Oni":CoC.instance.transformations.LowerBodyOni.applyEffect();
            case "RedPanda":CoC.instance.transformations.LowerBodyRedPanda.applyEffect();
            case "Orc":CoC.instance.transformations.LowerBodyOrc.applyEffect();
            case "Centipede":CoC.instance.transformations.LowerBodyCentipede.applyEffect();
            case "Wendigo":CoC.instance.transformations.LowerBodyWendigo.applyEffect();
            case "YukiOnna":CoC.instance.transformations.LowerBodyYukiOnna.applyEffect();
            case "PlantRootClaws":CoC.instance.transformations.LowerBodyPlantRootClaws.applyEffect();
            case "PlantHighHeels":CoC.instance.transformations.LowerBodyPlantHighHeels.applyEffect();
            case "Goo":CoC.instance.transformations.LowerBodyGoo.applyEffect();
            case "Ferret":CoC.instance.transformations.LowerBodyFerret.applyEffect();
            case "Avian":CoC.instance.transformations.LowerBodyAvian.applyEffect();
            case "Melkie":CoC.instance.transformations.LowerBodyMelkie.applyEffect();
            case "UshiOni":CoC.instance.transformations.LowerBodyUshiOni.applyEffect();
            case "Mouse":CoC.instance.transformations.LowerBodyMouse.applyEffect();
            case "Hinezumi":CoC.instance.transformations.LowerBodyHinezumi.applyEffect();
            case "Yeti":CoC.instance.transformations.LowerBodyYeti.applyEffect();
            case "Gazer":CoC.instance.transformations.LowerBodyGazer.applyEffect();
            case "FireSnail":CoC.instance.transformations.LowerBodyFireSnail.applyEffect();
            case "Frostwyrm":CoC.instance.transformations.LowerBodyFrostwyrm.applyEffect();
            case "Raccoon":CoC.instance.transformations.LowerBodyRaccoon.applyEffect();
            case "Squirrel":CoC.instance.transformations.LowerBodySquirrel.applyEffect();
            case "Kangaroo":CoC.instance.transformations.LowerBodyKangaroo.applyEffect();
            case "CaveWyrm":CoC.instance.transformations.LowerBodyCaveWyrm.applyEffect();
            case "Bunny":CoC.instance.transformations.LowerBodyBunny.applyEffect();
            case "Jabberwocky":CoC.instance.transformations.LowerBodyJabberwocky.applyEffect();
            case "Crab":CoC.instance.transformations.LowerBodyCrab.applyEffect();
            case "Cancer":CoC.instance.transformations.LowerBodyCancer.applyEffect();
            
            
            
            case "Alraune":CoC.instance.transformations.LowerBodyPlantFlower.applyEffect();
            case "Ant":CoC.instance.transformations.LowerBodyAnt.applyEffect();
            case "Atlach":CoC.instance.transformations.LowerBodyAtlach.applyEffect();
            case "AtlachNacha":CoC.instance.transformations.LowerBodyAtlachNacha.applyEffect();
            case "Bipedal":CoC.instance.transformations.LowerBodyBipedal.applyEffect();
            case "Dragon":CoC.instance.transformations.LowerBodyDraconic().applyEffect();
            case "Elf":CoC.instance.transformations.LowerBodyElf.applyEffect();
            case "Ghost":CoC.instance.transformations.LowerBodyGhost.applyEffect();
            case "Ghost2":CoC.instance.transformations.LowerBodyGhost2.applyEffect();
            case "Harpy":CoC.instance.transformations.LowerBodyHarpy.applyEffect();
            case "Human":CoC.instance.transformations.LowerBodyBipedal.applyEffect();
                CoC.instance.transformations.LowerBodyHuman.applyEffect();
            case "Horse":CoC.instance.transformations.LowerBodyBipedal.applyEffect();
                CoC.instance.transformations.LowerBodyHoofed().applyEffect();
            case "Hydra":CoC.instance.transformations.LowerBodyHydra.applyEffect();
            case "Jiangshi":CoC.instance.transformations.LowerBodyJiangshi.applyEffect();
            case "Kraken":CoC.instance.transformations.LowerBodyKraken.applyEffect();
            case "Raiju":CoC.instance.transformations.LowerBodyRaiju().applyEffect();
            case "Salamander":CoC.instance.transformations.LowerBodySalamander().applyEffect();
            case "Scylla":CoC.instance.transformations.LowerBodyScylla.applyEffect();
            case "Shark":CoC.instance.transformations.LowerBodyShark().applyEffect();
            case "Snake":CoC.instance.transformations.LowerBodySnake.applyEffect();
            case "Wolf":CoC.instance.transformations.LowerBodyWolf().applyEffect();
            default:CoC.instance.transformations.LowerBodyBipedal.applyEffect();
                CoC.instance.transformations.LowerBodyHuman.applyEffect();
        }
        var _sw29_ = (arr[12]);        

        switch (_sw29_)
        {  // Rear Body ( Back/Neck )  
            case "AtlachNacha":CoC.instance.transformations.RearBodyAtlachNacha.applyEffect();
            case "Bat":CoC.instance.transformations.RearBodyBatCollar.applyEffect();
            case "Centipede":CoC.instance.transformations.RearBodyCentipede.applyEffect();
            case "Cobra":CoC.instance.transformations.RearBodyCobraHood.applyEffect();
            case "Displacer":CoC.instance.transformations.RearBodyDisplacerTentacles.applyEffect();
            case "Eyestalk":CoC.instance.transformations.RearBodyTentacleEyestalks.applyEffect();
            case "Fenrir":CoC.instance.transformations.RearBodyFenrirIceSpikes.applyEffect();
            case "FrostWyrm":CoC.instance.transformations.RearBodyFrostwyrm.applyEffect();
            case "FurCoat":CoC.instance.transformations.RearBodyFurCoat.applyEffect();
            case "Ghost":CoC.instance.transformations.RearBodyGhostlyAura.applyEffect();
            case "Glacial":CoC.instance.transformations.RearBodyGlacialAura.applyEffect();
            case "Goo":CoC.instance.transformations.RearBodyMetamorphicGoo.applyEffect();
            case "Human":CoC.instance.transformations.RearBodyNone.applyEffect();
            case "Kraken":CoC.instance.transformations.RearBodyKraken.applyEffect();
            case "Lion":CoC.instance.transformations.RearBodyLionMane.applyEffect();
            case "Orca":CoC.instance.transformations.RearBodyOrcaBlowhole.applyEffect();
            case "Raiju":CoC.instance.transformations.RearBodyRaijuMane.applyEffect();
            case "Shark":CoC.instance.transformations.RearBodySharkFin.applyEffect();
            case "Snail":CoC.instance.transformations.RearBodySnailShell.applyEffect();
            case "Yeti":CoC.instance.transformations.RearBodyYetiFur.applyEffect();
            case "Wolf":CoC.instance.transformations.RearBodyWolfCollar.applyEffect();
            default:CoC.instance.transformations.RearBodyNone.applyEffect();
        }
        var _sw30_ = (arr[13]);        

        switch (_sw30_)
        {  //Skin  
            /*ransformations.SkinPatternNone.applyEffect();
				CoC.instance.transformations.SkinPatternOrc.applyEffect();
				CoC.instance.transformations.SkinPatternOni.applyEffect();
				CoC.instance.transformations.SkinPatternKitsune.applyEffect();
				CoC.instance.transformations.SkinPatternVenomousMarkings.applyEffect();
				CoC.instance.transformations.SkinPatternOil.applyEffect();
				CoC.instance.transformations.SkinPatternScarWindswept.applyEffect();
				CoC.instance.transformations.SkinPatternUshiOniTattoo.applyEffect();
				CoC.instance.transformations.SkinPatternBeeStripes.applyEffect();
				CoC.instance.transformations.SkinPatternTigerSharkStripes.applyEffect();
				CoC.instance.transformations.SkinPatternOrca.applyEffect();
				CoC.instance.transformations.SkinPatternSeaDragon.applyEffect();
			*/
            case "Alraune":
                CoC.instance.transformations.SkinColor(AlrauneRace.AlrauneSkinColor).applyEffect();
                CoC.instance.transformations.SkinPlain.applyEffect();
            case "Alicorn":
                CoC.instance.transformations.SkinPlain.applyEffect();
                CoC.instance.transformations.SkinFur(Skin.COVERAGE_COMPLETE, {
                                    colors : AlicornRace.AlicornFurColors
                                }).applyEffect();
            case "Ant":
                CoC.instance.transformations.SkinPlain.applyEffect();
                CoC.instance.transformations.SkinChitin(Skin.COVERAGE_COMPLETE, {
                                    colors : AntRace.AntChitinColors
                                }).applyEffect();
            case "AtlachNacha":
                CoC.instance.transformations.SkinPlain.applyEffect();
                CoC.instance.transformations.SkinChitin(Skin.COVERAGE_COMPLETE, {
                                    colors : AtlachNachaRace.AtlachNachaChitinColors
                                }).applyEffect();
            case "Dragon":
                CoC.instance.transformations.SkinPlain.applyEffect();
                CoC.instance.transformations.SkinDragonScales(Skin.COVERAGE_COMPLETE, {
                                    colors : DragonRace.DragonScaleColors
                                }).applyEffect();
            case "Elf":
                CoC.instance.transformations.SkinPatternNone.applyEffect();
                CoC.instance.transformations.SkinColor(ElfRace.ElfSkinColors).applyEffect();
                CoC.instance.transformations.SkinPlain.applyEffect();
                player.skinAdj = "flawless";
            case "Fenrir":
                CoC.instance.transformations.SkinPlain.applyEffect();
                CoC.instance.transformations.SkinFur(Skin.COVERAGE_COMPLETE, {
                                    colors : WolfRace.BasicWolfFurColors
                                }).applyEffect();
            case "Goblin":
                CoC.instance.transformations.SkinPlain.applyEffect();
                CoC.instance.transformations.SkinColor(GoblinRace.GoblinSkinColors).applyEffect();
            case "Ghost":
                CoC.instance.transformations.SkinTransparent.applyEffect();
                CoC.instance.transformations.SkinPatternWhiteBlackVeins.applyEffect();
                CoC.instance.transformations.SkinColor(PoltergeistRace.PoltergeistSkinColors).applyEffect();
            case "Human":
                CoC.instance.transformations.SkinPatternNone.applyEffect();
                CoC.instance.transformations.SkinColor(HumanRace.HumanSkinColors).applyEffect();
                CoC.instance.transformations.SkinPlain.applyEffect();
            case "Jiangshi":
                CoC.instance.transformations.SkinColor(JiangshiRace.JiangshiSkinColors).applyEffect();
                CoC.instance.transformations.SkinPlain.applyEffect();
            case "Kitsune":
                CoC.instance.transformations.SkinPlain.applyEffect();
                CoC.instance.transformations.SkinFur(Skin.COVERAGE_COMPLETE, {
                                    colors : KitsuneRace.BasicKitsuneFurColors
                                }).applyEffect();
                CoC.instance.transformations.SkinPatternKitsune.applyEffect();
            case "Kitsumori":
                CoC.instance.transformations.SkinPlain.applyEffect();
                CoC.instance.transformations.SkinFur(Skin.COVERAGE_COMPLETE, {
                                    colors : KitshooRace.KitshooFurColors
                                }).applyEffect();
                CoC.instance.transformations.SkinPatternKitsune.applyEffect();
            case "Kraken":
                CoC.instance.transformations.SkinSlippery.applyEffect();
                CoC.instance.transformations.SkinColor(ScyllaRace.ScyllaSkinColors).applyEffect();
            case "Raccoon":
                CoC.instance.transformations.SkinFur(Skin.COVERAGE_COMPLETE, {
                                    colors : RaccoonRace.RaccoonFurColors
                                }).applyEffect();
            case "Wolf":
                CoC.instance.transformations.SkinFur(Skin.COVERAGE_COMPLETE, {
                                    colors : WolfRace.BasicWolfHairColors
                                }).applyEffect();
            case "Raiju":
                CoC.instance.transformations.SkinPatternRaiju.applyEffect();
            case "Salamander":
                CoC.instance.transformations.SkinScales(Skin.COVERAGE_LOW, {
                                    colors : SalamanderRace.SalamanderScaleColors
                                }).applyEffect();
            case "Shark", "Snake":

                switch (_sw30_)
                {case "Shark":
                        CoC.instance.transformations.SkinAquaScales(Skin.COVERAGE_HIGH, {
                                            color : "orange",
                                            color2 : "black",
                                            pattern : Skin.PATTERN_TIGER_STRIPES
                                        }).applyEffect();
                        //CoC.instance.transformations.SkinPatternTigerSharkStripes.applyEffect();
                        break;
                }
                CoC.instance.transformations.SkinScales(Skin.COVERAGE_LOW, {
                                    colors : NagaRace.SnakeScaleColors
                                }).applyEffect();
            case "Vouivre":
                CoC.instance.transformations.SkinDragonScales(Skin.COVERAGE_COMPLETE, {
                                    colors : NagaRace.SnakeScaleColors
                                }).applyEffect();
            
            case "Fur":  // Default Fur - For races with no color requirements  
            CoC.instance.transformations.SkinFur(Skin.COVERAGE_COMPLETE).applyEffect();
            default:
                CoC.instance.transformations.SkinPatternNone.applyEffect();
                CoC.instance.transformations.SkinPlain.applyEffect();
        }
        var _sw31_ = (arr[14]);        

        switch (_sw31_)
        {  // Ovipositor ( Bee/Spider egg laying )  
            case "Ant":if (!player.canOvipositAnt())
                {
                    CoC.instance.transformations.OvipositorAnt.applyEffect();
                }
            case "Human":if (!player.canOviposit())
                {
                    CoC.instance.transformations.RemoveOvipositor.applyEffect();
                }
            case "Mantis":if (!player.canOvipositMantis())
                {
                    CoC.instance.transformations.OvipositorMantis.applyEffect();
                }
            case "Spider":if (!player.canOvipositSpider())
                {
                    CoC.instance.transformations.OvipositorSpider.applyEffect();
                }
            default:if (player.canOviposit())
                {
                    CoC.instance.transformations.RemoveOvipositor.applyEffect();
                }
        }
        var _sw32_ = (arr[15]);        

        switch (_sw32_)
        {  // Oviposition ( Harpy / Reptile egg laying )  
            case "Human":CoC.instance.transformations.RemoveOviposition.applyEffect();
            default:CoC.instance.transformations.RemoveOviposition.applyEffect();
        }
        var _sw33_ = (arr[16]);        

        switch (_sw33_)
        {  // Glowing Asshole  
            case "Human":CoC.instance.transformations.AssholeNormal.applyEffect();
            case "Glow":CoC.instance.transformations.AssholeGlowing.applyEffect();
            default:CoC.instance.transformations.AssholeNormal.applyEffect();
        }
        var _sw34_ = (arr[17]);        

        switch (_sw34_)
        {  //Tail  
            /*	CoC.instance.transformations.TailScorpion.applyEffect();
				CoC.instance.transformations.TailManticore.applyEffect();
				CoC.instance.transformations.TailBurning.applyEffect();
				CoC.instance.transformations.TailTwinkasha.applyEffect();
				CoC.instance.transformations.TailCat.applyEffect();
				CoC.instance.transformations.TailNekomataOneThirdForked.applyEffect();
				CoC.instance.transformations.TailNekomataTwoThirdsForked.applyEffect();
				CoC.instance.transformations.TailCat2nd.applyEffect();
				CoC.instance.transformations.TailRedPanda.applyEffect(); 
				CoC.instance.transformations.TailKirin.applyEffect();
				CoC.instance.transformations.TailPig.applyEffect();
				CoC.instance.transformations.TailMantis.applyEffect();
				CoC.instance.transformations.TailGoat.applyEffect();
				CoC.instance.transformations.TailCow.applyEffect();
				CoC.instance.transformations.TailDraconic.applyEffect();
				CoC.instance.transformations.TailOrca.applyEffect();
				CoC.instance.transformations.TailHarpy.applyEffect();
				CoC.instance.transformations.TailBee.applyEffect();
				CoC.instance.transformations.TailLizard.applyEffect();
				CoC.instance.transformations.TailDemonic.applyEffect();
				CoC.instance.transformations.TailDog.applyEffect();
				CoC.instance.transformations.TailCaveWyrm.applyEffect();
				CoC.instance.transformations.TailAvian.applyEffect();
				CoC.instance.transformations.TailGriffin.applyEffect();
				CoC.instance.transformations.TailKangaroo.applyEffect();
				CoC.instance.transformations.TailThunderbird.applyEffect();
				CoC.instance.transformations.TailSquirrel.applyEffect();
				CoC.instance.transformations.TailWeasel.applyEffect();
				CoC.instance.transformations.TailMouse.applyEffect();
				CoC.instance.transformations.TailHinezumi.applyEffect();
				CoC.instance.transformations.TailFerret.applyEffect();
				CoC.instance.transformations.TailBear.applyEffect();
				CoC.instance.transformations.TailUshiOni.applyEffect();
				CoC.instance.transformations.TailWendigo.applyEffect();
			*/
            case "Ant":CoC.instance.transformations.TailAnt.applyEffect();
            case "Atlach":CoC.instance.transformations.TailSpinneretAtlach.applyEffect();
            case "Bunny":CoC.instance.transformations.TailRabbit.applyEffect();
            case "Dragon":CoC.instance.transformations.TailDraconic.applyEffect();
            case "Horse":CoC.instance.transformations.TailHorse.applyEffect();
            case "Human":CoC.instance.transformations.TailNone.applyEffect();
            case "Hydra":CoC.instance.transformations.TailHydra.applyEffect();
            case "Kitsune":CoC.instance.transformations.TailFox(9).applyEffect();
            case "Kitsumori":CoC.instance.transformations.TailKitshoo(9).applyEffect();
            case "Raccoon":CoC.instance.transformations.TailRaccoon.applyEffect();
            case "Raiju":CoC.instance.transformations.TailRaiju.applyEffect();
            case "Salamander":CoC.instance.transformations.TailSalamander.applyEffect();
            case "Shark":CoC.instance.transformations.TailShark.applyEffect();
            case "Spider":CoC.instance.transformations.TailSpider.applyEffect();
            case "Wolf":CoC.instance.transformations.TailWolf.applyEffect();
            default:CoC.instance.transformations.TailNone.applyEffect();
        }
        var _sw35_ = (arr[18]);        

        switch (_sw35_)
        {  // Tongue  
            case "Cat":CoC.instance.transformations.TongueCat.applyEffect();
            case "CaveWyrm":CoC.instance.transformations.TongueCaveWyrm.applyEffect();
            case "Demon":CoC.instance.transformations.TongueDemonic.applyEffect();
            case "Dog":CoC.instance.transformations.TongueDog.applyEffect();
            case "Dragon":CoC.instance.transformations.TongueDraconic.applyEffect();
            case "Elf":CoC.instance.transformations.TongueElf.applyEffect();
            case "Ghost":CoC.instance.transformations.TongueGhost.applyEffect();
            case "Human":CoC.instance.transformations.TongueHuman.applyEffect();
            case "Melkie":CoC.instance.transformations.TongueMelkie.applyEffect();
            case "Ratatoskr":CoC.instance.transformations.TongueRatatoskr.applyEffect();
            case "Ravenous":CoC.instance.transformations.TongueRavenous.applyEffect();
            case "Snake":CoC.instance.transformations.TongueSnake.applyEffect();
            default:CoC.instance.transformations.TongueHuman.applyEffect();
        }
        var _sw36_ = (arr[19]);        

        switch (_sw36_)
        {  //Wings  
            /*	CoC.instance.transformations.WingsFeatheredSphinx.applyEffect();
				CoC.instance.transformations.WingsManticoreLarge.applyEffect();
				CoC.instance.transformations.WingsManticoreSmall.applyEffect();
				CoC.instance.transformations.WingsNightmare.applyEffect(); 
				CoC.instance.transformations.WingsThunderousAura.applyEffect();
				CoC.instance.transformations.WingsMantisLarge.applyEffect();
				CoC.instance.transformations.WingsMantisSmall.applyEffect();
				CoC.instance.transformations.WingsDraconicHuge.applyEffect();
				CoC.instance.transformations.WingsDraconicLarge.applyEffect();
				CoC.instance.transformations.WingsDraconicSmall.applyEffect();
				CoC.instance.transformations.WingsFeatheredPhoenix.applyEffect();
				CoC.instance.transformations.WingsBeeLarge.applyEffect();
				CoC.instance.transformations.WingsBeeSmall.applyEffect();
				CoC.instance.transformations.WingsDemonicQuadrupleLarge.applyEffect();
				CoC.instance.transformations.WingsDemonicLarge.applyEffect();
				CoC.instance.transformations.WingsDemonicTiny.applyEffect();
				CoC.instance.transformations.WingsVampire.applyEffect();
				CoC.instance.transformations.WingsFeatheredAvian.applyEffect();
				CoC.instance.transformations.WingsLevitation.applyEffect();
				CoC.instance.transformations.WingsWindyAura.applyEffect();
				CoC.instance.transformations.WingsGiantDragonfly.applyEffect();
				CoC.instance.transformations.WingsSeaDragon.applyEffect();
				CoC.instance.transformations.WingsDevilfeather.applyEffect();
				CoC.instance.transformations.WingsFeyDragon.applyEffect();
				CoC.instance.transformations.WingsJabberwocky.applyEffect();
				CoC.instance.transformations.WingsPlant.applyEffect();
				 
			 */
            case "Ant":CoC.instance.transformations.WingsAntLarge.applyEffect();
            case "Alicorn":CoC.instance.transformations.WingsFeatheredAlicorn.applyEffect();
            case "Couatl":CoC.instance.transformations.WingsCouatl.applyEffect();
            case "DraconicL":CoC.instance.transformations.WingsDraconicLarge.applyEffect();
            case "Fairy":CoC.instance.transformations.WingsFairy.applyEffect();
            case "Feathered":CoC.instance.transformations.WingsFeatheredLarge.applyEffect();
            case "Ghost":CoC.instance.transformations.WingsEthereal.applyEffect();
            case "Phoenix":CoC.instance.transformations.WingsFeatheredPhoenix.applyEffect();
            case "Human":CoC.instance.transformations.WingsNone.applyEffect();
            case "Thunder":CoC.instance.transformations.WingsThunderousAura.applyEffect();
            default:CoC.instance.transformations.WingsNone.applyEffect();
        }
        var _sw37_ = (arr[20]);        

        switch (_sw37_)
        {  //Cocks  
            /*	public var cocks:CockCoC.instance.transformations = new CockCoC.instance.transformations();
				public function UnlockCocks():void { return cocks.UnlockCocks(); }
				public function CockNone(cock:int = 0): Transformation { return cocks.CockNone(); }
				public function CockHuman(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 			{ return cocks.CockHuman(cock, length, thickness); }
				public function CockKirin(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 			{ return cocks.CockKirin(cock, length, thickness); }
				public function CockDog(cock:int = 0, length:Number = 5.5, thickness:Number = 1, knot:Number = 1.4): Transformation { return cocks.CockDog(cock, length, thickness, knot); }
				public function CockDemon(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 			{ return cocks.CockDemon(cock, length, thickness); }
				public function CockTentacle(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockTentacle(cock, length, thickness); }
				public function CockScylla(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockScylla(cock, length, thickness); }
				public function CockCat(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 			{ return cocks.CockCat(cock, length, thickness); }
				public function CockCancer(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockCancer(cock, length, thickness); }
				public function CockLizard(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockLizard(cock, length, thickness); }
				public function CockCaveWyrm(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockCaveWyrm(cock, length, thickness); }
				public function CockAnemone(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockAnemone(cock, length, thickness); }
				public function CockKangaroo(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockKangaroo(cock, length, thickness); }
				public function CockDragon(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockDragon(cock, length, thickness); }
				public function CockDisplacer(cock:int = 0, length:Number = 5.5, thickness:Number = 1, knot:Number = 1.5): Transformation { return cocks.CockDisplacer(cock, length, thickness, knot); }
				public function CockFox(cock:int = 0, length:Number = 5.5, thickness:Number = 1, knot:Number = 1.25): Transformation { return cocks.CockFox(cock, length, thickness, knot); }
				public function CockBee(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 			{ return cocks.CockBee(cock, length, thickness); }
				public function CockPig(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 			{ return cocks.CockPig(cock, length, thickness); }
				public function CockAvian(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 			{ return cocks.CockAvian(cock, length, thickness); }
				public function CockRhino(cock:int = 0, length:Number = 5.5, thickness:Number = 1, inBlackCock:Boolean = false): Transformation { return cocks.CockRhino(cock, length, thickness, inBlackCock); }
				public function CockEchidna(cock:int = 0, length:Number = 5.5, thickness:Number = 1, inBlackCock:Boolean = false): Transformation { return cocks.CockEchidna(cock, length, thickness, inBlackCock); }
				public function CockWolf(cock:int = 0, length:Number = 5.5, thickness:Number = 1, knot:Number = 1.1): Transformation { return cocks.CockWolf(cock, length, thickness, knot); }
				public function CockStamen(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockStamen(cock, length, thickness); }
				public function CockRedPanda(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockRedPanda(cock, length, thickness); }
				public function CockGryphon(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockGryphon(cock, length, thickness); }
				public function CockCentipede(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockCentipede(cock, length, thickness); }
				public function CockUshiOni(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockUshiOni(cock, length, thickness); }
				public function CockInsect(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockInsect(cock, length, thickness); }
				public function GrowKnot(cock:int = 0, crit:Number = 1, mod:Number = 1, div:Number = 20): Transformation 	{ return cocks.GrowKnot(cock, crit, mod, div); }
				public function CockChangeType(type:CockTypesEnum, grow:Boolean, oneByOne:Boolean=false):Transformation 	{ return cocks.CockChangeType(type, grow, oneByOne); }
				*/
            case "Alraune":if (player.cocks.length >= 1)
                {
                    CoC.instance.transformations.CockStamen(0, rand(3) + 4).applyEffect(false);
                }
            case "Horse":if (player.cocks.length >= 1)
                {
                    CoC.instance.transformations.CockHorse(0, rand(3) + 4).applyEffect(false);
                }
            case "Human":if (player.cocks.length >= 1)
                {
                    CoC.instance.transformations.CockHuman(0, rand(3) + 4).applyEffect(false);
                }
            case "Insect":if (player.cocks.length >= 1)
                {
                    CoC.instance.transformations.CockInsect(0, rand(3) + 4).applyEffect(false);
                }
            case "Lizard":if (player.cocks.length >= 1)
                {
                    CoC.instance.transformations.CockLizard(0, rand(3) + 4).applyEffect(false);
                }
            case "Raiju":if (player.cocks.length >= 1)
                {
                    CoC.instance.transformations.CockRaiju(0, rand(3) + 4).applyEffect(false);
                }
            case "Wolf":if (player.cocks.length >= 1)
                {
                    CoC.instance.transformations.CockWolf(0, rand(3) + 4).applyEffect(false);
                }
            case "EasterBunny", "Raccoon":CoC.instance.transformations.CockHuman(0, rand(3) + 4).applyEffect(false);
            default:if (player.cocks.length >= 1)
                {
                    CoC.instance.transformations.CockHuman(0, rand(3) + 4).applyEffect(false);
                }
        }
        var _sw38_ = (arr[21]);        

        switch (_sw38_)
        {  // Vaginas  
            /*	public var vaginas:VaginaCoC.instance.transformations = new VaginaCoC.instance.transformations();
				public function UnlockVagina(): void { return vaginas.UnlockVagina(); }
				public function VaginaNone(vagina:int = 0): Transformation { return vaginas.VaginaNone(vagina); }
				public function CockToVagina(vagina:int = 0): Transformation { return vaginas.CockToVagina(vagina); }
				public function VaginaHuman(vagina:int = 0): Transformation { return vaginas.VaginaHuman(vagina); }
				public function VaginaKirin(vagina:int = 0): Transformation { return vaginas.VaginaKirin(vagina); }
				public function VaginaSandTrap(vagina:int = 0): Transformation { return vaginas.VaginaSandTrap(vagina); }
				public function VaginaCaveWyrm(vagina:int = 0): Transformation { return vaginas.VaginaCaveWyrm(vagina); }
				public function VaginaCentipede(vagina:int = 0): Transformation { return vaginas.VaginaCentipede(vagina); }
				public function VaginaManticore(vagina:int = 0): Transformation { return vaginas.VaginaManticore(vagina); }
				public function VaginaCancer(vagina:int = 0): Transformation { return vaginas.VaginaCancer(vagina); }
				public function VaginaDemonic(vagina:int = 0): Transformation { return vaginas.VaginaDemonic(vagina); }
				public function VaginaScylla(vagina:int = 0): Transformation { return vaginas.VaginaScylla(vagina); }
				public function VaginaNaga(vagina:int = 0): Transformation { return vaginas.VaginaNaga(vagina); }
				public function VaginaShark(vagina:int = 0): Transformation { return vaginas.VaginaShark(vagina); }
			*/
            case "Alraune":if (player.hasVagina())
                {
                    CoC.instance.transformations.VaginaAlraune().applyEffect();
                }
            case "Human":if (player.hasVagina())
                {
                    CoC.instance.transformations.VaginaHuman().applyEffect();
                }
            case "Horse":if (player.hasVagina())
                {
                    CoC.instance.transformations.VaginaHorse().applyEffect();
                }
            case "Lizard":if (player.hasVagina())
                {
                    CoC.instance.transformations.VaginaNaga().applyEffect();
                }
            case "Raiju":if (player.hasVagina())
                {
                    CoC.instance.transformations.VaginaRaiju().applyEffect();
                }
            case "Scylla":if (player.hasVagina())
                {
                    CoC.instance.transformations.VaginaScylla().applyEffect();
                }
            case "Shark":if (player.hasVagina())
                {
                    CoC.instance.transformations.VaginaShark().applyEffect();
                }
            
            
            
            case "Goblin":if (!player.hasVagina())
                {
                    CoC.instance.transformations.VaginaHuman().applyEffect();
                }
            default:if (player.hasVagina())
                {
                    CoC.instance.transformations.VaginaHuman().applyEffect();
                }
        }
        var _sw39_ = (arr[22]);        

        switch (_sw39_)
        {  // Race Specific Perks  
            case "AtlachNacha":
                player.createPerk(PerkLib.Venomancy, 0, 0, 0, 0);
                player.createPerk(PerkLib.Insanity, 0, 0, 0, 0);
            case "EasterBunny":
                player.createPerk(PerkLib.EasterBunnyBalls, 0, 0, 0, 0);
            case "Elf":
                player.createPerk(PerkLib.FlawlessBody, 0, 0, 0, 0);
                player.createPerk(PerkLib.ElvenSense, 0, 0, 0, 0);
            case "Fairy":
                player.createPerk(PerkLib.FlawlessBody, 0, 0, 0, 0);
            case "Ghost":
                player.createPerk(PerkLib.Ghostslinger, 0, 0, 0, 0);
                player.createPerk(PerkLib.Telekinesis, 0, 0, 0, 0);
                player.createPerk(PerkLib.PhantomShooting, 0, 0, 0, 0);
            case "Goblin":
                player.createPerk(PerkLib.GoblinoidBlood, 0, 0, 0, 0);
                player.createPerk(PerkLib.BouncyBody, 0, 0, 0, 0);
            case "Jiangshi":
                player.createPerk(PerkLib.HaltedVitals, 0, 0, 0, 0);
                player.createPerk(PerkLib.SuperStrength, 0, 0, 0, 0);
                player.createPerk(PerkLib.PoisonNails, 0, 0, 0, 0);
                player.createPerk(PerkLib.Rigidity, 0, 0, 0, 0);
                player.createPerk(PerkLib.LifeLeech, 0, 0, 0, 0);
                player.createPerk(PerkLib.Undeath, 0, 0, 0, 0);
                player.createPerk(PerkLib.EnergyDependent, 0, 0, 0, 0);
                flags[kFLAGS.CURSE_OF_THE_JIANGSHI] = 2;
            case "Phoenix":
                player.createPerk(PerkLib.HarpyWomb, 10, 0, 0, 0);
            default:
        }
    }
}
