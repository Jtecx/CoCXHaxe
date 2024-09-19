package classes.races;

import classes.BodyData;
import classes.bodyParts.*;
import classes.CockTypesEnum;
import classes.iMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.transformations.TransformationGroupAny;
import classes.VaginaClass;

class CatRace extends Race
{
    public var TfList(get, never) : Array<Dynamic>;

    public static var catFurColors : Array<Dynamic> = ["brown", "chocolate", "auburn", "caramel", "orange", "sandy brown", "golden", "black", "midnight black", "dark gray", "gray", "light gray", "silver", "white", "orange and white", "brown and white", "black and white", "gray and white"];
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
        super("Cat", id, []);
    }
    
    private function get_TfList() : Array<Dynamic>
    {
        return [
        new TransformationGroupAny("FaceHumanOrCat", [
        game.transformations.FaceCat, 
        game.transformations.FaceCatCanines
    ]), 
        game.transformations.EyesCat, 
        game.transformations.EarsCat, 
        game.transformations.TongueCat, 
        game.transformations.TailCat, 
        game.transformations.ArmsCat, 
        game.transformations.LowerBodyCat(), 
        game.transformations.SkinFurGradual(Skin.COVERAGE_HIGH, {
                    colors : catFurColors
                }), 
        game.transformations.HornsNone, 
        game.transformations.WingsNone, 
        game.transformations.CockChangeType(CockTypesEnum.CAT, false)
    ];
    }
    
    override public function setup() : Void
    {
        addScores().faceType(ANY(Face.CAT, Face.CAT_CANINES), +1).faceType(NONE(Face.CHESHIRE, Face.CHESHIRE_SMILE), 0, -7).eyeType(Eyes.CAT, +1).eyeType(Eyes.FERAL, -11).earType(Ears.CAT, +1).tongueType(Tongue.CAT, +1).tailType(Tail.CAT, +1).armType(Arms.CAT, +1).legType(LowerBody.CAT, +1).skinCoatType(Skin.FUR, +1).hornType(NONE(Horns.DEMON, Horns.DRACONIC_X2, Horns.DRACONIC_X4_12_INCH_LONG), 0, -2).wingType(NONE(Wings.BAT_LIKE_TINY, Wings.DRACONIC_SMALL, Wings.BAT_LIKE_LARGE, Wings.DRACONIC_LARGE, Wings.BAT_LIKE_LARGE_2, Wings.DRACONIC_HUGE), 0, -2).hasCockOfType(CockTypesEnum.CAT, +1).breastRowCount(2, +1).breastRowCount(3, +2).breastRowCount(cast((4), LESS_THAN), 0, -1).customRequirement("", "not magical feline race", 
                        function(body : BodyData) : Bool
                        {
                            return !isCheshireSubrace(body) &&
                            !isDisplacerSubrace(body) &&
                            !isHellcatSubrace(body) &&
                            !isManticoreSubrace(body) &&
                            !isNekomataSubrace(body) &&
                            !isSphinxSubrace(body);
                        }, 0, -1000
            ).hasPerk(PerkLib.Flexibility, +1);
        
        addMutation(IMutationsLib.CatLikeNimblenessIM);
        addMutation(IMutationsLib.EyeOfTheTigerIM);
        
        buildTier(8, "cat").customNamingFunction(function(body : BodyData) : String
                                {
                                    if (body.isTaur && body.legType == LowerBody.CAT)
                                    {
                                        return "cat-taur";
                                    }
                                    if (body.faceType == Face.HUMAN)
                                    {
                                        return "cat-morph";
                                    }
                                    return "cat-" + body.mf("boy", "girl");
                                }).buffs({
                            spe.mult : +0.60,
                            lib.mult : +0.60
                        }).end();
    }
    
    public static function cheshireSubraceRating(body : BodyData) : Int
    {
        var x : Int = 0;
        if (body.hairColors == "lilac and white")
        {
            x++;
        }
        if (body.furColors == "lilac and white")
        {
            x++;
        }
        if (body.faceType == Face.CHESHIRE || body.faceType == Face.CHESHIRE_SMILE)
        {
            x++;
        }
        return x;
    }
    public static function displacerSubraceRating(body : BodyData) : Int
    {
        var x : Int = 0;
        if (body.eyeType == Eyes.DISPLACER)
        {
            x++;
        }
        if (body.earType == Ears.DISPLACER)
        {
            x++;
        }
        if (body.armType == Arms.DISPLACER)
        {
            x++;
        }
        if (body.rearType == RearBody.DISPLACER_TENTACLES)
        {
            x++;
        }
        return x;
    }
    public static function hellcatSubraceRating(body : BodyData) : Int
    {
        var x : Int = 0;
        if (body.eyeType == Eyes.INFERNAL)
        {
            x++;
        }
        if (body.hairType == Hair.BURNING)
        {
            x++;
        }
        if (body.tailType == Tail.BURNING || body.tailType == Tail.TWINKASHA)
        {
            x++;
        }
        return x;
    }
    public static function nekomataSubraceRating(body : BodyData) : Int
    {
        var x : Int = 0;
        if (body.tailType == Tail.NEKOMATA_FORKED_1_3 || body.tailType == Tail.NEKOMATA_FORKED_2_3 || (body.tailType == Tail.CAT && body.tailCount > 1))
        {
            x++;
        }
        return x;
    }
    public static function sphinxSubraceRating(body : BodyData) : Int
    {
        var x : Int = 0;
        if (body.armType == Arms.SPHINX)
        {
            x++;
        }
        if (body.wingType == Wings.FEATHERED_SPHINX)
        {
            x++;
        }
        return x;
    }
    public static function manticoreSubraceRating(body : BodyData) : Int
    {
        var x : Int = 0;
        if (body.faceType == Face.MANTICORE)
        {
            x++;
        }
        if (body.eyeType == Eyes.MANTICORE)
        {
            x++;
        }
        if (body.tailType == Tail.MANTICORE_PUSSYTAIL)
        {
            x++;
        }
        if (body.wingType == Wings.MANTICORE_SMALL || body.wingType == Wings.MANTICORE_LARGE)
        {
            x++;
        }
        if (body.vaginaType == VaginaClass.MANTICORE)
        {
            x++;
        }
        return x;
    }
    public static function isCheshireSubrace(body : BodyData) : Bool
    {
        return cheshireSubraceRating(body) >
        Math.max(Math.max(Math.max(Math.max(
                                        hellcatSubraceRating(body), 
                                        nekomataSubraceRating(body)
                    ), 
                                sphinxSubraceRating(body)
                ), 
                        displacerSubraceRating(body)
            ), 
                manticoreSubraceRating(body)
        );
    }
    public static function isDisplacerSubrace(body : BodyData) : Bool
    {
        return displacerSubraceRating(body) >
        Math.max(Math.max(Math.max(Math.max(
                                        hellcatSubraceRating(body), 
                                        nekomataSubraceRating(body)
                    ), 
                                cheshireSubraceRating(body)
                ), 
                        sphinxSubraceRating(body)
            ), 
                manticoreSubraceRating(body)
        );
    }
    public static function isHellcatSubrace(body : BodyData) : Bool
    {
        return hellcatSubraceRating(body) >
        Math.max(Math.max(Math.max(Math.max(
                                        nekomataSubraceRating(body), 
                                        cheshireSubraceRating(body)
                    ), 
                                sphinxSubraceRating(body)
                ), 
                        displacerSubraceRating(body)
            ), 
                manticoreSubraceRating(body)
        );
    }
    public static function isManticoreSubrace(body : BodyData) : Bool
    {
        return manticoreSubraceRating(body) >
        Math.max(Math.max(Math.max(Math.max(
                                        hellcatSubraceRating(body), 
                                        nekomataSubraceRating(body)
                    ), 
                                cheshireSubraceRating(body)
                ), 
                        sphinxSubraceRating(body)
            ), 
                displacerSubraceRating(body)
        );
    }
    public static function isNekomataSubrace(body : BodyData) : Bool
    {
        return nekomataSubraceRating(body) >
        Math.max(Math.max(Math.max(Math.max(
                                        hellcatSubraceRating(body), 
                                        cheshireSubraceRating(body)
                    ), 
                                sphinxSubraceRating(body)
                ), 
                        displacerSubraceRating(body)
            ), 
                manticoreSubraceRating(body)
        );
    }
    public static function isSphinxSubrace(body : BodyData) : Bool
    {
        return sphinxSubraceRating(body) >
        Math.max(Math.max(Math.max(Math.max(
                                        hellcatSubraceRating(body), 
                                        nekomataSubraceRating(body)
                    ), 
                                cheshireSubraceRating(body)
                ), 
                        displacerSubraceRating(body)
            ), 
                manticoreSubraceRating(body)
        );
    }
}

