package classes.stats;

import classes.Creature;
import classes.PerkLib;
import classes.Monster;
import classes.iMutations.IMutationsLib;
import classes.Player;
import classes.scenes.places.heXinDao.JourneyToTheEast;

class CoreStat extends RawStat
{
    public function new(host : Creature, name : String)
    {
        super(host, name, {
                    min : 0,
                    value : 0,
                    max : 100
                });
    }
    
    override private function get_max() : Float
    {
        if (Std.is(host, Monster))
        {
            return Infinity;
        }
        var base : Float = 100;
        base += 2 * host.perkv1(PerkLib.AscensionTranshumanism);
        if (host.hasPerk(PerkLib.MunchkinAtBioLab))
        {
            base += 10;
        }
        if (host.hasPerk(PerkLib.DarkAscensionTheDarkSoul))
        {
            base += 10 * host.perkv1(PerkLib.DarkAscensionTheDarkSoul);
        }
        switch (statName)
        {
            case "str.core":
                base += 16 * host.perkv1(PerkLib.AscensionTranshumanismStr);
                base += host.perkv1(PerkLib.BodyTempering);
                if (host.perkv1(IMutationsLib.HumanBonesIM) >= 1)
                {
                    base += 5;
                }
                if (host.perkv1(IMutationsLib.HumanBonesIM) >= 2)
                {
                    base += 5;
                }
                if (host.perkv1(IMutationsLib.HumanBonesIM) >= 4)
                {
                    base += 10;
                }
                if (host.perkv1(IMutationsLib.HumanMusculatureIM) >= 4)
                {
                    base += 10;
                }
                if (Std.is(host, Player) && JourneyToTheEast.EvelynnCoreLimitBreakerCounter > 0)
                {
                    base += JourneyToTheEast.EvelynnCoreLimitBreakerCounter;
                }
                var str : Float = 1;
                if (host.hasPerk(PerkLib.AsuraStrength))
                {
                    str += 0.1;
                }
                if (host.hasPerk(PerkLib.SwordImmortalFirstForm))
                {
                    str += 0.05;
                }
                base *= str;
                base = Math.round(base);
            case "tou.core":
                base += 16 * host.perkv1(PerkLib.AscensionTranshumanismTou);
                base += host.perkv1(PerkLib.BodyTempering);
                if (host.perkv1(IMutationsLib.HumanBonesIM) >= 1)
                {
                    base += 5;
                }
                if (host.perkv1(IMutationsLib.HumanBonesIM) >= 2)
                {
                    base += 5;
                }
                if (host.perkv1(IMutationsLib.HumanBonesIM) >= 4)
                {
                    base += 10;
                }
                if (host.perkv1(IMutationsLib.HumanFatIM) >= 4)
                {
                    base += 10;
                }
                if (Std.is(host, Player) && JourneyToTheEast.EvelynnCoreLimitBreakerCounter > 0)
                {
                    base += JourneyToTheEast.EvelynnCoreLimitBreakerCounter;
                }
                var tou : Float = 1;
                if (host.hasPerk(PerkLib.AsuraToughness))
                {
                    tou += 0.1;
                }
                if (host.hasPerk(PerkLib.BloodDemonToughness))
                {
                    tou += 0.1;
                }
                if (host.hasPerk(PerkLib.DemonSovereignToughnessAndLibido))
                {
                    tou += 0.05;
                }
                base *= tou;
                base = Math.round(base);
            case "spe.core":
                base += 16 * host.perkv1(PerkLib.AscensionTranshumanismSpe);
                base += host.perkv1(PerkLib.BodyTempering);
                if (host.perkv1(IMutationsLib.HumanBloodstreamIM) >= 1)
                {
                    base += 5;
                }
                if (host.perkv1(IMutationsLib.HumanBloodstreamIM) >= 2)
                {
                    base += 5;
                }
                if (host.perkv1(IMutationsLib.HumanBloodstreamIM) >= 4)
                {
                    base += 10;
                }
                if (Std.is(host, Player) && JourneyToTheEast.EvelynnCoreLimitBreakerCounter > 0)
                {
                    base += JourneyToTheEast.EvelynnCoreLimitBreakerCounter;
                }
                var spe : Float = 1;
                if (host.hasPerk(PerkLib.AsuraSpeed))
                {
                    spe += 0.1;
                }
                if (host.hasPerk(PerkLib.SwordImmortalFirstForm))
                {
                    spe += 0.05;
                }
                base *= spe;
                base = Math.round(base);
            case "int.core":
                base += 16 * host.perkv1(PerkLib.AscensionTranshumanismInt);
                base += host.perkv1(PerkLib.SoulTempering);
                if (host.perkv1(IMutationsLib.HumanSmartsIM) >= 1)
                {
                    base += 5;
                }
                if (host.perkv1(IMutationsLib.HumanSmartsIM) >= 2)
                {
                    base += 5;
                }
                if (host.perkv1(IMutationsLib.HumanSmartsIM) >= 4)
                {
                    base += 10;
                }
                if (Std.is(host, Player) && JourneyToTheEast.EvelynnCoreLimitBreakerCounter > 0)
                {
                    base += JourneyToTheEast.EvelynnCoreLimitBreakerCounter;
                }
                var inte : Float = 1;
                if (host.hasPerk(PerkLib.BloodDemonIntelligence))
                {
                    inte += 0.1;
                }
                if (host.hasPerk(PerkLib.GreySageIntelligence))
                {
                    inte += 0.1;
                }
                base *= inte;
                base = Math.round(base);
            case "wis.core":
                base += 16 * host.perkv1(PerkLib.AscensionTranshumanismWis);
                base += host.perkv1(PerkLib.SoulTempering);
                if (host.perkv1(IMutationsLib.HumanSmartsIM) >= 1)
                {
                    base += 5;
                }
                if (host.perkv1(IMutationsLib.HumanSmartsIM) >= 2)
                {
                    base += 5;
                }
                if (host.perkv1(IMutationsLib.HumanSmartsIM) >= 4)
                {
                    base += 10;
                }
                if (Std.is(host, Player) && JourneyToTheEast.EvelynnCoreLimitBreakerCounter > 0)
                {
                    base += JourneyToTheEast.EvelynnCoreLimitBreakerCounter;
                }
                var wis : Float = 1;
                if (host.hasPerk(PerkLib.BloodDemonWisdom))
                {
                    wis += 0.1;
                }
                if (host.hasPerk(PerkLib.GreySageWisdom))
                {
                    wis += 0.1;
                }
                if (host.hasPerk(PerkLib.SwordImmortalFirstForm))
                {
                    wis += 0.05;
                }
                base *= wis;
                base = Math.round(base);
            case "lib.core":
                base += 16 * host.perkv1(PerkLib.AscensionTranshumanismLib);
                base += host.perkv1(PerkLib.SoulTempering);
                if (host.perkv1(IMutationsLib.HumanBloodstreamIM) >= 1)
                {
                    base += 5;
                }
                if (host.perkv1(IMutationsLib.HumanBloodstreamIM) >= 2)
                {
                    base += 5;
                }
                if (host.perkv1(IMutationsLib.HumanBloodstreamIM) >= 4)
                {
                    base += 10;
                }
                if (Std.is(host, Player) && JourneyToTheEast.EvelynnCoreLimitBreakerCounter > 0)
                {
                    base += JourneyToTheEast.EvelynnCoreLimitBreakerCounter;
                }
                if (host.hasPerk(PerkLib.DemonSovereignToughnessAndLibido))
                {
                    base *= 1.05;
                }
        }
        return base;
    }
}

