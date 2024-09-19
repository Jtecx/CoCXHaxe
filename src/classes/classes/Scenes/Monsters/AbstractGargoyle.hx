/**
 * ...
 * @author Ormael
 */
package classes.scenes.monsters;

import classes.*;
import classes.items.*;

class AbstractGargoyle extends Monster
{
    public function GargoyleStoneClawAttack() : Void
    {
        clearOutput();
        var damage : Float = 0;
        damage += this.str;
        damage += eBaseStrengthDamage() * 0.5;
        damage += this.tou;
        damage += eBaseToughnessDamage() * 0.5;
        if (hasStatusEffect(StatusEffects.Provoke))
        {
            damage *= statusEffectv2(StatusEffects.Provoke);
        }
        var crit : Bool = false;
        var critChance : Int = 5;
        if (this.inte <= 200)
        {
            critChance += as3hx.Compat.parseInt(this.inte / 10);
        }
        if (this.inte > 200)
        {
            critChance += 20;
        }
        if (rand(100) < critChance)
        {
            crit = true;
            damage *= 1.75;
        }
        damage = Math.round(damage);
        outputText(capitalA + short + " slash you with sharp stone claw dealing ");
        player.takePhysDamage(damage, true);
        outputText(" damage!");
        if (crit == true)
        {
            outputText(" <b>*Critical Hit!*</b>");
        }
        outputText("\n\n");
    }
    public function GargoyleTailSlamAttack() : Void
    {
        clearOutput();
        createStatusEffect(StatusEffects.AbilityCooldown1, 5, 0, 0, 0);
        var damage : Float = 0;
        damage += this.str;
        damage += eBaseStrengthDamage() * 0.25;
        damage += this.tou;
        damage += eBaseToughnessDamage() * 0.25;
        if (hasStatusEffect(StatusEffects.Provoke))
        {
            damage *= statusEffectv2(StatusEffects.Provoke);
            addStatusValue(StatusEffects.AbilityCooldown1, 1, -1);
        }
        var crit : Bool = false;
        var critChance : Int = 5;
        if (this.inte <= 200)
        {
            critChance += as3hx.Compat.parseInt(this.inte / 10);
        }
        if (this.inte > 200)
        {
            critChance += 20;
        }
        if (rand(100) < critChance)
        {
            crit = true;
            damage *= 1.75;
        }
        damage = Math.round(damage);
        outputText(capitalA + short + " hammers " + pronoun1 + " tail down on you attempting to crush you under its mace like tip. It hurt a lot, but you hold your ground wincing against the blow. ");
        player.takePhysDamage(damage, true);
        if (!player.hasPerk(PerkLib.Resolute))
        {
            outputText(" You recoil, stunned by the massive impact and take ");
            player.takePhysDamage(Math.round(damage * 0.1), true);
            outputText(" damage!");
            player.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
        }
        if (crit == true)
        {
            outputText(" <b>*Critical Hit!*</b>");
        }
        outputText("\n\n");
    }
    public function GargoyleTailCleaveAttack() : Void
    {
        clearOutput();
        createStatusEffect(StatusEffects.AbilityCooldown2, 5, 0, 0, 0);
        var damage : Float = 0;
        damage += this.str;
        damage += eBaseStrengthDamage() * 0.25;
        damage += this.tou;
        damage += eBaseToughnessDamage() * 0.25;
        if (hasStatusEffect(StatusEffects.Provoke))
        {
            damage *= statusEffectv2(StatusEffects.Provoke);
            addStatusValue(StatusEffects.AbilityCooldown2, 1, -1);
        }
        //if () damage *= 5;jak PC ma 4+ pomocników
        var crit : Bool = false;
        var critChance : Int = 5;
        if (this.inte <= 200)
        {
            critChance += as3hx.Compat.parseInt(this.inte / 10);
        }
        if (this.inte > 200)
        {
            critChance += 20;
        }
        if (rand(100) < critChance)
        {
            crit = true;
            damage *= 1.75;
        }
        damage = Math.round(damage);
        outputText(capitalA + short + " swipe the field with it axe-bladed tail, slicing you");
        //if () outputText("r team");jak PC ma 4+ pomocników
        outputText(", dealing ");
        player.takePhysDamage(damage, true);
        outputText(" damage! The attack leaves you bleeding from deep wounds!");
        if (!player.immuneToBleed())
        {
            player.createStatusEffect(StatusEffects.IzmaBleed, 3, 0, 0, 0);
        }
        if (crit == true)
        {
            outputText(" <b>*Critical Hit!*</b>");
        }
        outputText("\n\n");
    }
    public function GargoyleWingBuffetAttack() : Void
    {
        clearOutput();
        createStatusEffect(StatusEffects.AbilityCooldown3, 4, 0, 0, 0);
        var damage : Float = 0;
        damage += this.str * 0.2;
        damage += this.tou * 0.2;
        if (hasStatusEffect(StatusEffects.Provoke))
        {
            damage *= statusEffectv2(StatusEffects.Provoke);
            addStatusValue(StatusEffects.AbilityCooldown3, 1, -1);
        }
        var crit : Bool = false;
        var critChance : Int = 5;
        if (this.inte <= 200)
        {
            critChance += as3hx.Compat.parseInt(this.inte / 10);
        }
        if (this.inte > 200)
        {
            critChance += 20;
        }
        if (rand(100) < critChance)
        {
            crit = true;
            damage *= 1.75;
        }
        damage = Math.round(damage);
        outputText(capitalA + short + " flaps " + pronoun1 + " massive stone wings at you trying to knock you down. You’re thrown to the ground. ");
        player.takePhysDamage(damage, true);
        if (crit == true)
        {
            outputText(" <b>*Critical Hit!*</b>");
        }
        if (!player.hasPerk(PerkLib.Resolute))
        {
            player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
        }
        if (player.hasPerk(PerkLib.Resolute))
        {
            outputText(" You’re thankfully to resilient to be stunned by such attacks and remain standing.");
        }
        outputText("\n\n");
    }
    
    public function new()
    {
        super();
        createPerk(PerkLib.Resolute, 0, 0, 0, 0);
        createPerk(PerkLib.Sentience, 0, 0, 0, 0);
        createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
    }
}
