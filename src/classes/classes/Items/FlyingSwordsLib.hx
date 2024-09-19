/**
 * ...
 * @author Ormael
 */
package classes.items;

import classes.items.flyingSwords.*;
import classes.scenes.combat.CombatAbility;

@:final class FlyingSwordsLib extends ItemConstants
{
    public static inline var DEFAULT_VALUE : Float = 6;  //cena bazowa dla latających mieczy to 50 gems a nie 40 gems  
    public static var NOTHING : Nothing = new Nothing();
    
    public var ASAUCHI(default, never) : FlyingSwords = new FlyingSwords("Asauchi", "Asauchi", "Asauchi", "Asauchi", "slash", 32, 1600, "Sword that was forged from soulmetal. It may not be as deadly as others but due to material it lessen consumption of soul energies.", "Massive");
    public var A_HALFM(default, never) : FlyingSwords = new FlyingSwords("A.HalfM", "Aquamarine Half-Moon", "Aquamarine Half-Moon", "Aquamarine Half-Moon", "slash", 15, 1500, "Sword that was forged from metal repeadly bathed in water from oceanic trench.", "Large", 1, CombatAbility.TAG_WATER);
    public var A_HALFM2(default, never) : FlyingSwords = new FlyingSwords("A.HalfM2", "Aquamarine Half-Moon Duo", "Aquamarine Half-Moon Duo", "Aquamarine Half-Moon Duo", "slash", 15, 3000, "Pair of swords that were forged from metal repeadly bathed in water from oceanic trench.", "Large", 2, CombatAbility.TAG_WATER);
    public var B_HALFM(default, never) : FlyingSwords = new FlyingSwords("B.HalfM", "Black Half-Moon", "Black Half-Moon", "Black Half-Moon", "slash", 6, 600, "Sword that was forged from metal repeadly bathed in liquid ice.", "Small", 1, CombatAbility.TAG_ICE);
    public var B_HALFM2(default, never) : FlyingSwords = new FlyingSwords("B.HalfM2", "Black Half-Moon Duo", "Black Half-Moon Duo", "Black Half-Moon Duo", "slash", 6, 1200, "Pair of swords that were forged from metal repeadly bathed in liquid ice.", "Small", 2, CombatAbility.TAG_ICE);
    public var B_HALFM3(default, never) : FlyingSwords = new FlyingSwords("B.HalfM3", "Black Half-Moon Quartet", "Black Half-Moon Quartet", "Black Half-Moon Quartet", "slash", 6, 2400, "Set of four swords that were forged from metal repeadly bathed in liquid ice.", "Small", 4, CombatAbility.TAG_ICE);
    public var C_NEW_M(default, never) : FlyingSwords = new FlyingSwords("C.New.M", "Chrysolite New Moon", "Chrysolite New Moon", "Chrysolite New Moon", "slash", 40, 3750, "Magnificent sword that was forged from metal repeadly tempered by the golden crow flames.", "Massive", 1, CombatAbility.TAG_PLASMA);
    public var E_HALFM(default, never) : FlyingSwords = new FlyingSwords("E.HalfM", "Ebon Half-Moon", "Ebon Half-Moon", "Ebon Half-Moon", "slash", 6, 600, "Sword that was forged from metal repeadly infused with the darkness.", "Small", 1, CombatAbility.TAG_DARKNESS);
    public var E_HALFM2(default, never) : FlyingSwords = new FlyingSwords("E.HalfM2", "Ebon Half-Moon Duo", "Ebon Half-Moon Duo", "Ebon Half-Moon Duo", "slash", 6, 1200, "Pair of swords that were forged from metal repeadly infused with the darkness.", "Small", 2, CombatAbility.TAG_DARKNESS);
    public var E_HALFM3(default, never) : FlyingSwords = new FlyingSwords("E.HalfM3", "Ebon Half-Moon Quartet", "Ebon Half-Moon Quartet", "Ebon Half-Moon Quartet", "slash", 6, 2400, "Set of four swords that were forged from metal repeadly infused with the darkness.", "Small", 4, CombatAbility.TAG_DARKNESS);
    public var MOONLGT(default, never) : FlyingSwords = new FlyingSwords("Moonlgt", "Moonlight", "Moonlight", "Moonlight", "slash", 8, 800, "This flying sword was specialy forged and enchanted to help with sneak attacks and posses increased chance to leave bleeding wounds.", "Small");
    public var MOONLGT2(default, never) : FlyingSwords = new FlyingSwords("Moonlgt2", "Moonlight Duo", "Moonlight Duo", "Moonlight Duo", "slash", 8, 1600, "This pair of flying swords were specialy forged and enchanted to help with sneak attacks and posses increased chance to leave bleeding wounds.", "Small", 2);
    public var MOONLGT3(default, never) : FlyingSwords = new FlyingSwords("Moonlgt3", "Moonlight Quartet", "Moonlight Quartet", "Moonlight Quartet", "slash", 8, 3200, "This set of four flying swords were specialy forged and enchanted to help with sneak attacks and posses increased chance to leave bleeding wounds.", "Small", 4);
    public var O_HALFM(default, never) : FlyingSwords = new FlyingSwords("O.HalfM", "Obsidian Half-Moon", "Obsidian Half-Moon", "Obsidian Half-Moon", "slash", 15, 1500, "Sword that was forged from metal repeadly tempered deep in planet crust.", "Large", 1, CombatAbility.TAG_EARTH);
    public var O_HALFM2(default, never) : FlyingSwords = new FlyingSwords("O.HalfM2", "Obsidian Half-Moon Duo", "Obsidian Half-Moon Duo", "Obsidian Half-Moon Duo", "slash", 15, 3000, "Pair of swords that were forged from metal repeadly tempered deep in planet crust.", "Large", 2, CombatAbility.TAG_EARTH);
    public var S_HALFM(default, never) : FlyingSwords = new FlyingSwords("S.HalfM", "Scarlet Half-Moon", "Scarlet Half-Moon", "Scarlet Half-Moon", "slash", 6, 600, "Sword that was forged from metal repeadly tempered by the lightning.", "Small", 1, CombatAbility.TAG_LIGHTNING);
    public var S_HALFM2(default, never) : FlyingSwords = new FlyingSwords("S.Half2M", "Scarlet Half-Moon Duo", "Scarlet Half-Moon Duo", "Scarlet Half-Moon Duo", "slash", 6, 1200, "Pair of swords that were forged from metal repeadly tempered by the lightning.", "Small", 2, CombatAbility.TAG_LIGHTNING);
    public var S_HALFM3(default, never) : FlyingSwords = new FlyingSwords("S.Half3M", "Scarlet Half-Moon Quartet", "Scarlet Half-Moon Quartet", "Scarlet Half-Moon Quartet", "slash", 6, 2400, "Set of four swords that were forged from metal repeadly tempered by the lightning.", "Small", 4, CombatAbility.TAG_LIGHTNING);
    public var S_TWINS(default, never) : FlyingSwords = new FlyingSwords("S.Twins", "Sky Twins", "Sky Twins", "Sky Twins", "slash", 12, 1200, "Pair of solid swords that could be used to fly or to tear enemies apart.", "Large", 2);
    public var TRASFLS(default, never) : FlyingSwords = new FlyingSwords("TraSFlS", "Tra.S.Fl.Sword", "training soul flying sword", "a training flying sword", "slash", 1, 100, "This large flying sword was specialy forged and enhanted to help novice soul cultivatiors to train their soulforce.  Still if situation calls for it it could be used as a normal weapon or to fly on it.", "Large");
    public var W_HALFM(default, never) : FlyingSwords = new FlyingSwords("W.HalfM", "White Half-Moon", "White Half-Moon", "White Half-Moon", "slash", 6, 600, "Sword that was forged from metal repeadly bathed in lava.", "Small", 1, CombatAbility.TAG_FIRE);
    public var W_HALFM2(default, never) : FlyingSwords = new FlyingSwords("W.HalfM2", "White Half-Moon Duo", "White Half-Moon Duo", "White Half-Moon Duo", "slash", 6, 1200, "Pair of swords that were forged from metal repeadly bathed in lava.", "Small", 2, CombatAbility.TAG_FIRE);
    public var W_HALFM3(default, never) : FlyingSwords = new FlyingSwords("W.HalfM3", "White Half-Moon Quartet", "White Half-Moon Quartet", "White Half-Moon Quartet", "slash", 6, 2400, "Set of four swords that were forged from metal repeadly bathed in lava.", "Small", 4, CombatAbility.TAG_FIRE);
    
    public function new()
    {
        super();
    }
}

