package classes.bodyParts;

import classes.Creature;
import classes.internals.EnumValue;
import classes.StatusEffects;
import classes.PerkLib;

class RearBody extends BodyPart
{
    /**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("NONE", "FENRIR_ICE_SPIKES")
	 * - name: human-readable default name, ("none", "draconic hairy mane")
	 *
	 * - appearanceDesc: detailed description of the hair for PlayerAppearance.as
	 * - appearanceDescFunc: function that returns an appearanceDesc value (appearanceDesc is ignored if this exists)
	 *
	 * - plural: true/false, is the name plural ("behemoth spikes") or not ("shark fin")
	 */
    public static var Types : Array<Dynamic> = [];
    
    public static inline var NONE : Int = 0;
    
    public static inline var DRACONIC_MANE : Int = 1;
    
    public static inline var DRACONIC_SPIKES : Int = 2;
    
    public static inline var FENRIR_ICE_SPIKES : Int = 3;
    
    public static inline var LION_MANE : Int = 4;
    
    public static inline var BEHEMOTH : Int = 5;
    
    public static inline var SHARK_FIN : Int = 6;
    
    public static inline var ORCA_BLOWHOLE : Int = 7;
    
    public static inline var RAIJU_MANE : Int = 8;
    
    public static inline var BAT_COLLAR : Int = 9;
    
    public static inline var WOLF_COLLAR : Int = 10;
    
    public static inline var DISPLACER_TENTACLES : Int = 11;
    
    public static inline var SNAIL_SHELL : Int = 12;
    
    public static inline var METAMORPHIC_GOO : Int = 13;
    
    //public static const thundermantisrearbody: int = 14;//button 0 on 2nd page of metamorph
    public static inline var GHOSTLY_AURA : Int = 15;
    
    public static inline var YETI_FUR : Int = 16;
    
    public static inline var GLACIAL_AURA : Int = 17;
    
    public static inline var CENTIPEDE : Int = 18;
    
    public static inline var KRAKEN : Int = 19;
    
    public static inline var FROSTWYRM : Int = 20;
    
    public static inline var FUR_COAT : Int = 21;
    
    public static inline var TENTACLE_EYESTALKS : Int = 22;
    
    public static inline var ATLACH_NACHA : Int = 23;
    
    public static inline var MINDBREAKER : Int = 24;
    
    
    public static inline var COBRA_HOOD : Int = 25;
    
    public static inline var BEE_HANDMAIDEN : Int = 26;
    
    public static inline var HELLHOUND_COLLAR : Int = 27;
    
    public static inline var ABYSSAL_SHARK_FIN : Int = 28;
    
    public static inline var ARIGEAN_RED_AURA : Int = 29;
    
    public static inline var ARIGEAN_YELLOW_AURA : Int = 30;
    
    public static inline var ARIGEAN_PINCER_LIMBS : Int = 31;
    
    public static inline var THIRSTY_NECK : Int = 32;
    
    public static inline var MOTH_COLLAR : Int = 33;
    
    
    public function new(creature : Creature)
    {
        super(creature, null);
    }
    
    public static function getAppearanceDescription(player : Dynamic) : String
    {
        var id : Int = player.rearBody.type;
        
        return formatDescription(((Types[id].appearanceDescFunc) ? Types[id].appearanceDescFunc(player) : Types[id].appearanceDesc) || "", player);
    }
    
    
    private static function formatDescription(desc : String, creature : Dynamic) : String
    {
        var upperCasePattern : as3hx.Compat.Regex = new as3hx.Compat.Regex('^.', "");
        
        return upperCasePattern.replace(desc, function(__DOLLAR__0 : Dynamic) : Dynamic
                {
                    return __DOLLAR__0.toUpperCase();
                });
    }
    private static var RearBody_static_initializer = {
        EnumValue.add(Types, NONE, "NONE", {
                    name : "none"
                });
        EnumValue.add(Types, DRACONIC_MANE, "DRACONIC_MANE", {
                    name : "draconic hairy mane"
                });
        EnumValue.add(Types, DRACONIC_SPIKES, "DRACONIC_SPIKES", {
                    name : "draconic spiky mane"
                });
        EnumValue.add(Types, FENRIR_ICE_SPIKES, "FENRIR_ICE_SPIKES", {
                    name : "ice shards",
                    appearanceDesc : "Jagged ice shards grows out of your back, providing excellent defence and chilling the air around you.",
                    plural : true
                });
        EnumValue.add(Types, LION_MANE, "LION_MANE", {
                    name : "lion mane",
                    appearanceDesc : "Around your neck there is a thick mane of [fur color] fur. It looks great on you."
                });
        EnumValue.add(Types, BEHEMOTH, "BEHEMOTH", {
                    name : "behemoth spikes",
                    plural : true
                });
        EnumValue.add(Types, SHARK_FIN, "SHARK_FIN", {
                    name : "shark fin",
                    appearanceDesc : "A large shark-like fin has sprouted between your shoulder blades. With it you have far more control over swimming underwater."
                });
        EnumValue.add(Types, ORCA_BLOWHOLE, "ORCA_BLOWHOLE", {
                    name : "orca blowhole",
                    appearanceDesc : "Between your shoulder blades is a blowhole that allows to breath in air from your back while swimming, just like an orca."
                });
        EnumValue.add(Types, RAIJU_MANE, "RAIJU_MANE", {
                    name : "raiju mane",
                    appearanceDesc : "A thick collar of fur grows around your neck. Multiple strands of fur are colored in a dark shade, making it look like a lightning bolt runs along the center of your fur collar."
                });
        EnumValue.add(Types, BAT_COLLAR, "BAT_COLLAR", {
                    name : "bat collar",
                    appearanceDesc : "Around your neck is a thick collar of fur reminiscent of a bat's."
                });
        EnumValue.add(Types, WOLF_COLLAR, "WOLF_COLLAR", {
                    name : "wolf collar",
                    appearanceDesc : "Around your neck, there is a thick coat of [fur color] fur. It looks great on you. That said, you can dismiss every one of your bestial features at any time should the need arise for you to appear human."
                });
        EnumValue.add(Types, DISPLACER_TENTACLES, "DISPLACER_TENTACLES", {
                    name : "displacer tentacles",
                    appearanceDesc : "On your back grows two tentacles with a pair of thick, heavy feelers. You use them to suck your victims dry of their milk loads as you pump them full of your lewd venom.",
                    plural : true
                });
        EnumValue.add(Types, SNAIL_SHELL, "SNAIL_SHELL", {
                    name : "snail shell",
                    appearanceDescFunc : function(player : Dynamic) : String
                    {
                        var desc : String = "On your back is a large spiralling shell which" + ((player.hasPerk(PerkLib.FireAffinity)) ? " erupts regularly with magma and" : "") + " protects your vital organs.";
                        
                        return desc;
                    }
                });
        EnumValue.add(Types, METAMORPHIC_GOO, "METAMORPHIC_GOO", {
                    name : "metamorphic goo rear",
                    appearanceDesc : "Since your body is made of malleable goo you can reshape your form however you want to gain tentacle or any limb or appendage whenever you need one either for combat or for fun."
                });
        EnumValue.add(Types, GHOSTLY_AURA, "GHOSTLY_AURA", {
                    name : "ghostly aura",
                    appearanceDesc : "An eerie ghostly aura surrounds you. Your ominous presence is enough to disturb even the bravest of souls."
                });
        EnumValue.add(Types, YETI_FUR, "YETI_FUR", {
                    name : "yeti fur",
                    appearanceDescFunc : function(player : Dynamic) : String
                    {
                        var desc : String = "Covered with a natural " + ((player.biggestTitSize() > 1) ? "fur bikini" : "layer of fur") + ", your " + ((player.biggestTitSize() > 1) ? "chest and " : "") + "crotch is protected against the cold.";
                        
                        return desc;
                    }
                });
        EnumValue.add(Types, GLACIAL_AURA, "GLACIAL_AURA", {
                    name : "glacial aura",
                    appearanceDesc : "The air temperature around you naturally drops to water freezing levels, causing snow flurries to appear around you every now and then as moisture enters your personal space."
                });
        EnumValue.add(Types, CENTIPEDE, "CENTIPEDE", {
                    name : "centipede rear",
                    appearanceDesc : "Around your neck sits a set of pincer like maxillipeds. You can use them to sting and hold onto your prey."
                });
        EnumValue.add(Types, KRAKEN, "KRAKEN", {
                    name : "kraken rear",
                    appearanceDesc : "Small glowing dots draw a trail all over the length of your body. They shine beautifully in both the deepest waters and the night giving you a somewhat ominous presence."
                });
        EnumValue.add(Types, FROSTWYRM, "FROSTWYRM", {
                    name : "frostwyrm rear",
                    appearanceDesc : "Around your neck there is a thick collar of snowy white fur. It looks great on you and, best of all, shields you against the cold."
                });
        EnumValue.add(Types, FUR_COAT, "FUR_COAT", {
                    name : "fur coat",
                    appearanceDesc : "On your back you wear a thick fur coat, not unlike a mantle complete with a hood always worn over your head it has a pair of holes just to let a pair of horns or rather antlers juts through it."
                });
        EnumValue.add(Types, TENTACLE_EYESTALKS, "TENTACLE_EYESTALKS", {
                    name : "tentacle eyestalks",
                    appearanceDescFunc : function(player : Dynamic) : String
                    {
                        var desc : String = "A set of " + player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) + " tentacle eyestalks expand from your back giving you all around vision. Their gazes are charged with lethal magical powers.";
                        
                        return desc;
                    },
                    plural : true
                });
        EnumValue.add(Types, ATLACH_NACHA, "ATLACH_NACHA", {
                    name : "Atlach Nacha rear",
                    appearanceDesc : "Two pairs of chitinous, black spider legs sprout from your shoulders and back. Red eyes blink and close at the tips."
                });
        EnumValue.add(Types, MINDBREAKER, "MINDBREAKER", {
                    name : "Mindbreaker rear",
                    appearanceDesc : "On your back spreads a webbed leather membrane, which from afar may look like a cape."
                });
        EnumValue.add(Types, COBRA_HOOD, "COBRA_HOOD", {
                    name : "cobra hood",
                    appearanceDescFunc : function(player : Dynamic) : String
                    {
                        var desc : String = " Behind your hair is a large cobra hood decorated with intimating red triangular patterns.";
                        if (player.faceType == Face.SNAKE_FANGS)
                        {
                            desc += " Anyone can tell just from the vibrant colors that you are highly venomous.";
                        }
                        return desc;
                    }
                });
        EnumValue.add(Types, BEE_HANDMAIDEN, "BEE_HANDMAIDEN", {
                    name : "Hypnotic droning aura",
                    appearanceDesc : "Your wingbeat produces a lulling aura that may entrance aggressors into a more pliant disposition the better the chances for you to deliver your eggs."
                });
        EnumValue.add(Types, HELLHOUND_COLLAR, "HELLHOUND_COLLAR", {
                    name : "hellhound furry neck",
                    appearanceDesc : "Around your neck, there is a thick coat of [fur color] fur."
                });
        EnumValue.add(Types, ABYSSAL_SHARK_FIN, "ABYSSAL_SHARK_FIN", {
                    name : "abyss shark fin",
                    appearanceDesc : "A large, shark-like fin has sprouted between your shoulders, and a second, smaller fin beneath it at the height of your navel. With them, you have much a easier ability to swim around."
                });
        EnumValue.add(Types, ARIGEAN_RED_AURA, "ARIGEAN_RED_AURA", {
                    name : "arigean aura (R)",
                    appearanceDesc : "A black and red haze is exhaled from your symbiotic partners, sticking close to your form giving you an intimidating aura to help frighten your foes."
                });
        EnumValue.add(Types, ARIGEAN_YELLOW_AURA, "ARIGEAN_YELLOW_AURA", {
                    name : "arigean aura (Y)",
                    appearanceDesc : "A black and yellow haze is exhaled from your symbiotic partners, sticking close to your form giving you an intimidating aura to help frighten your foes."
                });
        EnumValue.add(Types, ARIGEAN_PINCER_LIMBS, "ARIGEAN_PINCER_LIMBS", {
                    name : "An extra pair of pincer like limbs",
                    appearanceDesc : "An extra pair of large black pincer-like limbs sprout from your back, each seems to be adorn in black armor-like skin not unlike that found on your legs. You can’t help but laugh at the thought of crushing the life from your foes with your fearsome claws."
                });
        EnumValue.add(Types, THIRSTY_NECK, "THIRSTY_NECK", {
                    name : "thirsty neck",
                    appearanceDesc : "Your throat is constantly parched, aching for the sweet taste of blood. It’s difficult for you to not go crazy when the liquid is spilled nearby and at time you even fully lose control. The exact spot where your sire has bitten you is still marked by a pair of faint scars, the only wound on your entire body that won’t fully heal no matter how much you try."
                });
        EnumValue.add(Types, MOTH_COLLAR, "MOTH_COLLAR", {
                    name : "moth collar",
                    appearanceDesc : "You have a fluffy collar"
                });
        true;
    }

}

