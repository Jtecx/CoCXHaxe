package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.CoC;
import classes.geneticMemories.RaceMem;
import classes.PerkLib;
import classes.Race;

class AngelRace extends Race
{
    public static var RaceBody : Array<Dynamic> = [
        /*Antenna*/"Human", 
        /*Arms*/"Human", 
        /*Balls*/"Human", 
        /*Breasts*/"Human", 
        /*Nips*/"Human", 
        /*Ears*/"Human", 
        /*Eyes*/"Human", 
        /*Face*/"Human", 
        /*Gills*/"Human", 
        /*Hair*/"Human", 
        /*Horns*/"Human", 
        /*LowerBody*/"Human", 
        /*RearBody*/"Human", 
        /*Skin*/"Human", 
        /*Ovipositor*/"Human", 
        /*Oviposition*/"Human", 
        /*GlowingAss*/"Human", 
        /*Tail*/"Human", 
        /*Tongue*/"Human", 
        /*Wings*/"Human", 
        /*Penis*/"Human", 
        /*Vagina*/"Human", 
        /*Perks*/"Human"
    ];
    
    public function new(id : Int)
    {
        super("Angel", id, []);  //RaceBody);  
        chimeraTier = 0;
        grandChimeraTier = 0;
        disabled = true;
    }
    
    override public function setup() : Void
    //start ctrl-spacing here
    {
        addScores();
        
        buildTier(15, "angel-kin").buffs({
                            str.mult : +0.25,
                            tou.mult : +0.50,
                            wis.mult : +1.50,
                            maxlust_mult : -0.15,
                            maxsf_mult : +1,
                            maxwrath_mult : +0.6,
                            maxmana_mult : -0.8
                        }).end();
        
        buildTier(21, "angel").buffs({
                            str.mult : +0.65,
                            tou.mult : +0.70,
                            wis.mult : +2.00,
                            sens : +20,
                            maxlust_mult : -0.3,
                            maxsf_mult : +1.5,
                            maxwrath_mult : +0.8
                        }).end()  //requirePerk(PerkLib.)-perk causing no mana for them like soulless make no sf for demons  ;
    }
}

