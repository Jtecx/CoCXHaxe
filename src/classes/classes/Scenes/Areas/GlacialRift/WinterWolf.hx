/**
 * ...
 * @author Liadri
 */
package classes.scenes.areas.glacialRift;

import classes.*;
import classes.bodyParts.Butt;
import classes.bodyParts.Hips;
import classes.scenes.SceneLib;
import classes.internals.WeightedDrop;

class WinterWolf extends Monster
{
    override public function defeated(hpVictory : Bool) : Void
    {
        SceneLib.glacialRift.winterwolfScene.winAgainstWinterWolf();
    }
    
    override public function won(hpVictory : Bool, pcCameWorms : Bool) : Void
    {
        SceneLib.glacialRift.winterwolfScene.loseToWinterWolf();
    }
    
    public function frostbite() : Void
    {
        outputText("The wolf lunge, biting viciously at your leg.");
        var dmgtaken : Float = 0;
        var damage : Float = 0;
        if (!player.hasStatusEffect(StatusEffects.FrostburnDoT))
        {
            outputText(" You feel the cold enter your body and shake you to the very core weakening your resolve just as much as slowing down your movement.");
            if (player.str > 7)
            {
                player.addCurse("str", 6, 2);
                showStatDown("str");
                if (!player.immuneToFrostBurn())
                {
                    player.createStatusEffect(StatusEffects.FrostburnDoT, 6, 0, 0, 0);
                }
            }
            else
            {
                if (!player.immuneToFrostBurn())
                {
                    player.createStatusEffect(StatusEffects.FrostburnDoT, 0, 0, 0, 0);
                }
                damage += 30 + Math.round(rand((str + weaponAttack) / 2));
                player.takeIceDamage(damage);
                dmgtaken += damage;
            }
            damage += 30 + Math.round(rand((str + weaponAttack) / 2));
            player.takeIceDamage(damage);
            dmgtaken += damage;
            outputText(" (<b>[font-damage]" + damage + "[/font]</b>)");
        }
        else
        {
            outputText(" The coldness effects intensify as your movement slowing down even more.");
            if (player.str > 6)
            {
                player.addCurse("str", 5, 2);
                showStatDown("str");
                player.addStatusValue(StatusEffects.FrostburnDoT, 1, 5);
            }
            else
            {
                damage += 30 + Math.round(rand((str + weaponAttack) / 2));
                player.takeIceDamage(damage);
                dmgtaken += damage;
            }
            damage += 30 + Math.round(rand((str + weaponAttack) / 2));
            player.takeIceDamage(damage);
            dmgtaken += damage;
            outputText(" (<b>[font-damage]" + damage + "[/font]</b>)");
        }
    }
    
    private function wolfHold() : Void
    {
        outputText("The wolf suddenly grab you crushing you under its paw as it start tearing you apart with its maw.");
        player.createStatusEffect(StatusEffects.WolfHold, 0, 0, 0, 0);
        if (!player.hasPerk(PerkLib.Juggernaut) && armorPerk != "Heavy")
        {
            player.takePhysDamage(12 + rand(15));
        }
    }
    
    public function paw() : Void
    {
        outputText("The wolf smash you with its enormous paw you rail at the impact as it sends you flying across the field.");
        player.takePhysDamage(str + weaponAttack);
        player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
        createStatusEffect(StatusEffects.AbilityCooldown1, 3, 0, 0, 0);
        if (player.hasStatusEffect(StatusEffects.WolfHold))
        {
            player.removeStatusEffect(StatusEffects.WolfHold);
        }
    }
    
    public function new()
    {
        super();
        this.a = "the ";
        this.short = "winter wolf";
        this.imageName = "s_winterWolf";
        this.long = "You're facing a wolf that can only be described as oversized. The beast bigger than a horse is easily 10 feet tall with a pelt about just as white as the landscape below it. A small blue mist trail regularly escape its mouth subjesting its bite might be way worse then it appear.";
        // this.plural = false;
        this.createCock(18, 3, CockTypesEnum.WOLF);
        this.balls = 2;
        this.ballSize = 2;
        this.cumMultiplier = 2;
        createBreastRow(Appearance.breastCupInverse("flat"));
        this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
        this.ass.analWetness = AssClass.WETNESS_NORMAL;
        this.tallness = 10 * 12;
        this.hips.type = Hips.RATING_BOYISH;
        this.butt.type = Butt.RATING_TIGHT;
        this.skin.growFur({
                    color : "glacial white"
                });
        this.hairColor = "glacial white";
        this.hairLength = 8;
        initStrTouSpeInte(400, 420, 375, 120);
        initWisLibSensCor(100, 75, 150, 50);
        this.weaponName = "paws";
        this.weaponVerb = "paw-slash";
        this.weaponAttack = 274;
        this.armorName = "fur";
        this.armorDef = 328;
        this.armorMDef = 261;
        this.bonusHP = 15000;
        this.bonusLust = 324;
        this.lust = 10;
        this.lustVuln = 0.4;
        this.level = 99;
        this.additionalXP = 5000;
        this.gems = 200 + rand(50);
        this.drop = new WeightedDrop().add(consumables.CHILLYP, 1).add(null, 2);
        this.createStatusEffect(StatusEffects.GenericRunDisabled, 0, 0, 0, 0);
        this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
        this.createPerk(PerkLib.GoliathI, 0, 0, 0, 0);
        this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
        this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
        this.createPerk(PerkLib.IceNature, 0, 0, 0, 0);
        this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
        this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
        this.abilities = [
                {
                    call : frostbite,
                    type : ABILITY_PHYSICAL,
                    range : RANGE_MELEE,
                    tags : [TAG_BODY, TAG_ICE]
                }, 
                {
                    call : wolfHold,
                    type : ABILITY_PHYSICAL,
                    range : RANGE_MELEE,
                    tags : [TAG_BODY],
                    condition : function() : Bool
                    {
                        return player.tallness < 96 && !player.hasStatusEffect(StatusEffects.WolfHold);
                    }
                }, 
                {
                    call : paw,
                    type : ABILITY_PHYSICAL,
                    range : RANGE_MELEE,
                    tags : [TAG_BODY],
                    condition : function() : Bool
                    {
                        return player.tallness < 72 && !hasStatusEffect(StatusEffects.AbilityCooldown1);
                    }
                }, 
                {
                    call : frostbite,
                    type : ABILITY_PHYSICAL,
                    range : RANGE_MELEE,
                    tags : [TAG_BODY, TAG_ICE],
                    condition : function() : Bool
                    {
                        return player.hasStatusEffect(StatusEffects.WolfHold);
                    },
                    weight : Infinity
                }
        ];
        checkMonster();
    }
}

