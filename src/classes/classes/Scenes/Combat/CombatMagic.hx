/**
 * Coded by aimozg on 30.05.2017.
 */
package classes.scenes.combat;

import classes.bodyParts.Horns;
import classes.globalFlags.KACHIEVEMENTS;
import classes.globalFlags.KFLAGS;
import classes.iMutations.*;
import classes.items.dynamic.effects.SimpleRaceEnchantment;
import classes.items.EnchantmentLib;
import classes.items.IELib;
import classes.items.ItemEffect;
import classes.items.JewelryLib;
import classes.items.NecklaceLib;
import classes.PerkLib;
import classes.Race;
import classes.Races;
import classes.scenes.dungeons.d3.Lethice;
import classes.scenes.nPCs.Forgefather;
import classes.scenes.places.telAdre.UmasShop;
import classes.scenes.SceneLib;
import classes.StatusEffectType;
import classes.StatusEffects;
import classes.lists.Gender;

class CombatMagic extends BaseCombatContent
{
    public function new()
    {
        super();
    }
    
    @:allow(classes.scenes.combat)
    private function applyAutocast() : Void
    {
        outputText("\n\n");
        if (!player.hasPerk(PerkLib.HexKnowledge) || (player.hasPerk(PerkLib.HexKnowledge) && player.hasPerk(PerkLib.HyperCasting)))
        {
            if (player.hasPerk(PerkLib.Autocast) && CombatAbilities.ChargeWeapon.isKnownAndUsable && flags[kFLAGS.AUTO_CAST_CHARGE_WEAPON_DISABLED] == 0)
            {
                CombatAbilities.ChargeWeapon.autocast();
            }
            if (player.hasPerk(PerkLib.Autocast) && CombatAbilities.ChargeRWeapon.isKnownAndUsable && flags[kFLAGS.AUTO_CAST_CHARGE_R_WEAPON_DISABLED] == 0)
            {
                CombatAbilities.ChargeRWeapon.autocast();
            }
            if (player.hasPerk(PerkLib.Autocast) && CombatAbilities.ChargeArmor.isKnownAndUsable && flags[kFLAGS.AUTO_CAST_CHARGE_ARMOR_DISABLED] == 0)
            {
                CombatAbilities.ChargeArmor.autocast();
            }
        }
        if (!player.hasPerk(PerkLib.DivineKnowledge) || (player.hasPerk(PerkLib.DivineKnowledge) && player.hasPerk(PerkLib.HyperCasting)))
        {
            if (player.hasPerk(PerkLib.Autocast) && CombatAbilities.Might.isKnownAndUsable && flags[kFLAGS.AUTO_CAST_MIGHT_DISABLED] == 0)
            {
                CombatAbilities.Might.autocast();
            }
            if (player.hasPerk(PerkLib.Autocast) && CombatAbilities.Blink.isKnownAndUsable && flags[kFLAGS.AUTO_CAST_BLINK_DISABLED] == 0)
            {
                CombatAbilities.Blink.autocast();
            }
        }
        if (player.hasPerk(PerkLib.Autocast) && CombatAbilities.ManaShield.isKnownAndUsable && flags[kFLAGS.AUTO_CAST_MANA_SHIELD_DISABLED] == 0)
        {
            CombatAbilities.ManaShield.autocast();
        }
    }
    
    @:allow(classes.scenes.combat)
    private function cleanupAfterCombatImpl() : Void
    {
        for (perkObj/* AS3HX WARNING could not determine type for var: perkObj exp: EIdent(magicCounterPerks) type: null */ in magicCounterPerks)
        {
            if (player.hasStatusEffect(perkObj.counter))
            {
                player.removeStatusEffect(perkObj.counter);
            }
        }
    }
    
    @:allow(classes.scenes.combat)
    private function costChange_all() : Float
    {
        var costPercent : Float = 0;
        costPercent += 100 * player.spellcostStat.value;
        if (player.hasPerk(PerkLib.SeersInsight))
        {
            costPercent -= (100 * player.perkv1(PerkLib.SeersInsight));
        }
        if (player.hasPerk(PerkLib.SpellcastingAffinity))
        {
            costPercent -= player.perkv1(PerkLib.SpellcastingAffinity);
        }
        if (player.hasPerk(PerkLib.WarMageNovice))
        {
            costPercent -= 10;
        }
        if (player.hasPerk(PerkLib.WarMageApprentice))
        {
            costPercent -= 10;
        }
        if (player.hasPerk(PerkLib.WarMageAdept))
        {
            costPercent -= 10;
        }
        if (player.hasPerk(PerkLib.WarMageExpert))
        {
            costPercent -= 15;
        }
        if (player.hasPerk(PerkLib.WarMageMaster))
        {
            costPercent -= 20;
        }
        if (player.hasPerk(PerkLib.HyperCasting))
        {
            costPercent -= 20;
        }
        if (player.hasPerk(PerkLib.AscensionMysticality))
        {
            costPercent -= (player.perkv1(PerkLib.AscensionMysticality) * 2);
        }
        if (player.perkv1(IMutationsLib.HumanParathyroidGlandIM) >= 4 && player.racialScore(Races.HUMAN) > 17)
        {
            costPercent -= 10;
        }
        if (player.headjewelryName == "fox hairpin")
        {
            costPercent -= 20;
        }
        if (player.weapon == weapons.N_STAFF)
        {
            costPercent += 200;
        }
        if (player.weapon == weapons.U_STAFF)
        {
            costPercent -= 50;
        }
        if (player.weapon == weapons.ASCENSU)
        {
            costPercent -= 25;
        }
        return costPercent;
    }
    
    @:allow(classes.scenes.combat)
    private function costChange_spell() : Float
    {
        var costPercent : Float = 0;
        if (player.level >= 27 && player.inte >= 100)
        {
            costPercent += 50;
        }
        if (player.level >= 54 && player.inte >= 200)
        {
            costPercent += 50;
        }
        if (player.level >= 78 && player.inte >= 300)
        {
            costPercent += 50;
        }
        if (player.level >= 126 && player.inte >= 400)
        {
            costPercent += 50;
        }
        return costPercent;
    }
    
    @:allow(classes.scenes.combat)
    private function costChange_heal() : Float
    {
        var costPercent : Float = 0;
        if (player.hasPerk(PerkLib.WisenedHealer))
        {
            costPercent += 100;
            if (player.level >= 27 && player.wis >= 100)
            {
                costPercent += 25;
            }
            if (player.level >= 54 && player.wis >= 200)
            {
                costPercent += 25;
            }
            if (player.level >= 78 && player.wis >= 300)
            {
                costPercent += 25;
            }
            if (player.level >= 126 && player.wis >= 400)
            {
                costPercent += 25;
            }
        }
        if (player.level >= 27 && player.inte >= 100)
        {
            costPercent += 25;
        }
        if (player.level >= 54 && player.inte >= 200)
        {
            costPercent += 25;
        }
        if (player.level >= 78 && player.inte >= 300)
        {
            costPercent += 25;
        }
        if (player.level >= 126 && player.inte >= 400)
        {
            costPercent += 25;
        }
        if (player.hasPerk(PerkLib.NaturalHealingMinor))
        {
            costPercent -= 10;
        }
        if (player.hasPerk(PerkLib.NaturalHealingMajor))
        {
            costPercent -= 15;
        }
        if (player.hasPerk(PerkLib.NaturalHealingEpic))
        {
            costPercent -= 20;
        }
        if (player.hasPerk(PerkLib.NaturalHealingLegendary))
        {
            costPercent -= 25;
        }
        return costPercent;
    }
    
    @:allow(classes.scenes.combat)
    private function spellCostImpl(mod : Float) : Float
    {
        var costPercent : Float = 100 + costChange_all() + costChange_spell();
        //Addiditive mods
        if (spellModImpl() > 1)
        {
            costPercent += Math.round(spellModImpl() - 1) * 10;
        }
        //Limiting it and multiplicative mods
        if (player.hasPerk(PerkLib.BloodMage) && costPercent < 50)
        {
            costPercent = 50;
        }
        mod *= costPercent / 100;
        if (player.hasPerk(PerkLib.BloodMage) && mod < 5)
        {
            mod = 5;
        }
        else if (mod < 2)
        {
            mod = 2;
        }
        mod = Math.round(mod * 100) / 100;
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function spellCostBloodImpl(mod : Float) : Float
    {
        var costPercent : Float = 100 + costChange_all() + costChange_spell();
        //Addiditive mods
        if (player.hasPerk(PerkLib.HiddenJobBloodDemon))
        {
            costPercent -= 5;
        }
        if (player.hasPerk(PerkLib.WayOfTheBlood))
        {
            costPercent -= 5;
        }
        if (player.hasPerk(PerkLib.BloodDemonToughness))
        {
            costPercent -= 5;
        }
        if (player.hasPerk(PerkLib.MyBloodForBloodPuppies))
        {
            costPercent -= 5;
        }
        if (player.hasPerk(PerkLib.YourPainMyPower))
        {
            costPercent -= 5;
        }
        if (player.hasPerk(PerkLib.BloodDemonIntelligence))
        {
            costPercent -= 5;
        }
        //
        //
        if (player.hasPerk(PerkLib.BloodDemonWisdom))
        {
            costPercent -= 5;
        }
        //
        if (spellModImpl() > 1)
        {
            costPercent += Math.round(spellModImpl() - 1) * 10;
        }
        if (player.hasPerk(PerkLib.AscensionMysticality))
        {
            costPercent -= (player.perkv1(PerkLib.AscensionMysticality) * 2);
        }
        //Limiting it and multiplicative mods
        if (costPercent < 5)
        {
            costPercent = 5;
        }
        mod *= costPercent / 100;
        if (mod < 2)
        {
            mod = 2;
        }
        mod = Math.round(mod * 100) / 100;
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function costChange_white() : Float
    {
        var costPercent : Float = 0;
        if (player.hasPerk(PerkLib.Ambition))
        {
            costPercent -= (100 * player.perkv2(PerkLib.Ambition));
        }
        if (player.weapon == weapons.PURITAS)
        {
            costPercent -= 15;
        }
        return costPercent;
    }
    
    @:allow(classes.scenes.combat)
    private function spellCostWhiteImpl(mod : Float) : Float
    {
        var costPercent : Float = 100 + costChange_all() + costChange_spell() + costChange_white();
        //Addiditive mods
        if (spellModWhiteImpl() > 1)
        {
            costPercent += Math.round(spellModWhiteImpl() - 1) * 10;
        }
        if (player.hasPerk(PerkLib.AscensionMysticality))
        {
            costPercent -= (player.perkv1(PerkLib.AscensionMysticality) * 2);
        }
        //Limiting it and multiplicative mods
        if (player.hasPerk(PerkLib.BloodMage) && costPercent < 50)
        {
            costPercent = 50;
        }
        mod *= costPercent / 100;
        if (player.hasPerk(PerkLib.BloodMage) && mod < 5)
        {
            mod = 5;
        }
        else if (mod < 2)
        {
            mod = 2;
        }
        mod = Math.round(mod * 100) / 100;
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function costChange_black() : Float
    {
        var costPercent : Float = 0;
        if (player.hasPerk(PerkLib.Obsession))
        {
            costPercent -= (100 * player.perkv2(PerkLib.Obsession));
        }
        if (player.hasPerk(PerkLib.Necromancy))
        {
            costPercent -= 50;
        }
        if (player.weapon == weapons.DEPRAVA)
        {
            costPercent -= 15;
        }
        return costPercent;
    }
    
    @:allow(classes.scenes.combat)
    private function spellCostBlackImpl(mod : Float) : Float
    {
        var costPercent : Float = 100 + costChange_all() + costChange_spell() + costChange_black();
        //Addiditive mods
        if (spellModBlackImpl() > 1)
        {
            costPercent += Math.round(spellModBlackImpl() - 1) * 10;
        }
        if (player.hasPerk(PerkLib.AscensionMysticality))
        {
            costPercent -= (player.perkv1(PerkLib.AscensionMysticality) * 2);
        }
        //Limiting it and multiplicative mods
        if (player.hasPerk(PerkLib.BloodMage) && costPercent < 50)
        {
            costPercent = 50;
        }
        mod *= costPercent / 100;
        if (player.hasPerk(PerkLib.BloodMage) && mod < 5)
        {
            mod = 5;
        }
        else if (mod < 2)
        {
            mod = 2;
        }
        mod = Math.round(mod * 100) / 100;
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function costChange_grey() : Float
    {
        var costPercent : Float = 0;
        if (player.hasPerk(PerkLib.GrandGreyArchmage2ndCircle))
        {
            costPercent -= 20;
        }
        return costPercent;
    }
    
    @:allow(classes.scenes.combat)
    private function spellCostGreyImpl(mod : Float) : Float
    {
        var costPercent : Float = 100 + costChange_all() + costChange_spell() + costChange_grey();
        //Addiditive mods
        if (spellModGreyImpl() > 1)
        {
            costPercent += Math.round(spellModGreyImpl() - 1) * 10;
        }
        if (player.hasPerk(PerkLib.AscensionMysticality))
        {
            costPercent -= player.perkv1(PerkLib.AscensionMysticality);
        }
        //Limiting it and multiplicative mods
        if (player.hasPerk(PerkLib.BloodMage) && costPercent < 50)
        {
            costPercent = 50;
        }
        mod *= costPercent / 100;
        if (player.hasPerk(PerkLib.BloodMage) && mod < 5)
        {
            mod = 5;
        }
        else if (mod < 2)
        {
            mod = 2;
        }
        mod = Math.round(mod * 100) / 100;
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function spellCostGreenImpl(mod : Float) : Float
    {
        var costPercent : Float = 100 + costChange_all() + costChange_spell() + costChange_white();
        //Addiditive mods
        if (spellModGreenImpl() > 1)
        {
            costPercent += Math.round(spellModGreenImpl() - 1) * 10;
        }
        //Limiting it and multiplicative mods
        if (player.hasPerk(PerkLib.BloodMage) && costPercent < 50)
        {
            costPercent = 50;
        }
        mod *= costPercent / 100;
        if (player.hasPerk(PerkLib.BloodMage) && mod < 5)
        {
            mod = 5;
        }
        else if (mod < 2)
        {
            mod = 2;
        }
        mod = Math.round(mod * 100) / 100;
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function modChange_all() : Float
    {
        var mod : Float = player.spellpowerStat.value - 1;  // spellpower stat starts with 1  
        if (player.jewelryEffectId == JewelryLib.MODIFIER_SPELL_POWER)
        {
            mod += (player.jewelryEffectMagnitude / 100);
        }
        if (player.jewelryEffectId2 == JewelryLib.MODIFIER_SPELL_POWER)
        {
            mod += (player.jewelryEffectMagnitude / 100);
        }
        if (player.jewelryEffectId3 == JewelryLib.MODIFIER_SPELL_POWER)
        {
            mod += (player.jewelryEffectMagnitude / 100);
        }
        if (player.jewelryEffectId4 == JewelryLib.MODIFIER_SPELL_POWER)
        {
            mod += (player.jewelryEffectMagnitude / 100);
        }
        if (player.necklaceEffectId == NecklaceLib.MODIFIER_SPELL_POWER)
        {
            mod += (player.necklaceEffectMagnitude / 100);
        }
        if (player.armor == armors.DWARMOR)
        {
            mod += 0.3;
        }
        if (player.necklace == necklaces.SILCNEC && player.hasPerk(PerkLib.Soulless))
        {
            mod += 0.5;
        }
        if (player.hasAetherTwinsTierWeapon())
        {
            mod += 0.2;
        }
        if (player.hasAetherTwinsTierShield())
        {
            mod += 0.5;
        }
        if (player.perkv1(IMutationsLib.FiendishMetabolismIM) >= 3 && player.hasPerk(PerkLib.DemonEnergyThirst) && player.perkv1(PerkLib.DemonEnergyThirst) > 0)
        {
            var mTPCur : Float = player.perkv1(PerkLib.DemonEnergyThirst);
            var mTPCap : Float = 5 * player.perkv1(IMutationsLib.FiendishMetabolismIM);
            if (mTPCur > mTPCap)
            {
                mTPCur = mTPCap;
            }
            mod += (0.1 * mTPCur);
        }
        if (player.perkv1(IMutationsLib.DrakeBloodIM) >= 3)
        {
            mod += (0.25 * (player.perkv1(IMutationsLib.DrakeBloodIM) - 2));
        }
        if (player.countCockSocks("blue") > 0)
        {
            mod += (player.countCockSocks("blue") * .05);
        }
        if (player.hasPerk(PerkLib.ChiReflowMagic))
        {
            mod += UmasShop.NEEDLEWORK_MAGIC_SPELL_MULTI;
        }
        // hope it doesn't lag too much
        for (e/* AS3HX WARNING could not determine type for var: e exp: ECall(EField(EIdent(player),allItemEffects),[EField(EIdent(IELib),Spellpower_RaceTier)]) type: null */ in player.allItemEffects(IELib.Spellpower_RaceTier))
        {
            mod += e.power * player.racialTier(try cast(e.value1, Race) catch(e:Dynamic) null) / 100;
        }
        for (f/* AS3HX WARNING could not determine type for var: f exp: ECall(EField(EIdent(player),allItemEffects),[EField(EIdent(IELib),Spellpower_RaceX2)]) type: null */ in player.allItemEffects(IELib.Spellpower_RaceX2))
        {
            mod += f.power * ((player.isRaceCached(try cast(f.value1, Race) catch(e:Dynamic) null)) ? 2 : 1) / 100;
        }
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function modChange_spell_1() : Float
    {
        var mod : Float = 0;
        if (player.hasPerk(PerkLib.BrutalSpells) && player.inte >= 75)
        {
            mod += .05;
        }
        if (player.hasPerk(PerkLib.Archmage) && player.inte >= 100)
        {
            mod += .3;
        }
        if (player.hasPerk(PerkLib.ArchmageEx) && player.inte >= 100)
        {
            mod += 1.05;
        }
        if (player.hasPerk(PerkLib.Channeling) && player.inte >= 60)
        {
            mod += .2;
        }
        if (player.hasPerk(PerkLib.GrandArchmage) && player.inte >= 125)
        {
            mod += .4;
        }
        if (player.hasPerk(PerkLib.GrandArchmage2ndCircle) && player.inte >= 150)
        {
            mod += .5;
        }
        if (player.hasPerk(PerkLib.GrandArchmage3rdCircle) && player.inte >= 175)
        {
            mod += .6;
        }
        if (player.hasPerk(PerkLib.GrandMage) && player.inte >= 75)
        {
            mod += .2;
        }
        if (player.hasPerk(PerkLib.JobSorcerer) && player.inte >= 25)
        {
            mod += .1;
        }
        if (player.hasPerk(PerkLib.Mage) && player.inte >= 50)
        {
            mod += .1;
        }
        if (player.hasPerk(PerkLib.Spellpower) && player.inte >= 50)
        {
            mod += .1;
        }
        if (player.hasPerk(PerkLib.TraditionalMageI) && ((player.isUsingStaff() || player.isPartiallyStaffTypeWeapon() || player.isUsingWand()) && player.isUsingTome()))
        {
            var tmb : Float = 1;
            if (player.hasPerk(PerkLib.TraditionalMageII))
            {
                tmb += 1;
            }
            if (player.hasPerk(PerkLib.TraditionalMageIII))
            {
                tmb += 1;
            }
            if (player.hasPerk(PerkLib.TraditionalMageIV))
            {
                tmb += 1;
            }
            if (player.hasPerk(PerkLib.TraditionalMageV))
            {
                tmb += 1;
            }
            if (player.hasPerk(PerkLib.TraditionalMageVI))
            {
                tmb += 1;
            }
            if (player.isPartiallyStaffTypeWeapon())
            {
                tmb *= 0.5;
            }
            mod += tmb;
        }
        if (player.hasPerk(PerkLib.Ambition))
        {
            mod += player.perkv2(PerkLib.Ambition);
        }
        if (player.hasPerk(PerkLib.KnowledgeIsPower))
        {
            if (player.perkv1(IMutationsLib.RatatoskrSmartsIM) >= 3)
            {
                mod += (Math.round(camp.codex.checkUnlocked() / 100) * 3);
            }
            else
            {
                mod += Math.round(camp.codex.checkUnlocked() / 100);
            }
        }
        if (player.hasPerk(PerkLib.ZenjisInfluence3))
        {
            mod += .3;
        }
        if (player.hasPerk(PerkLib.TamamoNoMaeCursedKimono))
        {
            mod += (player.cor * .01);
        }
        if (player.hasPerk(PerkLib.InariBlessedKimono))
        {
            mod += ((100 - player.cor) * .01);
        }
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function modChange_spell_2() : Float
    {
        var mod : Float = 0;
        if (player.hasPerk(PerkLib.SeersInsight))
        {
            mod += player.perkv1(PerkLib.SeersInsight);
        }
        if (player.headJewelry == headjewelries.SPHINXAS)
        {
            mod += .5;
        }
        if (player.hasStatusEffect(StatusEffects.Maleficium))
        {
            if (player.perkv1(IMutationsLib.ObsidianHeartIM) >= 2)
            {
                if (player.perkv1(IMutationsLib.ObsidianHeartIM) >= 3)
                {
                    mod += 2.5;
                }
                else
                {
                    mod += 1.25;
                }
            }
            else
            {
                mod += 1;
            }
        }
        if (player.hasStatusEffect(StatusEffects.PerfectClarity))
        {
            if (player.perkv1(IMutationsLib.DiamondHeartIM) >= 2)
            {
                if (player.perkv1(IMutationsLib.DiamondHeartIM) >= 3)
                {
                    mod += 2.5;
                }
                else
                {
                    mod += 1.25;
                }
            }
            else
            {
                mod += 1;
            }
        }
        if (player.hasPerk(PerkLib.ElementalBody))
        {
            if (player.perkv1(PerkLib.ElementalBody) == 1 || player.perkv1(PerkLib.ElementalBody) == 2 || player.perkv1(PerkLib.ElementalBody) == 3)
            {
                if (player.perkv2(PerkLib.ElementalBody) == 1)
                {
                    mod += .05;
                }
                if (player.perkv2(PerkLib.ElementalBody) == 2)
                {
                    mod += .1;
                }
                if (player.perkv2(PerkLib.ElementalBody) == 3)
                {
                    mod += .15;
                }
                if (player.perkv2(PerkLib.ElementalBody) == 4)
                {
                    mod += .2;
                }
            }
            else
            {
                if (player.perkv2(PerkLib.ElementalBody) == 1)
                {
                    mod += .1;
                }
                if (player.perkv2(PerkLib.ElementalBody) == 2)
                {
                    mod += .2;
                }
                if (player.perkv2(PerkLib.ElementalBody) == 3)
                {
                    mod += .3;
                }
                if (player.perkv2(PerkLib.ElementalBody) == 4)
                {
                    mod += .4;
                }
            }
        }
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function modChange_heal() : Float
    {
        var mod : Float = 0;
        if (player.hasPerk(PerkLib.SpellpowerHealing) && player.wis >= 50)
        {
            mod += .2;
        }
        if (player.hasPerk(PerkLib.NaturalHealingMinor))
        {
            mod += .3;
        }
        if (player.hasPerk(PerkLib.NaturalHealingMajor))
        {
            mod += .4;
        }
        if (player.hasPerk(PerkLib.NaturalHealingEpic))
        {
            mod += .5;
        }
        if (player.hasPerk(PerkLib.NaturalHealingLegendary))
        {
            mod += .6;
        }
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function spellModImpl() : Float
    {
        var mod : Float = 1 + modChange_all() + modChange_spell_1() + modChange_spell_2();
        if (player.hasPerk(PerkLib.Obsession))
        {
            mod += player.perkv1(PerkLib.Obsession);
        }
        if (player.headJewelry == headjewelries.DMONSKUL)
        {
            mod += player.cor * .006;
        }
        if (player.isGargoyle() && Forgefather.material == "alabaster")
        {
            if (Forgefather.refinement == 0)
            {
                mod += (.15);
            }
            if (Forgefather.refinement == 1)
            {
                mod += (.25);
            }
            if (Forgefather.refinement == 2 || Forgefather.refinement == 3)
            {
                mod += (.5);
            }
            if (Forgefather.refinement == 4)
            {
                mod += (1);
            }
        }
        if (player.hasPerk(PerkLib.AscensionMysticality))
        {
            mod *= 1 + (player.perkv1(PerkLib.AscensionMysticality) * 0.1);
        }
        if (player.weapon == weapons.ASCENSU)
        {
            mod *= 6.5;
        }
        if (player.hasStatusEffect(StatusEffects.DarkRitual))
        {
            mod *= 3;
        }
        mod = Math.round(mod * 100) / 100;
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function spellModBloodImpl() : Float
    {
        var mod : Float = 1;
        if (spellModImpl() > 1)
        {
            mod += (spellModImpl() - 1);
        }
        if (player.hasPerk(PerkLib.HiddenJobBloodDemon))
        {
            mod += .1;
        }
        if (player.hasPerk(PerkLib.WayOfTheBlood))
        {
            mod += .15;
        }
        if (player.hasPerk(PerkLib.BloodDemonToughness))
        {
            mod += .2;
        }
        if (player.hasPerk(PerkLib.MyBloodForBloodPuppies))
        {
            mod += .25;
        }
        if (player.hasPerk(PerkLib.YourPainMyPower))
        {
            mod += .3;
        }
        if (player.hasPerk(PerkLib.BloodDemonIntelligence))
        {
            mod += .35;
        }
        //
        //
        if (player.hasPerk(PerkLib.BloodDemonWisdom))
        {
            mod += .5;
        }
        //
        mod = Math.round(mod * 100) / 100;
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function spellModGreyImpl() : Float
    {
        var mod : Float = 1;
        if (spellModImpl() > 1)
        {
            mod += (spellModImpl() - 1);
        }
        if (player.hasPerk(PerkLib.SpellpowerGrey) && player.inte >= 50)
        {
            mod += .15;
        }
        if (player.hasPerk(PerkLib.GreyMageApprentice) && player.inte >= 75)
        {
            mod += .1;
        }
        if (player.hasPerk(PerkLib.GreyMage) && player.inte >= 125)
        {
            mod += .2;
        }
        if (player.hasPerk(PerkLib.GreyArchmage) && player.inte >= 175)
        {
            mod += .3;
        }
        if (player.hasPerk(PerkLib.GrandGreyArchmage) && player.inte >= 225)
        {
            mod += .4;
        }
        if (player.hasPerk(PerkLib.GrandGreyArchmage2ndCircle) && player.inte >= 275)
        {
            mod += .5;
        }
        if (player.weaponRange == weaponsrange.RG_TOME && player.level < 18)
        {
            if (player.level < 6)
            {
                mod += 1;
            }
            if (player.level < 12)
            {
                mod += 1;
            }
            mod += 1;
        }
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function spellModWhiteImpl() : Float
    {
        var mod : Float = 1;
        if (spellModImpl() > 1)
        {
            mod += (spellModImpl() - 1);
        }
        if (player.hasStatusEffect(StatusEffects.BlessingOfDivineMarae))
        {
            mod += player.statusEffectv2(StatusEffects.BlessingOfDivineMarae);
        }
        if (player.hasPerk(PerkLib.AvatorOfPurity))
        {
            mod += .2;
        }
        if (Forgefather.purePearlEaten)
        {
            mod += .25;
        }
        if (player.hasPerk(PerkLib.UnicornBlessing) && player.cor <= 20)
        {
            mod += .2;
        }
        if (player.hasPerk(PerkLib.PrestigeJobArchpriest))
        {
            mod += .2;
        }
        if (player.hasPerk(PerkLib.PrestigeJobWarlock))
        {
            mod -= .4;
        }
        if (player.hasKeyItem("Holy Symbol") >= 0)
        {
            mod += .2;
        }
        if (player.necklace == necklaces.LEAFAMU)
        {
            if (player.isElf())
            {
                mod += .2;
            }
            else
            {
                mod += .1;
            }
        }
        if (player.weaponRange == weaponsrange.RW_TOME && player.level < 18)
        {
            if (player.level < 6)
            {
                mod += 1;
            }
            if (player.level < 12)
            {
                mod += 1;
            }
            mod += 1;
        }
        if (player.weapon == weapons.PURITAS)
        {
            mod *= 2.5;
        }
        mod = Math.round(mod * 100) / 100;
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function spellModBlackImpl() : Float
    {
        var mod : Float = 1;
        if (spellModImpl() > 1)
        {
            mod += (spellModImpl() - 1);
        }
        if (player.hasPerk(PerkLib.AvatorOfCorruption))
        {
            mod += .3;
        }
        if (Forgefather.lethiciteEaten)
        {
            mod += .25;
        }
        if (player.hasPerk(PerkLib.BicornBlessing) && player.cor >= 80)
        {
            mod += .2;
        }
        if (player.hasPerk(PerkLib.PrestigeJobArchpriest))
        {
            mod -= .4;
        }
        if (player.hasPerk(PerkLib.PrestigeJobWarlock))
        {
            mod += .2;
        }
        if (player.countMiscJewelry(miscjewelries.DMAGETO) > 0)
        {
            mod += 0.25;
        }
        if (player.headJewelry == headjewelries.GHORNAM && player.horns.type == Horns.DEMON)
        {
            mod += 0.25;
        }
        if (player.weaponRange == weaponsrange.RB_TOME && player.level < 18)
        {
            if (player.level < 6)
            {
                mod += 1;
            }
            if (player.level < 12)
            {
                mod += 1;
            }
            mod += 1;
        }
        if (player.weapon == weapons.DEPRAVA)
        {
            mod *= 2.5;
        }
        mod = Math.round(mod * 100) / 100;
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function spellModGreenImpl() : Float
    {
        var mod : Float = 1;
        if (spellModWhiteImpl() > 1)
        {
            mod += (spellModWhiteImpl() - 1);
        }
        if (player.hasPerk(PerkLib.OneWiththeForest) && player.perkv2(PerkLib.OneWiththeForest) > 0)
        {
            mod += (0.05 * player.perkv2(PerkLib.OneWiththeForest));
        }
        if (player.hasPerk(PerkLib.VegetalAffinity))
        {
            mod += 0.5;
        }
        if (player.hasPerk(PerkLib.GreenMagic))
        {
            mod += 1;
        }
        if (player.hasStatusEffect(StatusEffects.GreenCovenant))
        {
            mod += 1;
        }
        mod = Math.round(mod * 100) / 100;
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function healCostImpl(mod : Float) : Float
    {
        var costPercent : Float = 100 + costChange_all() + costChange_heal();
        //Addiditive mods
        if (healModImpl() > 1)
        {
            costPercent += Math.round(healModImpl() - 1) * 10;
        }
        if (player.hasPerk(PerkLib.AscensionMysticality))
        {
            costPercent -= (player.perkv1(PerkLib.AscensionMysticality) * 2);
        }
        mod *= costPercent / 100;
        if (mod < 5)
        {
            mod = 5;
        }
        mod = Math.round(mod * 100) / 100;
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function healCostWhiteImpl(mod : Float) : Float
    {
        var costPercent : Float = 100 + costChange_all() + costChange_heal() + costChange_white();
        //Addiditive mods
        if (healModWhiteImpl() > 1)
        {
            costPercent += Math.round(healModWhiteImpl() - 1) * 10;
        }
        if (player.hasPerk(PerkLib.AscensionMysticality))
        {
            costPercent -= (player.perkv1(PerkLib.AscensionMysticality) * 2);
        }
        mod *= costPercent / 100;
        if (mod < 5)
        {
            mod = 5;
        }
        mod = Math.round(mod * 100) / 100;
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function healCostBlackImpl(mod : Float) : Float
    {
        var costPercent : Float = 100 + costChange_all() + costChange_heal() + costChange_black();
        //Addiditive mods
        if (healModBlackImpl() > 1)
        {
            costPercent += Math.round(healModBlackImpl() - 1) * 10;
        }
        if (player.hasPerk(PerkLib.AscensionMysticality))
        {
            costPercent -= (player.perkv1(PerkLib.AscensionMysticality) * 2);
        }
        mod *= costPercent / 100;
        if (mod < 5)
        {
            mod = 5;
        }
        mod = Math.round(mod * 100) / 100;
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function healModImpl() : Float
    {
        var mod : Float = 1 + modChange_all() + modChange_heal();
        if (player.hasPerk(PerkLib.Obsession))
        {
            mod += player.perkv1(PerkLib.Obsession);
        }
        if (player.hasPerk(PerkLib.Ambition))
        {
            mod += player.perkv1(PerkLib.Ambition);
        }
        if (player.hasPerk(PerkLib.TamamoNoMaeCursedKimono))
        {
            mod += (player.cor * .01);
        }
        if (player.hasPerk(PerkLib.SeersInsight))
        {
            mod += player.perkv1(PerkLib.SeersInsight);
        }
        if (player.hasPerk(PerkLib.InariBlessedKimono))
        {
            mod += ((100 - player.cor) * .01);
        }
        if (player.hasPerk(PerkLib.AscensionMysticality))
        {
            mod *= 1 + (player.perkv1(PerkLib.AscensionMysticality) * 0.1);
        }
        if (player.weapon == weapons.ASCENSU)
        {
            mod *= 6.5;
        }
        if (player.weapon == weapons.ECLIPSE)
        {
            mod *= 0.2;
        }
        if (player.weapon == weapons.OCCULUS)
        {
            mod *= 5;
        }
        mod = Math.round(mod * 100) / 100;
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function healModWhiteImpl() : Float
    {
        var mod : Float = 1;
        if (healModImpl() > 1)
        {
            mod += (healModImpl() - 1);
        }
        if (player.hasPerk(PerkLib.Ambition))
        {
            mod += player.perkv2(PerkLib.Ambition);
        }
        if (player.hasStatusEffect(StatusEffects.BlessingOfDivineMarae))
        {
            mod += player.statusEffectv2(StatusEffects.BlessingOfDivineMarae);
        }
        if (player.hasPerk(PerkLib.AvatorOfPurity))
        {
            mod += .3;
        }
        if (player.hasPerk(PerkLib.UnicornBlessing) && player.cor <= 20)
        {
            mod += .2;
        }
        if (player.hasKeyItem("Holy Symbol") >= 0)
        {
            mod += .2;
        }
        if (player.hasPerk(PerkLib.SeersInsight))
        {
            mod += player.perkv1(PerkLib.SeersInsight);
        }
        if (player.hasPerk(PerkLib.AscensionMysticality))
        {
            mod *= 1 + (player.perkv1(PerkLib.AscensionMysticality) * 0.1);
        }
        if (player.weapon == weapons.PURITAS)
        {
            mod *= 2.5;
        }
        mod = Math.round(mod * 100) / 100;
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function healModBlackImpl() : Float
    {
        var mod : Float = 1;
        if (healModImpl() > 1)
        {
            mod += (healModImpl() - 1);
        }
        if (player.hasPerk(PerkLib.Obsession))
        {
            mod += player.perkv2(PerkLib.Obsession);
        }
        if (player.hasPerk(PerkLib.AvatorOfCorruption))
        {
            mod += .3;
        }
        if (player.hasPerk(PerkLib.BicornBlessing) && player.cor >= 80)
        {
            mod += .2;
        }
        if (player.hasPerk(PerkLib.SeersInsight))
        {
            mod += player.perkv1(PerkLib.SeersInsight);
        }
        if (player.hasPerk(PerkLib.AscensionMysticality))
        {
            mod *= 1 + (player.perkv1(PerkLib.AscensionMysticality) * 0.1);
        }
        if (player.weapon == weapons.DEPRAVA)
        {
            mod *= 2.5;
        }
        mod = Math.round(mod * 100) / 100;
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function spellGreyCooldownImpl() : Float
    {
        var mod : Float = 3;
        if (player.weapon == weapons.B_STAFF)
        {
            mod -= 1;
        }
        if (player.hasPerk(PerkLib.NaturalSpellcasting))
        {
            if (player.necklace == necklaces.LEAFAMU && player.isElf())
            {
                mod -= 2;
            }
            else
            {
                mod -= 1;
            }
        }
        if (player.hasPerk(PerkLib.HyperCasting))
        {
            mod -= 1;
        }
        if (mod < 0)
        {
            mod = 0;
        }
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function spellGreyTier2CooldownImpl() : Float
    {
        var mod : Float = 6;
        if (player.hasPerk(PerkLib.NaturalSpellcasting))
        {
            if (player.necklace == necklaces.LEAFAMU && player.isElf())
            {
                mod -= 2;
            }
            else
            {
                mod -= 1;
            }
        }
        if (player.hasPerk(PerkLib.HyperCasting))
        {
            mod -= 2;
        }
        if (mod < 0)
        {
            mod = 0;
        }
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function spellWhiteCooldownImpl() : Float
    {
        var mod : Float = 3;
        if (player.weapon == weapons.B_STAFF)
        {
            mod -= 1;
        }
        if (player.hasPerk(PerkLib.AvatorOfPurity))
        {
            mod -= 1;
        }
        if (player.hasPerk(PerkLib.NaturalSpellcasting))
        {
            if (player.necklace == necklaces.LEAFAMU && player.isElf())
            {
                mod -= 2;
            }
            else
            {
                mod -= 1;
            }
        }
        if (player.hasPerk(PerkLib.HyperCasting))
        {
            mod -= 1;
        }
        if (mod < 0)
        {
            mod = 0;
        }
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function spellWhiteTier2CooldownImpl() : Float
    {
        var mod : Float = 6;
        if (player.hasPerk(PerkLib.AvatorOfPurity))
        {
            mod -= 1;
        }
        if (player.hasPerk(PerkLib.NaturalSpellcasting))
        {
            if (player.necklace == necklaces.LEAFAMU && player.isElf())
            {
                mod -= 2;
            }
            else
            {
                mod -= 1;
            }
        }
        if (player.hasPerk(PerkLib.HyperCasting))
        {
            mod -= 2;
        }
        if (mod < 0)
        {
            mod = 0;
        }
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function spellWhiteTier3CooldownImpl() : Float
    {
        var mod : Float = 12;
        if (player.hasPerk(PerkLib.AvatorOfPurity))
        {
            mod -= 1;
        }
        if (player.hasPerk(PerkLib.NaturalSpellcasting))
        {
            if (player.necklace == necklaces.LEAFAMU && player.isElf())
            {
                mod -= 2;
            }
            else
            {
                mod -= 1;
            }
        }
        if (player.hasPerk(PerkLib.HyperCasting))
        {
            mod -= 4;
        }
        if (mod < 0)
        {
            mod = 0;
        }
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function spellBlackCooldownImpl() : Float
    {
        var mod : Float = 3;
        if (player.weapon == weapons.B_STAFF)
        {
            mod -= 1;
        }
        if (player.hasPerk(PerkLib.AvatorOfCorruption))
        {
            mod -= 1;
        }
        if (player.hasPerk(PerkLib.NaturalSpellcasting))
        {
            if (player.necklace == necklaces.LEAFAMU && player.isElf())
            {
                mod -= 2;
            }
            else
            {
                mod -= 1;
            }
        }
        if (player.hasPerk(PerkLib.Necromancy))
        {
            mod -= 1;
        }
        if (player.hasPerk(PerkLib.HyperCasting))
        {
            mod -= 1;
        }
        if (mod < 0)
        {
            mod = 0;
        }
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function spellBlackTier2CooldownImpl() : Float
    {
        var mod : Float = 6;
        if (player.hasPerk(PerkLib.AvatorOfCorruption))
        {
            mod -= 1;
        }
        if (player.hasPerk(PerkLib.NaturalSpellcasting))
        {
            if (player.necklace == necklaces.LEAFAMU && player.isElf())
            {
                mod -= 2;
            }
            else
            {
                mod -= 1;
            }
        }
        if (player.hasPerk(PerkLib.Necromancy))
        {
            mod -= 1;
        }
        if (player.hasPerk(PerkLib.HyperCasting))
        {
            mod -= 2;
        }
        if (mod < 0)
        {
            mod = 0;
        }
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function spellBlackTier3CooldownImpl() : Float
    {
        var mod : Float = 12;
        if (player.hasPerk(PerkLib.AvatorOfCorruption))
        {
            mod -= 1;
        }
        if (player.hasPerk(PerkLib.NaturalSpellcasting))
        {
            if (player.necklace == necklaces.LEAFAMU && player.isElf())
            {
                mod -= 2;
            }
            else
            {
                mod -= 1;
            }
        }
        if (player.hasPerk(PerkLib.Necromancy))
        {
            mod -= 1;
        }
        if (player.hasPerk(PerkLib.HyperCasting))
        {
            mod -= 4;
        }
        if (mod < 0)
        {
            mod = 0;
        }
        return mod;
    }
    
    @:allow(classes.scenes.combat)
    private function spellGenericCooldownImpl() : Float
    {
        var mod : Float = 3;
        if (player.weapon == weapons.B_STAFF)
        {
            mod -= 1;
        }
        if (player.hasPerk(PerkLib.NaturalSpellcasting))
        {
            if (player.necklace == necklaces.LEAFAMU && player.isElf())
            {
                mod -= 2;
            }
            else
            {
                mod -= 1;
            }
        }
        if (player.hasPerk(PerkLib.HyperCasting))
        {
            mod -= 1;
        }
        return mod;
    }
    
    public function getBlackMagicMinLust() : Float
    {
        if (player.hasPerk(PerkLib.GreyMage))
        {
            return 30;
        }
        return 50;
    }
    
    public function getWhiteMagicLustCap() : Float
    {
        var whiteLustCap : Int = as3hx.Compat.parseInt(player.maxLust() * 0.75);
        if (player.hasPerk(PerkLib.Enlightened) && player.cor < (10 + player.corruptionTolerance))
        {
            whiteLustCap += as3hx.Compat.parseInt(player.maxLust() * 0.1);
        }
        if (player.hasPerk(PerkLib.FocusedMind) && !player.hasPerk(PerkLib.GreyMage))
        {
            whiteLustCap += as3hx.Compat.parseInt(player.maxLust() * 0.1);
        }
        if (player.hasPerk(PerkLib.GreyMage))
        {
            if (player.hasPerk(PerkLib.Enlightened) && player.cor < (10 + player.corruptionTolerance))
            {
                whiteLustCap = as3hx.Compat.parseInt(player.maxLust() - 15);
            }
            else
            {
                whiteLustCap = as3hx.Compat.parseInt(player.maxLust() - 45);
            }
        }
        return whiteLustCap;
    }
    
    private function omnicasterMutliForReflectDmgAndAchievments() : Float
    {
        return AbstractSpell.omnicasterRepeatCount();
    }
    
    public function perkRelatedDurationBoosting() : Float
    {
        var perkRelatedDB : Float = 0;
        if (player.hasPerk(PerkLib.LongerLastingBuffsI))
        {
            perkRelatedDB += 1;
        }
        if (player.hasPerk(PerkLib.LongerLastingBuffsII))
        {
            perkRelatedDB += 1;
        }
        if (player.hasPerk(PerkLib.LongerLastingBuffsIII))
        {
            perkRelatedDB += 1;
        }
        if (player.hasPerk(PerkLib.LongerLastingBuffsIV))
        {
            perkRelatedDB += 1;
        }
        if (player.hasPerk(PerkLib.LongerLastingBuffsV))
        {
            perkRelatedDB += 1;
        }
        if (player.hasPerk(PerkLib.LongerLastingBuffsVI))
        {
            perkRelatedDB += 1;
        }
        if (player.hasPerk(PerkLib.EverLastingBuffs))
        {
            perkRelatedDB += 5;
        }
        if (player.hasPerk(PerkLib.EternalyLastingBuffs))
        {
            perkRelatedDB += 5;
        }
        return perkRelatedDB;
    }
    
    public static var magicCounterPerks : Dynamic = {
            fire : {
                tier1 : PerkLib.RagingInferno,
                tier2 : PerkLib.RagingInfernoEx,
                tier3 : PerkLib.RagingInfernoSu,
                tier4 : PerkLib.RagingInfernoMastered,
                counter : StatusEffects.CounterRagingInferno,
                type : "fire"
            },
            earth : {
                tier1 : PerkLib.RumblingQuake,
                tier2 : PerkLib.RumblingQuakeEx,
                tier3 : PerkLib.RumblingQuakeSu,
                tier4 : PerkLib.RumblingQuakeMastered,
                counter : StatusEffects.CounterRumblingQuake,
                type : "earth"
            },
            wind : {
                tier1 : PerkLib.HowlingGale,
                tier2 : PerkLib.HowlingGaleEx,
                tier3 : PerkLib.HowlingGaleSu,
                tier4 : PerkLib.HowlingGaleMastered,
                counter : StatusEffects.CounterHowlingGale,
                type : "wind"
            },
            water : {
                tier1 : PerkLib.HighTide,
                tier2 : PerkLib.HighTideEx,
                tier3 : PerkLib.HighTideSu,
                tier4 : PerkLib.HighTideMastered,
                counter : StatusEffects.CounterHighTide,
                type : "water"
            },
            ice : {
                tier1 : PerkLib.GlacialStorm,
                tier2 : PerkLib.GlacialStormEx,
                tier3 : PerkLib.GlacialStormSu,
                tier4 : PerkLib.GlacialStormMastered,
                counter : StatusEffects.CounterGlacialStorm,
                type : "ice"
            },
            lightning : {
                tier1 : PerkLib.HighVoltage,
                tier2 : PerkLib.HighVoltageEx,
                tier3 : PerkLib.HighVoltageSu,
                tier4 : PerkLib.HighVoltageMastered,
                counter : StatusEffects.CounterHighVoltage,
                type : "lightning"
            },
            darkness : {
                tier1 : PerkLib.EclipsingShadow,
                tier2 : PerkLib.EclipsingShadowEx,
                tier3 : PerkLib.EclipsingShadowSu,
                tier4 : PerkLib.EclipsingShadowMastered,
                counter : StatusEffects.CounterEclipsingShadow,
                type : "darkness"
            },
            acid : {
                tier1 : PerkLib.CorrosiveMeltdown,
                tier2 : PerkLib.CorrosiveMeltdownEx,
                tier3 : PerkLib.CorrosiveMeltdownSu,
                tier4 : PerkLib.CorrosiveMeltdownMastered,
                counter : StatusEffects.CounterCorrosiveMeltdown,
                type : "acid"
            }
        };
    
    @:allow(classes.scenes.combat)
    private function calcMagicCounterModImpl(perkObj : Dynamic, damage : Float, casting : Bool = true) : Float
    {
        var modDmg : Float = damage;
        //v1 is counter value in 5% (for later tiers),
        if (player.hasPerk(perkObj.tier1) || player.hasPerk(perkObj.tier4))
        
        //if has perk{
            
            if (casting)
            {
                if (player.hasStatusEffect(perkObj.counter))
                
                //counter created{
                    
                    var cap : Float = 40;
                    if (player.hasPerk(perkObj.tier2))
                    {
                        cap += 80;
                    }
                    if (player.hasPerk(perkObj.tier3))
                    {
                        cap += 480;
                    }
                    if (player.hasPerk(perkObj.tier4))
                    {
                        cap += 320;
                    }
                    //calculating damage
                    if (player.statusEffectv1(perkObj.counter) > 0)
                    {
                        modDmg = Math.round(damage * (1 + player.statusEffectv1(perkObj.counter) * 0.05));
                    }
                    //fancy messages
                    if (player.statusEffectv1(perkObj.counter) == 0)
                    {
                        outputText("\nUnfortunately, traces of your previously used " + perkObj.type + " magic are too weak to be used.\n\n");
                    }
                    else
                    {
                        outputText("\nTraces of your previously used " + perkObj.type + " magic are still here, and you use them to empower another spell!\n\n");
                    }
                    //increasing counters
                    var increase : Float = 8;
                    if (player.hasPerk(perkObj.tier2))
                    {
                        increase += 4;
                    }
                    if (player.hasPerk(perkObj.tier4))
                    {
                        increase += 16;
                    }
                    if (player.statusEffectv1(perkObj.counter) < cap)
                    {
                        player.addStatusValue(perkObj.counter, 1, increase);
                        player.addStatusValue(perkObj.counter, 2, 1);
                    }
                }
                else if (player.hasPerk(perkObj.tier4))
                {
                    player.createStatusEffect(perkObj.counter, 24, 1, 0, 0);
                }
                else if (player.hasPerk(perkObj.tier2))
                {
                    player.createStatusEffect(perkObj.counter, 12, 1, 0, 0);
                }
                else
                {
                    player.createStatusEffect(perkObj.counter, 8, 1, 0, 0);
                }
            }
            //just calc damage
            else
            {
                
                if (player.hasStatusEffect(perkObj.counter) && player.statusEffectv1(perkObj.counter) > 0)
                {
                    modDmg = Math.round(damage * (1 + player.statusEffectv1(perkObj.counter) * 0.05));
                }
            }
        }
        return modDmg;
    }
    
    @:allow(classes.scenes.combat)
    private function maintainMagicCounter(perkObj : Dynamic) : Void
    {
        if (player.hasStatusEffect(perkObj.counter))
        {
            if (player.hasPerk(perkObj.tier3) || player.hasPerk(perkObj.tier4))
            {
                player.addStatusValue(perkObj.counter, 1, 4);
            }
            else if (player.hasPerk(perkObj.tier2))
            {
                player.addStatusValue(perkObj.counter, 1, 6);
            }
            player.addStatusValue(perkObj.counter, 1, 8);
        }
    }
    
    @:allow(classes.scenes.combat)
    private function calcInfernoModImpl(damage : Float, casting : Bool = true) : Float
    {
        return calcMagicCounterModImpl(Reflect.field(magicCounterPerks, "fire"), damage, casting);
    }
    
    @:allow(classes.scenes.combat)
    private function calcGlacialModImpl(damage : Float, casting : Bool = true) : Float
    {
        return calcMagicCounterModImpl(Reflect.field(magicCounterPerks, "ice"), damage, casting);
    }
    
    @:allow(classes.scenes.combat)
    private function calcVoltageModImpl(damage : Float, casting : Bool = true) : Float
    {
        return calcMagicCounterModImpl(Reflect.field(magicCounterPerks, "lightning"), damage, casting);
    }
    
    @:allow(classes.scenes.combat)
    private function calcEclypseModImpl(damage : Float, casting : Bool = true) : Float
    {
        return calcMagicCounterModImpl(Reflect.field(magicCounterPerks, "darkness"), damage, casting);
    }
    
    @:allow(classes.scenes.combat)
    private function calcTideModImpl(damage : Float, casting : Bool = true) : Float
    {
        return calcMagicCounterModImpl(Reflect.field(magicCounterPerks, "water"), damage, casting);
    }
    
    @:allow(classes.scenes.combat)
    private function calcQuakeModImpl(damage : Float, casting : Bool = true) : Float
    {
        return calcMagicCounterModImpl(Reflect.field(magicCounterPerks, "earth"), damage, casting);
    }
    
    @:allow(classes.scenes.combat)
    private function calcGaleModImpl(damage : Float, casting : Bool = true) : Float
    {
        return calcMagicCounterModImpl(Reflect.field(magicCounterPerks, "wind"), damage, casting);
    }
    
    @:allow(classes.scenes.combat)
    private function calcCorrosionModImpl(damage : Float, casting : Bool = true) : Float
    {
        return calcMagicCounterModImpl(Reflect.field(magicCounterPerks, "acid"), damage, casting);
    }
    
    @:allow(classes.scenes.combat)
    private function maintainInfernoModImpl() : Void
    {
        maintainMagicCounter(Reflect.field(magicCounterPerks, "fire"));
    }
    
    @:allow(classes.scenes.combat)
    private function maintainGlacialModImpl() : Void
    {
        maintainMagicCounter(Reflect.field(magicCounterPerks, "ice"));
    }
    
    @:allow(classes.scenes.combat)
    private function maintainVoltageModImpl() : Void
    {
        maintainMagicCounter(Reflect.field(magicCounterPerks, "lightning"));
    }
    
    @:allow(classes.scenes.combat)
    private function maintainEclypseModImpl() : Void
    {
        maintainMagicCounter(Reflect.field(magicCounterPerks, "darkness"));
    }
    
    @:allow(classes.scenes.combat)
    private function maintainTideModImpl() : Void
    {
        maintainMagicCounter(Reflect.field(magicCounterPerks, "water"));
    }
    
    @:allow(classes.scenes.combat)
    private function maintainQuakeModImpl() : Void
    {
        maintainMagicCounter(Reflect.field(magicCounterPerks, "earth"));
    }
    
    @:allow(classes.scenes.combat)
    private function maintainGaleModImpl() : Void
    {
        maintainMagicCounter(Reflect.field(magicCounterPerks, "wind"));
    }
    
    @:allow(classes.scenes.combat)
    private function maintainCorrosionModImpl() : Void
    {
        maintainMagicCounter(Reflect.field(magicCounterPerks, "acid"));
    }
    
    public function MagicPrefixEffect(display : Bool = true) : Void
    //if (player.hasPerk(PerkLib.Spellsong) && player.hasStatusEffect(StatusEffects.Sing)) {
    {
        
        //	outputText(" You weave your song into magic to unleash a spell.\n\n");
        //}
        if (player.armor == armors.DWSROBE)
        {
            if (display)
            {
                outputText("As your mana flows through your body, culminating in your hands, your sheer robe glows, giving [themonster] a good, long look at you.\n\n");
                if (player.gender == Gender.GENDER_FEMALE || (player.gender == Gender.GENDER_HERM && rand(2) == 0))
                {
                    outputText("You lean forward, moving your [breasts] from side to side. As your mana focuses, you roll your shoulders back and your hips forward, giving the [themonster] a little moan, biting your lip, your arms behind your back. Their gaze drops to your snatch, but as they gaze at your delta, you finish your spell, robes turning back to normal. ");
                }
                else
                {
                    outputText("You spread your hands, letting mana flow through you. Your robe all but vanishes, and you thrust your hips forward, [cock] hardening slightly, your bulge standing up straight and tenting the sheer silk. Giving your enemy a cocky grin, you lick your lips, giving them a few thrusts of your hips. ");
                    outputText("[Themonster], stunned by the sudden change in your bearing and…manhood, gives you more than enough time to finish your spell. ");
                }
                if (player.perkv1(PerkLib.ImpNobility) > 0)
                {
                    outputText("  Your imp cohorts assist your spellcasting, adding their diagrams to your own.");
                }
            }
            var damage : Float = 0;
            var damagemultiplier : Float = 1;
            damage += combat.teases.teaseBaseLustDamage();
            if (player.hasPerk(PerkLib.UnbreakableBind))
            {
                damagemultiplier += 1;
            }
            if (player.hasStatusEffect(StatusEffects.ControlFreak))
            {
                damagemultiplier += (2 - player.statusEffectv1(StatusEffects.ControlFreak));
            }
            damage *= damagemultiplier;
            if (player.hasPerk(PerkLib.Sadomasochism))
            {
                damage *= player.sadomasochismBoost();
            }
            damage = combat.teases.fueledByDesireDamageBonus(damage);
            
            //Determine if critical tease!
            var crit : Bool = false;
            var critChance : Int = 5;
            critChance += combat.teases.combatTeaseCritical();
            if (rand(100) < critChance)
            {
                crit = true;
                damage *= 1.75;
            }
            if (monster.hasStatusEffect(StatusEffects.HypnosisNaga))
            {
                damage *= 0.5;
            }
            if (player.hasPerk(PerkLib.RacialParagon))
            {
                damage *= combat.RacialParagonAbilityBoost();
            }
            monster.teased(Math.round(monster.lustVuln * damage));
            if (crit && display)
            {
                outputText(" <b>Critical!</b>");
            }
            SceneLib.combat.teaseXP(1 + SceneLib.combat.bonusExpAfterSuccesfullTease());
            outputText("\n\n");
            combat.teases.fueledByDesireHeal(display);
        }
    }
    
    //THIS FEATURE GOVERNS EVERY POST CAST EFFECT YOUR SPELLS MAY CAUSE
    public function MagicAddonEffect(numberOfProcs : Float = 1) : Void
    {
        if (player.hasStatusEffect(StatusEffects.Venomancy))
        {
            if (player.tailVenom >= player.VenomWebCost())
            {
                var injections : Float = 0;
                if (player.hasPerk(PerkLib.ArcaneVenom))
                {
                    numberOfProcs *= AbstractSpell.stackingArcaneVenom();
                }
                while (player.tailVenom >= player.VenomWebCost() && injections < numberOfProcs)
                {
                    var damageB : Float = 35 + rand(player.lib / 10);
                    var poisonScaling : Float = 1;
                    var dam4Bab : Float = 1;
                    if (player.hasPerk(PerkLib.ImprovedVenomGlandSu))
                    {
                        dam4Bab *= 2;
                    }
                    poisonScaling += player.lib / 100;
                    poisonScaling += player.tou / 100;
                    if (player.level < 10)
                    {
                        damageB += 20 + (player.level * 3);
                    }
                    else if (player.level < 20)
                    {
                        damageB += 50 + (player.level - 10) * 2;
                    }
                    else if (player.level < 30)
                    {
                        damageB += 70 + (player.level - 20) * 1;
                    }
                    else
                    {
                        damageB += 80;
                    }
                    damageB *= 0.04;
                    damageB *= dam4Bab;
                    poisonScaling *= dam4Bab;
                    damageB *= 1 + (poisonScaling / 10);
                    monster.teased(Math.round(monster.lustVuln * damageB), false);
                    monster.statStore.addBuffObject({
                                tou : -poisonScaling
                            }, "Poison", {
                                text : "Poison"
                            });
                    var venomType : StatusEffectType = StatusEffects.NagaVenom;
                    if (player.racialScore(Races.NAGA) >= 23)
                    {
                        venomType = StatusEffects.ApophisVenom;
                    }
                    if (monster.hasStatusEffect(venomType))
                    {
                        monster.addStatusValue(venomType, 3, 1);
                    }
                    else
                    {
                        monster.createStatusEffect(venomType, 0, 0, 1, 0);
                    }
                    if (player.hasPerk(PerkLib.WoundPoison))
                    {
                        if (monster.hasStatusEffect(StatusEffects.WoundPoison))
                        {
                            monster.addStatusValue(StatusEffects.WoundPoison, 1, 10);
                        }
                        else
                        {
                            monster.createStatusEffect(StatusEffects.WoundPoison, 10, 0, 0, 0);
                        }
                    }
                    player.tailVenom -= player.VenomWebCost();
                    flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
                    injections++;
                }
                outputText(" Your venom is forcefully injected ");
                if (injections > 1)
                {
                    outputText("" + injections + " times");
                }
                outputText(" in [themonster] through your magic!");
            }
        }
        if (player.hasStatusEffect(StatusEffects.BalanceOfLife))
        {
            HPChange(player.maxHP() * numberOfProcs * 0.05, false);
        }
    }
    
    public function brutalSpellsEffect(display : Bool = true) : Void
    {
        if (monster.armorMDef > 0 && display)
        {
            outputText("\nYour spells are so brutal that you damage [themonster]'s magical resistance!");
        }
        var bbc : Float = (Math.round(monster.armorMDef * 0.1) + 5);
        if (monster.armorMDef - bbc > 0)
        {
            monster.armorMDef -= bbc;
        }
        else
        {
            monster.armorMDef = 0;
        }
    }
    
    public function spellMagicBolt() : Void
    {
        spellMagicBolt2(false, false);
    }
    public function spellElementalBolt() : Void
    {
        spellMagicBolt2(true, false);
    }
    public function spellEdgyMagicBolt() : Void
    {
        spellMagicBolt2(false, true);
    }
    public function spellEdgyElementalBolt() : Void
    {
        spellMagicBolt2(true, true);
    }
    public function spellMagicBolt2(elemental : Bool = false, edgy : Bool = false) : Void
    {
        useMana((elemental) ? 80 : 40, Combat.USEMANA_MAGIC);
        if (edgy)
        {
            player.wrath -= 100;
        }
        flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
        clearOutput();
        combat.darkRitualCheckDamage();
        if (handleShell())
        {
            return;
        }
        outputText("You narrow your eyes, focusing your mind with deadly intent.  ");
        if (player.hasPerk(PerkLib.StaffChanneling) && (player.weapon.isStaffType() || player.weaponOff.isStaffType() || player.weapon.isWandType() || player.weaponOff.isWandType()))
        {
            if (player.weapon.isWandType() || player.weaponOff.isWandType())
            {
                outputText("You point your wand and shoot a magic bolt toward [themonster]!\n\n");
            }
            else
            {
                outputText("You point your staff and shoot a magic bolt toward [themonster]!\n\n");
            }
        }
        else
        {
            outputText("You point your hand toward [themonster] and shoot a magic bolt!\n\n");
        }
        var damage : Float = scalingBonusIntelligence() * spellMod() * 1.2;
        if (damage < 10)
        {
            damage = 10;
        }
        //weapon bonus
        if (player.hasPerk(PerkLib.StaffChanneling) && (player.weapon.isStaffType() || player.weaponOff.isStaffType() || player.weapon.isWandType() || player.weaponOff.isWandType()))
        {
            var weaponAtk : Float = player.weaponAttack;
            if (player.weapon.isWandType() || player.weaponOff.isWandType())
            {
                weaponAtk = Math.round(weaponAtk * 0.75);
            }
            if (weaponAtk < 51)
            {
                damage *= (1 + (weaponAtk * 0.04));
            }
            else if (weaponAtk >= 51 && weaponAtk < 101)
            {
                damage *= (3 + ((weaponAtk - 50) * 0.035));
            }
            else if (weaponAtk >= 101 && weaponAtk < 151)
            {
                damage *= (4.75 + ((weaponAtk - 100) * 0.03));
            }
            else if (weaponAtk >= 151 && weaponAtk < 201)
            {
                damage *= (6.25 + ((weaponAtk - 150) * 0.025));
            }
            else
            {
                damage *= (7.5 + ((weaponAtk - 200) * 0.02));
            }
        }
        if (player.hasPerk(PerkLib.ElementalBolt))
        {
            damage *= 1.25;
        }
        if (player.armorName == "FrancescaCloak")
        {
            damage *= 2;
        }
        if (edgy)
        {
            damage *= 2;
        }
        //Determine if critical hit!
        var crit : Bool = false;
        var critChance : Int = 5;
        critChance += combatMagicalCritical();
        if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals))
        {
            critChance = 0;
        }
        if (rand(100) < critChance)
        {
            crit = true;
            damage *= 1.75;
        }
        damage = Math.round(damage);
        outputText(monster.capitalA + monster.short + " takes ");
        doMagicDamage(damage, true, true);
        outputText(" damage.");
        if (crit)
        {
            outputText(" <b>*Critical Hit!*</b>");
        }
        MagicAddonEffect();
        outputText("\n\n");
        checkAchievementDamage(damage);
        if (edgy)
        {
            awardAchievement("Edgy Caster", kACHIEVEMENTS.COMBAT_EDGY_CASTER);
        }
        flags[kFLAGS.SPELLS_CAST]++;
        if (!player.hasStatusEffect(StatusEffects.CastedSpell))
        {
            player.createStatusEffect(StatusEffects.CastedSpell, 0, 0, 0, 0);
        }
        spellPerkUnlock();
        combat.heroBaneProc(damage);
        statScreenRefresh();
        if (player.hasPerk(PerkLib.ElementalBolt))
        {
            for (perkObj/* AS3HX WARNING could not determine type for var: perkObj exp: EIdent(magicCounterPerks) type: Dynamic */ in magicCounterPerks)
            {
                maintainMagicCounter(perkObj);
            }
        }
        if (monster.HP <= monster.minHP())
        {
            doNext(endHpVictory);
        }
        else
        {
            if (Std.is(monster, Lethice) && (try cast(monster, Lethice) catch(e:Dynamic) null).fightPhase == 3)
            {
                outputText("\n\n<i>\"Ouch. Such arcane skills for one so uncouth,\"</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>\"How will you beat me without your magics?\"</i>\n\n");
                monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
            }
            enemyAI();
        }
    }
    
    public function spellGreenCovenantOff() : Void
    {
        clearOutput();
        outputText("Information Noona Warning:\n\n<b>Your Green Covenant is deactivated now.</b>");
        player.removeStatusEffect(StatusEffects.GreenCovenant);
        enemyAI();
    }
    
    private function handleShell() : Bool
    {
        if (monster.hasStatusEffect(StatusEffects.Shell))
        {
            outputText("As soon as your magic touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
            flags[kFLAGS.SPELLS_CAST]++;
            if (!player.hasStatusEffect(StatusEffects.CastedSpell))
            {
                player.createStatusEffect(StatusEffects.CastedSpell, 0, 0, 0, 0);
            }
            spellPerkUnlock();
            enemyAI();
            return true;
        }
        return false;
    }
}

