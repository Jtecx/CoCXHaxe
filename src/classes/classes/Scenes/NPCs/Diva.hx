package classes.scenes.nPCs;

import classes.Appearance;
import classes.AssClass;
import classes.bodyParts.Butt;
import classes.bodyParts.Hips;
import classes.bodyParts.Wings;
import classes.EngineCore;
import classes.Monster;
import classes.PerkLib;
import classes.StatusEffects;
import classes.VaginaClass;
import classes.internals.ChainedDrop;
import classes.scenes.combat.spellsWhite.WhitefireSpell;
import classes.scenes.combat.spellsWhite.BlindSpell;
import classes.scenes.combat.CombatAbility;

class Diva extends Monster
{
    private var _biteCounter : Int = 0;
    private var finalFight : Bool = false;
    private var _sonicScreamCooldown : Int = 0;
    
    public function new(ff : Bool = false)
    {
        super();
        this.finalFight = ff;
        var levelBonus : Int = (ff) ? 70 : 40;
        this.a = "";
        this.short = "Diva";
        this.long = "";
        this.createVagina(false, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_NORMAL);
        createBreastRow(Appearance.breastCupInverse("DD"));
        this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
        this.ass.analWetness = AssClass.WETNESS_DRY;
        this.tallness = (5 * 12) + 6;
        this.hips.type = Hips.RATING_CURVY;
        this.butt.type = Butt.RATING_NOTICEABLE;
        this.bodyColor = "pale";
        this.hairColor = "blonde";
        this.hairLength = 16;
        initStrTouSpeInte(8 * levelBonus, 10 * levelBonus, 12 * levelBonus, 14 * levelBonus);
        initWisLibSensCor(14 * levelBonus, 10 * levelBonus, 12 * levelBonus, 20);
        this.weaponName = "dive";
        this.weaponVerb = "swoop";
        this.armorName = "dress";
        this.armorDef = levelBonus * 4;
        this.armorMDef = levelBonus * 4;
        this.wings.type = Wings.BAT_LIKE_LARGE;
        this.bonusHP = levelBonus * 2000;
        this.bonusLust = levelBonus * 23;
        this.lustVuln = 1;
        this.level = levelBonus;
        this.drop = new ChainedDrop(consumables.VAMPBLD);
        this.createStatusEffect(StatusEffects.Flying, 50, 0, 0, 0);
        checkMonster();
    }
    
    override private function get_long() : String
    {
        var str : String = "Diva appears to be a vampire, the fangs and wings kind of give it away.\n"
        + "She circles above and around you, waiting for an opening while she constantly screeches.\n"
        + "Huh, she might be more bat-like that you initially thought.\n"
        + "Girl certainly has quite the pair of lungs if nothing else.\n"
        + "Her red and black dress gives her quite the villainous look while having some unfortunate consequences of it having a skirt and her being a flier.\n"
        + "Somehow, she manages to keep herself from having a rather intimate reunion with the walls despite not looking at where she is flying in favor of drooling at the sight of your neck.\n"
        + "Guess all that screeching has an actual purpose aside from annoying you.";
        if (finalFight)
        {
            str += "\nLooks like she got one hell of a power-up thanks to your generous blood donations. Masochism much, Champ?";
            if (EngineCore.silly())
            {
                str += "\nGit gud, scrub.";
            }
        }
        return str;
    }
    
    override private function attackSucceeded() : Bool
    {
        if (_sonicScreamCooldown > 0)
        {
            _sonicScreamCooldown--;
        }
        return super.attackSucceeded();
    }
    
    override private function performCombatAction() : Void
    {
        if (player.hasStatusEffect(StatusEffects.NagaBind))
        {
            moveBite();
        }
        else
        {
            var options : Array<Dynamic> = [moveEmbrace, moveSwoopToss];
            if (_sonicScreamCooldown == 0)
            {
                options.push(moveSonicScream);
            }
            if (finalFight && !player.hasStatusEffect(StatusEffects.Blind))
            {
                options.push(moveDarkness);
            }
            options[rand(options.length)]();
        }
    }
    
    override public function isFlying() : Bool
    {
        return !hasStatusEffect(StatusEffects.Stunned);
    }
    
    public function handlePlayerSpell(spell : String = "") : Void
    {
        if (spell == "whitefire" && player.hasStatusEffect(StatusEffects.Blind))
        {
            player.removeStatusEffect(StatusEffects.Blind);
            outputText("The room lights back as the flame dispels the shadow.");
        }
        if (spell == "blind" && this.hasStatusEffect(StatusEffects.Blind))
        {
            outputText("Diva recoils in pain as the bright light strikes her like a hammer, temporarily pinning her to the ground and stunning her.");
            this.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
        }
    }
    
    override public function postPlayerAbility(ability : CombatAbility, display : Bool = true) : Void
    {
        if (Std.is(ability, BlindSpell) && hasStatusEffect(StatusEffects.Blind))
        {
            if (display)
            {
                outputText("Diva recoils in pain as the bright light strikes her like a hammer, temporarily pinning her to the ground and stunning her.");
            }
            this.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
        }
        else if (Std.is(ability, WhitefireSpell) && hasStatusEffect(StatusEffects.Blind))
        {
            if (display)
            {
                outputText("The room lights back as the flame dispels the shadow.");
            }
        }
    }
    
    private function moveEmbrace() : Void
    {
        if ((rand(120) >= (player.spe > 80)) ? player.spe : 80)
        {
            player.createStatusEffect(StatusEffects.NagaBind, 0, 0, 0, 0);
            outputText("Diva suddenly dives and closes her wings and arms on you, locking you in an embrace!");
            if (EngineCore.silly())
            {
                outputText("  Bad touch, bad touch!");
            }
        }
        else
        {
            outputText("Diva suddenly dives in attempt to close her wings and arms on you but you're faster than her and swiftly evade the grapple.");
        }
    }
    
    public function moveBite() : Void
    {
        if (player.isGargoyle())
        {
            outputText("Diva tries to bite you but quickly step back holding a hand to her mouth with a surprised yelp of clear pain. You smirk amused... did she seriously try to bite in your stone skin?");
            takePhysDamage(maxHP() * .1);
        }
        else if (player.isAlraune())
        {
            outputText("Diva tries to bite you but just as her fang pierces your skin she shoves you off and starts spitting."
                    + "\n\n"
                    + "\"<i>Puaaah what the hell did I taste just now! Your blood taste like saps and flower nectar. How disgusting!</i>\""
                    + "\n\n"
                    + "Well now you're kind of offended by her reaction... guess plant sap really tastes bad for her.");
            takePhysDamage(10);
        }
        else
        {
            addHP(maxHP() * .2);
            var dam : Int = as3hx.Compat.parseInt(this.str * 2);
            for (i in 0..._biteCounter)
            {
                dam += as3hx.Compat.parseInt(dam * .50);
            }
            _biteCounter++;
            outputText("Diva bites into your neck and begins drinking her fill. The rather loud slurping noises she makes kind of ruin the mood, though. Weirdly enough you feel aroused from this despite the pain.");
            if (silly())
            {
                outputText("  You masochist, you.");
            }
            dam = Math.round(dam);
            player.takePhysDamage(dam);
            player.takeLustDamage(2 + rand(4), true);
        }
    }
    
    private function moveSwoopToss() : Void
    {
        outputText("Diva makes a pass bare inches above your head, using her momentum to snatch");
        if (finalFight)
        {
            outputText("and toss you across the room and into an intimate reunion between your face and the wall.");
        }
        else
        {
            outputText("you only to drop you from higher height.");
        }
        var dam : Int = 50;
        dam += this.str;
        dam += rand((140 - player.tallness) * .25);
        player.takePhysDamage(dam);
    }
    
    private function moveDarkness() : Void
    {
        outputText("\"<i>Let us see how thou fight without this precious light of yours!</i>\""
                + "\n\n"
                + "Diva lands, opening her wings wide as a pair of black orbs form at her fingertips. She shatters them on the ground plunging the room in complete darkness and extinguishing all light."
                + "\n\n"
                + "You will be unable to locate her correctly without a proper visual.");
        if (!player.isImmuneToBlind())
        {
            player.createStatusEffect(StatusEffects.Blind, 999, 0, 0, 0);
        }
    }
    
    private function moveSonicScream() : Void
    {
        if (finalFight)
        {
            outputText("Diva suddenly lets out an agonising screech which echoes through the entire room, shattering all the glass along its path and forcing you to reflexively try to cover your ears with your hands, dropping your weapons in the process and still staggering you despite your efforts. The scream is so powerful that, in addition to damaging your eardrums and fucking your balance something fierce, it also bodily throws you into a nearby wall. At least you didn’t wind up impaled on some weapon’s rack, that would be plain embarrassing.");
        }
        else
        {
            outputText("Diva gets what look like a conical item out of her bag and suddenly lets out an agonising screech which echoes through the entire room, forcing you to reflexively try to cover your ears with your hands, dropping your weapons in the process and still staggering you despite your efforts.");
        }
        player.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
        _sonicScreamCooldown = 6;
    }
    
    override public function won(hpVictory : Bool, pcCameWorms : Bool) : Void
    {
        DivaScene.instance.moonlightSonata(true);
        cleanupAfterCombat();
    }
    
    override public function defeated(hpVictory : Bool) : Void
    {
        if (finalFight)
        {
            DivaScene.instance.defeatedFinalFight();
        }
        else
        {
            DivaScene.instance.defeatedFirstSecond();
        }
    }
}

