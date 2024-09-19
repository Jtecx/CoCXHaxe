/**
 * ...
 * @author Liadri
 */
package classes.scenes.areas.beach;

import haxe.Constraints.Function;
import classes.*;
import classes.bodyParts.Butt;
import classes.bodyParts.Hips;
import classes.bodyParts.Horns;
import classes.bodyParts.Tail;
import classes.globalFlags.KFLAGS;
import classes.scenes.combat.Combat;
import classes.scenes.combat.CombatUI;
import classes.scenes.SceneLib;
import classes.internals.WeightedDrop;
import coc.view.CoCButton;

class CancerAttack extends Monster
{
    override public function changeBtnWhenBound(btnStruggle : CoCButton, btnBoundWait : CoCButton) : Void
    {
        if (player.hasStatusEffect(StatusEffects.CancerMonsterGrab))
        {
            btnStruggle.call(cancerGrabStruggle);
            btnBoundWait.call(cancerGrabWait);
        }
    }
    override private function performCombatAction() : Void
    {
        if (player.hasStatusEffect(StatusEffects.MonsterDig))
        {
            if (player.statusEffectv1(StatusEffects.MonsterDig) > 0)
            {
                CancerWait();
            }
            else if (player.statusEffectv1(StatusEffects.MonsterDig) == 0)
            {
                Grab();
            }
        }
        else if (player.hasStatusEffect(StatusEffects.CancerMonsterGrab))
        {
            Guillotine();
        }
        else
        {
            var choiceList : Array<Dynamic> = [Dig, Dig];
            if (!player.isFlying())
            {
                choiceList.push(Slam);
                choiceList.push(Slam);
                choiceList.push(Slam);
                choiceList.push(Slam);
                choiceList.push(Slam);
                
            }
            if (!player.hasStatusEffect(StatusEffects.Blind))
            {
                choiceList.push(BubbleSplash);
                choiceList.push(BubbleSplash);
                
            }
            var choice : Function = randomChoice(choiceList);
            choice();
        }
    }
    
    override public function defeated(hpVictory : Bool) : Void
    {
        SceneLib.beach.cancerScene.defeat();
    }
    
    override public function won(hpVictory : Bool, pcCameWorms : Bool) : Void
    {
        SceneLib.beach.cancerScene.rape();
    }
    
    private function Dig() : Void
    {
        if (this.hasStatusEffect(StatusEffects.AlrauneEntangle))
        {
            outputText("The cancer would love to dig a path away from you but is currently entangled in your vines!");
        }
        else
        {
            outputText("The cancer dig [monster his] way underground, disappearing from view.");
            if (!player.hasStatusEffect(StatusEffects.MonsterDig))
            {
                player.createStatusEffect(StatusEffects.MonsterDig, 1 + rand(3), 0, 0, 0);
            }
            if (!player.hasStatusEffect(StatusEffects.MonsterInvisible))
            {
                player.createStatusEffect(StatusEffects.MonsterInvisible, 0, 0, 0, 0);
            }
        }
    }
    
    private function Grab() : Void
    {
        if (Combat.playerWaitsOrDefends())
        {
            outputText("By observing your environment and staying alert, you manage to dodge just in time as the pincer dig its way back up from under you. \n\n");
        }
        else if (player.isFlying())
        {
            outputText("You can’t help but chuckle at the cancer futile attempts to ambush you from beneath, simply flying way out of its reach. You taunt [monster him] still chuckling.\n\n" +
                    "<i>\"Hey, idiot! How do you plan to dig under and surprise that which does not even touch the ground!\"</i>\n\n");
        }
        else
        {
            outputText("The Cancer surge out of the sand under you, grabbing you in its pincer as [monster he] flatly adds.\n\n" +
                    "<i>\"Gotcha… You struggled, I don’t like it when they struggle, so I will crush you until you stop struggling.\"</i>\n\n");
            player.createStatusEffect(StatusEffects.CancerMonsterGrab, 2 + rand(5), 0, 0, 0);
        }
        player.removeStatusEffect(StatusEffects.MonsterDig);
        player.removeStatusEffect(StatusEffects.MonsterInvisible);
    }
    
    private function CancerWait() : Void
    {
        outputText("You hear the soil grumbling as your opponent dig around underground.");
        player.addStatusValue(StatusEffects.MonsterDig, 1, -1);
    }
    
    //(Struggle)
    public function cancerGrabStruggle() : Void
    {
        clearOutput();
        if ((player.statusEffectv1(StatusEffects.CancerMonsterGrab) - 1 <= 0) || player.hasPerk(PerkLib.FluidBody))
        {
            outputText("You manage to break out of the cancer death grip still gasping for air.");
            player.removeStatusEffect(StatusEffects.CancerMonsterGrab);
        }
        else
        {
            outputText("You struggle to break out of the cancer grip to no result.");
            player.addStatusValue(StatusEffects.CancerMonsterGrab, 1, -1);
        }
        outputText("\n\n");
        SceneLib.combat.enemyAIImpl();
    }
    
    //(Wait)
    public function cancerGrabWait() : Void
    {
        clearOutput();
        outputText("Why bother resisting?  Theres no way you can escape this iron grip anyway.");
        outputText("\n\n");
        SceneLib.combat.enemyAIImpl();
    }
    
    private function Guillotine() : Void
    {
        var damage : Float = rand(weaponAttack);
        outputText("The cancer begins to crush you inside [monster his] pincers. It hurts!! You can almost hear your bones breaking!");
        damage += eBaseStrengthDamage() * 2;
        damage = Math.round(damage);
        player.takePhysDamage(damage, true);
        statScreenRefresh();
    }
    
    private function Slam() : Void
    {
        var damage : Float = rand(weaponAttack);
        outputText("The cancer slams [monster his] giant pincer on you like a hammer.");
        damage += eBaseStrengthDamage() * 2;
        damage = Math.round(damage);
        player.takePhysDamage(damage, true);
        statScreenRefresh();
    }
    
    private function BubbleSplash() : Void
    {
        if (this.hasVagina())
        {
            outputText("The cancer gasps in pleasure as her mandible opens revealing her pussy. Out of nowhere, she suddenly splashes you right in the face with a powerful gushing jet of foaming juices. <b>You’re blinded!</b>\n\n");
        }
        if (this.hasCock())
        {
            outputText("The cancer gasps in pleasure as his mandible opens revealing his cock. Out of nowhere, he suddenly splashes you right in the face with a powerful gushing jet of foaming juices. <b>You’re blinded!</b>\n\n");
        }
        player.createStatusEffect(StatusEffects.Blind, 6, 0, 0, 0);
    }
    
    public function new(IsFemale : Bool)
    {
        super();
        this.a = "the ";
        this.short = "cancer";
        this.imageName = "cancer";
        this.long = "You are fighting a cancer, a centaur mixing the upper body of a human with the bottom body of a large crab. " +
                "Its pincers stands at the ready looking for the opportunity of a swift and likely fatal grapple. " +
                "While your opponent torso is pretty bare it’s obvious the crab part is sturdier than any steel plating. " +
                "The creepiest thing about all of this is that " + ((IsFemale) ? "her" : "his") + " facial expression seems frozen in a constant blank state.";
        if (IsFemale)
        {
            this.createVagina(false, VaginaClass.WETNESS_SLICK, VaginaClass.LOOSENESS_LOOSE);
            this.createBreastRow(1);
        }
        if (!IsFemale)
        {
            this.createBreastRow(0);
            this.createCock(7.5, 1, CockTypesEnum.CANCER);
            this.balls = 2;
            this.ballSize = 1;
            this.cumMultiplier = 3;
        }
        this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
        this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
        this.tallness = rand(8) + 70;
        this.hips.type = Hips.RATING_AMPLE + 2;
        this.butt.type = Butt.RATING_LARGE;
        this.bodyColor = "light";
        this.hairColor = "pale brown";
        this.hairLength = 15;
        initStrTouSpeInte(167, 185, 149, 42);
        initWisLibSensCor(41, 144, 82, -40);
        this.weaponName = "pincers";
        this.weaponVerb = "pincer";
        this.weaponAttack = 69;
        this.armorName = "chitin";
        this.armorDef = 90;
        this.armorMDef = 10;
        this.bonusHP = 200;
        this.bonusLust = 263;
        this.lust = 30;
        this.level = 37;
        this.gems = rand(40) + 40;
        this.drop = new WeightedDrop().addMany(1, consumables.BUBBLEG);
        this.tailType = Tail.NONE;
        checkMonster();
    }
}


