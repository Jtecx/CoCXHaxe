package classes.stats;

import classes.Creature;
import classes.PerkLib;
import classes.iMutations.IMutationsLib;

class TrainingStat extends RawStat
{
    public function new(host : Creature, name : String)
    {
        super(host, name, {
                    min : 1,
                    value : 0,
                    max : 100
                });
    }
    
    override private function get_max() : Float
    {
        var train : Float = 100;
        //train += 2 * host.perkv1(PerkLib.AscensionTranshumanism);
        if (host.hasPerk(PerkLib.MunchkinAtBioLab))
        {
            train += 10;
        }
        switch (statName)
        {
            case "str.train":
                var str : Float = 1;
                if (host.perkv1(IMutationsLib.HumanBonesIM) >= 3)
                {
                    str += 0.2;
                }
                if (host.perkv1(IMutationsLib.HumanBonesIM) >= 4)
                {
                    str += 0.1;
                }
                train *= str;
                train = Math.round(train);
            case "tou.train":
                var tou : Float = 1;
                if (host.perkv1(IMutationsLib.HumanBonesIM) >= 3)
                {
                    tou += 0.2;
                }
                if (host.perkv1(IMutationsLib.HumanBonesIM) >= 4)
                {
                    tou += 0.1;
                }
                train *= tou;
                train = Math.round(train);
            case "spe.train":
                var spe : Float = 1;
                if (host.perkv1(IMutationsLib.HumanBloodstreamIM) >= 3)
                {
                    spe += 0.2;
                }
                if (host.perkv1(IMutationsLib.HumanBloodstreamIM) >= 4)
                {
                    spe += 0.1;
                }
                train *= spe;
                train = Math.round(train);
            case "int.train":
                var inte : Float = 1;
                if (host.perkv1(IMutationsLib.HumanSmartsIM) >= 3)
                {
                    inte += 0.2;
                }
                if (host.perkv1(IMutationsLib.HumanSmartsIM) >= 4)
                {
                    inte += 0.1;
                }
                train *= inte;
                train = Math.round(train);
            case "wis.train":
                //train += 16 * host.perkv1(PerkLib.AscensionTranshumanismWis);
                //train += host.perkv1(PerkLib.SoulTempering);
                var wis : Float = 1;
                if (host.perkv1(IMutationsLib.HumanSmartsIM) >= 3)
                {
                    wis += 0.2;
                }
                if (host.perkv1(IMutationsLib.HumanSmartsIM) >= 4)
                {
                    wis += 0.1;
                }
                train *= wis;
                train = Math.round(train);
            case "lib.train":
                var lib : Float = 1;
                if (host.perkv1(IMutationsLib.HumanBloodstreamIM) >= 3)
                {
                    lib += 0.2;
                }
                if (host.perkv1(IMutationsLib.HumanBloodstreamIM) >= 4)
                {
                    lib += 0.1;
                }
                train *= lib;
                train = Math.round(train);
        }
        return train;
    }
}

