/**
 * ...
 * @author Liadri
 */
package classes.scenes.areas.tundra;

import classes.*;
import classes.globalFlags.*;
import classes.scenes.areas.forest.Alraune;
import classes.scenes.Holidays;
import classes.scenes.SceneLib;
import classes.internals.ChainedDrop;
import classes.display.SpriteDb;

class SnowLily extends Alraune
{
    override public function defeated(hpVictory : Bool) : Void
    {
        if (player.hasStatusEffect(StatusEffects.RiverDungeonA))
        {
            cleanupAfterCombat();
        }
        else
        {
            SceneLib.forest.alrauneScene.alrauneDeepwoodsWon();
        }
    }
    
    override public function won(hpVictory : Bool, pcCameWorms : Bool) : Void
    {
        if (player.hasStatusEffect(StatusEffects.RiverDungeonA))
        {
            SceneLib.dungeons.riverdungeon.defeatedByPlantWomen();
        }
        else
        {
            SceneLib.forest.alrauneScene.alrauneDeepwoodsLost();
        }
    }
    
    public function new()
    {
        super();
        if (player.hasStatusEffect(StatusEffects.RiverDungeonA))
        {
            this.a = "a ";
            this.short = "mist snow lily alraune";
            this.long = "You are fighting against a Mist Snow Lily, an intelligent plant with the torso of a woman and the lower body of a giant flower. Whole her body cover faint vein-like lines. She seems really keen on raping you.";
            this.bodyColor = "light blue";
            this.hairColor = "white";
        }
        else if (Holidays.isHalloween())
        {
            this.short = "Jack-O-Raune";
            this.long = "You are fighting against a Jack-O-Raune, an intelligent plant with the torso of a woman and the lower body of a giant pumpkin with snaking tentacle vines. She seems really keen on raping you.";
            this.bodyColor = "pale orange";
            this.hairColor = "dark green";
        }
        else
        {
            this.short = "snow lily alraune";
            this.long = "You are fighting against a Snow Lily, an intelligent plant with the torso of a woman and the lower body of a giant flower. She seems really keen on raping you.";
            this.bodyColor = "light blue";
            this.hairColor = "white";
        }
        if (player.hasStatusEffect(StatusEffects.RiverDungeonA))
        {
            initStrTouSpeInte(38, 740, 38, 300);
            initWisLibSensCor(300, 520, 220, 10);
            this.armorDef = 625;
            this.armorMDef = 135;
            this.bonusHP = 1800;
            this.bonusLust = 710;
            this.level = 70;
            this.createPerk(PerkLib.EnemyEliteType, 0, 0, 0, 0);
            this.drop = new ChainedDrop().add(consumables.SNOWFLO, 1 / 6).add(consumables.MARAFRU, 1 / 4).add(useables.PCSHARD, 1 / 2);
        }
        else
        {
            initStrTouSpeInte(10, 250, 10, 100);
            initWisLibSensCor(100, 200, 50, 10);
            this.armorDef = 90;
            this.armorMDef = 9;
            this.bonusHP = 200;
            this.bonusLust = 290;
            this.level = 40;
            this.drop = new ChainedDrop().add(consumables.SNOWFLO, 1 / 6).add(consumables.MARAFRU, 1 / 4);
        }
        this.imageName = "snow lily alraune";
        this.gems = rand(25) + 15;
        this.removePerk(PerkLib.FireVulnerability);
        this.createPerk(PerkLib.IceNature, 0, 0, 0, 0);
        this.createPerk(PerkLib.EnemyPlantType, 0, 0, 0, 0);
        checkMonster();
    }
}


