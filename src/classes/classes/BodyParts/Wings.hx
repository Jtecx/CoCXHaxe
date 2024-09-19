package classes.bodyParts;

import classes.Creature;
import classes.internals.EnumValue;
import classes.CoC;
import classes.scenes.nPCs.Forgefather;
import classes.globalFlags.KFLAGS;

class Wings extends SaveableBodyPart
{
    /**
	 * Entry properties:
	 * - value: numerical id (1, 4)
	 * - id: name of the constant ("BEE_SMALL", "HARPY")
	 * - name: short human-readable default name, ("small bee-like", "harpy")
	 * - desc: default description ("small", "feathered"), defaults to name
	 *
	 * - appearanceDesc: description for PlayerAppearance.as (always visible)
	 * - appearanceDescFunc: a function that returns a description for PlayerAppearance.as (appearanceDesc is ignored if this exists)
	 *
	 * - wingSlap: enables use of arms for wing slap
	 * - canFly: special arms type that enables flying even without wings
	 * - physical: Do the wings take up space
	 *
	 * - hairy: has hair material
	 * - fur: has fur material
	 * - feathers: has feathers material
	 * - scales: has scales material
	 * - chitin: has chitin material
	 */
    public static var Types : Array<Dynamic> = [];
    
    public static inline var NONE : Int = 0;
    
    
    public static inline var BEE_SMALL : Int = 1;
    
    
    public static inline var BEE_LARGE : Int = 2;
    
    
    public static inline var HARPY : Int = 4;
    
    public static inline var IMP : Int = 5;  //not used for PC - can change it with some new wing type  
    
    public static inline var BAT_LIKE_TINY : Int = 6;
    
    public static inline var BAT_LIKE_LARGE : Int = 7;
    
    public static inline var SHARK_FIN : Int = 8;  //not longer used so not count  
    public static inline var FEATHERED_LARGE : Int = 9;
    
    public static inline var DRACONIC_SMALL : Int = 10;
    
    public static inline var DRACONIC_LARGE : Int = 11;
    
    public static inline var GIANT_DRAGONFLY : Int = 12;
    
    public static inline var BAT_LIKE_LARGE_2 : Int = 13;
    
    public static inline var DRACONIC_HUGE : Int = 14;
    
    public static inline var FEATHERED_PHOENIX : Int = 15;  //button 0 on 2nd page of metamorph  
    
    public static inline var FEATHERED_ALICORN : Int = 16;
    
    public static inline var MANTIS_SMALL : Int = 17;
    
    public static inline var MANTIS_LARGE : Int = 18;
    
    public static inline var MANTIS_LARGE_2 : Int = 19;
    
    public static inline var GARGOYLE_LIKE_LARGE : Int = 20;
    
    public static inline var PLANT : Int = 21;
    
    public static inline var MANTICORE_SMALL : Int = 22;
    
    public static inline var MANTICORE_LARGE : Int = 23;
    
    // Deprecated, became an Arms body part
    public static inline var BAT_ARM : Int = 24;
    public static inline var VAMPIRE : Int = 25;
    
    public static inline var FEY_DRAGON : Int = 26;
    
    public static inline var FEATHERED_AVIAN : Int = 27;
    
    public static inline var NIGHTMARE : Int = 28;
    
    public static inline var FEATHERED_SPHINX : Int = 29;  //button 0 on 3rd page of metamorph  
    
    public static inline var ETHEREAL : Int = 30;
    
    public static inline var THUNDEROUS_AURA : Int = 31;
    
    public static inline var LEVITATION : Int = 32;
    
    public static inline var DEVILFEATHER : Int = 33;
    
    public static inline var FAIRY : Int = 34;
    
    public static inline var WINDY_AURA : Int = 35;
    
    public static inline var SEA_DRAGON : Int = 36;
    
    
    public static inline var ANT_SMALL : Int = 37;
    
    
    public static inline var ANT_LARGE : Int = 38;
    
    public static inline var YGGDRASIL_LARGE : Int = 39;
    
    public static inline var YGGDRASIL_HUGE : Int = 40;
    
    public static inline var YGGDRASIL_HUGE_2 : Int = 41;
    
    
    public static inline var JABBERWOCKY : Int = 42;
    
    
    public static inline var COUATL : Int = 43;
    
    public static inline var PUREDEVILFEATHER : Int = 44;
    
    public static inline var MOTH_SMALL : Int = 45;
    
    public static inline var MOTH_LARGE : Int = 46;
    
    public var desc : String = "non-existant";
    public function new(creature : Creature)
    {
        super(creature, "wings", []);
    }
    
    override private function set_type(value : Int) : Int
    {
        super.type = value;
        this.desc = stringOr(Types[value].desc, Types[value].name);
        return value;
    }
    
    override public function hasMaterial(type : Int) : Bool
    {
        switch (type)
        {
            case BodyMaterial.SKIN:
                return true;
            case BodyMaterial.HAIR:
                return Types[this.type].hairy;
            case BodyMaterial.FUR:
                return Types[this.type].fur;
            case BodyMaterial.SCALES:
                return Types[this.type].scales;
            case BodyMaterial.CHITIN:
                return Types[this.type].chitin;
            case BodyMaterial.FEATHERS:
                return Types[this.type].feathers;
            default:
                return false;
        }
    }
    
    override private function loadFromOldSave(savedata : Dynamic) : Void
    // For the Arms to be properly replaced, in the loadGameObject function of Saves.as, player.wings.loadFromSaveData must be called *before* saveFile.data.armType is checked
    {
        
        // Otherwise, the new savedata.armType won't be checked as the arm's type was already extracted from the save file
        if (savedata.wingType == BAT_ARM)
        {
            savedata.wingType = NONE;
            savedata.armType = Arms.BAT;
        }
        
        type = intOr(savedata.wingType, NONE);
    }
    
    public static function getAppearanceDescription(player : Dynamic) : String
    {
        var id : Int = player.wings.type;
        
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
    private static var Wings_static_initializer = {
        EnumValue.add(Types, NONE, "NONE", {
                    name : "non-existant"
                });
        EnumValue.add(Types, BEE_SMALL, "BEE_SMALL", {
                    name : "small bee-like",
                    appearanceDesc : "A pair of tiny-yet-beautiful bee-wings sprout from your back, too small to allow you to fly.",
                    physical : true
                });
        EnumValue.add(Types, BEE_LARGE, "BEE_LARGE", {
                    name : "large bee-like",
                    appearanceDesc : "A pair of large bee-wings sprout from your back, reflecting the light through their clear membranes beautifully. They flap quickly, allowing you to easily hover in place or fly.",
                    canFly : true,
                    physical : true
                });
        EnumValue.add(Types, HARPY, "HARPY", {
                    name : "harpy",
                    desc : "large feathery",
                    wingSlap : true,
                    canFly : true,
                    physical : true
                });
        EnumValue.add(Types, IMP, "IMP", {
                    name : "imp",
                    desc : "small",
                    physical : true
                });
        EnumValue.add(Types, BAT_LIKE_TINY, "BAT_LIKE_TINY", {
                    name : "tiny bat-like",
                    desc : "tiny, bat-like",
                    appearanceDesc : "A pair of tiny bat-like demon-wings sprout from your back, flapping cutely, but otherwise being of little use.",
                    physical : true
                });
        EnumValue.add(Types, BAT_LIKE_LARGE, "BAT_LIKE_LARGE", {
                    name : "large bat-like",
                    desc : "large, bat-like",
                    appearanceDesc : "A pair of large bat-like demon-wings fold behind your shoulders. With a muscle-twitch, you can extend them, and use them to soar gracefully through the air.",
                    wingSlap : true,
                    canFly : true,
                    physical : true
                });
        EnumValue.add(Types, FEATHERED_LARGE, "FEATHERED_LARGE", {
                    name : "large feathered",
                    desc : "large, feathered",
                    appearanceDesc : "A pair of large, feathery wings sprout from your back. Though you usually keep the [haircolor]-colored wings folded close, they can unfurl to allow you to soar as gracefully as a harpy.",
                    wingSlap : true,
                    canFly : true,
                    feathers : true,
                    physical : true
                });
        EnumValue.add(Types, DRACONIC_SMALL, "DRACONIC_SMALL", {
                    name : "small draconic",
                    desc : "small, draconic",
                    appearanceDesc : "Small, vestigial wings sprout from your shoulders. They might look like bat's wings, but the membranes are covered in fine, delicate scales.",
                    scales : true,
                    physical : true
                });
        EnumValue.add(Types, DRACONIC_LARGE, "DRACONIC_LARGE", {
                    name : "large draconic",
                    desc : "large, draconic",
                    appearanceDesc : "Large wings sprout from your shoulders. When unfurled they stretch further than your arm span, and a single beat of them is all you need to set out toward the sky. They look a bit like bat's wings, but the membranes are covered in fine, delicate scales and a wicked talon juts from the end of each bone.",
                    wingSlap : true,
                    canFly : true,
                    scales : true,
                    physical : true
                });
        EnumValue.add(Types, GIANT_DRAGONFLY, "GIANT_DRAGONFLY", {
                    name : "giant dragonfly",
                    appearanceDesc : "Giant dragonfly wings hang from your shoulders. At a whim, you could twist them into a whirring rhythm fast enough to lift you off the ground and allow you to fly.",
                    canFly : true,
                    physical : true
                });
        EnumValue.add(Types, BAT_LIKE_LARGE_2, "BAT_LIKE_LARGE_2", {
                    name : "two large pairs of bat-like",
                    appearanceDesc : "Two pairs of large bat-like demon-wings fold behind your shoulders. With a muscle-twitch, you can extend them, and use them to soar gracefully through the air.",
                    wingSlap : true,
                    canFly : true,
                    physical : true
                });
        EnumValue.add(Types, DRACONIC_HUGE, "DRACONIC_HUGE", {
                    name : "large majestic draconic",
                    desc : "large, majestic draconic",
                    appearanceDesc : "Magnificent huge wings sprout from your shoulders. When unfurled they stretch over twice further than your arm span, and a single beat of them is all you need to set out toward the sky. They look a bit like bat's wings, but the membranes are covered in fine, delicate scales and a wicked talon juts from the end of each bone.",
                    wingSlap : true,
                    canFly : true,
                    scales : true,
                    physical : true
                });
        EnumValue.add(Types, FEATHERED_PHOENIX, "FEATHERED_PHOENIX", {
                    name : "phoenix",
                    desc : "large crimson feathered",
                    appearanceDesc : "A pair of large, feathery wings sprout from your back. Though you usually keep the crimson-colored wings folded close, they can unfurl to allow you to soar as gracefully as a phoenix.",
                    wingSlap : true,
                    canFly : true,
                    feathers : true,
                    physical : true
                });
        EnumValue.add(Types, FEATHERED_ALICORN, "FEATHERED_ALICORN", {
                    name : "alicorn",
                    desc : "large white feathered",
                    appearanceDesc : "A pair of large, feathery wings sprout from your back. Though you usually keep the [haircolor]-colored wings folded close, they can unfurl to allow you to soar as gracefully as an alicorn.",
                    wingSlap : true,
                    canFly : true,
                    feathers : true,
                    physical : true
                });
        EnumValue.add(Types, MANTIS_SMALL, "MANTIS_SMALL", {
                    name : "small mantis-like",
                    appearanceDesc : "A pair of tiny mantis-wings sprout from your back, too small to allow you to fly.",
                    physical : true
                });
        EnumValue.add(Types, MANTIS_LARGE, "MANTIS_LARGE", {
                    name : "large mantis-like",
                    appearanceDesc : "A pair of large mantis-wings sprout from your back, reflecting the light through their clear membranes beautifully. They flap quickly, allowing you to easily hover in place or fly.",
                    canFly : true,
                    physical : true
                });
        EnumValue.add(Types, MANTIS_LARGE_2, "MANTIS_LARGE_2", {
                    name : "two large pairs of mantis-like",
                    canFly : true,
                    physical : true
                });
        EnumValue.add(Types, GARGOYLE_LIKE_LARGE, "GARGOYLE_LIKE_LARGE", {
                    name : "large stony",
                    appearanceDescFunc : function(player : Dynamic) : String
                    {
                        var desc : String = "";
                        desc += " Large ";
                        desc += Forgefather.material;
                        desc += " wings sprout from your shoulders. When unfurled they stretch wider than your arm span and a single beat of them is all you need to set out toward the sky. They look a bit like ";
                        if (Forgefather.wings == 1)
                        {
                            desc += "bird";
                        }
                        if (Forgefather.wings == 2)
                        {
                            desc += "bat";
                        }
                        desc += " wings and, although they were made of stone, they allow you to fly around with excellent aerial agility.";
                        return desc;
                    },
                    wingSlap : true,
                    canFly : true,
                    physical : true
                });
        EnumValue.add(Types, PLANT, "PLANT", {
                    name : "three pairs of cockvines",
                    desc : "cockvine",
                    appearanceDesc : "Three pairs of oily, prehensile phalluses sprout from your shoulders and back. From afar, they may look like innocent vines, but up close, each tentacle contain a bulbous head with a leaking cum-slit, perfect for mass breeding.",
                    physical : true
                });
        EnumValue.add(Types, MANTICORE_SMALL, "MANTICORE_SMALL", {
                    name : "small manticore-like",
                    appearanceDesc : "A pair of small leathery wings covered with [fur color] fur rest on your back. Despite being too small to allow flight they at least look cute on you.",
                    physical : true
                });
        EnumValue.add(Types, MANTICORE_LARGE, "MANTICORE_LARGE", {
                    name : "large manticore-like",
                    appearanceDesc : "A pair of large ominous leathery wings covered with [fur color] fur expand from your back. You can open them wide to soar high in search of your next prey.",
                    wingSlap : true,
                    canFly : true,
                    physical : true
                });
        EnumValue.add(Types, VAMPIRE, "VAMPIRE", {
                    name : "large bat",
                    appearanceDesc : "Between your shoulder blades rest a pair of large, ominous black wings reminiscent of a bat’s. They can unfurl up to twice your arm’s length, allowing you to gracefully dance in the night sky.",
                    wingSlap : true,
                    canFly : true,
                    physical : true
                });
        EnumValue.add(Types, FEY_DRAGON, "FEY_DRAGON", {
                    name : "large majestic fey draconic",
                    appearanceDesc : "Magnificent huge wings sprout from your shoulders. When unfurled they stretch over twice further than your arm span, and a single beat of them is all you need to set out toward the sky. They look like butterfly wings albeith far to large to belong to any regular butterfly. The delicate frame of your fey dragon wings allows for great speed and maneuverability.",
                    wingSlap : true,
                    canFly : true,
                    physical : true
                });
        EnumValue.add(Types, FEATHERED_AVIAN, "FEATHERED_AVIAN", {
                    name : "avian",
                    desc : "large, feathered",
                    appearanceDesc : "A pair of large, feathery wings sprout from your back. Though you usually keep the [feather color] wings folded close, they can unfurl to allow you to soar as gracefully as a bird.",
                    wingSlap : true,
                    canFly : true,
                    feathers : true,
                    physical : true
                });
        EnumValue.add(Types, NIGHTMARE, "NIGHTMARE", {
                    name : "leathery",
                    desc : "large black leathery",
                    appearanceDesc : "A pair of large ominous black leathery wings expand from your back. You can open them wide to soar high in the sky.",
                    wingSlap : true,
                    canFly : true,
                    physical : true
                });
        EnumValue.add(Types, FEATHERED_SPHINX, "FEATHERED_SPHINX", {
                    name : "sphinx",
                    desc : "large feathered",
                    appearanceDesc : "A pair of large, feathery wings sprout from your back. Though you usually keep the [haircolor]-colored wings folded close, they can unfurl to allow you to soar as gracefully as a sphinx.",
                    wingSlap : true,
                    canFly : true,
                    feathers : true,
                    physical : true
                });
        EnumValue.add(Types, ETHEREAL, "ETHEREAL", {
                    name : "ethereal tendrils",
                    appearanceDesc : "Three pairs of otherworldly tendrils grow out of your back. They have an ethereal glow around them and they gently sway against an invisible wind.",
                    canFly : true,
                    physical : false
                });
        EnumValue.add(Types, THUNDEROUS_AURA, "THUNDEROUS_AURA", {
                    name : "thunderous aura",
                    appearanceDesc : "You generate so much electricity that the sound of static and voltage follows you around, announcing your arrival.",
                    canFly : true,
                    physical : false
                });
        EnumValue.add(Types, LEVITATION, "LEVITATION", {
                    name : "levitation",
                    appearanceDesc : "Although you don't have wings, you have the ability to levitate in the air should you wish to, though you usually prefer to stay at ground level.",
                    canFly : true,
                    physical : false
                });
        EnumValue.add(Types, DEVILFEATHER, "DEVILFEATHER", {
                    name : "devil",
                    desc : "black, feathered",
                    appearanceDesc : "A pair of large ominous black feathered wings expand from your back. You can open them wide to soar high in the sky.",
                    canFly : true,
                    physical : true
                });
        EnumValue.add(Types, FAIRY, "FAIRY", {
                    name : "fairy",
                    desc : "butterfly",
                    appearanceDesc : "A large pair of colorful butterfly wings rest on your shoulder blades. Your fairy wings give you a regal appearance fit for fey royalty.",
                    canFly : true,
                    physical : true
                });
        EnumValue.add(Types, WINDY_AURA, "WINDY_AURA", {
                    name : "windy aura",
                    appearanceDesc : "An aura of strong wind constantly seems to accompany you wherever you go. You can use it to create tornados and even take flight riding on a dust devil should you need to.",
                    canFly : true,
                    physical : false
                });
        EnumValue.add(Types, SEA_DRAGON, "SEA_DRAGON", {
                    name : "large majestic aquatic",
                    appearanceDesc : "Two large majestic webbed wings not unlike the aquatic flippers of a deep-sea creature unfurls from your back, the interior lined with bright color patterns and bioluminescent specks that change depending on your mood. These wings are as good to fly as they are to swim.",
                    wingSlap : true,
                    canFly : true,
                    physical : true
                });
        EnumValue.add(Types, ANT_SMALL, "ANT_SMALL", {
                    name : "small ant-like",
                    appearanceDesc : "Four skinny but beautiful ant-wings sprout from your back, too small to allow you to fly.",
                    physical : true
                });
        EnumValue.add(Types, ANT_LARGE, "ANT_LARGE", {
                    name : "large ant-like",
                    appearanceDesc : "Four long, skinny ant-wings sprout from your back, reflecting the light through their clear membranes beautifully. They flap quickly, allowing you to easily hover in place or fly.",
                    canFly : true,
                    physical : true
                });
        EnumValue.add(Types, YGGDRASIL_LARGE, "YGGDRASIL_LARGE", {
                    name : "large yggdrasil",
                    desc : "large, plant-like",
                    appearanceDesc : "Twin pieces of wood, halfway between a vine and a trunk, extend from your shoulder blades. Currently curled up against your back, these can unfurl into large, leafy wings that grant you the power of flight.",
                    wingSlap : true,
                    canFly : true,
                    physical : true
                });
        EnumValue.add(Types, YGGDRASIL_HUGE, "YGGDRASIL_HUGE", {
                    name : "large majestic yggdrasil",
                    desc : "large, majestic plant-like",
                    appearanceDesc : "Massive wings of wood extend from your shoulders, the leafy plumage shivering with each step you take.",
                    wingSlap : true,
                    canFly : true,
                    physical : true
                });
        EnumValue.add(Types, YGGDRASIL_HUGE_2, "YGGDRASIL_HUGE_2", {
                    name : "two large pairs of majestic yggdrasil",
                    desc : "two large, majestic pairs of plant-like",
                    appearanceDesc : "Twin pairs of Massive wings of wood extend from your shoulders, the leafy plumage shivering with each step you take. The air around you is filled with the rustling, like the wind through a dense forest canopy. Now far too large to hide, you keep your woodland wings unfurled behind you, a grand, capelike display.",
                    wingSlap : true,
                    canFly : true,
                    physical : true
                });
        EnumValue.add(Types, JABBERWOCKY, "JABBERWOCKY", {
                    name : "large exotic draconic",
                    appearanceDesc : "Magnificent huge wings sprout from your shoulders. When unfurled they stretch over twice further than your arm span, and a single beat of them is all you need to set out toward the sky. They look a bit like bat's wings, but the membranes are splited in cells like that of a butterfly though some parts are covered in fine, delicate scales . While draconic in appearance the delicate frame of your fey like dragon wings allows for even better speed and maneuverability.",
                    wingSlap : true,
                    canFly : true,
                    physical : true
                });
        EnumValue.add(Types, COUATL, "COUATL", {
                    name : "large colorful feathered",
                    desc : "large, colorful, feathered",
                    appearanceDesc : "A pair of large, feathery wings sprout from your back. The feathers are colorful with shades combining those of your hairs, scales and even their own unique feather colors. Though you usually keep the your wings folded close, they can unfurl to allow you to soar as gracefully as a couatl.",
                    wingSlap : true,
                    canFly : true,
                    feathers : true,
                    physical : true
                });
        EnumValue.add(Types, PUREDEVILFEATHER, "PUREDEVILFEATHER", {
                    name : "puredevil",
                    desc : "white, feathered",
                    appearanceDesc : "A pair of large immaculate white feathered wings expand from your back. You can open them wide to soar high in the sky.",
                    canFly : true,
                    physical : true
                });
        EnumValue.add(Types, MOTH_SMALL, "MOTH_SMALL", {
                    name : "moth",
                    desc : "fuzzy, small",
                    appearanceDesc : "A pair of small [chitin color1] fuzzy satin covered insectile wings.",
                    canFly : true,
                    physical : true
                });
        EnumValue.add(Types, MOTH_LARGE, "MOTH_LARGE", {
                    name : "moth",
                    desc : "fuzzy, large",
                    appearanceDesc : "A pair of large [chitin color1] fuzzy satin covered insectile wings.",
                    canFly : true,
                    physical : true
                });
        true;
    }

}

