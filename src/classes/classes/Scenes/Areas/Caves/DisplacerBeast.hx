/**
 * ...
 * @author Liadri
 */
package classes.scenes.areas.caves;

import classes.*;
import classes.bodyParts.Butt;
import classes.bodyParts.Hips;
import classes.globalFlags.KFLAGS;
import classes.scenes.SceneLib;
import classes.internals.*;

class DisplacerBeast extends Monster
{
    public function moveDisplacerBeastPhaseStrike() : Void
    {
        outputText("The displacer beast blinks out and appears right behind you as it begins mauling you with its claws.");
        for (i in 1...4)
        {
            outputText("\n\nThe displacer beast claws you! ");
            phasestrikeDmg();
        }
    }
    private function phasestrikeDmg() : Void
    {
        var damage : Float = 0;
        damage += eBaseStrengthDamage();
        damage += this.weaponAttack;
        damage += rand(str);
        damage += rand(weaponAttack);
        damage += 1.2;
        damage = Math.round(damage);
        player.takePhysDamage(damage, true);
    }
    
    override public function preMeleeMissed() : Void
    {
        outputText("The displacer beast teleports, dodging your attack.\n");
    }
    
    override public function defeated(hpVictory : Bool) : Void
    {
        SceneLib.displacerbeastScene.displacerBeastVictory();
    }
    
    override public function won(hpVictory : Bool, pcCameWorms : Bool) : Void
    {
        if (inDungeon)
        {
            inDungeon = false;
        }  //EL check  
        if (flags[kFLAGS.DISPLACER_BEAST_WINS] < 1)
        {
            flags[kFLAGS.DISPLACER_BEAST_WINS] = 1;
        }
        SceneLib.displacerbeastScene.displacerBeastDefeat();
    }
    
    override private function get_long() : String
    {
        var str : String = "";
        str += "This strange cat girl has two pairs of arms ending with clawed paws. From her back grows two long tentacles similar to that of a calamari. She growls aggressively at you like a feral beast and despite the obvious clothes she wears, she might as well be one.";
        if (game.flags[kFLAGS.DISPLACER_BEAST_WINS] >= 1)
        {
            str += " She’s clearly starved and wants your milk!";
        }
        return str;
    }
    
    public function new()
    {
        super();
        if (inDungeon)
        
        //EL check{
            
            var mod : Int = SceneLib.dungeons.ebonlabyrinth.enemyLevelMod;
            initStrTouSpeInte(162 + 11 * mod, 142 + 21 * mod, 210 + 30 * mod, 76 + 10 * mod);
            initWisLibSensCor(76 + 10 * mod, 120 + 20 * mod, 60 + 10 * mod, -40);
            this.weaponAttack = 40 + 6 * mod;
            this.armorDef = 40 + 3 * mod;
            this.armorMDef = 40 + 3 * mod;
            this.bonusHP = 100 + 50 * mod;
            this.bonusLust = 240 + 34 * mod;
            this.level = 60 + 5 * mod;
            this.gems = (mod > 20) ? 0 : Math.floor((120 + rand(60)) * Math.exp(0.3 * mod));
            this.additionalXP = (mod > 20) ? 0 : Math.floor(800 * Math.exp(0.3 * mod));
        }
        else
        {
            initStrTouSpeInte(152, 152, 210, 76);
            initWisLibSensCor(76, 120, 60, -40);
            this.weaponAttack = 40;
            this.armorDef = 40;
            this.armorMDef = 40;
            this.bonusHP = 100;
            this.bonusLust = 240;
            this.level = 60;
            this.gems = rand(20) + 80;
        }
        this.a = "the ";
        this.short = "displacer beast";
        this.imageName = "displacer beast";
        this.long = "";
        this.createVagina(false, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_NORMAL);
        createBreastRow(Appearance.breastCupInverse("D"));
        this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
        this.ass.analWetness = AssClass.WETNESS_NORMAL;
        this.tallness = 72;
        this.hips.type = Hips.RATING_CURVY;
        this.butt.type = Butt.RATING_LARGE + 2;
        this.bodyColor = "";
        this.hairColor = "";
        this.hairLength = 9;
        this.weaponName = "claws";
        this.weaponVerb = "slash";
        this.armorName = "fur";
        this.wrath = 130;
        this.lustVuln = .35;
        this.lust = 30;
        this.drop = new ChainedDrop().add(useables.EBONBLO, 1 / 20).add(consumables.D_FRUIT, 0.7);
        this.abilities = [
                {
                    call : moveDisplacerBeastPhaseStrike,
                    type : ABILITY_PHYSICAL,
                    range : RANGE_MELEE,
                    tags : [TAG_BODY]
                }
        ];
        this.createStatusEffect(StatusEffects.EvasiveTeleport, 190, 0, 0, 0);
        checkMonster();
    }
}

