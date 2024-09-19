/**
 * Created by aimozg on 10.01.14.
 */
package classes.items;

import haxe.Constraints.Function;
import classes.items.alchemy.AlchemyLib;
import classes.items.consumables.*;
import classes.Player;
import classes.races.*;
import classes.scenes.SceneLib;

@:final class ConsumableLib extends AlchemyLib
{
    private var m(get, never) : Mutations;

    //public var consumableItems:Array = [];
    
    public static inline var DEFAULT_VALUE : Float = 6;
    
    //DEMONIC POTIONS
    //Tainted
    public var INCUBID(default, never) : Consumable = mk("IncubiD", "IncubiD", "an Incubi draft", 6, "The cork-topped flask swishes with a slimy looking off-white fluid, purported to give incubi-like powers.  A stylized picture of a humanoid with a huge penis is etched into the glass.", curry(m.incubiDraft, true), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                DEFAULT_ESSENCE_DROP_TABLE(AE_DEMON, true), 
                [
                [10, AR_CORR_INC], 
                [1, AR_INT], 
                [1, AR_LIB], 
                [1, AR_SENS_INC]
        ]
        );
    public var S_DREAM(default, never) : Consumable = mk("S.Dream", "S.Dream", "a bottle of 'Succubus' Dream'", 6, "This precious fluid is often given to men a succubus intends to play with for a long time, though this batch has been enhanced by Lumi to have even greater potency.", m.succubusDream, ItemConstants.U_TF).refineableInto(
                [
                [1, AS_BALLS]
        ], [
                [1, AE_DEMON], 
                [1, AE_GROW]
        ], [
                [10, AR_CORR_INC]
        ]
        );
    public var SDELITE(default, never) : Consumable = mk("SDelite", "S.Delite", "a bottle of 'Succubi's Delight'", 6, "This precious fluid is often given to men a succubus intends to play with for a long time.", curry(m.succubisDelight, true), ItemConstants.U_TF).refineableInto(
                [
                [1, AS_BALLS]
        ], [
                [1, AE_DEMON], 
                [1, AE_GROW]
        ], [
                [10, AR_CORR_INC]
        ]
        );
    public var SUCMILK(default, never) : Consumable = mk("SucMilk", "SucMilk", "a bottle of Succubi milk", 6, "This milk-bottle is filled to the brim with a creamy white milk of dubious origin.  A pink label proudly labels it as \"<i>Succubi Milk</i>\".  In small text at the bottom of the label it reads: \"<i>To bring out the succubus in YOU!</i>\"", curry(m.succubiMilk, true), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                DEFAULT_ESSENCE_DROP_TABLE(AE_DEMON, true), 
                [
                [10, AR_CORR_INC], 
                [1, AR_INT], 
                [1, AR_LIB], 
                [1, AR_SPE], 
                [1, AR_SENS_INC]
        ], 
                DemonRace.DemonSkinColors
        );
    //Untainted
    public var P_DRAFT(default, never) : Consumable = mk("P.Draft", "P.Draft", "an untainted Incubi draft", 20, "The cork-topped flask swishes with a slimy looking off-white fluid, purported to give incubi-like powers.  A stylized picture of a humanoid with a huge penis is etched into the glass. Rathazul has purified this to prevent corruption upon use.", curry(m.incubiDraft, false), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                DEFAULT_ESSENCE_DROP_TABLE(AE_DEMON, true), 
                [
                [1, AR_INT], 
                [1, AR_LIB], 
                [1, AR_SENS_INC]
        ]
        );
    public var P_S_MLK(default, never) : Consumable = mk("P.S.Mlk", "P.S.Mlk", "an untainted bottle of Succubi milk", 20, "This milk-bottle is filled to the brim with a creamy white milk of dubious origin.  A pink label proudly labels it as \"<i>Succubi Milk</i>\".  In small text at the bottom of the label it reads: \"<i>To bring out the succubus in YOU!</i>\"  Purified by Rathazul to prevent corruption.", curry(m.succubiMilk, false), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                DEFAULT_ESSENCE_DROP_TABLE(AE_DEMON, true), 
                [
                [1, AR_INT], 
                [1, AR_LIB], 
                [1, AR_SPE], 
                [1, AR_SENS_INC]
        ], 
                DemonRace.DemonSkinColors
        );
    public var PSDELIT(default, never) : Consumable = mk("PSDelit", "PSDelit", "an untainted bottle of \"Succubi's Delight\"", 20, "This precious fluid is often given to men a succubus intends to play with for a long time.  It has been partially purified by Rathazul to prevent corruption.", curry(m.succubisDelight, false), ItemConstants.U_TF).refineableInto(
                [
                [1, AS_BALLS]
        ], [
                [1, AE_DEMON], 
                [1, AE_GROW]
        ]
        );
    
    //DYES
    public var AUBURND(default, never) : HairDye = ItemTemplateLib.instance.createHairDye("Auburn", 1);
    public var BLACK_D(default, never) : HairDye = ItemTemplateLib.instance.createHairDye("Black", 1);
    public var BLOND_D(default, never) : HairDye = ItemTemplateLib.instance.createHairDye("Blond", 1);
    public var BLUEDYE(default, never) : HairDye = ItemTemplateLib.instance.createHairDye("Blue", 1);
    public var BROWN_D(default, never) : HairDye = ItemTemplateLib.instance.createHairDye("Brown", 1);
    public var GRAYDYE(default, never) : HairDye = ItemTemplateLib.instance.createHairDye("Gray", 1);
    public var GREEN_D(default, never) : HairDye = ItemTemplateLib.instance.createHairDye("Green", 1);
    public var ORANGDY(default, never) : HairDye = ItemTemplateLib.instance.createHairDye("Orange", 1);
    public var PINKDYE(default, never) : HairDye = ItemTemplateLib.instance.createHairDye("Pink", 1);
    public var PURPDYE(default, never) : HairDye = ItemTemplateLib.instance.createHairDye("Purple", 1);
    public var RAINDYE(default, never) : HairDye = ItemTemplateLib.instance.createHairDye("Rainbow", 4);
    public var RED_DYE(default, never) : HairDye = ItemTemplateLib.instance.createHairDye("Red", 1);
    public var WHITEDY(default, never) : HairDye = ItemTemplateLib.instance.createHairDye("White", 1);
    public var RUSSDYE(default, never) : HairDye = ItemTemplateLib.instance.createHairDye("Russet", 1);
    public var YELLDYE(default, never) : HairDye = ItemTemplateLib.instance.createHairDye("Yellow", 1);
    public var GOLDB_D(default, never) : HairDye = ItemTemplateLib.instance.createHairDye("Golden Blonde", 1);
    public var SNOWW_D(default, never) : HairDye = ItemTemplateLib.instance.createHairDye("Snow White", 2);
    public var SILVDYE(default, never) : HairDye = ItemTemplateLib.instance.createHairDye("Silver", 2);
    public var GOLDDYE(default, never) : HairDye = ItemTemplateLib.instance.createHairDye("Golden", 2);
    public var QWHITED(default, never) : HairDye = ItemTemplateLib.instance.createHairDye("Quartz White", 3);
    
    //SKIN OILS & BODY LOTIONS
    public var DARK_OL(default, never) : SkinOil = ItemTemplateLib.instance.createSkinOil("dark");
    public var EBONYOL(default, never) : SkinOil = ItemTemplateLib.instance.createSkinOil("ebony");
    public var FAIR_OL(default, never) : SkinOil = ItemTemplateLib.instance.createSkinOil("fair");
    public var LIGHTOL(default, never) : SkinOil = ItemTemplateLib.instance.createSkinOil("light");
    public var MAHOGOL(default, never) : SkinOil = ItemTemplateLib.instance.createSkinOil("mahogany");
    public var OLIVEOL(default, never) : SkinOil = ItemTemplateLib.instance.createSkinOil("olive");
    public var RUSS_OL(default, never) : SkinOil = ItemTemplateLib.instance.createSkinOil("russet");
    public var TAN_OIL(default, never) : SkinOil = ItemTemplateLib.instance.createSkinOil("tan");
    
    public var CLEARLN(default, never) : BodyLotion = new BodyLotion("ClearLn", "Clear", "smooth thick creamy liquid");
    public var ROUGHLN(default, never) : BodyLotion = new BodyLotion("RoughLn", "Rough", "thick abrasive cream");
    public var SEXY_LN(default, never) : BodyLotion = new BodyLotion("SexyLtn", "Sexy", "pretty cream like substance");
    public var SMTH_LN(default, never) : BodyLotion = new BodyLotion("SmthLtn", "Smooth", "smooth thick creamy liquid");
    
    //EGGS
    //Small
    public var BLACKEG(default, never) : Consumable = mk("BlackEg", "BlackEg(Ltx)", "a rubbery black egg", 6, "This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.", curry(m.blackRubberEgg, false));
    public var BLUEEGG(default, never) : Consumable = mk("BlueEgg", "BlueEgg(-Vg)", "a blue and white mottled egg", 6, "This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.", curry(m.blueEgg, false));
    public var BROWNEG(default, never) : Consumable = mk("BrownEg", "BrownEg(Ass)", "a brown and white mottled egg", 6, "This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.", curry(m.brownEgg, false));
    public var PINKEGG(default, never) : Consumable = mk("PinkEgg", "PinkEgg(-Dk)", "a pink and white mottled egg", 6, "This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.", curry(m.pinkEgg, false));
    public var PURPLEG(default, never) : Consumable = mk("PurplEg", "PurplEg(Hip)", "a purple and white mottled egg", 6, "This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.", curry(m.purpleEgg, false));
    public var WHITEEG(default, never) : Consumable = mk("WhiteEg", "WhiteEg(Nip)", "a milky-white egg", 6, "This is an oblong egg, not much different from a chicken egg in appearance.  Something tells you it's more than just food.", curry(m.whiteEgg, false));
    //Large
    public var L_BLKEG(default, never) : Consumable = mk("L.BlkEg", "L.BlkEg", "a large rubbery black egg", 6, "This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.  For all you know, it could turn you into rubber!", curry(m.blackRubberEgg, true));
    public var L_BLUEG(default, never) : Consumable = mk("L.BluEg", "L.BluEg", "a large blue and white mottled egg", 6, "This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.", curry(m.blueEgg, true));
    public var L_BRNEG(default, never) : Consumable = mk("L.BrnEg", "L.BrnEg", "a large brown and white mottled egg", 6, "This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.", curry(m.brownEgg, true));
    public var L_PNKEG(default, never) : Consumable = mk("L.PnkEg", "L.PnkEg", "a large pink and white mottled egg", 6, "This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.", curry(m.pinkEgg, true));
    public var L_PRPEG(default, never) : Consumable = mk("L.PrpEg", "L.PrpEg", "a large purple and white mottled egg", 6, "This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.", curry(m.purpleEgg, true));
    public var L_WHTEG(default, never) : Consumable = mk("L.WhtEg", "L.WhtEg", "a large white egg", 6, "This is an oblong egg, not much different from an ostrich egg in appearance.  Something tells you it's more than just food.", curry(m.whiteEgg, true));
    //Others
    public var DRGNEGG(default, never) : Consumable = mk("DrgnEgg", "DrgnEgg", "an unfertilized dragon egg", 6, "A large, solid egg, easily the size of your clenched fist.  Its shell color is reddish-white, with blue splotches.", m.eatEmberEgg);
    public var NPNKEGG(default, never) : Consumable = mk("NPnkEgg", "NPnkEgg", "a neon pink egg", 6, "This is an oblong egg with an unnatural neon pink coloration.  It tingles in your hand with odd energies that make you feel as if you could jump straight into the sky.", curry(m.neonPinkEgg, false, 0));
    public var SNOWFLO(default, never) : Consumable = mk("SnowFlo", "SnowFlower", "a Snow Flower", 6, "This beautiful flower grows even in the frozen wastes of the Glacial Rift, defying the arctic cold.", m.alrauneSnowFlower);
    public var EMBER_F(default, never) : Consumable = mk("Ember.F", "EmberFlower", "a Ember Flower", 6, "This beautiful flower grows even in the ash of the Volcanic Crag, defying the heat.", m.alrauneEmberFlower);
    public var BLACK_L(default, never) : Consumable = mk("Black.L", "BlackLily", "a Black Lily", 6, "You obtained this rather peculiar flower from Rafflesia, and despite its corrupted origins, it probably has the best smell ever.", m.alrauneBlackLily);
    
    //FOOD & BEVERAGES
    public var AjidAji(default, never) : Consumable = mk("AjidAji", "Aji de Aji", "a bag of Aji de Aji", 6, "A small bag of Aji de Aji Peppers.", function(player : Player) : Void
                {
                    SceneLib.trollVillage.elderstore.itemsConsumed("AjidAji");
                });
    public var BC_BEER(default, never) : Consumable = mk("BC Beer", "BC Beer", "a mug of Black Cat Beer", 1, "A capped mug containing an alcoholic drink secreted from the breasts of Niamh.  It smells tasty.", function(player : Player) : Void
                {
                    SceneLib.telAdre.niamh.blackCatBeerEffects(player);
                });
    public var BHMTCUM(default, never) : Consumable = mk("BhmtCum", "BhmtCum", "a sealed bottle of behemoth cum", 15, "This bottle of behemoth cum looks thick and viscous.  You suspect that it might boost your strength and toughness.  It also has delicious taste.", m.behemothCum);
    public var BIMBOCH(default, never) : Consumable = mk("BimboCh", "BimboCh", "a bottle of bimbo champagne", 20, "A bottle of bimbo champagne. Drinking this might incur temporary bimbofication.", curry(function(player : Player) : Void
                        {
                            SceneLib.telAdre.niamh.bimboChampagne(player, true, true);
                        }));
    public var CHOCBOX(default, never) : Consumable = mk("ChocBox", "ChocBox", "a box of chocolate", 250, "A box of sweet chocolates. Maybe you can give it to someone you like?", m.boxChocolate);
    public var CCUPCAK(default, never) : Consumable = mk("CCupcak", "CCupcak", "a gigantic, chocolate cupcake", 250, "A gigantic, chocolate cupcake. You could easily get full from eating this!", m.giantChocolateCupcake);
    public var D_MORAD(default, never) : Consumable = mk("D_Morad", "D.Morada", "a bag of Dulce Morada", 6, "It appears to be a few purple-colored hard candies. It has the same color as the troll figs.\n", function(player : Player) : Void
                {
                    SceneLib.trollVillage.elderstore.itemsConsumed("D.Morada");
                });
    public var EXCMILK(default, never) : Consumable = mk("ExcMilk", "ExcMilk", "a bottle of Excellia's milk", 10, "It's a bottle of Excellia's milk. It's guaranteed to restore your body and energy.", m.excelliaMilk);
    public var FISHFIL(default, never) : Consumable = mk("FishFil", "FishFil", "a fish fillet", 10, "A perfectly cooked piece of fish.  You're not sure what type of fish is, since you're fairly certain \"delicious\" is not a valid species.", m.fishFillet);
    public var FREFISH(default, never) : Consumable = mk("FreFish", "FreshFish", "a fresh fish", 6, "A fish freshly caugh from the waters of Mareth.", m.freshFish);
    public var FR_BEER(default, never) : Consumable = mk("Fr Beer", "Fr Beer", "a mug of frothy beer", 6, "A bottle of beer from The Black Cock.", m.frothyBeer);
    public var GODMEAD(default, never) : Consumable = mk("GodMead", "GodMead", "a pint of god's mead", 20, "A horn of potent, honey-colored mead. A single whiff makes your head swim and your thoughts turn to violence and heroism.", m.godMead);
    public var H_BISCU(default, never) : Consumable = mk("H.Bisct", "H.Biscuits", "a pack of hard biscuits", 5, "These biscuits are tasteless, but they can stay edible for an exceedingly long time.", m.hardBiscuits);
    public var IZYMILK(default, never) : Consumable = mk("IzyMilk", "IzyMilk", "a bottle of Isabella's milk", 6, "This is a bottle of Isabella's milk.  Isabella seems fairly certain it will invigorate you.", m.isabellaMilk);
    public var M__MILK(default, never) : Consumable = mk("M. Milk", "M. Milk", "a clear bottle of milk from Marble", 6, "A clear bottle of milk from Marble's breasts. It smells delicious.", m.useMarbleMilk);
    public var MINOCUM(default, never) : Consumable = mk("MinoCum", "MinoCum", "a sealed bottle of minotaur cum", 60, "This bottle of minotaur cum looks thick and viscous.  You know it has narcotic properties, but aside from that its effects are relatively unknown.", curry(m.minotaurCum, false));
    public var P_M_CUM(default, never) : Consumable = mk("P.M.Cum", "P.MinoCum", "a sealed bottle of purified minotaur cum", 80, "This bottle of minotaur cum looks thick and viscous.  You know it has narcotic properties, but aside from that its effects are relatively unknown.  This bottle of cum has been purified to prevent corruption and addiction.", curry(m.minotaurCum, true));
    public var P_WHSKY(default, never) : PhoukaWhiskey = new PhoukaWhiskey();
    public var PROMEAD(default, never) : Consumable = mk("ProMead", "ProMead", "a pint of premium god's mead", 200, "A horn of super potent, honey-colored premium mead. A single whiff makes your head swim and your thoughts turn to violence and heroism.", m.proMead);
    public var PURPEAC(default, never) : Consumable = mk("PurPeac", "PurPeac", "a pure peach", 10, "This is a peach from Minerva's spring, yellowy-orange with red stripes all over it.", m.purityPeach);
    public var SHEEPMK(default, never) : Consumable = mk("SheepMk", "SheepMk", "a bottle of sheep milk", 30, "This bottle of sheep milk is said to have corruption-fighting properties.  It may be useful.", m.sheepMilk);
    public var S_WATER(default, never) : Consumable = mk("S.Water", "SpringWtr", "a waterskin filled with spring water", 30, "A waterskin full of purified water from Minerva's spring.  It's clean and clear, with a faint sweet scent to it.  You're sure it would be a very refreshing drink.", m.springWater);
    public var TRAILMX(default, never) : Consumable = mk("TrailMx", "Trail Mix", "a pack of trail mix", 20, "This mix of nuts, dried fruits and berries is lightweight, easy to store and very nutritious.", m.trailMix);
    public var URTACUM(default, never) : Consumable = mk("UrtaCum", "UrtaCum", "a sealed bottle of Urta's cum", 15, "This bottle of Urta's cum looks thick and viscous.  It's quite delicious.", m.urtaCum);
    public var W_PDDNG(default, never) : Consumable = mk("W.Pddng", "W.Pudding", "a slice of winter pudding", 35, "A slice of delicious Winter Pudding.  It smells delicious. \n\nNote: Eating this might cause antlers to grow from your head.", m.winterPudding);
    public var ZENJI_H(default, never) : Consumable = mk("Zenji H", "ZenjiHunt", "a Zenji's Hunt", 30, "Presumably the seared meat of a smaller creature, a gift from your loving troll.", m.zenjiHunt);
    public var SFILLET(default, never) : Consumable = mk("SFillet", "S.Fillet", "a Stomiidae fillet", 10, "A fish fillet made of some deep sea fish, while not very big it is packed with nutrition.", m.stomiidaeFillet);
    public var C_STEAK(default, never) : Consumable = mk("C.Steak", "C.Steak", "a Calamari Steak", 15, "A squid that’s been roasted over a fire, it seems like it would be a decent meal.", m.calamariSteak);
    public var C_JERKY(default, never) : Consumable = mk("C.Jerky", "C.Jerky", "a Coelacanth Jerky", 5, "A piece of jerky with a bit of extra salt, supposedly it’s from a deep sea fish. It keeps quite well.", m.coelacanthJerky);
    public var SIINGOT(default, never) : Consumable = mk("SIIngot", "SoftIronIngot", "a Soft Iron Ingot", 70, "An ingot of soft iron, while still hard it should be softer than most metals. (Requires Miracle Metal to use)", m.softIronIngot);
    public var L_B_BAR(default, never) : Consumable = mk("L.B.Bar", "LightBronzeBar", "a Light Bronze Bar", 120, "An ingot of light bronze, the metallic smell it gives off is quite strong. (Requires Miracle Metal to use)", m.lightBronzeBar);
    public var EAINGOT(default, never) : Consumable = mk("EAIngot", "EbonbloomAlloyIngot", "a Ebonbloom Alloy Ingot", 200, "A dark gray, metal alloy ingot which supposedly is made with Ebonbloom, you can’t help but drool at the thought of consuming this. (Requires Miracle Metal to use)", m.ebonbloomAlloyIngot);
    
    //GROWERS/SHRINKERS
    public var REDUCTO(default, never) : Consumable = new Reducto();
    public var GROPLUS(default, never) : Consumable = new GroPlus();
    public var LBSPRAY(default, never) : Consumable = new LubeSpray();
    public var SSPONGE(default, never) : Consumable = new ShimmeringSponge();
    
    //MAGIC BOOKS
    public var B__BOOK(default, never) : Consumable = new BlackBook();
    public var G__BOOK(default, never) : Consumable = new GreyBook();
    public var W__BOOK(default, never) : Consumable = new WhiteBook();
    public var RMANUSC(default, never) : Consumable = new RedManuscript();
    public var CRIMS_J(default, never) : Consumable = new CrimsonJade();
    public var POL_MID(default, never) : Consumable = mk("Pol.Mid", "Pol.Mid.Spell", "a scroll with Polar Midnight spell", 200, "This scroll, wrote down by Alvina Shadowbane, contain knowledge about Polar Midnight spell.", m.blackPolarMidnight);
    public var MET_SHO(default, never) : Consumable = mk("Met.Sho", "Met.Sho.Spell", "a tome with Meteor Shower spell", 200, "This tome, contain knowledge about Meteor Shower spell.", m.whiteMeteorShower);
    
    //MANA POTIONS
    public var VDARCON(default, never) : Consumable = mk("VDARCON", "V.D.ARC", "a very diluted Arcane Regen Concotion", 20, "This very diluted concotion could help you recover some of the spent mana.  Naturaly it won't be much but in tight situation it could make a difference between won or lost fight.", m.verydilutedarcaneregenconcotion);
    public var D_ARCON(default, never) : Consumable = mk("D_ARCON", "Dil.ARC", "a diluted Arcane Regen Concotion", 120, "This diluted concotion could help you recover some of the spent mana.  It won't be much but still a few more time more than after using very diluted concotion.", m.dilutedarcaneregenconcotion);
    public var AREGCON(default, never) : Consumable = mk("AREGCON", "ARegCon", "an Arcane Regen Concotion", 720, "This concotion could help you recover some of the spent mana.  It won't be much but still a few more time more than after using diluted concotion.", m.arcaneregenconcotion);
    
    //MAGIC STORAGES AND LOOT BAGS OF COSMOS
    public var BAGOCOS(default, never) : Consumable = mk("BagOCos", "BagOfCosmos", "a Bag of Cosmos", 1200, "It's small bag used by Soul Cultivtors covered with a complex symbols making it object that allow to store many more things that the size of itself would indicate.", m.bagofcosmos);
    public var SPPEARL(default, never) : Consumable = mk("SPPearl", "SkyPoisonPearl", "a Sky Poison Pearl", 12000, "Mysterious Pearl.", m.skypoisonpearl);  //moze jednak zmniejszyc do 6k tylko - 60 slotow po 200 gems kazdy wart = 12k (maybe reduce it to only 6k - 60 slots with 200 gems each worth = 12k)  
    public var BAGOCA1(default, never) : Consumable = mk("BagOCA1", "BagOfCosmosA1", "a Bag of Cosmos (A1)", 0, "It's small bag used by enemy Soul Cultivtor to store much more things that the size of itself would indicate. What could be in this one?", m.bagofcosmosA1);
    public var BAGOCA2(default, never) : Consumable = mk("BagOCA2", "BagOfCosmosA2", "a Bag of Cosmos (A2)", 0, "It's small bag used by enemy Soul Cultivtor to store much more things that the size of itself would indicate. What could be in this one?", m.bagofcosmosA2);
    public var BAGOCA3(default, never) : Consumable = mk("BagOCA3", "BagOfCosmosA3", "a Bag of Cosmos (A3)", 0, "It's small bag used by enemy Soul Cultivtor to store much more things that the size of itself would indicate. What could be in this one?", m.bagofcosmosA3);
    public var BAGOCA4(default, never) : Consumable = mk("BagOCA4", "BagOfCosmosA4", "a Bag of Cosmos (A4)", 0, "It's small bag used by enemy Soul Cultivtor to store much more things that the size of itself would indicate. What could be in this one?", m.bagofcosmosA4);
    public var BAGOCA5(default, never) : Consumable = mk("BagOCA5", "BagOfCosmosA5", "a Bag of Cosmos (A5)", 0, "It's small bag used by enemy Soul Cultivtor to store much more things that the size of itself would indicate. What could be in this one?", m.bagofcosmosA5);
    public var BAGOCA6(default, never) : Consumable = mk("BagOCA6", "BagOfCosmosA6", "a Bag of Cosmos (A6)", 0, "It's small bag used by enemy Soul Cultivtor to store much more things that the size of itself would indicate. What could be in this one?", m.bagofcosmosA6);
    
    //PILLS
    public var LG_SFRP(default, never) : Consumable = mk("LGSFRP", "LGSFRPill", "a low-grade Soulforce Recovery Pill", 10, "This low-grade recovery pill could help you recover some of the spent soulforce.  Naturaly it won't be much but in tight situation it could make a difference between won or lost fight.", m.lowgradesoulforcerecoverypill);
    public var LGSFRPB(default, never) : Consumable = mk("LGSFRPB", "LGSFRPBottle", "a bottle of low-grade Soulforce Recovery Pills", 110, "Those low-grade recovery pills could help you recover some of the spent soulforce.  Naturaly they won't be much but in tight situation it could make a difference between won or lost fight.", m.lowgradesoulforcerecoverypill2);
    public var MG_SFRP(default, never) : Consumable = mk("MGSFRP", "MGSFRPill", "a mid-grade Soulforce Recovery Pill", 60, "This mid-grade recovery pill could help you recover some of the spent soulforce.  It won't be much but still a few more time more than after using low-grade one version of this pill.", m.midgradesoulforcerecoverypill);
    public var MGSFRPB(default, never) : Consumable = mk("MGSFRPB", "MGSFRPBottle", "a bottle of mid-grade Soulforce Recovery Pills", 610, "Those mid-grade recovery pills could help you recover some of the spent soulforce.  They won't be much but still a few more time more than after using low-grade one version of those pills.", m.midgradesoulforcerecoverypill2);
    public var HG_SFRP(default, never) : Consumable = mk("HGSFRP", "HGSFRPill", "a high-grade Soulforce Recovery Pill", 360, "This high-grade recovery pill could hep you recover some of the spent soulforce.  It can restore significant amount of soulforce compared to lower grade pills but still it's only an aid not a replacement for regular cultivation.", m.highgradesoulforcerecoverypill);
    public var HGSFRPB(default, never) : Consumable = mk("HGSFRPB", "HGSFRPBottle", "a bottle of high-grade Soulforce Recovery Pills", 3610, "Those high-grade recovery pills could help you recover some of the spent soulforce.  They can restore significant amount of soulforce compared to lower grade pills but still it's only an aid not a replacement for regular cultivation.", m.highgradesoulforcerecoverypill2);
    public var SG_SFRP(default, never) : Consumable = mk("SGSFRP", "SuperiorGradeSFRecovPill", "a superior-grade Soulforce Recovery Pill", 2160, "This superior-grade recovery pill could hep you recover some of the spent soulforce.  Best possible to obtain pill to fast recover soulforce in tight situations when you don't have time to cultivate.", m.superiorgradesoulforcerecoverypill);
    public var SGSFRPB(default, never) : Consumable = mk("SGSFRPB", "SGSFRPBottle", "a bottle of superior-grade Soulforce Recovery Pills", 21610, "Those superior-grade recovery pills could help you recover some of the spent soulforce.  Best possible to obtain pills to fast recover soulforce in tight situations when you don't have time to cultivate.", m.superiorgradesoulforcerecoverypill2);
    public var FATPILL(default, never) : Consumable = mk("FATPILL", "FastingPill", "a Fasting Pill", 100, "This fasting pill could keep you fully/partialy from feeling hunger for a few days.", m.fasteningpill);
    
    //SOUL SKILLS MANUALS
    public var TRITMAN(default, never) : Consumable = mk("TRITMAN", "TTManual", "a manual for Triple Thrust Soulskill", 50, "This manual would teach you how to use Triple Thrust soulskill. (Phys)", m.triplethrustmanual);
    public var SEXTMAN(default, never) : Consumable = mk("SEXTMAN", "STManual", "a manual for Sextuple Thrust Soulskill", 120, "This manual would teach you how to use Sextuple Thrust soulskill. (Phys)", m.sextuplethrustmanual);
    public var NONTMAN(default, never) : Consumable = mk("NONTMAN", "NTManual", "a manual for Nonuple Thrust Soulskill", 290, "This manual would teach you how to use Nonuple Thrust soulskill. (Phys)", m.nonuplethrustmanual);
    public var MABIMAN(default, never) : Consumable = mk("MABIMAN", "MBManual", "a manual for Many Birds Soulskill", 50, "This manual would teach you how to use Many Birds soulskill. (Mag)", m.manybirdsmanual);
    public var DRASMAN(default, never) : Consumable = mk("DRASMAN", "DSManual", "a manual for Draco Sweep Soulskill", 50, "This manual would teach you how to use Draco Sweep soulskill. (Phys)", m.dracosweepmanual);
    public var COMETMA(default, never) : Consumable = mk("COMETMA", "COManual", "a manual for Comet Soulskill", 200, "This manual would teach you how to use Comet soulskill. (Mag)", m.cometmanual);
    public var VPTRMAN(default, never) : Consumable = mk("VPTRMAN", "VPTManual", "a manual for Violet Pupil Transformation Soulskill", 200, "This manual would teach you how to use Violet Pupil Transformation soulskill.", m.violetpupiltransformationmanual);
    public var SOBLMAN(default, never) : Consumable = mk("SOBLMAN", "SOBLManual", "a manual for Soul Blast Soulskill", 1000, "This manual would teach you how to use Soul Blast soulskill. (Phys)", m.soulblastmanual);
    public var FOLBMAN(default, never) : Consumable = mk("FOLBMAN", "FOLBscManual", "a manual for Flames of Love (Rankless) Soulskill", 50, "This manual would teach you how to use Flames of Love (Rankless) soulskill.", m.flamesoflovemanualrankless);
    public var IOLBMAN(default, never) : Consumable = mk("IOLBMAN", "IOLBscManual", "a manual for Icicles of Love (Rankless) Soulskill", 50, "This manual would teach you how to use Icicles of Love (Rankless) soulskill.", m.iciclesoflovemanualrankless);
    public var SOSBMAN(default, never) : Consumable = mk("SOSBMAN", "SOSBscManual", "a manual for Storm of Sisterhood (Rankless) Soulskill", 50, "This manual would teach you how to use Storm of Sisterhood (Rankless) soulskill.", m.stormofsisterhoodmanualrankless);
    public var NOBBMAN(default, never) : Consumable = mk("NOBBMAN", "NOBBscManual", "a manual for Night of Brotherhood (Rankless) Soulskill", 50, "This manual would teach you how to use Night of Brotherhood (Rankless) soulskill.", m.nightofbrotherhoodmanualrankless);
    public var DEV_MAN(default, never) : Consumable = mk("DEV_MAN", "DevourManual", "a manual for Devour Soulskill", 50, "This manual would teach you how to use Devour soulskill.", m.devourermanual);
    public var HOB1MAN(default, never) : Consumable = mk("HOB1MAN", "HoBManual", "a manual for Hail of Blades", 100, "This manual would teach you how to use Hail of Blades soulskill. (Mag)", m.hailofbladesmanual1);
    public var HOB2MAN(default, never) : Consumable = mk("HOB2MAN", "GHoBManual", "a manual for Grandiose Hail of Blades", 400, "This manual would teach you how to use Grandiose Hail of Blades soulskill. (Mag)", m.hailofbladesmanual2);
    public var HOB3MAN(default, never) : Consumable = mk("HOB3MAN", "GHoMBManual", "a manual for Grandiose Hail of Moon Blades", 1600, "This manual would teach you how to use Grandiose Hail of Moon Blades soulskill. (Mag)", m.hailofbladesmanual3);
    //public const HOB4MAN: Consumable = mk("HOB4MAN", "Manual", "a manual for Grandiose Hailstorm of Yin-Yang Blades: Endless Tide", x, ".", m.hailofbladesmanual4);secret grandmaster ver of Hail of Blades ^^
    public var CEB_MAN(default, never) : Consumable = mk("CEB_MAN", "CEBManual", "a manual for Create Element (Basic)", 100, "This manual would teach you how to use Create Element (Basic) soulskill. (Mag)", m.createelementmanual1);
    public var CEA_MAN(default, never) : Consumable = mk("CEA_MAN", "CEAManual", "a manual for Create Element (Advanced)", 400, "This manual would teach you how to use Create Element (Advanced) soulskill. (Mag)", m.createelementmanual2);
    public var S_B_MAN(default, never) : Consumable = mk("S_B_MAN", "SoarBManual", "a manual for Soaring Blades passive", 1000, "This manual would teach you Soaring Blades passive.", m.soaringbladesmanual);
    public var FAFSMAN(default, never) : Consumable = mk("FAFSMAN", "FAFSManual", "a manual for First Attack: Flying Sword technique", 1000, "This manual would teach you First Attack: Flying Sword technique.", m.firstattackflyingswordmanual);
    //public const YYB_MAN: Consumable = mk("YYB_MAN", "YYBlastManual", "a manual for Yin Yang Blast", x, "This manual would teach you how to use Yin Yang Blast combination soulskill and it components Yin Palm and Yang Fist soulskills.", m.xxx);
    public var SUNRMAN(default, never) : Consumable = mk("SUNRMAN", "SunrManual", "a manual for Sunrise", 1000, "This manual would teach you how to use Sunrise soulskill. (Mag)", m.sunrisemanual);
    /*	public const FOLXMAN: Consumable = mk("MAN", "Manual", "a manual for Flames of Love () Soulskill", x, "This manual would teach you how to use Flames of Love (... Rank) soulskill.", m.xxx);
		public const IOLXMAN: Consumable = mk("MAN", "Manual", "a manual for Icicles of Love () Soulskill", x, ".", m.xxx);
		public const SOSXMAN: Consumable = mk("MAN", "Manual", "a manual for Storm of Sisterhood () Soulskill", x, ".", m.xxx);
		public const NOBXMAN: Consumable = mk("MAN", "Manual", "a manual for Night of Brotherhood () Soulskill", x, ".", m.xxx);
		public const XXXXMAN: Consumable = mk("MAN", "Manual", "a manual for ", x, ".", m.xxx);
		public const XXXXMAN: Consumable = mk("MAN", "Manual", "a manual for ", x, ".", m.xxx);
		public const XXXXMAN: Consumable = mk("MAN", "Manual", "a manual for ", x, ".", m.xxx);*/
    
    //RARE ITEMS (Permanent effects, gives perks on consumption.)
    public var BIMBOLQ(default, never) : BimboLiqueur = new BimboLiqueur();
    public var BROBREW(default, never) : Consumable = mk("BroBrew", "BroBrew", "a can of Bro Brew", 1000, "This aluminum can is labelled as 'Bro Brew'.  It even has a picture of a muscly, bare-chested man flexing on it.  A small label in the corner displays: \"Demon General's Warning: Bro Brew's effects are as potent (and irreversible) as they are refreshing.", m.broBrew);
    public var HUMMUS2(default, never) : Consumable = mk("Hummus2", "S.Hummus", "a blob of cheesy-looking super hummus", 6, "This pile of hummus doesn't look that clean, and you really don't remember where you got it from.  It looks bland.  So bland that you feel blander just by looking at it.", m.superHummus);
    public var P_PEARL(default, never) : PurePearl = new PurePearl();
    public var EZEKFRU(default, never) : Consumable = mk("EzekFru", "EzekielFruit", "a magical fruit", 300, 
                "Evangeline gave you this fruit as means of showing her gratitude. Eating it will probably strengthen your body and mind.\n\n<b>Effect: all stats +10</b>", m.ezekielfruit
        );
    public var E3PEARL(default, never) : ElementalPearl = new ElementalPearl(3);
    public var E5PEARL(default, never) : ElementalPearl = new ElementalPearl(5);
    public var E7PEARL(default, never) : ElementalPearl = new ElementalPearl(7);
    public var DEMONME(default, never) : Consumable = mk("DemonMe", "DemonizeMe", "a bottle of Demonize Me", 300, "The oil-like dark blue substance within the bottle seems ordinary enough, as normal as unholy fluids can get.", m.demonizeme);
    
    //NON-TRANSFORMATIVE ITEMS
    public var AGILI_E(default, never) : Consumable = mk("Agil.E.", "Agility E.", "an agility elixir", 6, "This greenish elixir is supposed to increase the user’s natural swiftness and agility.", m.agilityElixir);
    public var AIRWEED(default, never) : Consumable = mk("Airweed", "Airweed", "an Airweed", 10, "Upon consumption, this magic seaweed grants water breathing for 24 hours.", m.airweed);
    public var AKBALSL(default, never) : Consumable = new AkbalSaliva();
    public var ALCTHUN(default, never) : Consumable = mk("AlcThun", "Alch.Thunder", "an Alchemical Thunder", 50, "Lightning in a bottle. Add heavy electricity damage to your weapon for a limited time upon use.", m.buffAlchemicalThunder);
    public var AMBROSA(default, never) : Consumable = new Ambrosia();
    public var BALLOFL(default, never) : BallsOfFlame = new BallsOfFlame();
    public var BALLOTD(default, never) : BallsOfTheDarkness = new BallsOfTheDarkness();
    public var BANGB_M(default, never) : MiniBangBall = new MiniBangBall();
    public var BANGBM1(default, never) : BangBallMk1 = new BangBallMk1();
    public var BANGBM2(default, never) : BangBallMk2 = new BangBallMk2();
    public var BANGBM3(default, never) : BangBallMk3 = new BangBallMk3();
    public var BAPILL_(default, never) : Consumable = mk("BAPill", "Big Angry Pill", "a big angry pill", 125, "A big pill that's guaranteed to makes you a bit more angry.", m.bigangrypill);
    public var BCHCAKE(default, never) : Consumable = mk("BChCake", "BigChocolateCake", "a Big chocolate cake", 30, "A decadent-looking chocolate cake found primarily in wonderland.", m.bigChocolateCake);
    public var BH_PILL(default, never) : Consumable = mk("BH.Pill", "B.Heal Pill", "a big healing pill", 42, "A big healing pill that's guaranteed to heal you by a bit.", m.bighealpill);
    public var C__MINT(default, never) : Consumable = new Mint();
    public var CERUL_P(default, never) : Consumable = new CeruleanPotion();
    public var COAL___(default, never) : Consumable = new Coal();
    public var CFISHS(default, never) : Consumable = mk("CFishS.", "Cold Fish S.", "a bowl of cold fish soup", 20, "A soup made with fishes from the glacial rift. It is served cold to preserve the flavor and supposed calming effect which act as a lustkiller.", m.coldFishSoup);
    //	public const DAO_DEW: Consumable = mk("Dao Dew", "Dao Dew", "a cup of vixen tea", 15, "An exotic tea made by kitsunes. This herbal infusion is rumored to improve your expertise and expand your sexual knowledge.", m.daoDew);
    public var DEBIMBO(default, never) : DeBimbo = new DeBimbo();
    public var EXTSERM(default, never) : HairExtensionSerum = new HairExtensionSerum();
    public var F_DRAFT(default, never) : Consumable = mk("F.Draft", "FuckDraft", "a vial of roiling red fluid labeled \"Fuck Draft\"", 6, "This vial of red fluid bubbles constantly inside the glass, as if eager to escape.  It smells very strongly, though its odor is difficult to identify.  The word \"Fuck\" is inscribed on the side of the vial.", curry(m.lustDraft, true));
    public var FROZENB(default, never) : FrozenBalls = new FrozenBalls();
    public var H_PILL(default, never) : Consumable = new HealPill();
    public var HRBCNT(default, never) : Consumable = new HerbalContraceptive();
    public var INCOINS(default, never) : Consumable = mk("IncOIns", "IncenOfIns", "an incense of Insight", 15, "These sticks, when burned, are rumored to fill an area with an incense that allows for deep meditation and granting greater insight.", m.incenseOfInsight);
    public var ICICLE_(default, never) : Consumable = new IceShard();
    public var KITGIFT(default, never) : KitsuneGift = new KitsuneGift();
    public var LETHITE(default, never) : Lethite = new Lethite();
    public var LETH1TE(default, never) : Leth1te = new Leth1te();
    public var LETH2TE(default, never) : Leth2te = new Leth2te();
    public var LETH3TE(default, never) : Leth3te = new Leth3te();
    public var L_DRAFT(default, never) : Consumable = mk("L.Draft", "LustDraft", "a vial of roiling bubble-gum pink fluid", 20, "This vial of bright pink fluid bubbles constantly inside the glass, as if eager to escape.  It smells very sweet, and has \"Lust\" inscribed on the side of the vial.", curry(m.lustDraft, false));
    public var LACTAID(default, never) : Consumable = new Lactaid();
    public var LUSTSTK(default, never) : LustStick = new LustStick();
    public var MADMENK(default, never) : Consumable = mk("MadmenK", "MadmenKnowledge", "a Madmen knowledge", 100, "A bottle filled with the raw knowledge of an insane person. Every now and then insane people speak a truth unavailable to sane folks, having glimpsed into something only they can see. Knowledge is power but power is corrupt and can, with time, break even the most steeled of minds.", m.madmenKnowledge);
    public var MANUP_B(default, never) : Consumable = mk("ManUp B", "ManUp B.", "a ManUp beer", 6, "A beverage made for people who believe brawn is better than brains.", m.manUpBeer);
    public var MAPILL_(default, never) : Consumable = mk("MAPill", "Medium Angry Pill", "a medium angry pill", 50, "A medium pill that's guaranteed to makes you a bit more angry.", m.mediumangrypill);
    public var MH_PILL(default, never) : Consumable = mk("MH.Pill", "M.Heal Pill", "a medium healing pill", 15, "A medium healing pill that's guaranteed to heal you by a bit.", m.mediumhealpill);
    public var MILKPTN(default, never) : Consumable = new MilkPotion();
    public var MIND_UP(default, never) : MindUp = new MindUp();
    public var NUMBCND(default, never) : Consumable = mk("NumbCnd", "Numb Candies", "a strange packet of 'Numb Candies'", 40, "This packet of innocuous looking 'candy' guarantees to reduce troublesome hear or rut and taste delicious.", m.numbCandies);
    public var NUMBROX(default, never) : Consumable = new NumbRocks();
    public var NUMBOIL(default, never) : Consumable = new NumbingOil();
    public var OVIELIX(default, never) : OvipositionElixir = new OvipositionElixir();
    public var PEPPWHT(default, never) : Consumable = mk("PeppWht", "PeppWht", "a vial of peppermint white", 120, "This tightly corked glass bottle gives of a pepperminty smell and reminds you of the winter holidays.  How odd.", m.peppermintwhite);
    public var PODBONE(default, never) : Consumable = mk("PODBone", "pack of demon bones", "a pack of demon bones", 20, "It looks like a pack of demon bones that may still have between 1 and 10 demon bones inside.", m.packOfDemonBones);
    public var POISONB(default, never) : PoisonedBalls = new PoisonedBalls();
    public var PONAILS(default, never) : Consumable = mk("PONails", "pack of nails", "a pack of nails", 20, "It looks like a pack of nails that may still have between 10 and 30 nails inside.", m.packOfNails);
    public var PPHILTR(default, never) : Consumable = new PurityPhilter();
    public var PRNPKR(default, never) : Consumable = new PrincessPucker();
    public var SAPILL_(default, never) : Consumable = mk("SAPill", "Small Angry Pill", "a small angry pill", 20, "A small pill that's guaranteed to makes you a bit more angry.", m.smallangrypill);
    public var SENSDRF(default, never) : Consumable = new SensitivityDraft();
    public var SMART_T(default, never) : Consumable = new ScholarsTea();
    public var STRASCA(default, never) : Consumable = mk("StraSCa", "StrawberryShortcake", "a Strawberry shortcake", 30, "A delicious-looking shortcake found primarily in wonderland.", m.strawberryShortcake);
    public var TCLEAVE(default, never) : Consumable = mk("TCleave", "TCleave", "a tome for Cleave special", 10, "This tome would teach you how to use Cleave special.", m.tomeofcleave);
    public var THUNDBl(default, never) : ThunderBalls = new ThunderBalls();
    public var VITAL_T(default, never) : Consumable = new VitalityTincture();
    public var VIXEN_T(default, never) : Consumable = mk("Vixen T", "Vixen T.", "a cup of vixen tea", 15, "An exotic tea made by kitsunes. This herbal infusion is rumored to improve your expertise and expand your sexual knowledge.", m.vixenTea);
    public var W_STICK(default, never) : WingStick = new WingStick();
    //Aqua Seed - prawdopodobnie nazwa dla Siren TF ; Bubble Lemonade - nazwa dla Dark Slime TF
    
    //TRANSFORMATIVE ITEMS
    
    public var ABYSSIN(default, never) : Consumable = mk("AbyssIn", "AbyssalInk", "a vial of abyssal ink", 20, "Black abyssal ink normaly used for writing consuming this doesnt seem like the best idea.", curry(m.krakenInk, 0), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                MULTIRACE_ESSENCE_DROP_TABLE(
                        AE_SCYLLA, 
                        AE_KRAKEN
            ), [
                [1, AR_INT], 
                [1, AR_STR]
        ], ["ghostly white"]
        );
    public var ABYSGIN(default, never) : Consumable = mk("AbysGIn", "AbyssalGreyInk", "a vial of grey abyssal ink", 40, "Grey abyssal ink normaly used for writing consuming this doesnt seem like the best idea.", curry(m.krakenInk, 1), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                MULTIRACE_ESSENCE_DROP_TABLE(
                        AE_SCYLLA, 
                        AE_KRAKEN
            ), [
                [1, AR_INT], 
                [1, AR_STR]
        ], ["ghostly white"]
        );
    public var ABYSWIN(default, never) : Consumable = mk("AbysWIn", "AbyssalWhiteInk", "a vial of white abyssal ink", 60, "White abyssal ink normaly used for writing consuming this doesnt seem like the best idea.", curry(m.krakenInk, 2), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                MULTIRACE_ESSENCE_DROP_TABLE(
                        AE_SCYLLA, 
                        AE_KRAKEN
            ), [
                [1, AR_INT], 
                [1, AR_STR]
        ], ["ghostly white"]
        );
    public var ALICORN(default, never) : AbstractEquinum = new AbstractEquinum(2, "Alicorn", "Alicornum", "a vial of Alicornum", 200, "This is a long flared vial with a small label that reads, \"<i>Alicornum</i>\".  It is likely this potion is tied to alicorns in some way.");
    public var AQUSEED(default, never) : Consumable = mk("AquSeed", "AquaSeed", "an aqua seed", 20, "This seed looks and smells absolutely delicious.  Though it has an unusual color, the harpies prize these nuts as delicious treats.  Eating one might induce some physical transformations.", curry(m.goldenSeed, 0), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                MULTIRACE_ESSENCE_DROP_TABLE(AE_SHARK, AE_HARPY, AE_SIREN), 
                [
                [1, AR_STR], 
                [1, AR_SPE], 
                [1, AR_LIB]
        ]
        );
    public var ASKIRIN(default, never) : AsumaKirin = new AsumaKirin();
    public var ASTOOTH(default, never) : Consumable = mk("ASTooth", "ASTooth", "a gloomy abyssal shark tooth", 20, "This looks like a normal shark tooth, though enveloped with darkness.", curry(m.sharkTooth, 2), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_ABYSSAL_SHARK), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_STR], 
                [1, AR_WIS], 
                [1, AR_SPE]
        ], 
                concatUnique(AbyssalSharkRace.AbyssalSharkHairColors, AbyssalSharkRace.AbyssalSharkScaleColors)
        );
    public var B_GOSSR(default, never) : Consumable = mk("B.Gossr", "B.Gossr", "a bundle of black, gossamer webbing", 6, "These strands of gooey black gossamer seem quite unlike the normal silk that driders produce.  It smells sweet and is clearly edible, but who knows what it might do to you?", curry(m.sweetGossamer, 1), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                MULTIRACE_ESSENCE_DROP_TABLE(AE_DRIDER, AE_SPIDER)
        );
    public var BAYRLEA(default, never) : Consumable = mk("BayrLea", "Bayr leaf", "a Bayr leaf", 6, "This small leaf shaped like a bear paw can be made into a tea or used as a seasoning.", m.bayrleaf, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_BEAR), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_STR], 
                [1, AR_TOU]
        ]
        );
    public var BEEHONY(default, never) : BeeHoney = new BeeHoney(false, false);
    public var BLACKIN(default, never) : Consumable = mk("BlackIn", "BlackInk", "a vial of black ink", 10, "Pitch black ink normaly used for writing. Consuming this doesnt seem like the best idea.", curry(m.scyllaInk, 0), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_SCYLLA), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_STR], 
                [1, AR_SPE], 
                [1, AR_INT]
        ]
        );
    public var BLACKPP(default, never) : Consumable = mk("BlackPp", "BlackPp", "a solid black canine pepper", 10, "This solid black canine pepper is smooth and shiny, but something about it doesn't seem quite right...", curry(m.caninePepper, 3), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_DOG), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_LIB], 
                [1, AR_STR], 
                [1, AR_SPE], 
                [1, AR_TOU]
        ]
        );
    public var BLADEGR(default, never) : Consumable = mk("BladeGr", "BladeGrass", "a blade shaped grass", 6, "A form of herb normaly infused in samurai and other warrior tea.  You think infusing this unprocessed item in your tea could result in interesting result.", m.bladeGrass, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_MANTIS), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_LIB], 
                [1, AR_SPE], 
                [1, AR_INT]
        ], 
                MantisRace.MantisChitinColors
        );
    public var BOARTRU(default, never) : Consumable = mk("BoarTru", "BoarTruffle", "a boar truffle", 6, "It’s clear where the pigtail truffle gets its name.  A small, curly sprig resembling a pig’s tail can be seen jutting out of it. Now that it’s been enhanced by Lumi, it’s larger and fuzzier than it was before, almost like a peach.", curry(m.pigTruffle, true), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_PIG), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_STR], 
                [1, AR_LIB]
        ]
        );
    public var BUBBLEG(default, never) : Consumable = mk("B.Gum", "B.Gum", "a Bubblegum candy", 6, "A somewhat innocent pink spherical candy favored by cancers.", m.bubblegum, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_CANCER), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_STR], 
                [1, AR_LIB]
        ]
        );
    public var BULBYPP(default, never) : Consumable = mk("BulbyPp", "BulbyPp", "a bulbous pepper", 10, "This bulbous pepper has a slightly different shape than the other canine peppers, with two large orb-like protrusions at the base.", curry(m.caninePepper, 5), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_DOG), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_LIB], 
                [1, AR_STR], 
                [1, AR_SPE], 
                [1, AR_TOU]
        ]
        );
    public var C_VEMOM(default, never) : CentipedeVenom = new CentipedeVenom();
    public var CANINEP(default, never) : Consumable = mk("CanineP", "CanineP", "a Canine pepper", 6, "The pepper is shiny and red, bulbous at the base but long and narrow at the tip.  It smells spicy.", curry(m.caninePepper, 0), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_DOG), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_LIB], 
                [1, AR_STR], 
                [1, AR_SPE], 
                [1, AR_TOU]
        ]
        );
    public var CENTARI(default, never) : Centaurinum = new Centaurinum();
    public var CHILLYP(default, never) : Consumable = mk("ChillyP", "ChillyPp", "a Chilly pepper", 10, "This pepper is positively shrouded with a thin layer of ice.", m.chillyPepper, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                MULTIRACE_ESSENCE_DROP_TABLE(AE_FENRIR, AE_WOLF), 
                [
                [1, AR_LIB], 
                [1, AR_STR], 
                [1, AR_SPE], 
                [1, AR_TOU]
        ]
        );
    public var COUAOIL(default, never) : Consumable = mk("CouaOil", "CouatlOil", "a vial of couatl oil", 20, "A vial the size of your fist made of dark blue glass. It contains what appears to be an oily, red liquid. The odor is strange.", curry(m.evolvedNagaOil, 2), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                MULTIRACE_ESSENCE_DROP_TABLE(AE_COUATL, AE_SNAKE, AE_HARPY), 
                [
                [1, AR_SPE], 
                [1, AR_TOU], 
                [1, AR_LIB]
        ]
        );
    public var D_FRUIT(default, never) : Consumable = mk("D.Fruit", "D.Fruit", "a Displacement Fruit", 25, "This weird fruit is said to taste completely otherworldly. They grow in only the weirdest of place. Highly favored by displacer beasts.", m.displacementFruit, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_DISPLACER_BEAST), DEFAULT_ESSENCE_DROP_TABLE)
        );
    public var DBLPEPP(default, never) : Consumable = mk("DblPepp", "DblPepp", "a double canine pepper", 10, "This canine pepper is actually two that have grown together due to some freak coincidence.", curry(m.caninePepper, 2), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_DOG), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_LIB], 
                [1, AR_STR], 
                [1, AR_SPE], 
                [1, AR_TOU]
        ]
        );
    public var DESERTB(default, never) : Consumable = mk("DesertB", "Desert Berry", "a desert berry", 20, "This small orange berry is light in your hands.  It may have gotten its name from been founded usualy in desert regions.  You're certain it is no mere fruit.", m.desertBerry, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_WEREFOX), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_TOU], 
                [1, AR_SPE], 
                [1, AR_WIS]
        ], 
                concatUnique(
                        FoxRace.FoxHairColors, 
                        FoxRace.FoxFurColors
            )
        );
    public var DSLIMEJ(default, never) : Consumable = mk("DSlimeJ", "DarkSlimeJelly", "a Dark slime jelly", 20, "This looks to be a chunk of inert goop from a dark slime. Consuming this thing may have a weird effect on you.", curry(m.gooGasmic, 2), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                MULTIRACE_ESSENCE_DROP_TABLE(AE_GOO, AE_DARK_SLIME), 
                [], 
                DarkSlimeRace.DarkSlimeSkinColors
        );
    public var DRAKHRT(default, never) : Consumable = mk("DrakHrt", "DrakeHeart", "a drake's heart's flower", 50, "A rare, beautiful flower.  It could make an exquisite perfume.  According to a legend, dragons give this flower to the ones they intend to court.", curry(m.drakeHeart), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_DRAGON), DEFAULT_ESSENCE_DROP_TABLE), 
                [], 
                DragonRace.DragonScaleColors
        );
    public var DRYTENT(default, never) : Consumable = mk("DryTent", "DryTent", "a shriveled tentacle", 6, "A dried tentacle from one of the lake anemones.  It's probably edible, but the stingers are still a little active.", m.shriveledTentacle, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_ANEMONE), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_TOU]
        ]
        );
    public var ECTOPLS(default, never) : Consumable = mk("EctoPls", "EctoPls", "a bottle of ectoplasm", 6, "The green-tinted, hardly corporeal substance flows like a liquid inside its container. It makes you feel... uncomfortable, as you observe it.", curry(m.ectoplasm, 0), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_GHOST), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_INT], 
                [1, AR_LIB]
        ]
        );
    public var ELFEARS(default, never) : Consumable = mk("ElfEars", "ElfEars", "a Fae ear shaped plant", 6, "A plant that looks like a pointed Fae ear. Upon further inspection, the plant is very delicate and seems to radiate some sort of magical energy.", m.elfears, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                DEFAULT_ESSENCE_DROP_TABLE(AE_ELF, true), 
                [
                [1, AR_SPE], 
                [1, AR_INT]
        ], 
                concatUnique(
                        ElfRace.ElfHairColors, 
                        ElfRace.ElfSkinColors
            )
        );
    public var ENIGMANIUM(default, never) : Enigmanium = new Enigmanium();
    public var EQUINUM(default, never) : AbstractEquinum = new AbstractEquinum(0, "Equinum", "Equinum", "a vial of Equinum", 6, "This is a long flared vial with a small label that reads, \"<i>Equinum</i>\".  It is likely this potion is tied to horses in some way.");
    public var EYEDROP(default, never) : Consumable = mk("EyeDrop", "EyeDrop", "a bottle of eye drops", 50, "A bottle of medicinal eye drops for when a person has sight issues. May have strange effects on offworlders.", curry(m.eyeDrops, 0), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_CYCLOP), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_STR], 
                [1, AR_INT], 
                [1, AR_TOU], 
                [1, AR_LIB]
        ], 
                concatUnique(
                        GazerRace.GazerHairColors, 
                        GazerRace.GazerSkinColors
            )
        );
    public var F_TEAR(default, never) : Consumable = mk("F.Tear", "FafnirTear", "a Fafnir Tear", 15, "This beautiful flower only grows in the snow. It somehow digs its way and survives even in the harsh climate of the rift.", m.FafnirTear, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_FROST_WYRM), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_TOU], 
                [1, AR_SPE], 
                [1, AR_LIB]
        ]
        );
    public var FIERYS_(default, never) : Consumable = mk("FieryS", "FieryS.", "Fiery saké", 10, "A strong alcoholic beverage best served hot. The Hinezumi drink of this regularly.", curry(m.mouseCocoa, 1), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                MULTIRACE_ESSENCE_DROP_TABLE(AE_HINEZUMI, AE_MOUSE)
        );
    public var FCARROT(default, never) : Consumable = mk("FCarrot", "FlaredCarrot", "a Flared Carrot", 6, "A staple food loved both by bunny and horse morph. May have transformative properties when eaten raw.", curry(m.neonPinkEgg, false, 1));
    public var FOXBERY(default, never) : Consumable = mk("FoxBery", "Fox Berry", "a fox berry", 6, "This large orange berry is heavy in your hands.  It may have gotten its name from its bright orange coloration.  You're certain it is no mere fruit.", curry(m.foxTF, false), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_FOX), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_INT], 
                [1, AR_LIB]
        ], 
                concatUnique(
                        FoxRace.FoxHairColors, 
                        FoxRace.FoxFurColors
            )
        );
    public var FRRTFRT(default, never) : Consumable = mk("Frrtfrt", "FerretFrt", "a ferret fruit", 6, "This fruit is curved oddly, just like the tree it came from.  The skin is fuzzy and brown, like the skin of a peach.", m.ferretTF, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_FERRET), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_SPE]
        ]
        );
    public var FOXJEWL(default, never) : Consumable = mk("FoxJewl", "Fox Jewel", "a fox jewel", 50, "A shining teardrop-shaped jewel.  An eerie blue flame dances beneath the surface.", curry(m.foxJewel, false), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                MULTIRACE_ESSENCE_DROP_TABLE(AE_KITSUNE, AE_KITSUNE, AE_FOX, AE_HUMAN), 
                [
                [1, AR_INT], 
                [1, AR_WIS], 
                [1, AR_LIB]
        ], 
                concatUnique(
                        KitsuneRace.BasicKitsuneHairColors, 
                        KitsuneRace.BasicKitsuneFurColors, 
                        KitsuneRace.BasicKitsuneSkinColors
            )
        );
    public var FSNAILS(default, never) : Consumable = mk("FSnailS", "FireSnailSaliva", "a Fire snail Saliva", 20, "The saliva of a fire snail. Highly volatile.", m.firesnailsaliva, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_FIRE_SNAIL), DEFAULT_ESSENCE_DROP_TABLE)
        );
    public var G_FRUIT(default, never) : Consumable = mk("G.Fruit", "G.Fruit", "a Ghastly fruit", 10, "A ghastly whisker fruit from some underground place. Legends even says they may been growing in netherwold. Highly favored by nekomata.", m.ghastlyFruit, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                MULTIRACE_ESSENCE_DROP_TABLE(AE_NEKOMATA, AE_CAT)
        );
    public var GLDRIND(default, never) : GoldenRind = new GoldenRind();
    public var GORGOIL(default, never) : Consumable = mk("GorgOil", "GorgonOil", "a vial of gorgon oil", 20, "A vial the size of your fist made of dark green glass. It contains what appears to be oily, greenish liquid. The odor is foul.", curry(m.evolvedNagaOil, 0), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                MULTIRACE_ESSENCE_DROP_TABLE(AE_GORGON, AE_SNAKE), 
                [
                [1, AR_SPE], 
                [1, AR_TOU], 
                [1, AR_LIB]
        ]
        );
    public var GREYINK(default, never) : Consumable = mk("GreyInk", "GreyInk", "a vial of grey ink", 30, "Ash grey ink normaly used for writing consuming this doesnt seem like the best idea.", curry(m.scyllaInk, 1), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_SCYLLA), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_STR], 
                [1, AR_SPE], 
                [1, AR_INT]
        ]
        );
    public var GLDSEED(default, never) : Consumable = mk("GldSeed", "GoldenSeed", "a golden seed", 6, "This seed looks and smells absolutely delicious.  Though it has an unusual color, the harpies prize these nuts as delicious treats.  Eating one might induce some physical transformations.", curry(m.goldenSeed, 0), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_HARPY), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_SPE], 
                [1, AR_STR], 
                [1, AR_LIB]
        ], 
                HumanRace.HumanSkinColors
        );
    public var GOB_ALE(default, never) : Consumable = mk("Gob.Ale", "Gob.Ale", "a flagon of potent goblin ale", 6, "This sealed flagon of 'Goblin Ale' sloshes noisily with alcoholic brew.  Judging by the markings on the flagon, it's a VERY strong drink, and not to be trifled with.", m.goblinAle, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                [
                [10, AE_GOBLIN], 
                [2, AE_HUMAN], 
                [2, AE_SHRINK], 
                [1, AE_REMOVE]
        ], 
                [
                [1, AR_SPE]
        ], concatUnique(
                        GoblinRace.GoblinHairColors, 
                        GoblinRace.GoblinEyeColors, 
                        GoblinRace.GoblinSkinColors, 
                        GoblinRace.GoblinRareSkinColors
            )
        );
    public var GRE_BER(default, never) : Consumable = mk("Gre.Beer", "Gre.Beer", "a flagon of potent gremlin beer", 6, "This disgusting brew is made from the combination of goblin ale and incubi draft. It smells of old engine oil and rust, let’s hope it does not taste like that as well.", m.gremlinBeer, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_GREMLIN), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_SPE]
        ], 
                concatUnique(
                        GremlinRace.GremlinEyeColors, 
                        GremlinRace.GremlinHairColors, 
                        GremlinRace.GremlinSkinColors
            )
        );
    public var HDEWCAK(default, never) : HoneydewCake = new HoneydewCake();
    public var HUMMUS_(default, never) : Consumable = mk("Hummus ", "Hummus", "a blob of cheesy-looking hummus", 100, "This pile of hummus doesn't look that clean.  It looks bland.  So bland that you feel blander just by looking at it.", m.regularHummus, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                [
                [1, AE_HUMAN]
        ]
        );
    public var HYDRASC(default, never) : Consumable = mk("HydraSc", "HydraScale", "a hydra scale", 75, "The scale of a hydra. There is no telling of what it could do to you should you decide to use it.", curry(m.evolvedNagaOil, 3), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_HYDRA), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_SPE], 
                [1, AR_TOU], 
                [1, AR_LIB]
        ]
        );
    public var ICY_FIG(default, never) : Consumable = mk("Icy Fig", "Icy Fig", "an Icy Fig", 12, "A frozen fig that's a common delicacy among trolls that live in cold regions, it’s said that it infuses the consumer with tremendous insight.", curry(m.trollFig, 1), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_GLACIAL_TROLL), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_STR], 
                [1, AR_TOU], 
                [1, AR_WIS]
        ]
        );
    public var IMPFOOD(default, never) : Consumable = mk("ImpFood", "ImpFood", "a parcel of imp food", 6, "This is a small parcel of reddish-brown bread stuffed with some kind of meat.  It smells delicious.", m.impFood, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_IMP), DEFAULT_ESSENCE_DROP_TABLE), 
                [], 
                concatUnique(
                        ImpRace.ImpEyeColors, 
                        ImpRace.ImpHairColors, 
                        ImpRace.ImpSkinColors, 
                        ImpRace.ImpRareSkinColors
            )
        );
    public var INFWINE(default, never) : Consumable = mk("InfWine", "InfWine", "a bottle of infernal wine", 500, "This drink is made from a bottle of satyr wine, an incubus draft, and some succubus milk. It reeks of corruption. Are you sure it would be a smart idea to drink this?", m.infernalWine, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_DEVIL), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_INT], 
                [1, AR_LIB]
        ]
        );
    public var JABBERS(default, never) : Consumable = mk("JabberS", "JabberS", "a Jabberwocky scale", 100, "A scale of the so called rabbit dragon. It emits a faint glow of residual magic but are you sure you should be eating this?", m.jabberwockyScale, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_JABBERWOCKY), DEFAULT_ESSENCE_DROP_TABLE)
        );
    public var JACKALD(default, never) : Consumable = mk("JackalD", "JackalD", "a Jackal Date", 10, "A fruit found in the desert commonly eaten by its denizen. A favorite of the jackal like anubi.", m.jackalDate, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_ANUBIS), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_TOU], 
                [1, AR_WIS], 
                [1, AR_LIB]
        ]
        );
    public var KANGAFT(default, never) : Consumable = mk("KangaFt", "KangaFruit", "a piece of kanga fruit", 6, "A yellow, fibrous, tubular pod.  A split in the end reveals many lumpy, small seeds inside.  The smell of mild fermentation wafts from them.", curry(m.kangaFruit, 0), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_KANGAROO), DEFAULT_ESSENCE_DROP_TABLE)
        );
    public var KNOTTYP(default, never) : Consumable = mk("KnottyP", "KnottyP", "a knotty canine pepper", 10, "This knotted pepper is very swollen, with a massive, distended knot near the base.", curry(m.caninePepper, 4), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_DOG), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_LIB], 
                [1, AR_STR], 
                [1, AR_SPE], 
                [1, AR_TOU]
        ]
        );
    public var LABOVA_(default, never) : Consumable = mk("LaBova ", "La Bova", "a bottle containing a misty fluid labeled \"LaBova\"", 6, "A bottle containing a misty fluid with a grainy texture. It has a long neck and a ball-like base.  The label has a stylized picture of a well endowed cowgirl nursing two guys while they jerk themselves off.", curry(m.laBova, true, false), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                DEFAULT_ESSENCE_DROP_TABLE(AE_COW, true), 
                [
                [1, AR_STR], 
                [1, AR_TOU], 
                [1, AR_SPE]
        ]
        );
    public var LARGEPP(default, never) : Consumable = mk("LargePp", "LargePp", "an overly large canine pepper", 10, "This large canine pepper is much bigger than any normal peppers you've seen.", curry(m.caninePepper, 1), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_DOG), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_LIB], 
                [1, AR_STR], 
                [1, AR_SPE], 
                [1, AR_TOU]
        ]
        );
    public var LEVISUN(default, never) : Consumable = mk("LeviSun", "LeviSunscr", "a bottle of Leviathan Sunscreen", 6, "Seriously sea dragons use sunscreen too? You thought with all the scales they would not need such a thing to protect their pretty skin.", curry(m.orcaSunscreen, 1), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                MULTIRACE_ESSENCE_DROP_TABLE(AE_LEVIATHAN, AE_ORCA), 
                [
                [1, AR_STR], 
                [1, AR_SPE], 
                [1, AR_TOU]
        ]
        );
    public var M_GOSSR(default, never) : Consumable = mk("M.Gossr", "M.Gossr", "a bundle of midnight black gossamer webbing", 50, "This strange webbing is darker than night. It's so thick that light fails to get through it. It likely would be most unwise to consume it.", m.midnightGossamer, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                MULTIRACE_ESSENCE_DROP_TABLE(AE_ATLACH_NACHA, AE_SPIDER)
        );
    public var MAGSEED(default, never) : Consumable = mk("MagSeed", "MagSeed", "a magically-enhanced golden seed", 6, "This seed glows with power.  It's been enhanced by Lumi to unlock its full potential, allowing it to transform you more easily.", curry(m.goldenSeed, 1), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                [[1, AE_HARPY]], 
                [
                [1, AR_STR], 
                [1, AR_SPE], 
                [1, AR_LIB]
        ], 
                HumanRace.HumanSkinColors
        );
    public var MARAFRU(default, never) : MaraFruit = new MaraFruit();
    public var MANTICV(default, never) : ManticoreVenom = new ManticoreVenom();
    public var METHIRC(default, never) : Consumable = mk("MethirC", "MethirCryst", "a methir crystal", 6, "This fluorescent crystal grows near cave wyrm's nests, it looks edible.", m.methircrystal, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_CAVE_WYRM), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_STR], 
                [1, AR_TOU], 
                [1, AR_LIB]
        ]
        );
    public var ME_DROP(default, never) : Consumable = mk("ME Drop", "M.EyeDrop", "a bottle of magic eye drops", 50, "A bottle of medicinal eye drops for when a person has sight issues. It has been enhanced by powerful magic and may have severe secondary effects on offworlders.", curry(m.eyeDrops, 1), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                MULTIRACE_ESSENCE_DROP_TABLE(AE_GAZER, AE_CYCLOP), 
                [
                [1, AR_STR], 
                [1, AR_TOU], 
                [1, AR_INT], 
                [1, AR_LIB]
        ], 
                concatUnique(
                        GazerRace.GazerHairColors, 
                        GazerRace.GazerSkinColors
            )
        );
    public var MGHTYVG(default, never) : Consumable = mk("MghtyVg", "MghtyVg", "a mightily enhanced piece of kanga fruit", 6, "A yellow, fibrous, tubular pod.  A split in the end reveals many lumpy, small seeds inside.  The smell of mild fermentation wafts from them.  It glows slightly from Lumi's enhancements.", curry(m.kangaFruit, 1), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                [[1, KANGAFT]]
        );
    public var MINOBLO(default, never) : MinotaurBlood = new MinotaurBlood();
    public var MOTHDUS(default, never) : MothDust = new MothDust();
    public var MOUSECO(default, never) : Consumable = mk("MouseCo", "MouseCo", "a handful of mouse cocoa", 6, "A handful of rare aromatic beans with sharp creases in the middle, making them look like small mouse ears.  Allegedly very popular and plentiful before the mice-folk were wiped out.", curry(m.mouseCocoa, 0), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AlchemyLib.AE_MOUSE), MULTIRACE_ESSENCE_DROP_TABLE), 
                [
                [1, AR_SPE]
        ]
        );
    public var MYSTJWL(default, never) : Consumable = mk("MystJwl", "MystJwl", "a mystic jewel", 50, "The flames within this jewel glow brighter than before, and have taken on a sinister purple hue.  It has been enhanced to increase its potency, allowing it to transform you more easily, but may have odd side-effects...", curry(m.foxJewel, true), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                MULTIRACE_ESSENCE_DROP_TABLE(AE_KITSUNE, AE_KITSUNE, AE_FOX, AE_HUMAN), 
                [
                [1, AR_INT], 
                [1, AR_WIS], 
                [1, AR_LIB], 
                [1, AR_CORR_INC]
        ], 
                concatUnique(
                        KitsuneRace.ElderKitsuneSkinColors, 
                        KitsuneRace.ElderKitsuneColors
            )
        );
    public var NOCELIQ(default, never) : Consumable = mk("NoceLiq", "NocelloLiq", "a bottle of Nocello Liquer", 20, "This bottle contain sweet liquer called 'Nocello', which one sip can makes your stomach feel warm even in middle of glacial rift.  It looks to be just hazelnut flavored alcohol or there is more to it?", m.nocelloliquer, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                MULTIRACE_ESSENCE_DROP_TABLE(AE_PHOENIX, AE_PHOENIX, AE_SALAMANDER, AE_HARPY), 
                [
                [1, AR_SPE], 
                [1, AR_TOU], 
                [1, AR_LIB]
        ]
        );
    public var ONISAKE(default, never) : OnikiriSake = new OnikiriSake();
    public var ORCASUN(default, never) : Consumable = mk("OrcaSun", "OrcaSunscr", "a bottle of Orca Sunscreen", 6, "A very ordinary looking bottle of sunscreen, with a whale girl in swimwear labeled 'Orca sunscreen'.", curry(m.orcaSunscreen, 0), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_ORCA), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_STR], 
                [1, AR_SPE], 
                [1, AR_TOU]
        ]
        );
    public var ORCMEAD(default, never) : Consumable = mk("OrcMead", "OrcMead", "a flagon of Orc Mead", 6, "This sealed flagon of 'Orc Mead' sloshes noisily with alcoholic brew.  Judging by the markings on the flagon, it's a VERY strong drink, and not to be trifled with.", m.orcMead, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_ORC), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_STR], 
                [1, AR_SPE], 
                [1, AR_TOU]
        ], 
                OrcRace.OrcSkinColors
        );
    public var P_LBOVA(default, never) : Consumable = mk("P.LBova", "P.LBova", "a bottle containing a white fluid labeled \"Pure LaBova\"", 6, "A bottle containing a misty fluid with a grainy texture; it has a long neck and a ball-like base.  The label has a stylized picture of a well-endowed cow-girl nursing two guys while they jerk themselves off. It has been purified by Rathazul.", curry(m.laBova, false, false), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_COW), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_STR], 
                [1, AR_TOU], 
                [1, AR_SPE]
        ]
        );
    public var P_VEMOM(default, never) : PotentVenom = new PotentVenom();
    public var PIGTRUF(default, never) : Consumable = mk("PigTruf", "PigTruffle", "a pigtail truffle", 6, "It’s clear where this fungus gets its name.  A small, curly sprig resembling a pig’s tail can be seen jutting out of it.", curry(m.pigTruffle, false), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_PIG), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_STR], 
                [1, AR_TOU]
        ]
        );
    public var PRFRUIT(default, never) : Consumable = mk("PrFruit", "PrFruit", "a purple fruit", 6, "This sweet-smelling produce looks like an eggplant, but feels almost squishy, and rubbery to the touch. Holding it to your ear, you think you can hear some fluid sloshing around inside.", m.purpleFruitEssrayle, ItemConstants.U_TF);
    public var PROBOVA(default, never) : Consumable = mk("ProBova", "ProBova", "a bottle containing a misty fluid labeled \"ProBova\"", 6, "This cloudy potion has been enhanced by the alchemist Lumi to imbue its drinker with cow-like attributes.", curry(m.laBova, true, true), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_COW), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_STR], 
                [1, AR_TOU], 
                [1, AR_SPE]
        ]
        );
    public var PROTPLS(default, never) : Consumable = mk("ProtPls", "ProtPls", "a bottle of protoplasm", 6, "The opaque, incorporeal substance flows like a liquid inside its container. It makes you feel... uncomfortable, as you observe it and maybe it observe you back...", curry(m.ectoplasm, 1), ItemConstants.U_TF);
    public var PURHONY(default, never) : BeeHoney = new BeeHoney(true, false);
    public var RDRROOT(default, never) : Consumable = mk("RdRRoot", "R.R.Root", "a red river root", 14, "A long, odd shaped root. It smells spicy but surprisingly tasty. Eating it would supposedly alter your body in unknown ways.", m.redRiverRoot, ItemConstants.U_TF);
    public var REDVIAL(default, never) : VampireBlood = new VampireBlood();
    public var REPTLUM(default, never) : Consumable = mk("Reptlum", "Reptilum", "a vial of Reptilum", 6, "This is a rounded bottle with a small label that reads, \"<i>Reptilum</i>\".  It is likely this potion is tied to reptiles in some way.", m.reptilum, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_LIZARD), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_TOU], 
                [1, AR_LIB]
        ]
        );
    public var RESNOIL(default, never) : Consumable = mk("R.SnakOil", "R.SnakOil", "a vial of refined snake oil", 6, "A vial the size of your fist made of dark brown glass. It contains what appears to be an oily, blackish liquid. The odor is even more abominable then that of regular snake oil.", curry(m.snakeOil, 1), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                MULTIRACE_ESSENCE_DROP_TABLE(AE_APOPHIS, AE_SNAKE), 
                [], 
                NagaRace.SnakeScaleColors
        );
    public var RINGFIG(default, never) : Consumable = mk("RingFig", "RingFig", "a ringtail fig", 6, "A dried fig with two lobes and thin dark rings just below its stem.  The skin is wrinkly and it looks vaguely like a bulging scrotum.", m.ringtailFig, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_RACCOON), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_SPE], 
                [1, AR_LIB]
        ]
        );
    public var RIZZART(default, never) : RizzaRoot = new RizzaRoot();
    public var RUBYCRY(default, never) : Consumable = mk("RubyCry", "RubyCryst", "a ruby crystal", 6, "A shining teardrop-shaped jewel.  An eerie red fluid dances beneath the surface.", m.rubycrystal, ItemConstants.U_TF);
    public var S_GOSSR(default, never) : Consumable = mk("S.Gossr", "S.Gossr", "a bundle of pink, gossamer webbing", 6, "These strands of gooey pink gossamer seem quite unlike the normal silk that spider-morphs produce.  It smells sweet and is clearly edible, but who knows what it might do to you?", curry(m.sweetGossamer, 0), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_SPIDER), DEFAULT_ESSENCE_DROP_TABLE)
        );
    public var SALAMFW(default, never) : Consumable = mk("SalamFW", "SalamFW", "a hip flask of Salamander Firewater", 6, "This hip flask contain high-proof beverage called 'Salamander Firewater', which one sip can makes your throat feel like it been set on fire.  What whould happen if you drink whole flask content?", m.salamanderfirewater, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_SALAMANDER), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_STR], 
                [1, AR_TOU], 
                [1, AR_LIB]
        ], 
                concatUnique(
                        SalamanderRace.SalamanderScaleColors, 
                        SalamanderRace.SalamanderSkinColors
            )
        );
    public var SATYR_W(default, never) : SatyrWine = new SatyrWine();
    public var SAGEMED(default, never) : SageMedicine = new SageMedicine();
    public var SCORICO(default, never) : Scorpinum = new Scorpinum();
    public var SHARK_T(default, never) : Consumable = mk("Shark.T", "Shark.T", "a sharp shark tooth", 6, "A glinting white tooth, very sharp and intimidating.", curry(m.sharkTooth, 0), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_SHARK), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_STR], 
                [1, AR_LIB], 
                [1, AR_SPE]
        ], 
                concatUnique(SharkRace.SharkHairColors, SharkRace.SharkScaleColors)
        );
    public var SKELP__(default, never) : Consumable = mk("Skelp  ", "Skelp", "a skelp", 15, "A form of Kelp used by the Melkie as seasoning for their food. Very tasty but can result in transformation if used uncooked.", m.skelp, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                DEFAULT_ESSENCE_DROP_TABLE(AE_MELKIE, true), 
                [
                [1, AR_LIB], 
                [1, AR_SPE], 
                [1, AR_INT]
        ], 
                concatUnique(
                        MelkieRace.MelkieFurColors, 
                        MelkieRace.MelkieHairColors, 
                        MelkieRace.MelkieSkinColors
            )
        );
    public var SKYSEED(default, never) : Consumable = mk("SkySeed", "SkybornSeed", "a skyborn seed", 10, "A smallish, ovular nut-like fruit, with a hard greenish-blue shell that gives off a pleasant aroma.", curry(m.skybornSeed, 0), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_AVIAN), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_SPE], 
                [1, AR_STR]
        ]
        );
    public var SNAKOIL(default, never) : Consumable = mk("SnakOil", "SnakeOil", "a vial of snake oil", 6, "A vial the size of your fist made of dark brown glass. It contains what appears to be an oily, yellowish liquid. The odor is abominable.", curry(m.snakeOil, 0), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_SNAKE), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_LIB]
        ], 
                HumanRace.HumanSkinColors
        );
    public var SMRTNUT(default, never) : Consumable = mk("SmrtNut", "SmartyNuts", "a smarty nut", 6, "A special nut highly prized by Ratatoskr's. Rumors are it makes you smarter.", m.smartyNuts, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_SQUIRREL), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_INT], 
                [1, AR_SPE]
        ], 
                RatatoskrRace.RatatoskrHairColors
        );
    public var SPHONEY(default, never) : Consumable = new BeeHoney(false, true);
    public var SRMSEED(default, never) : Consumable = mk("SrmSeed", "StormSeed", "a storm seed", 20, "This magical seed radiate a faint aura of static as if struck by lightning.", m.stormSeed, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                MULTIRACE_ESSENCE_DROP_TABLE(AE_THUNDERBIRD, AE_HARPY), 
                [
                [1, AR_SPE], 
                [1, AR_LIB]
        ]
        );
    public var STRFLOW(default, never) : Consumable = mk("StrFlow", "StrangeFlower", "a strange flower", 20, "This weird flower has two pistils instead of one. You feel a strange connection to it.", m.strangeFlower, ItemConstants.U_TF);
    public var TGOGODD(default, never) : Consumable = mk("TGOGoss", "TGOnnaGoss", "a Thick Green Onna Gossamer", 6, "Those strands of green gossamer are rougher than those of driders. It looks edible, but the smell of musk and milk makes you a little dizzy.", curry(m.thickGossamer, 0), ItemConstants.U_TF);
    public var TRAPOIL(default, never) : Consumable = mk("TrapOil", "TrapOil", "a vial of trap oil", 6, "A round, opaque glass vial filled with a clear, viscous fluid.  It has a symbol inscribed on it, a circle with a cross and arrow pointing out of it in opposite directions.  It looks and smells entirely innocuous.", m.trapOil, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_SAND_TRAP), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_SPE], 
                [1, AR_LIB]
        ]
        );
    public var TROLFIG(default, never) : Consumable = mk("TrolFig", "TrollFig", "a Troll Fig", 12, "A hairy fig that's a common delicacy among trolls, it’s said that it infuses the consumer with tremendous insight.", curry(m.trollFig, 0), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_TROLL), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_STR], 
                [1, AR_TOU], 
                [1, AR_WIS]
        ]
        );
    public var TSCROLL(default, never) : TatteredScroll = new TatteredScroll();
    public var TSTOOTH(default, never) : Consumable = mk("TSTooth", "TSTooth", "a glowing tiger shark tooth", 6, "This looks like a normal shark tooth, though with an odd purple glow.", curry(m.sharkTooth, 1), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_SHARK), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_STR], 
                [1, AR_LIB], 
                [1, AR_SPE]
        ], 
                concatUnique(SharkRace.SharkHairColors, SharkRace.SharkScaleColors, ["orange"])
        );
    public var UNICORN(default, never) : AbstractEquinum = new AbstractEquinum(1, "Unicorn", "Unicornum", "a vial of Unicornum", 40, "This is a long flared vial with a small label that reads, \"<i>Unicornum</i>\".  It is likely this potion is tied to unicorns in some way.");
    public var VAMPBLD(default, never) : VampireBlood = new VampireBlood(true);
    public var VIXVIGR(default, never) : Consumable = mk("VixVigr", "VixVigr", "a bottle labelled \"Vixen's Vigor\"", 30, "This small medicine bottle contains something called \"Vixen's Vigor\", supposedly distilled from common fox-berries.  It is supposed to be a great deal more potent, and a small warning label warns of \"extra boobs\", whatever that means.", curry(m.foxTF, true), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                [[1, AE_FOX]], 
                [
                [1, AR_INT], 
                [1, AR_LIB]
        ], 
                concatUnique(
                        FoxRace.FoxHairColors, 
                        FoxRace.FoxFurColors
            )
        );
    public var VOLTTOP(default, never) : Consumable = mk("VoltTop", "VoltTopaz", "a Voltage topaz", 6, "This glittering jewel sparkles with a wondrous light. With such beauty, it would probably fetch a fair amount of gems in various markets. A faint static tingle warms your hands as a light flush travels up your arms...", curry(m.voltageTopaz, true), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_RAIJU), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_LIB]
        ], 
                concatUnique(
                        RaijuRace.RaijuEyeColors, 
                        RaijuRace.RaijuHairColors
            )
        );
    public var VOUIOIL(default, never) : Consumable = mk("VouiOil", "VouivreOil", "a vial of vouivre oil", 70, "A vial the size of your fist made of light green glass. It contains what appears to be an oily, purple liquid. The odor is strange.", curry(m.evolvedNagaOil, 1), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                MULTIRACE_ESSENCE_DROP_TABLE(AE_DRAGON, AE_SNAKE), 
                [
                [1, AR_SPE], 
                [1, AR_TOU], 
                [1, AR_LIB]
        ]
        );
    public var W_FRUIT(default, never) : Consumable = mk("W.Fruit", "W.Fruit", "a piece of whisker-fruit", 6, "This small, peach-sized fruit has tiny whisker-like protrusions growing from the sides.", m.whiskerFruit, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_CAT), DEFAULT_ESSENCE_DROP_TABLE), 
                [], 
                CatRace.catFurColors
        );
    public var W_EMRLD(default, never) : Consumable = mk("W.Emerald", "W.Emerald", "a Windstorm Emerald", 20, "This glittering jewel sparkles with a wondrous light. With such beauty, it would probably fetch a fair amount of gems in various markets. A faint green glow warms your hands as a light breeze travels up your arms...", curry(m.windstormEmerald, true), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_KAMAITACHI), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_LIB]
        ]
        );
    public var WHITEIS(default, never) : Consumable = mk("WhiteIS", "WhiteIceShard", "a White Ice Shard", 30, "This shard of cloudy white ice seems to resist all forms of heat and appears to radiate a sense of loneliness and frigid desire.", m.whiteIceShard, ItemConstants.U_TF);
    public var WOFRUIT(default, never) : Consumable = mk("WoFruit", "WonderFruit", "a Wonder fruit", 10, "A strange whisker fruit from what appears to be a different dimension. Its skin is dyed with all the color of the rainbow.", m.wonderFruit, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                MULTIRACE_ESSENCE_DROP_TABLE(AE_CHESHIRE, AE_CAT)
        );
    public var WETCLTH(default, never) : Consumable = mk("WetClth", "WetCloth", "a wet cloth dripping with slippery slime", 6, "Dripping with a viscous slime, you've no doubt rubbing this cloth on your body would have some kind of strange effect.", curry(m.gooGasmic, 0), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_GOO), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_STR], 
                [1, AR_TOU]
        ], 
                SlimeRace.SlimeSkinColors
        );
    public var WHITEIN(default, never) : Consumable = mk("WhiteIn", "WhiteInk", "a vial of white ink", 50, "Pearly white ink normaly used for writing consuming this doesnt seem like the best idea.", curry(m.scyllaInk, 2), ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_SCYLLA), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_STR], 
                [1, AR_SPE], 
                [1, AR_INT]
        ]
        );
    public var WOLF_PP(default, never) : Consumable = mk("Wolf Pp", "WolfPepper", "a Wolf pepper", 20, "The pepper is shiny and black, bulbous at the base but long and narrow at the tip.  It has a fuzzy feel to it and it smells spicy.", m.wolfPepper, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_WEREWOLF), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_STR], 
                [1, AR_TOU], 
                [1, AR_SPE]
        ]
        );
    public var YETICUM(default, never) : Consumable = mk("YetiCum", "YetiCum", "a bottle of Yeti Cum", 6, "This looks like some cum from a yeti. It looks potent and you can’t help but ponder about its effect.", m.yetiCum, ItemConstants.U_TF).refineableInto(
                DEFAULT_SUBSTANCES_DROP_TABLE, 
                cast((AE_YETI), DEFAULT_ESSENCE_DROP_TABLE), 
                [
                [1, AR_STR], 
                [1, AR_TOU], 
                [1, AR_SPE], 
                [1, AR_INT], 
                [1, AR_LIB]
        ]
        );
    
    public var LARGE_EGGS(default, never) : Array<Dynamic> = [L_BLKEG, L_BLUEG, L_BRNEG, L_PNKEG, L_PRPEG, L_WHTEG];
    public var SMALL_EGGS(default, never) : Array<Dynamic> = [BLACKEG, BLUEEGG, BROWNEG, PINKEGG, PURPLEG, WHITEEG];
    
    //ALCHEMICAL INGREDIANTS
    public var GINSENG(default, never) : Consumable = mk("Ginseng", "Ginseng", "a Ginseng", 6, "A plant of which the fragant root is commonly used for perfume and cooking. If properly refined, its alchemical properties can also be used as a component to enhance potions.", m.Ginseng);
    public var HEALHERB(default, never) : Consumable = mk("HealHerb", "HealHerb", "a Healing herb", 6, "An herb with healing properties. Can be consumed directly or processed into a poultice.", m.HealingHerb);
    public var MOONGRASS(default, never) : Consumable = mk("MoonGrass", "MoonGrass", "Moonlight grass", 6, "A tuft of grass with invigorative properties. Can be consumed directly or processed into a medicine.\n", m.MoonGrass);
    public var SNAKEBANE(default, never) : Consumable = mk("SnakFlowr", "SnakFlowr", "a Snakebane flower", 6, "This flower can cure poison but, when alchemically processed, remove burns and frostburns as well. Can be consumed directly or processed into a medicine.", m.SnakeFlower);
    public var IRONWEED(default, never) : Consumable = mk("IronWeed", "IronWeed", "a Iron weed", 6, "This magical weed dulls one’s sense of pain and temporarily hardens the skin. Can be consumed directly or processed into a medicine.", m.Ironweed);
    public var BLADEFERN(default, never) : Consumable = mk("BladeFerns", "BladeFerns", "a handfull of Blade ferns", 6, "This magical ferns helps the user temporarily generate more adrenaline and boosts the muscle mass, improving one’s strength and speed. Can be consumed directly or processed into a medicine.", m.BladeFerns);
    public var RAUNENECT(default, never) : Consumable = mk("RauneNectar", "RauneNectar", "a bottle of Alaune nectar", 6, "A powerful aphrodisiac when consumed, Alraune nectar can be processed into a perfume, granting the user the infamous arousing scent of the alraunes as well as an alchemical resilience to lust. Can be consumed directly or processed into a perfume.", m.AlrauneNectar);
    
    private var mutations : Mutations;
    
    /**
		 * A handy function to create SimpleConsumables (useable by any player, effect is a function accepting player:Player,
		 * shortName, longName, description and value are const)
		 * @param id id. Must be String 7 chars long
		 * @param shortName shortName, null to use id as shortName
		 * @param longName null to use shortName as longName
		 * @param description null to use longName as description
		 * @param effect function(player:Player) called to produce effect
		 * @param  (default false) Tag item as transformative
		 */
    private static function mk(id : String, shortName : String, longName : String, value : Float, description : String, effect : Function, tags : Array<Dynamic> = null) : Consumable
    {
        var item : Consumable = new SimpleConsumable(id, shortName, longName, effect, value, description);
        for (tag in tags)
        {
            item.withTag(tag);
        }
        return item;
    }
    private function get_m() : Mutations
    {
        if (mutations == null)
        {
            mutations = new Mutations();
        }
        return mutations;
    }
    public function new()
    {
        super();
    }
}
