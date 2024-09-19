/**
 * ...
 * @author Ormael
 */
package classes.scenes.nPCs;

import classes.*;
import classes.globalFlags.KFLAGS;
import classes.items.Shield;
import classes.items.Weapon;
import classes.scenes.SceneLib;
import classes.internals.SaveableState;

class AetherTwinsFollowers extends NPCAwareContent implements SaveableState
{
    public static var AetherTwinsShape : String;
    public static var AetherTwinsCount : Float;
    public static var AetherTwinsTalkMenu : Float;
    public static var AetherTwinsFoodMenuTin : Float;
    public static var AetherTwinsFoodMenuTinCap : Float;
    public static var AetherTwinsFoodMenuCopper : Float;
    public static var AetherTwinsFoodMenuCopperCap : Float;
    public static var AetherTwinsFoodMenuIron : Float;
    public static var AetherTwinsFoodMenuIronCap : Float;
    public static var AetherTwinsFoodMenuSilver : Float;
    public static var AetherTwinsFoodMenuSilverCap : Float;
    public static var AetherTwinsFoodMenuGold : Float;
    public static var AetherTwinsFoodMenuGoldCap : Float;
    public static var AetherTwinsFoodMenuWorldTreeBranch : Float;
    public static var AetherTwinsFoodMenuWorldTreeBranchCap : Float;
    public static var AetherTwinsFoodMenuDiamond : Float;
    public static var AetherTwinsFoodMenuDiamondCap : Float;
    public static var AetherTwinsFoodMenuAmethyst : Float;
    public static var AetherTwinsFoodMenuAmethystCap : Float;
    public static var AetherTwinsFoodMenuMoonstone : Float;
    public static var AetherTwinsFoodMenuMoonstoneCap : Float;
    public static var AetherTwinsFoodMenuSkymetal : Float;
    public static var AetherTwinsFoodMenuSkymetalCap : Float;
    public static var AetherTwinsFoodMenuAdamantine : Float;
    public static var AetherTwinsFoodMenuAdamantineCap : Float;
    public static var AetherTwinsFoodMenuOrichalcum : Float;
    public static var AetherTwinsFoodMenuOrichalcumCap : Float;
    public static var AetherTwinsFoodMenuBronze : Float;
    public static var AetherTwinsFoodMenuBronzeCap : Float;
    public static var AetherTwinsFoodMenuEbonIngot : Float;
    public static var AetherTwinsFoodMenuEbonIngotCap : Float;
    public static var AetherTwinsFoodMenu : Bool;
    public static var AetherTwinsFoodMenuBuckler : Bool;
    public static var AetherTwinsFoodMenuSpikeLShield : Bool;
    public static var AetherTwinsFoodMenuManaBracer : Bool;
    //public static var AetherTwinsFoodMenuKiteShield:Boolean;
    public static var AetherTwinsFoodMenuSGauntlet : Bool;
    public static var AetherTwinsFoodMenuClaws : Bool;
    public static var AetherTwinsFoodMenuHGaunt : Bool;
    public static var AetherTwinsFoodMenuBFGauntlets : Bool;
    public static var AetherTwinsFoodMenuLustyClaws : Bool;
    public static var AetherTwinsFoodMenuDualDaggers : Bool;
    public static var AetherTwinsFoodMenuThrowingDagger : Bool;
    public static var AetherTwinsFoodMenuTriDagger : Bool;
    public static var AetherTwinsFoodMenuLustyDagger : Bool;
    public static var AetherTwinsFoodMenuWitchDagger : Bool;
    public static var AetherTwinsFoodMenuAngstDagger : Bool;
    public static var AetherTwinsFoodMenuMace : Bool;
    public static var AetherTwinsFoodMenuSpear : Bool;
    public static var AetherTwinsFoodMenuWhip : Bool;
    public static var AetherTwinsFoodMenuWardensBlade : Bool;
    public static var AetherTwinsFoodMenuKatana : Bool;
    public static var AetherTwinsFoodMenu1 : Bool;
    public static var AetherTwinsFoodMenu2 : Bool;
    public static var AetherTwinsFoodMenu3 : Bool;
    
    private var one : Float = 0;
    private var two : Float = 0;
    
    public function stateObjectName() : String
    {
        return "AetherTwinsScenes";
    }
    
    public function resetState() : Void
    {
        AetherTwinsShape = "";
        AetherTwinsCount = 0;
        AetherTwinsTalkMenu = 0;
        AetherTwinsFoodMenuTin = 0;
        AetherTwinsFoodMenuTinCap = 0;
        AetherTwinsFoodMenuCopper = 0;
        AetherTwinsFoodMenuCopperCap = 0;
        AetherTwinsFoodMenuIron = 0;
        AetherTwinsFoodMenuIronCap = 0;
        AetherTwinsFoodMenuSilver = 0;
        AetherTwinsFoodMenuSilverCap = 0;
        AetherTwinsFoodMenuGold = 0;
        AetherTwinsFoodMenuGoldCap = 0;
        AetherTwinsFoodMenuWorldTreeBranch = 0;
        AetherTwinsFoodMenuWorldTreeBranchCap = 0;
        AetherTwinsFoodMenuDiamond = 0;
        AetherTwinsFoodMenuDiamondCap = 0;
        AetherTwinsFoodMenuAmethyst = 0;
        AetherTwinsFoodMenuAmethystCap = 0;
        AetherTwinsFoodMenuMoonstone = 0;
        AetherTwinsFoodMenuMoonstoneCap = 0;
        AetherTwinsFoodMenuSkymetal = 0;
        AetherTwinsFoodMenuSkymetalCap = 0;
        AetherTwinsFoodMenuAdamantine = 0;
        AetherTwinsFoodMenuAdamantineCap = 0;
        AetherTwinsFoodMenuOrichalcum = 0;
        AetherTwinsFoodMenuOrichalcumCap = 0;
        AetherTwinsFoodMenuBronze = 0;
        AetherTwinsFoodMenuBronzeCap = 0;
        AetherTwinsFoodMenuEbonIngot = 0;
        AetherTwinsFoodMenuEbonIngotCap = 0;
        AetherTwinsFoodMenu = false;
        AetherTwinsFoodMenuBuckler = false;
        AetherTwinsFoodMenuSpikeLShield = false;
        AetherTwinsFoodMenuManaBracer = false;
        //AetherTwinsFoodMenuKiteShield = false;
        AetherTwinsFoodMenuSGauntlet = false;
        AetherTwinsFoodMenuClaws = false;
        AetherTwinsFoodMenuHGaunt = false;
        AetherTwinsFoodMenuBFGauntlets = false;
        AetherTwinsFoodMenuLustyClaws = false;
        AetherTwinsFoodMenuDualDaggers = false;
        AetherTwinsFoodMenuThrowingDagger = false;
        AetherTwinsFoodMenuTriDagger = false;
        AetherTwinsFoodMenuLustyDagger = false;
        AetherTwinsFoodMenuWitchDagger = false;
        AetherTwinsFoodMenuAngstDagger = false;
        AetherTwinsFoodMenuMace = false;
        AetherTwinsFoodMenuSpear = false;
        AetherTwinsFoodMenuWhip = false;
        AetherTwinsFoodMenuWardensBlade = false;
        AetherTwinsFoodMenuKatana = false;
        AetherTwinsFoodMenu1 = false;
        AetherTwinsFoodMenu2 = false;
        AetherTwinsFoodMenu3 = false;
    }
    
    public function saveToObject() : Dynamic
    {
        return {
            AetherTwinsShape : AetherTwinsShape,
            AetherTwinsCount : AetherTwinsCount,
            AetherTwinsTalkMenu : AetherTwinsTalkMenu,
            AetherTwinsFoodMenuTin : AetherTwinsFoodMenuTin,
            AetherTwinsFoodMenuTinCap : AetherTwinsFoodMenuTinCap,
            AetherTwinsFoodMenuCopper : AetherTwinsFoodMenuCopper,
            AetherTwinsFoodMenuCopperCap : AetherTwinsFoodMenuCopperCap,
            AetherTwinsFoodMenuIron : AetherTwinsFoodMenuIron,
            AetherTwinsFoodMenuIronCap : AetherTwinsFoodMenuIronCap,
            AetherTwinsFoodMenuSilver : AetherTwinsFoodMenuSilver,
            AetherTwinsFoodMenuSilverCap : AetherTwinsFoodMenuSilverCap,
            AetherTwinsFoodMenuGold : AetherTwinsFoodMenuGold,
            AetherTwinsFoodMenuGoldCap : AetherTwinsFoodMenuGoldCap,
            AetherTwinsFoodMenuWorldTreeBranch : AetherTwinsFoodMenuWorldTreeBranch,
            AetherTwinsFoodMenuWorldTreeBranchCap : AetherTwinsFoodMenuWorldTreeBranchCap,
            AetherTwinsFoodMenuDiamond : AetherTwinsFoodMenuDiamond,
            AetherTwinsFoodMenuDiamondCap : AetherTwinsFoodMenuDiamondCap,
            AetherTwinsFoodMenuAmethyst : AetherTwinsFoodMenuAmethyst,
            AetherTwinsFoodMenuAmethystCap : AetherTwinsFoodMenuAmethystCap,
            AetherTwinsFoodMenuMoonstone : AetherTwinsFoodMenuMoonstone,
            AetherTwinsFoodMenuMoonstoneCap : AetherTwinsFoodMenuMoonstoneCap,
            AetherTwinsFoodMenuSkymetal : AetherTwinsFoodMenuSkymetal,
            AetherTwinsFoodMenuSkymetalCap : AetherTwinsFoodMenuSkymetalCap,
            AetherTwinsFoodMenuAdamantine : AetherTwinsFoodMenuAdamantine,
            AetherTwinsFoodMenuAdamantineCap : AetherTwinsFoodMenuAdamantineCap,
            AetherTwinsFoodMenuOrichalcum : AetherTwinsFoodMenuOrichalcum,
            AetherTwinsFoodMenuOrichalcumCap : AetherTwinsFoodMenuOrichalcumCap,
            AetherTwinsFoodMenuBronze : AetherTwinsFoodMenuBronze,
            AetherTwinsFoodMenuBronzeCap : AetherTwinsFoodMenuBronzeCap,
            AetherTwinsFoodMenuEbonIngot : AetherTwinsFoodMenuEbonIngot,
            AetherTwinsFoodMenuEbonIngotCap : AetherTwinsFoodMenuEbonIngotCap,
            AetherTwinsFoodMenu : AetherTwinsFoodMenu,
            AetherTwinsFoodMenuBuckler : AetherTwinsFoodMenuBuckler,
            AetherTwinsFoodMenuSpikeLShield : AetherTwinsFoodMenuSpikeLShield,
            AetherTwinsFoodMenuManaBracer : AetherTwinsFoodMenuManaBracer,
            AetherTwinsFoodMenuSGauntlet : AetherTwinsFoodMenuSGauntlet,
            AetherTwinsFoodMenuClaws : AetherTwinsFoodMenuClaws,
            AetherTwinsFoodMenuHGaunt : AetherTwinsFoodMenuHGaunt,
            AetherTwinsFoodMenuBFGauntlets : AetherTwinsFoodMenuBFGauntlets,
            AetherTwinsFoodMenuLustyClaws : AetherTwinsFoodMenuLustyClaws,
            AetherTwinsFoodMenuDualDaggers : AetherTwinsFoodMenuDualDaggers,
            AetherTwinsFoodMenuThrowingDagger : AetherTwinsFoodMenuThrowingDagger,
            AetherTwinsFoodMenuTriDagger : AetherTwinsFoodMenuTriDagger,
            AetherTwinsFoodMenuLustyDagger : AetherTwinsFoodMenuLustyDagger,
            AetherTwinsFoodMenuWitchDagger : AetherTwinsFoodMenuWitchDagger,
            AetherTwinsFoodMenuAngstDagger : AetherTwinsFoodMenuAngstDagger,
            AetherTwinsFoodMenuMace : AetherTwinsFoodMenuMace,
            AetherTwinsFoodMenuSpear : AetherTwinsFoodMenuSpear,
            AetherTwinsFoodMenuWhip : AetherTwinsFoodMenuWhip,
            AetherTwinsFoodMenuWardensBlade : AetherTwinsFoodMenuWardensBlade,
            AetherTwinsFoodMenuKatana : AetherTwinsFoodMenuKatana,
            AetherTwinsFoodMenu1 : AetherTwinsFoodMenu1,
            AetherTwinsFoodMenu2 : AetherTwinsFoodMenu2,
            AetherTwinsFoodMenu3 : AetherTwinsFoodMenu3
        };
    }
    
    public function loadFromObject(o : Dynamic, ignoreErrors : Bool) : Void
    {
        if (o != null)
        {
            AetherTwinsShape = Reflect.field(o, "AetherTwinsShape");
            AetherTwinsCount = Reflect.field(o, "AetherTwinsCount");
            AetherTwinsTalkMenu = Reflect.field(o, "AetherTwinsTalkMenu");
            AetherTwinsFoodMenuTin = Reflect.field(o, "AetherTwinsFoodMenuTin");
            AetherTwinsFoodMenuTinCap = Reflect.field(o, "AetherTwinsFoodMenuTinCap");
            AetherTwinsFoodMenuCopper = Reflect.field(o, "AetherTwinsFoodMenuCopper");
            AetherTwinsFoodMenuCopperCap = Reflect.field(o, "AetherTwinsFoodMenuCopperCap");
            AetherTwinsFoodMenuIron = Reflect.field(o, "AetherTwinsFoodMenuIron");
            AetherTwinsFoodMenuIronCap = Reflect.field(o, "AetherTwinsFoodMenuIronCap");
            AetherTwinsFoodMenuSilver = Reflect.field(o, "AetherTwinsFoodMenuSilver");
            AetherTwinsFoodMenuSilverCap = Reflect.field(o, "AetherTwinsFoodMenuSilverCap");
            AetherTwinsFoodMenuGold = Reflect.field(o, "AetherTwinsFoodMenuGold");
            AetherTwinsFoodMenuGoldCap = Reflect.field(o, "AetherTwinsFoodMenuGoldCap");
            AetherTwinsFoodMenuWorldTreeBranch = Reflect.field(o, "AetherTwinsFoodMenuWorldTreeBranch");
            AetherTwinsFoodMenuWorldTreeBranchCap = Reflect.field(o, "AetherTwinsFoodMenuWorldTreeBranchCap");
            AetherTwinsFoodMenuDiamond = Reflect.field(o, "AetherTwinsFoodMenuDiamond");
            AetherTwinsFoodMenuDiamondCap = Reflect.field(o, "AetherTwinsFoodMenuDiamondCap");
            AetherTwinsFoodMenuAmethyst = Reflect.field(o, "AetherTwinsFoodMenuAmethyst");
            AetherTwinsFoodMenuAmethystCap = Reflect.field(o, "AetherTwinsFoodMenuAmethystCap");
            AetherTwinsFoodMenuMoonstone = Reflect.field(o, "AetherTwinsFoodMenuMoonstone");
            AetherTwinsFoodMenuMoonstoneCap = Reflect.field(o, "AetherTwinsFoodMenuMoonstoneCap");
            AetherTwinsFoodMenuSkymetal = Reflect.field(o, "AetherTwinsFoodMenuSkymetal");
            AetherTwinsFoodMenuSkymetalCap = Reflect.field(o, "AetherTwinsFoodMenuSkymetalCap");
            AetherTwinsFoodMenuAdamantine = Reflect.field(o, "AetherTwinsFoodMenuAdamantine");
            AetherTwinsFoodMenuAdamantineCap = Reflect.field(o, "AetherTwinsFoodMenuAdamantineCap");
            AetherTwinsFoodMenuOrichalcum = Reflect.field(o, "AetherTwinsFoodMenuOrichalcum");
            AetherTwinsFoodMenuOrichalcumCap = Reflect.field(o, "AetherTwinsFoodMenuOrichalcumCap");
            AetherTwinsFoodMenuBronze = valueOr(Reflect.field(o, "AetherTwinsFoodMenuBronze"), 0);
            AetherTwinsFoodMenuBronzeCap = valueOr(Reflect.field(o, "AetherTwinsFoodMenuBronzeCap"), 0);
            AetherTwinsFoodMenuEbonIngot = valueOr(Reflect.field(o, "AetherTwinsFoodMenuEbonIngot"), 0);
            AetherTwinsFoodMenuEbonIngotCap = valueOr(Reflect.field(o, "AetherTwinsFoodMenuEbonIngotCap"), 0);
            AetherTwinsFoodMenu = Reflect.field(o, "AetherTwinsFoodMenu");
            AetherTwinsFoodMenuBuckler = Reflect.field(o, "AetherTwinsFoodMenuBuckler");
            AetherTwinsFoodMenuSpikeLShield = Reflect.field(o, "AetherTwinsFoodMenuSpikeLShield");
            AetherTwinsFoodMenuManaBracer = valueOr(Reflect.field(o, "AetherTwinsFoodMenuManaBracer"), false);
            //AetherTwinsFoodMenuKiteShield = valueOr(o["AetherTwinsFoodMenuKiteShield"], false);
            AetherTwinsFoodMenuSGauntlet = Reflect.field(o, "AetherTwinsFoodMenuSGauntlet");
            AetherTwinsFoodMenuClaws = Reflect.field(o, "AetherTwinsFoodMenuClaws");
            AetherTwinsFoodMenuHGaunt = Reflect.field(o, "AetherTwinsFoodMenuHGaunt");
            AetherTwinsFoodMenuBFGauntlets = Reflect.field(o, "AetherTwinsFoodMenuBFGauntlets");
            AetherTwinsFoodMenuLustyClaws = Reflect.field(o, "AetherTwinsFoodMenuLustyClaws");
            AetherTwinsFoodMenuDualDaggers = valueOr(Reflect.field(o, "AetherTwinsFoodMenuDualDaggers"), false);
            AetherTwinsFoodMenuThrowingDagger = valueOr(Reflect.field(o, "AetherTwinsFoodMenuThrowingDagger"), false);
            AetherTwinsFoodMenuTriDagger = valueOr(Reflect.field(o, "AetherTwinsFoodMenuTriDagger"), false);
            AetherTwinsFoodMenuLustyDagger = valueOr(Reflect.field(o, "AetherTwinsFoodMenuLustyDagger"), false);
            AetherTwinsFoodMenuWitchDagger = valueOr(Reflect.field(o, "AetherTwinsFoodMenuWitchDagger"), false);
            AetherTwinsFoodMenuAngstDagger = valueOr(Reflect.field(o, "AetherTwinsFoodMenuAngstDagger"), false);
            AetherTwinsFoodMenuMace = valueOr(Reflect.field(o, "AetherTwinsFoodMenuMace"), false);
            AetherTwinsFoodMenuSpear = valueOr(Reflect.field(o, "AetherTwinsFoodMenuSpear"), false);
            AetherTwinsFoodMenuWhip = valueOr(Reflect.field(o, "AetherTwinsFoodMenuWhip"), false);
            AetherTwinsFoodMenuWardensBlade = valueOr(Reflect.field(o, "AetherTwinsFoodMenuWardensBlade"), false);
            AetherTwinsFoodMenuKatana = valueOr(Reflect.field(o, "AetherTwinsFoodMenuKatana"), false);
            AetherTwinsFoodMenu1 = Reflect.field(o, "AetherTwinsFoodMenu1");
            AetherTwinsFoodMenu2 = Reflect.field(o, "AetherTwinsFoodMenu2");
            AetherTwinsFoodMenu3 = valueOr(Reflect.field(o, "AetherTwinsFoodMenu3"), false);
        }
        // loading from old save
        else
        {
            
            resetState();
        }
    }
    
    public function new()
    {
        super();
        Saves.registerSaveableState(this);
    }
    
    public function aethertwinsFollowers() : Void
    {
        clearOutput();
        if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] >= 1 || flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] >= 1)
        {
            AetherTwinsCount = 1;
        }
        if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] >= 1 && flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] >= 1)
        {
            AetherTwinsCount = 2;
        }
        outputText("You walk over to the Aether Twins' resting place.  Seeing you approach, the sentient weapon" + ((AetherTwinsCount > 1) ? "s turn the golem they" : " turns the golem it") + " used as a temporal host in your direction.\n\n");
        outputText("\"<i>Hey there, [name]! Need anything while we're safe at camp?</i>\"\n\n");
        menu();
        //if (AetherTwinsCount > 0) addButton(0, "Appearance", aethertwinsFollowersAppearance).hint("Examine Aether Twins appearance.");
        //else addButtonDisabled(0, "Appearance", "You can't examine them if none of them are currently using golem as temporal host.");
        addButton(1, "Talk", aethertwinsFollowersTalk).hint("Discuss with the Aether Twins.");
        if (AetherTwinsFoodMenu)
        {
            addButton(2, "Feed", aethertwinsFollowersFeed).hint("Give Aether Twins some equipment or materials to eat.");
        }
        else
        {
            addButtonDisabled(2, "???", "Maybe you should talk with them to unlock this option?");
        }
        //if (AetherTwinsTalkMenu > 0) addButton(3, "Spar", valeriaSpar).hint("Do a quick battle with Valeria!");
        //if (player.lust >= 33) addButton(4, "Sex", followersValeriaSex).hint("Initiate sexy time with the armor-goo.");
        if (AetherTwinsFoodMenu1)
        {
            addButton(5, "Morph", aethertwinsFollowersMorphMain).hint("Morph Aether Twins between all their unlocked forms.");
        }
        else
        {
            addButtonDisabled(5, "???", "Maybe you should work toward their second evolution?");
        }
        addButton(9, "Evolutions", aethertwinsFollowersEvolutionsMain);
        if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] == 1)
        {
            if (player.hasPerk(PerkLib.Rigidity))
            {
                addButtonDisabled(10, "Take A.D.", "Your current rigid state not allowing you to take her with you.");
            }
            else
            {
                addButton(10, "Take A.D.", takeAetherD).hint(weapons.AETHERD.description);
            }
        }
        if (flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] == 1)
        {
            if (player.hasPerk(PerkLib.Rigidity))
            {
                addButtonDisabled(11, "Take A.S.", "Your current rigid state not allowing you to take her with you.");
            }
            else
            {
                addButton(11, "Take A.S.", takeAetherS).hint(shields.AETHERS.description);
            }
        }
        addButton(14, "Back", camp.campFollowers);
    }
    
    private function aethertwinsFollowersAppearance() : Void
    {
        clearOutput();
        outputText("Aether Twin" + ((AetherTwinsCount > 1) ? "s are" : " is") + " using golem around six feet tall without any sexual characteristics, it stone body covered in cracks. ");
        if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] >= 1 || flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] >= 1)
        {
            outputText("On it " + ((flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] >= 1) ? "right" : "left") + " arm is gaunlet covering hand and reaching " + ((AetherTwinsTalkMenu > 0) ? "up" : "near") + " to the elbow. Further up the arm and on the " + ((flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] >= 1) ? "right" : "left") + " side of the ");
            if (AetherTwinsFoodMenu1)
            {
                outputText("golem body");
            }
            else
            {
                outputText("chest area");
            }
            if (AetherTwinsFoodMenu2)
            {
                outputText(" is covered with a think film made of");
            }
            else
            {
                outputText(" cracks are filled with");
            }
            outputText(" goo-like substance. It emits a faint " + ((flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] >= 1) ? "redd" : "blue") + "ish glow.");
        }
        else
        {
            outputText("On it both arms are gaunlets covering hand and reaching " + ((AetherTwinsTalkMenu > 0) ? "up" : "near") + " to the elbow. Further up the arm and on the ");
            if (AetherTwinsFoodMenu1)
            {
                outputText("golem body");
            }
            else
            {
                outputText("chest area");
            }
            if (AetherTwinsFoodMenu2)
            {
                outputText(" is covered with a think film made of");
            }
            else
            {
                outputText(" cracks are filled with");
            }
            outputText(" goo-like substance. They emits a faint reddish on the right side and blueish on the left side glow.");
        }
        //outputText(".");
        doNext(aethertwinsFollowers);
    }
    public function aethertwinsFollowersTalk() : Void
    {
        clearOutput();
        outputText("\"<i>So what do you wanna talk about?</i>\" The sentient weapon" + ((AetherTwinsCount > 1) ? "s ask" : "asks") + ". \"<i>Or do you wanna go smash someone till they are reduced to a blood pulp?</i>\"\n\n");
        menu();
        addButton(0, "Them", aethertwinsFollowersTalkThem);
        if (AetherTwinsTalkMenu > 0)
        {
            addButton(1, "Evolutions", aethertwinsFollowersTalkEvolutions);
            addButton(2, "Past", aethertwinsFollowersTalkPast);
        }
        else
        {
            addButtonDisabled(1, "???", "Twins memories related to this topic are still sealed.");
            addButtonDisabled(2, "???", "Twins memories related to this topic are still sealed.");
        }
        addButton(14, "Back", aethertwinsFollowers);
    }
    public function aethertwinsFollowersTalkThem() : Void
    {
        clearOutput();
        outputText("\"<i>Oh, so you're interested in " + ((AetherTwinsCount > 1) ? "us" : "me") + "? " + ((AetherTwinsCount > 1) ? "We're just" : "I'm just an") + " ordinary sentient weapon" + ((AetherTwinsCount > 1) ? "s" : "") + " crafted by some gifted blacksmith. Maybe even a very 'gifted' blacksmith If you know what " + ((AetherTwinsCount > 1) ? "we" : "I") + " mean.</i>\"\n\n");
        outputText("No you not don't know or at least you react in a way they take it as you not knowing. With a light reminder to return to the subject " + ((AetherTwinsCount > 1) ? "they" : "she") + " continue" + ((AetherTwinsCount > 1) ? "s" : "") + ".\n\n");
        outputText("\"<i>Maybe you think " + ((AetherTwinsCount > 1) ? "we're" : "i'm") + " weak but that's all relative. Just give " + ((AetherTwinsCount > 1) ? "us" : "me") + " some snacks and " + ((AetherTwinsCount > 1) ? "we" : "I") + "'ll get stronger in no time.</i>\"\n\n");
        outputText("Giving " + ((AetherTwinsCount > 1) ? "them" : "her") + " snacks? Like some food? Aren't " + ((AetherTwinsCount > 1) ? "they" : "she") + " a weapon? How would " + ((AetherTwinsCount > 1) ? "they" : "she") + " eat all that food?\n\n");
        outputText("\"<i>Hella no. " + ((AetherTwinsCount > 1) ? "We are" : "I am") + " not interested in food your kind eats. Bring " + ((AetherTwinsCount > 1) ? "us" : "me") + " all those tasty metals or equipment like gloves, claws and shields. That should be enough.</i>\"\n\n");
        outputText("That certainly would make thigns easier... or harder? As long " + ((AetherTwinsCount > 1) ? "their" : "her") + " 'appetite' isn't bottomless.\n\n");
        outputText("\"<i>So then ummm.. did you bring us some snacks?</i>\" " + ((AetherTwinsCount > 1) ? "Their" : "Her") + " voice sounds like " + ((AetherTwinsCount > 1) ? "they are" : "she is") + " expecting to get some 'food' now. You make an excuse like 'you need to go' and bring an end to the conversation.\n\n");
        if (!AetherTwinsFoodMenu && flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] >= 1 && flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] >= 1)
        {
            outputText("<b>Feed Option has been unlocked!!!</b>\n\n");
            AetherTwinsFoodMenu = true;
        }
        doNext(aethertwinsFollowersTalk);
        cheatTime(1 / 4);
    }
    public function aethertwinsFollowersTalkEvolutions() : Void
    {
        clearOutput();
        outputText("\"<i>That's what makes " + ((AetherTwinsCount > 1) ? "us" : "me") + " special, right? To keep devouring and evolving reaching our pinnacle.</i>\" Reaching your pinnacle? But why? \"<i>That's a silly question isn't it? Because...</i>\" " + ((AetherTwinsCount > 1) ? "they" : "she") + " fall silent for very long moment as if trying recall a reason. \"<i>... because it's the purpose of ");
        outputText(((AetherTwinsCount > 1) ? "our" : "my") + " existance.</i>\"\n\nJust like that? Merely existing to devour and evolve? Nothing more to " + ((AetherTwinsCount > 1) ? "their" : "her") + " evolutions than this?\n\n");
        outputText("\"<i>Haven't you also changed since coming to this realm? You also evolve in your own way, so why do you think " + ((AetherTwinsCount > 1) ? "our" : "my") + " evolutions have no purpose? Survival of the fittest, right?</i>\"\n\n");
        outputText("You fall silent thinking that over. Yes, you changed since coming here. Before you can continue conversation " + ((AetherTwinsCount > 1) ? "they end" : "she ends") + " it, \"<i>" + ((AetherTwinsCount > 1) ? "We're" : "I'm") + " bored, let's find someone to beat or something to eat. Come on... talking is so boring!!!</i>\"\n\n");
        doNext(aethertwinsFollowersTalk);
        cheatTime(1 / 4);
    }
    public function aethertwinsFollowersTalkPast() : Void
    {
        clearOutput();
        outputText("\"<i>Past?</i>\" " + ((AetherTwinsCount > 1) ? "They focus" : "She focuses") + " for a longer moment trying recall it. " + ((AetherTwinsCount > 1) ? "They stay" : "She stays") + " silent for very long moment before " + ((AetherTwinsCount > 1) ? "They speak" : "She speaks") + " again.\n\n\"<i>All " + ((AetherTwinsCount > 1) ? "we" : "I") + " could recall is awaking ");
        outputText("inside the dungeon next to the golem that " + ((AetherTwinsCount > 1) ? "we" : "I") + " bonded with and started controling like " + ((AetherTwinsCount > 1) ? "our" : "my") + " own bod" + ((AetherTwinsCount > 1) ? "ies" : "y") + ". Anything before that time is still veiled like some sort of mist covering " + ((AetherTwinsCount > 1) ? "our" : "my") + " older memories.</i>\"\n\n");
        outputText("Well that wasn't much. You end the converstaion asuring " + ((AetherTwinsCount > 1) ? "them" : "her") + " that with more evolutions " + ((AetherTwinsCount > 1) ? "they" : "she") + " will recall more details about " + ((AetherTwinsCount > 1) ? "their" : "her") + " past.\n\n");
        doNext(aethertwinsFollowersTalk);
        cheatTime(1 / 4);
    }
    
    public function aethertwinsFollowersFeed() : Void
    {
        clearOutput();
        outputText("\"<i>You brought somethng tasty for " + ((AetherTwinsCount > 1) ? "us" : "me") + " to eat?</i>\" " + ((AetherTwinsCount > 1) ? "They" : "She") + " ask" + ((AetherTwinsCount > 1) ? "s" : "") + ".");
        outputText("\n\n-------");
        if (AetherTwinsTalkMenu > 0)
        {
            outputText("\n\nEaten materials:");
            outputText("\n-Silver ingot (" + AetherTwinsFoodMenuSilver + "/" + AetherTwinsFoodMenuSilverCap + ")");
            outputText("\n-Gold ingot (" + AetherTwinsFoodMenuGold + "/" + AetherTwinsFoodMenuGoldCap + ")");
            outputText("\n-Tin ore (" + AetherTwinsFoodMenuTin + "/" + AetherTwinsFoodMenuTinCap + ")");
            outputText("\n-Copper ore (" + AetherTwinsFoodMenuCopper + "/" + AetherTwinsFoodMenuCopperCap + ")");
            outputText("\n-Iron ore (" + AetherTwinsFoodMenuIron + "/" + AetherTwinsFoodMenuIronCap + ")");
        }
        if (AetherTwinsFoodMenu1)
        {
            outputText("\n-Amethyst (" + AetherTwinsFoodMenuAmethyst + "/" + AetherTwinsFoodMenuAmethystCap + ")");
            outputText("\n-Diamond (" + AetherTwinsFoodMenuDiamond + "/" + AetherTwinsFoodMenuDiamondCap + ")");
        }
        if (AetherTwinsFoodMenu2)
        {
            outputText("\n-World Tree Branch (" + AetherTwinsFoodMenuWorldTreeBranch + "/" + AetherTwinsFoodMenuWorldTreeBranchCap + ")");
            outputText("\n-Bronze bar (" + AetherTwinsFoodMenuBronze + "/" + AetherTwinsFoodMenuBronzeCap + ")");
            outputText("\n-Moonstone (" + AetherTwinsFoodMenuMoonstone + "/" + AetherTwinsFoodMenuMoonstoneCap + ")");
            outputText("\n-Ebon ingot (" + AetherTwinsFoodMenuEbonIngot + "/" + AetherTwinsFoodMenuEbonIngotCap + ")");
        }
        outputText("\n\nEaten equipment:");
        if (AetherTwinsFoodMenuBuckler)
        {
            outputText("\n-Buckler");
        }
        if (AetherTwinsFoodMenuSpikeLShield)
        {
            outputText("\n-Spiked Light Shield");
        }
        if (AetherTwinsFoodMenuManaBracer)
        {
            outputText("\n-Mana Bracer");
        }
        //if (AetherTwinsFoodMenuKiteShield) outputText("\n-");
        if (AetherTwinsFoodMenuSGauntlet)
        {
            outputText("\n-Spiked Gauntlet");
        }
        if (AetherTwinsFoodMenuClaws)
        {
            outputText("\n-Claws");
        }
        if (AetherTwinsFoodMenuHGaunt)
        {
            outputText("\n-Hooked Gauntlets");
        }
        if (AetherTwinsFoodMenuBFGauntlets)
        {
            outputText("\n-Big Fucking Gauntlets");
        }
        if (AetherTwinsFoodMenuLustyClaws)
        {
            outputText("\n-Lusty Claws");
        }
        if (AetherTwinsFoodMenuDualDaggers)
        {
            outputText("\n-Dual Daggers");
        }
        if (AetherTwinsFoodMenuThrowingDagger)
        {
            outputText("\n-Throwing Dagger");
        }
        if (AetherTwinsFoodMenuTriDagger)
        {
            outputText("\n-Tri-Dagger");
        }
        if (AetherTwinsFoodMenuLustyDagger)
        {
            outputText("\n-Lusty Dagger");
        }
        if (AetherTwinsFoodMenuWitchDagger)
        {
            outputText("\n-Witch Dagger");
        }
        if (AetherTwinsFoodMenuAngstDagger)
        {
            outputText("\n-Angst Dagger");
        }
        if (AetherTwinsFoodMenuMace)
        {
            outputText("\n-Mace");
        }
        if (AetherTwinsFoodMenuSpear)
        {
            outputText("\n-Spear");
        }
        if (AetherTwinsFoodMenuWhip)
        {
            outputText("\n-Whip");
        }
        if (AetherTwinsFoodMenuWardensBlade)
        {
            outputText("\n-Warden's Blade");
        }
        if (AetherTwinsFoodMenuKatana)
        {
            outputText("\n-Katana");
        }
        menu();
        var btn : Int = 0;
        if (player.hasItem(useables.S_INGOT, 1))
        {
            if (AetherTwinsTalkMenu > 0)
            {
                if (AetherTwinsFoodMenuSilver < AetherTwinsFoodMenuSilverCap)
                {
                    addButton(btn, useables.S_INGOT.shortName, aethertwinsFollowersFeedMaterial, useables.S_INGOT);
                }
                else
                {
                    addButtonDisabled(btn, useables.S_INGOT.shortName, "They can't eat more of this type of metal without undergoing next evolution.");
                }
            }
            else
            {
                addButtonDisabled(btn, useables.S_INGOT.shortName, "They can't eat this type of metal before first evolution.");
            }
            btn++;
        }
        if (player.hasItem(useables.G_INGOT, 1))
        {
            if (AetherTwinsTalkMenu > 0)
            {
                if (AetherTwinsFoodMenuGold < AetherTwinsFoodMenuGoldCap)
                {
                    addButton(btn, useables.G_INGOT.shortName, aethertwinsFollowersFeedMaterial, useables.G_INGOT);
                }
                else
                {
                    addButtonDisabled(btn, useables.G_INGOT.shortName, "They can't eat more of this type of metal without undergoing next next evolution.");
                }
            }
            else
            {
                addButtonDisabled(btn, useables.G_INGOT.shortName, "They can't eat this type of metal before first evolution.");
            }
            btn++;
        }
        if (player.hasItem(useables.TIN_ORE, 1) || SceneLib.crafting.hasMaterial(useables.TIN_ORE) > 0)
        {
            if (AetherTwinsTalkMenu > 0)
            {
                if (AetherTwinsFoodMenuTin < AetherTwinsFoodMenuTinCap)
                {
                    addButton(btn, useables.TIN_ORE.shortName, aethertwinsFollowersFeedMaterial, useables.TIN_ORE);
                }
                else
                {
                    addButtonDisabled(btn, useables.TIN_ORE.shortName, "They can't eat more of this type of metal without undergoing next evolution.");
                }
            }
            else
            {
                addButtonDisabled(btn, useables.TIN_ORE.shortName, "They can't eat this type of metal before first evolution.");
            }
            btn++;
        }
        if (player.hasItem(useables.COP_ORE, 1) || SceneLib.crafting.hasMaterial(useables.COP_ORE) > 0)
        {
            if (AetherTwinsTalkMenu > 0)
            {
                if (AetherTwinsFoodMenuCopper < AetherTwinsFoodMenuCopperCap)
                {
                    addButton(btn, useables.COP_ORE.shortName, aethertwinsFollowersFeedMaterial, useables.COP_ORE);
                }
                else
                {
                    addButtonDisabled(btn, useables.COP_ORE.shortName, "They can't eat more of this type of metal without undergoing next evolution.");
                }
            }
            else
            {
                addButtonDisabled(btn, useables.COP_ORE.shortName, "They can't eat this type of metal before first evolution.");
            }
            btn++;
        }
        if (player.hasItem(useables.IRONORE, 1) || SceneLib.crafting.hasMaterial(useables.IRONORE) > 0)
        {
            if (AetherTwinsTalkMenu > 0)
            {
                if (AetherTwinsFoodMenuIron < AetherTwinsFoodMenuIronCap)
                {
                    addButton(btn, useables.IRONORE.shortName, aethertwinsFollowersFeedMaterial, useables.IRONORE);
                }
                else
                {
                    addButtonDisabled(btn, useables.IRONORE.shortName, "They can't eat more of this type of metal without undergoing next evolution.");
                }
            }
            else
            {
                addButtonDisabled(btn, useables.IRONORE.shortName, "They can't eat this type of metal before first evolution.");
            }
            btn++;
        }
        if (player.hasItem(useables.AMETIST, 1))
        {
            if (AetherTwinsFoodMenu1)
            {
                if (AetherTwinsFoodMenuAmethyst < AetherTwinsFoodMenuAmethystCap)
                {
                    addButton(btn, useables.AMETIST.shortName, aethertwinsFollowersFeedMaterial, useables.AMETIST);
                }
                else
                {
                    addButtonDisabled(btn, useables.AMETIST.shortName, "They can't eat more of this type of mineral without undergoing next evolution.");
                }
            }
            else
            {
                addButtonDisabled(btn, useables.AMETIST.shortName, "They can't eat this type of mineral before second evolution.");
            }
            btn++;
        }
        if (player.hasItem(useables.DIAMOND, 1))
        {
            if (AetherTwinsFoodMenu1)
            {
                if (AetherTwinsFoodMenuDiamond < AetherTwinsFoodMenuDiamondCap)
                {
                    addButton(btn, useables.DIAMOND.shortName, aethertwinsFollowersFeedMaterial, useables.DIAMOND);
                }
                else
                {
                    addButtonDisabled(btn, useables.DIAMOND.shortName, "They can't eat more of this type of mineral without undergoing next evolution.");
                }
            }
            else
            {
                addButtonDisabled(btn, useables.DIAMOND.shortName, "They can't eat this type of mineral before second evolution.");
            }
            btn++;
        }
        if (player.hasItem(useables.WT_BRAN, 1))
        {
            if (AetherTwinsFoodMenu2)
            {
                if (AetherTwinsFoodMenuWorldTreeBranch < AetherTwinsFoodMenuWorldTreeBranchCap)
                {
                    addButton(btn, useables.WT_BRAN.shortName, aethertwinsFollowersFeedMaterial, useables.WT_BRAN);
                }
                else
                {
                    addButtonDisabled(btn, useables.WT_BRAN.shortName, "They can't eat more of this type of mineral without undergoing next evolution.");
                }
            }
            else
            {
                addButtonDisabled(btn, useables.WT_BRAN.shortName, "They can't eat this type of mineral before third evolution.");
            }
            btn++;
        }
        if (player.hasItem(useables.BRONZEB, 1) || SceneLib.crafting.hasMaterial(useables.BRONZEB) > 0)
        {
            if (AetherTwinsFoodMenu2)
            {
                if (AetherTwinsFoodMenuBronze < AetherTwinsFoodMenuBronzeCap)
                {
                    addButton(btn, useables.BRONZEB.shortName, aethertwinsFollowersFeedMaterial, useables.BRONZEB);
                }
                else
                {
                    addButtonDisabled(btn, useables.BRONZEB.shortName, "They can't eat more of this type of mineral without undergoing next evolution.");
                }
            }
            else
            {
                addButtonDisabled(btn, useables.BRONZEB.shortName, "They can't eat this type of mineral before third evolution.");
            }
            btn++;
        }
        if (player.hasItem(useables.MOONSTO, 1) || SceneLib.crafting.hasMaterial(useables.MOONSTO) > 0)
        {
            if (AetherTwinsFoodMenu2)
            {
                if (AetherTwinsFoodMenuMoonstone < AetherTwinsFoodMenuMoonstoneCap)
                {
                    addButton(btn, useables.MOONSTO.shortName, aethertwinsFollowersFeedMaterial, useables.MOONSTO);
                }
                else
                {
                    addButtonDisabled(btn, useables.MOONSTO.shortName, "They can't eat more of this type of mineral without undergoing next evolution.");
                }
            }
            else
            {
                addButtonDisabled(btn, useables.MOONSTO.shortName, "They can't eat this type of mineral before third evolution.");
            }
            btn++;
        }
        if (player.hasItem(useables.EBONING, 1) || SceneLib.crafting.hasMaterial(useables.EBONING) > 0)
        {
            if (AetherTwinsFoodMenu2)
            {
                if (AetherTwinsFoodMenuEbonIngot < AetherTwinsFoodMenuEbonIngotCap)
                {
                    addButton(btn, useables.EBONING.shortName, aethertwinsFollowersFeedMaterial, useables.EBONING);
                }
                else
                {
                    addButtonDisabled(btn, useables.EBONING.shortName, "They can't eat more of this type of mineral without undergoing next evolution.");
                }
            }
            else
            {
                addButtonDisabled(btn, useables.EBONING.shortName, "They can't eat this type of mineral before third evolution.");
            }
            btn++;
        }
        if (player.hasItem(shields.BUCKLER, 1) && !AetherTwinsFoodMenuBuckler)
        {
            addButton(btn, shields.BUCKLER.shortName, aethertwinsFollowersFeedEquipment, shields.BUCKLER);
            btn++;
        }
        if (player.hasItem(weapons.S_GAUNT, 1) && !AetherTwinsFoodMenuSGauntlet)
        {
            addButton(btn, weapons.S_GAUNT.shortName, aethertwinsFollowersFeedEquipment, weapons.S_GAUNT);
            btn++;
        }
        if (player.hasItem(weapons.CLAWS, 1) && !AetherTwinsFoodMenuClaws)
        {
            addButton(btn, weapons.CLAWS.shortName, aethertwinsFollowersFeedEquipment, weapons.CLAWS);
            btn++;
        }
        if (player.hasItem(shields.SPIL_SH, 1) && !AetherTwinsFoodMenuSpikeLShield)
        {
            if (AetherTwinsTalkMenu > 0)
            {
                addButton(btn, shields.SPIL_SH.shortName, aethertwinsFollowersFeedEquipment, shields.SPIL_SH);
            }
            else
            {
                addButtonDisabled(btn, shields.SPIL_SH.shortName, "They can't eat this shield before first evolution.");
            }
            btn++;
        }
        if (player.hasItem(weapons.H_GAUNT, 1) && !AetherTwinsFoodMenuHGaunt)
        {
            if (AetherTwinsTalkMenu > 0)
            {
                addButton(btn, weapons.H_GAUNT.shortName, aethertwinsFollowersFeedEquipment, weapons.H_GAUNT);
            }
            else
            {
                addButtonDisabled(btn, weapons.H_GAUNT.shortName, "They can't eat this weapon before first evolution.");
            }
            btn++;
        }
        if (player.hasItem(weapons.BFGAUNT, 1) && !AetherTwinsFoodMenuBFGauntlets)
        {
            if (AetherTwinsTalkMenu > 0)
            {
                addButton(btn, weapons.BFGAUNT.shortName, aethertwinsFollowersFeedEquipment, weapons.BFGAUNT);
            }
            else
            {
                addButtonDisabled(btn, weapons.BFGAUNT.shortName, "They can't eat this weapon before first evolution.");
            }
            btn++;
        }
        if (player.hasItem(weapons.L_CLAWS, 1) && !AetherTwinsFoodMenuLustyClaws)
        {
            if (AetherTwinsTalkMenu > 0)
            {
                addButton(btn, weapons.L_CLAWS.shortName, aethertwinsFollowersFeedEquipment, weapons.L_CLAWS);
            }
            else
            {
                addButtonDisabled(btn, weapons.L_CLAWS.shortName, "They can't eat this weapon before first evolution.");
            }
            btn++;
        }
        if (player.hasItem(shields.MABRACE, 1) && !AetherTwinsFoodMenuManaBracer)
        {
            if (AetherTwinsFoodMenu1)
            {
                addButton(btn, shields.MABRACE.shortName, aethertwinsFollowersFeedEquipment, shields.MABRACE);
            }
            else
            {
                addButtonDisabled(btn, shields.MABRACE.shortName, "They can't eat this weapon before second evolution.");
            }
            btn++;
        }
        if (player.hasItem(weapons.DDAGGER, 1) && !AetherTwinsFoodMenuDualDaggers)
        {
            if (AetherTwinsFoodMenu1)
            {
                addButton(btn, weapons.DDAGGER.shortName, aethertwinsFollowersFeedEquipment, weapons.DDAGGER);
            }
            else
            {
                addButtonDisabled(btn, weapons.DDAGGER.shortName, "They can't eat this weapon before second evolution.");
            }
            btn++;
        }
        if (player.hasItem(weapons.TDAGGER, 1) && !AetherTwinsFoodMenuThrowingDagger)
        {
            if (AetherTwinsFoodMenu1)
            {
                addButton(btn, weapons.TDAGGER.shortName, aethertwinsFollowersFeedEquipment, weapons.TDAGGER);
            }
            else
            {
                addButtonDisabled(btn, weapons.TDAGGER.shortName, "They can't eat this weapon before second evolution.");
            }
            btn++;
        }
        if (player.hasItem(weapons.TRIDAG, 1) && !AetherTwinsFoodMenuTriDagger)
        {
            if (AetherTwinsFoodMenu1)
            {
                addButton(btn, weapons.TRIDAG.shortName, aethertwinsFollowersFeedEquipment, weapons.TRIDAG);
            }
            else
            {
                addButtonDisabled(btn, weapons.TRIDAG.shortName, "They can't eat this weapon before second evolution.");
            }
            btn++;
        }
        if (player.hasItem(weapons.L_DAGGR, 1) && !AetherTwinsFoodMenuLustyDagger)
        {
            if (AetherTwinsFoodMenu1)
            {
                addButton(btn, weapons.L_DAGGR.shortName, aethertwinsFollowersFeedEquipment, weapons.L_DAGGR);
            }
            else
            {
                addButtonDisabled(btn, weapons.L_DAGGR.shortName, "They can't eat this weapon before second evolution.");
            }
            btn++;
        }
        if (player.hasItem(weapons.WDAGGER, 1) && !AetherTwinsFoodMenuWitchDagger)
        {
            if (AetherTwinsFoodMenu1)
            {
                addButton(btn, weapons.WDAGGER.shortName, aethertwinsFollowersFeedEquipment, weapons.WDAGGER);
            }
            else
            {
                addButtonDisabled(btn, weapons.WDAGGER.shortName, "They can't eat this weapon before second evolution.");
            }
            btn++;
        }
        if (player.hasItem(weapons.ANGSTD1, 1) && !AetherTwinsFoodMenuAngstDagger)
        {
            if (AetherTwinsFoodMenu1)
            {
                addButton(btn, weapons.ANGSTD1.shortName, aethertwinsFollowersFeedEquipment, weapons.ANGSTD1);
            }
            else
            {
                addButtonDisabled(btn, weapons.ANGSTD1.shortName, "They can't eat this weapon before second evolution.");
            }
            btn++;
        }  /*
	if (player.hasItem(shields.KITE_SH, 1) && !AetherTwinsFoodMenuKiteShield) {
		if (AetherTwinsFoodMenu2) addButton(btn, shields.KITE_SH.shortName, aethertwinsFollowersFeedEquipment, shields.KITE_SH);
		else addButtonDisabled(btn, shields.KITE_SH.shortName, "They can't eat this weapon before third evolution.");
		btn++;
	}*/  
        if (player.hasItem(weapons.MACE, 1) && !AetherTwinsFoodMenuMace)
        {
            if (AetherTwinsFoodMenu2)
            {
                addButton(btn, weapons.MACE.shortName, aethertwinsFollowersFeedEquipment, weapons.MACE);
            }
            else
            {
                addButtonDisabled(btn, weapons.MACE.shortName, "They can't eat this weapon before third evolution.");
            }
            btn++;
        }
        if (player.hasItem(weapons.SPEAR, 1) && !AetherTwinsFoodMenuSpear)
        {
            if (AetherTwinsFoodMenu2)
            {
                addButton(btn, weapons.SPEAR.shortName, aethertwinsFollowersFeedEquipment, weapons.SPEAR);
            }
            else
            {
                addButtonDisabled(btn, weapons.SPEAR.shortName, "They can't eat this weapon before third evolution.");
            }
            btn++;
        }
        if (player.hasItem(weapons.WHIP, 1) && !AetherTwinsFoodMenuWhip)
        {
            if (AetherTwinsFoodMenu2)
            {
                addButton(btn, weapons.WHIP.shortName, aethertwinsFollowersFeedEquipment, weapons.WHIP);
            }
            else
            {
                addButtonDisabled(btn, weapons.WHIP.shortName, "They can't eat this weapon before third evolution.");
            }
            btn++;
        }
        if (player.hasItem(weapons.WDBLADE, 1) && !AetherTwinsFoodMenuWardensBlade)
        {
            if (AetherTwinsFoodMenu2)
            {
                addButton(btn, weapons.WDBLADE.shortName, aethertwinsFollowersFeedEquipment, weapons.WDBLADE);
            }
            else
            {
                addButtonDisabled(btn, weapons.WDBLADE.shortName, "They can't eat this weapon before third evolution.");
            }
            btn++;
        }
        if (player.hasItem(weapons.KATANA, 1) && !AetherTwinsFoodMenuKatana)
        {
            if (AetherTwinsFoodMenu3)
            {
                addButton(btn, weapons.KATANA.shortName, aethertwinsFollowersFeedEquipment, weapons.KATANA);
            }
            else
            {
                addButtonDisabled(btn, weapons.KATANA.shortName, "They can't eat this weapon before fourth evolution.");
            }
            btn++;
        }
        addButton(14, "Back", aethertwinsFollowers);
    }
    public function aethertwinsFollowersFeedMaterial(itype : ItemType) : Void
    {
        clearOutput();
        outputText("You decide it's time to upgrade the twins with some new material. You grab the " + itype.shortName + " out of your bag and slowly let the twin eat it, the material turning liquid as you squeeze it between gauntlets. ");
        outputText("Before long the now fluid " + itype.shortName + " is coating them entirely. A few seconds later you are done and the " + itype.shortName + " is fully absorbed into the twins.\n\n");
        outputText("\"<i>Thank you for the meal.</i>\" they grins.\n\n");
        switch (itype)
        {
            case useables.TIN_ORE:AetherTwinsFoodMenuTin += 1;
            case useables.COP_ORE:AetherTwinsFoodMenuCopper += 1;
            case useables.IRONORE:AetherTwinsFoodMenuIron += 1;
            case useables.S_INGOT:AetherTwinsFoodMenuSilver += 1;
            case useables.G_INGOT:AetherTwinsFoodMenuGold += 1;
            case useables.AMETIST:AetherTwinsFoodMenuAmethyst += 1;
            case useables.DIAMOND:AetherTwinsFoodMenuDiamond += 1;
            case useables.WT_BRAN:AetherTwinsFoodMenuWorldTreeBranch += 1;
            case useables.BRONZEB:AetherTwinsFoodMenuBronze += 1;
            case useables.MOONSTO:AetherTwinsFoodMenuMoonstone += 1;
            case useables.EBONING:AetherTwinsFoodMenuEbonIngot += 1;
        }
        //if (!(SceneLib.crafting.hasMaterial(itype) && SceneLib.crafting.useMaterial(itype))) player.destroyItems(itype, 1);
        //else SceneLib.crafting.feedAetherTwinsMaterialFromOreBag(itype);
        if (SceneLib.crafting.hasMaterial(itype) > 0)
        {
            SceneLib.crafting.feedAetherTwinsMaterialFromOreBag(itype);
        }
        else
        {
            player.destroyItems(itype, 1);
        }
        doNext(aethertwinsFollowersFeed);
        cheatTime(1 / 4);
    }
    public function aethertwinsFollowersFeedEquipment(itype : ItemType) : Void
    {
        clearOutput();
        outputText("You deposit the item on the ground and approach the aether twins from it. Not to your surprise the item begins to melt as if turning to sludge as the twins zap them with some unknown magic the twins growing something not unlike magical teeth with which they begin munching on this new material. Before long the item is fully assimilated into the twins which acquire some of its powers.\n\n");
        outputText("\"<i>Thank you for the meal.</i>\" they grin.\n\n");
        switch (itype)
        {
            case shields.BUCKLER:AetherTwinsFoodMenuBuckler = true;
            case shields.SPIL_SH:AetherTwinsFoodMenuSpikeLShield = true;
            case shields.MABRACE:AetherTwinsFoodMenuManaBracer = true;
            //case shields.KITE_SH:	AetherTwinsFoodMenuKiteShield = true;		break;
            case weapons.S_GAUNT:AetherTwinsFoodMenuSGauntlet = true;
            case weapons.CLAWS:AetherTwinsFoodMenuClaws = true;
            case weapons.H_GAUNT:AetherTwinsFoodMenuHGaunt = true;
            case weapons.BFGAUNT:AetherTwinsFoodMenuBFGauntlets = true;
            case weapons.L_CLAWS:AetherTwinsFoodMenuLustyClaws = true;
            case weapons.DDAGGER:AetherTwinsFoodMenuDualDaggers = true;
            case weapons.TDAGGER:AetherTwinsFoodMenuThrowingDagger = true;
            case weapons.TRIDAG:AetherTwinsFoodMenuTriDagger = true;
            case weapons.L_DAGGR:AetherTwinsFoodMenuLustyDagger = true;
            case weapons.WDAGGER:AetherTwinsFoodMenuWitchDagger = true;
            case weapons.ANGSTD1:AetherTwinsFoodMenuAngstDagger = true;
            case weapons.MACE:AetherTwinsFoodMenuMace = true;
            case weapons.SPEAR:AetherTwinsFoodMenuSpear = true;
            case weapons.WHIP:AetherTwinsFoodMenuWhip = true;
            case weapons.WDBLADE:AetherTwinsFoodMenuWardensBlade = true;
            case weapons.KATANA:AetherTwinsFoodMenuKatana = true;
        }
        player.destroyItems(itype, 1);
        doNext(aethertwinsFollowersFeed);
        cheatTime(1 / 4);
    }
    
    public function aethertwinsFollowersMorphMain() : Void
    {
        clearOutput();
        outputText("\"<i>You want us to change form into different one? Wasn't the one we currently have good one? Ahh, well... then what other form you want us to assume?</i>\"\n\n");
        menu();
        if (AetherTwinsShape == "Human-tier Gaunlets")
        {
            addButtonDisabled(0, "HtGauntl", "They are curretly in Human-tier Gauntlets form.");
        }
        else
        {
            addButton(0, "HtGauntl", aethertwinsFollowersMorphMainHumanTierGaunlets);
        }
        if (AetherTwinsShape == "Sky-tier Gaunlets")
        {
            addButtonDisabled(1, "StGauntl", "They are curretly in Sky-tier Gauntlets form.");
        }
        else
        {
            addButton(1, "StGauntl", aethertwinsFollowersMorphMainSkyTierGaunlets);
        }
        if (AetherTwinsFoodMenu2)
        {
            if (AetherTwinsShape == "Human-tier Dagger and Shield")
            {
                addButtonDisabled(2, "HtDagger&Shield", "They are curretly in Human-tier Dagger and Shield form.");
            }
            else
            {
                addButton(2, "HtDagger&Shield", aethertwinsFollowersMorphMainHumanTierSmallWeapons);
            }
            if (AetherTwinsShape == "Human-tier Dual Daggers")
            {
                addButtonDisabled(3, "HtDualDaggers", "They are curretly in Human-tier Dual Daggers form.");
            }
            else if (player.hasPerk(PerkLib.DualWield))
            {
                addButton(3, "HtDualDaggers", aethertwinsFollowersMorphMainHumanTierDualSmallWeapons);
            }
            else
            {
                addButtonDisabled(3, "HtDualDaggers", "Without knowing how to Dual Wield weapons you wouldn't be able to use this form of their.");
            }
        }
        else
        {
            addButtonDisabled(2, "???", "After twins third evolution.");
            addButtonDisabled(3, "???", "After twins third evolution.");
        }
        addButton(14, "Back", aethertwinsFollowers);
    }
    public function aethertwinsFollowersMorphMainHumanTierGaunlets() : Void
    {
        clearOutput();
        outputText("\"<i>So you liked our Human-tier gauntlets form? It may be not as much fun as other forms but we can asume this one,</i>\" they reply. After a moment both of them shape become less defined and more fluid. Slowly they become larger than a pair of medium-sized gauntlets that coversr your hands and forearms with sharp claws.");
        AetherTwinsShape = "Human-tier Gaunlets";
        if (player.statusEffectv1(StatusEffects.AetherTwins1) != 0)
        {
            one = player.statusEffectv1(StatusEffects.AetherTwins1);
            player.addStatusValue(StatusEffects.AetherTwins1, 1, -one);
        }
        if (player.statusEffectv2(StatusEffects.AetherTwins1) != 5)
        {
            two = player.statusEffectv2(StatusEffects.AetherTwins1);
            player.addStatusValue(StatusEffects.AetherTwins1, 2, -(two - 5));
        }
        doNext(aethertwinsFollowersMorphMain);
        cheatTime(1 / 6);
    }
    public function aethertwinsFollowersMorphMainSkyTierGaunlets() : Void
    {
        clearOutput();
        outputText("\"<i>So you liked our Sky-tier gauntlets form? It may be not as much fun as other forms but we can asume this one,</i>\" they reply. After a moment both of them shape become less defined and more fluid. Slowly they become a bit larger than BF gauntelrs with much sharper claws and spiked similar to those on spiked shield growing all over upper section of gauntlets.\n\n");
        AetherTwinsShape = "Sky-tier Gaunlets";
        if (player.statusEffectv1(StatusEffects.AetherTwins1) != 0)
        {
            one = player.statusEffectv1(StatusEffects.AetherTwins1);
            player.addStatusValue(StatusEffects.AetherTwins1, 1, -one);
        }
        if (player.statusEffectv2(StatusEffects.AetherTwins1) != 15)
        {
            two = player.statusEffectv2(StatusEffects.AetherTwins1);
            player.addStatusValue(StatusEffects.AetherTwins1, 2, -(two - 15));
        }
        doNext(aethertwinsFollowersMorphMain);
        cheatTime(1 / 6);
    }
    public function aethertwinsFollowersMorphMainHumanTierSmallWeapons() : Void
    {
        clearOutput();
        outputText("\"<i>So you liked our Human-tier dagger and shield form? It may be not as much fun as other forms but we can asume this one,</i>\" they reply. After a moment both of them shape become less defined and more fluid. Slowly they become a medium sized dagger and small shield.\n\n");
        AetherTwinsShape = "Human-tier Dagger and Shield";
        if (player.statusEffectv1(StatusEffects.AetherTwins1) != 20)
        {
            one = player.statusEffectv1(StatusEffects.AetherTwins1);
            player.addStatusValue(StatusEffects.AetherTwins1, 1, -(one - 19));
        }
        if (player.statusEffectv2(StatusEffects.AetherTwins1) != 17)
        {
            two = player.statusEffectv2(StatusEffects.AetherTwins1);
            player.addStatusValue(StatusEffects.AetherTwins1, 2, -(two - 17));
        }
        doNext(aethertwinsFollowersMorphMain);
        cheatTime(1 / 6);
    }
    public function aethertwinsFollowersMorphMainHumanTierDualSmallWeapons() : Void
    {
        clearOutput();
        outputText("\"<i>So you liked our Human-tier dual dagger form? It may be not as much fun as other forms but we can asume this one,</i>\" they reply. After a moment both of them shape become less defined and more fluid. Slowly they become a pair of medium sized daggers.\n\n");
        AetherTwinsShape = "Human-tier Dual Daggers";
        if (player.statusEffectv1(StatusEffects.AetherTwins1) != 20)
        {
            one = player.statusEffectv1(StatusEffects.AetherTwins1);
            player.addStatusValue(StatusEffects.AetherTwins1, 1, -(one - 19));
        }
        if (player.statusEffectv2(StatusEffects.AetherTwins1) != 7)
        {
            two = player.statusEffectv2(StatusEffects.AetherTwins1);
            player.addStatusValue(StatusEffects.AetherTwins1, 2, -(two - 7));
        }
        doNext(aethertwinsFollowersMorphMain);
        cheatTime(1 / 6);
    }
    
    public function aethertwinsFollowersEvolutionsMain() : Void
    {
        menu();
        if (AetherTwinsFoodMenuBuckler && AetherTwinsFoodMenuSGauntlet && AetherTwinsFoodMenuClaws && AetherTwinsTalkMenu < 1)
        {
            addButton(0, "HtGauntl", aethertwinsFollowersEvolutionsToHumanTierGaunlets);
        }
        else if (AetherTwinsTalkMenu > 0)
        {
            addButtonDisabled(0, "HtGauntl", "They already unlocked Human-tier Gauntlets form.");
        }
        else
        {
            addButtonDisabled(0, "HtGauntl", "They not yet ate enough nutriments to evolve into this shape.");
        }
        if (AetherTwinsFoodMenuSpikeLShield && AetherTwinsFoodMenuHGaunt && AetherTwinsFoodMenuBFGauntlets && AetherTwinsFoodMenuLustyClaws && AetherTwinsFoodMenuTin == 2 && AetherTwinsFoodMenuCopper == 2 && AetherTwinsFoodMenuIron == 2 && AetherTwinsFoodMenuSilver == 2 && AetherTwinsFoodMenuGold == 2 && !AetherTwinsFoodMenu1)
        {
            addButton(1, "StGauntl", aethertwinsFollowersEvolutionsToSkyTierGaunlets);
        }
        else if (AetherTwinsFoodMenu1)
        {
            addButtonDisabled(1, "StGauntl", "They already unlocked Sky-tier Gauntlets form.");
        }
        else
        {
            addButtonDisabled(1, "StGauntl", "They not yet ate enough nutriments to evolve into this shape.");
        }
        if (AetherTwinsFoodMenuManaBracer && AetherTwinsFoodMenuDualDaggers && AetherTwinsFoodMenuThrowingDagger && AetherTwinsFoodMenuTriDagger && AetherTwinsFoodMenuLustyDagger && AetherTwinsFoodMenuWitchDagger && AetherTwinsFoodMenuAngstDagger && AetherTwinsFoodMenuTin == 4 && AetherTwinsFoodMenuCopper == 4 && AetherTwinsFoodMenuIron == 4 && AetherTwinsFoodMenuSilver == 4 && AetherTwinsFoodMenuGold == 4 && AetherTwinsFoodMenuAmethyst == 2 && AetherTwinsFoodMenuDiamond == 2 && !AetherTwinsFoodMenu2)
        {
            addButton(2, "HtDagger&Shield", aethertwinsFollowersEvolutionsToHumanTierSmallWeapons);
        }
        else if (AetherTwinsFoodMenu2)
        {
            addButtonDisabled(2, "HtDagger&Shield", "They already unlocked Human-tier Dagger and Shield form.");
        }
        else
        {
            addButtonDisabled(2, "HtDagger&Shield", "They not yet ate enough nutriments to evolve into this shape.");
        }
        addButton(14, "Back", aethertwinsFollowers);
    }
    private function aethertwinsFollowersEvolutionsToHumanTierGaunlets() : Void
    {
        clearOutput();
        outputText("\"<i>Woohoo we're evolving.</i>\" they exclaim. \"<i>We're going Faster Harder Better Stronger Curvier!!!</i>\"\n\n");
        outputText("<b>The Aether Twins base form evolved unlocking some of their sealed memories.</b>\n\n");
        player.createStatusEffect(StatusEffects.AetherTwins1, 0, 5, 0, 0);
        AetherTwinsShape = "Human-tier Gaunlets";
        AetherTwinsFoodMenuTin = 0;
        AetherTwinsFoodMenuTinCap = 2;
        AetherTwinsFoodMenuCopper = 0;
        AetherTwinsFoodMenuCopperCap = 2;
        AetherTwinsFoodMenuIron = 0;
        AetherTwinsFoodMenuIronCap = 2;
        AetherTwinsFoodMenuSilver = 0;
        AetherTwinsFoodMenuSilverCap = 2;
        AetherTwinsFoodMenuGold = 0;
        AetherTwinsFoodMenuGoldCap = 2;
        AetherTwinsTalkMenu = 1;
        doNext(aethertwinsFollowers);
        cheatTime(1 / 6);
    }
    private function aethertwinsFollowersEvolutionsToSkyTierGaunlets() : Void
    {
        clearOutput();
        outputText("\"<i>Woohoo it's that feeling again... We're evolving again...</i>\" they exclaim. \"<i>We're going Faster Harder Better Stronger!!!</i>\"\n\n");
        outputText("<b>The Aether Twins base form evolved second time unlocking option to switch between current form and pre-evolution one.</b>\n\n");
        player.addStatusValue(StatusEffects.AetherTwins1, 2, 10);
        AetherTwinsShape = "Sky-tier Gaunlets";
        AetherTwinsFoodMenu1 = true;
        AetherTwinsFoodMenuTin -= 2;
        AetherTwinsFoodMenuTinCap += 2;
        AetherTwinsFoodMenuCopper -= 2;
        AetherTwinsFoodMenuCopperCap += 2;
        AetherTwinsFoodMenuIron -= 2;
        AetherTwinsFoodMenuIronCap += 2;
        AetherTwinsFoodMenuSilver -= 2;
        AetherTwinsFoodMenuSilverCap += 2;
        AetherTwinsFoodMenuGold -= 2;
        AetherTwinsFoodMenuGoldCap += 2;
        AetherTwinsFoodMenuAmethyst = 0;
        AetherTwinsFoodMenuAmethystCap = 2;
        AetherTwinsFoodMenuDiamond = 0;
        AetherTwinsFoodMenuDiamondCap = 2;
        doNext(aethertwinsFollowersMorphMain);
        cheatTime(1 / 6);
    }
    private function aethertwinsFollowersEvolutionsToHumanTierSmallWeapons() : Void
    {
        clearOutput();
        outputText("\"<i>Woohoo it's happening feeling again... We're evolving once more...</i>\" they exclaim. \"<i>We're going Faster Harder Better Stronger Sharper!!!</i>\"\n\n");
        player.addStatusValue(StatusEffects.AetherTwins1, 1, 19);
        player.addStatusValue(StatusEffects.AetherTwins1, 2, 2);
        AetherTwinsShape = "Human-tier Dagger and Shield";
        AetherTwinsFoodMenu2 = true;
        AetherTwinsFoodMenuTin -= 4;
        AetherTwinsFoodMenuTinCap += 8;
        AetherTwinsFoodMenuCopper -= 4;
        AetherTwinsFoodMenuCopperCap += 8;
        AetherTwinsFoodMenuIron -= 4;
        AetherTwinsFoodMenuIronCap += 8;
        AetherTwinsFoodMenuSilver -= 4;
        AetherTwinsFoodMenuSilverCap += 8;
        AetherTwinsFoodMenuGold -= 4;
        AetherTwinsFoodMenuGoldCap += 8;
        AetherTwinsFoodMenuAmethyst -= 2;
        AetherTwinsFoodMenuAmethystCap += 2;
        AetherTwinsFoodMenuDiamond -= 2;
        AetherTwinsFoodMenuDiamondCap += 2;
        AetherTwinsFoodMenuWorldTreeBranch = 0;
        AetherTwinsFoodMenuWorldTreeBranchCap = 4;
        AetherTwinsFoodMenuBronze = 0;
        AetherTwinsFoodMenuBronzeCap = 4;
        AetherTwinsFoodMenuMoonstone = 0;
        AetherTwinsFoodMenuMoonstoneCap = 4;
        AetherTwinsFoodMenuEbonIngot = 0;
        AetherTwinsFoodMenuEbonIngotCap = 4;
        doNext(aethertwinsFollowersMorphMain);
        cheatTime(1 / 6);
    }  /*
private function aethertwinsFollowersEvolutionsToSkyTierGaunlets():void {
	clearOutput();
	outputText("\"<i>Woohoo it's happening feeling again... We're evolving once more...</i>\" they exclaim. \"<i>We're going Faster Harder Better Stronger Sharper Bigger!!!</i>\"\n\n");
	evo to normal sized weapon(s) form(s)
	AetherTwinsFoodMenu3 = true;
	doNext(aethertwinsFollowersMorphMain);
	cheatTime(1/6);
}
private function aethertwinsFollowersEvolutionsToSkyTierGaunlets():void {
	clearOutput();
	outputText("\"<i>Woohoo it's happening feeling again... We're evolving once more...</i>\" they exclaim. \"<i>We're going Faster Harder Better Stronger Sharper Bigger Curvier!!!</i>\"\n\n");
	evo to large sized weapon(s) form(s)
	doNext(aethertwinsFollowersMorphMain);
	cheatTime(1/6);
}
private function aethertwinsFollowersEvolutionsToSkyTierGaunlets():void {
	clearOutput();
	outputText("\"<i>Woohoo it's happening feeling again... We're evolving once more...</i>\" they exclaim. \"<i>We're going Faster Harder Better Stronger Sharper Bigger Curvier Sexier!!!</i>\"\n\n");
	evo to massive sized weapon(s) form(s)
	doNext(aethertwinsFollowersMorphMain);
	cheatTime(1/6);
}*/  
    
    private function takeAetherD() : Void
    {
        clearOutput();
        var item : Weapon = player.setWeapon(weapons.AETHERD);  //Item is now the player's old weapon  
        if (item == null)
        
        // failed to equip{
            
            doNext(aethertwinsFollowers);
            return;
        }
        if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] < 2)
        {
            flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] = 2;
        }
        inventory.takeItem(item, aethertwinsFollowers);
    }
    private function takeAetherS() : Void
    {
        clearOutput();
        var item : Shield = player.setShield(shields.AETHERS);  //Item is now the player's old shield  
        if (item == null)
        
        // failed to equip{
            
            doNext(aethertwinsFollowers);
            return;
        }
        if (flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] < 2)
        {
            flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] = 2;
        }
        inventory.takeItem(item, aethertwinsFollowers);
    }
}
