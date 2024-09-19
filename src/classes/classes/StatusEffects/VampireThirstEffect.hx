/**
 * Coded by aimozg on 28.10.2017.
 */
package classes.statusEffects;

import classes.iMutations.IMutationsLib;
import classes.Races;
import classes.StatusEffectClass;
import classes.StatusEffectType;

class VampireThirstEffect extends StatusEffectClass
{
    public var currentBoost(get, never) : Int;
    public var singleStackBoost(get, never) : Float;

    public static var TYPE : StatusEffectType = register("Vampire Thirst", VampireThirstEffect);
    public function new()
    {
        super(TYPE);
    }
    
    public function drink(amount : Float = 1) : Void
    {
        modSatiety(amount);
    }
    public function maxThirst() : Float
    {
        var maxThi : Float = 0;
        if (game.player.facePart.type == 34)
        {
            maxThi += 30;
        }
        if (game.player.perkv1(IMutationsLib.VampiricBloodstreamIM) >= 1 && game.player.racialScore(Races.VAMPIRE) >= 10)
        {
            maxThi += 15;
            if (game.player.perkv1(IMutationsLib.VampiricBloodstreamIM) >= 2)
            {
                maxThi += 30;
            }
            if (game.player.perkv1(IMutationsLib.VampiricBloodstreamIM) >= 3)
            {
                maxThi += 75;
            }
            if (game.player.perkv1(IMutationsLib.VampiricBloodstreamIM) >= 4)
            {
                maxThi += 180;
            }
        }
        if (game.player.perkv1(IMutationsLib.HollowFangsIM) >= 1)
        {
            maxThi += 5;
        }
        if (game.player.perkv1(IMutationsLib.HollowFangsIM) >= 3)
        {
            maxThi += 10;
        }
        return maxThi;
    }
    public function modSatiety(delta : Float) : Void
    {
        value1 = boundFloat(-10, value1 + delta, maxThirst());
        host.statStore.replaceBuffObject({
                    str : currentBoost,
                    spe : currentBoost,
                    int : currentBoost,
                    lib : currentBoost
                }, "VampirismSatiety", {
                    text : "Vampirism"
                });
        if (game.player.hunger < game.player.maxHunger())
        {
            game.player.refillHunger(10, false);
        }
    }
    
    private function get_currentBoost() : Int
    {
        if (value1 <= 0)
        {
            return 0;
        }
        return as3hx.Compat.parseInt(value1 * singleStackBoost);
    }
    private function get_singleStackBoost() : Float
    {
        var sSB : Float = 2;
        if (game.player.perkv1(IMutationsLib.VampiricBloodstreamIM) >= 3)
        {
            sSB += 1;
        }
        if (game.player.perkv1(IMutationsLib.VampiricBloodstreamIM) >= 4)
        {
            sSB += 1;
        }
        return ((1 + game.player.newGamePlusMod()) * sSB);
    }
    
    override public function onRemove() : Void
    {
        host.statStore.removeBuffs("VampirismSatiety");
    }
    
    override public function onAttach() : Void
    {
        host.statStore.replaceBuffObject({
                    str : currentBoost,
                    spe : currentBoost,
                    int : currentBoost,
                    lib : currentBoost
                }, "VampirismSatiety", {
                    text : "Vampirism"
                });
    }
}

