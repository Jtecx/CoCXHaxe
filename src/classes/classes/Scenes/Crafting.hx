package classes.scenes;

import flash.errors.Error;
import haxe.Constraints.Function;
import classes.*;
import classes.globalFlags.KFLAGS;
import classes.items.alchemy.AlchemyLib;
import classes.items.alchemy.AlchemyReagent;
import classes.items.alchemy.AlembicCatalyst;
import classes.items.Consumable;
import classes.scenes.crafting.AlchemyExtraction;
import classes.scenes.crafting.MutagenPillCrafting;
import classes.scenes.crafting.StatPillCrafting;
import classes.transformations.PossibleEffect;
import classes.internals.EnumValue;
import classes.internals.SaveableState;

class Crafting extends BaseContent implements SaveableState
{
    public static var ALEMBIC_LEVELS : Array<Dynamic> = [];
    public static var ALEMBIC_LEVEL_NONE : Int = EnumValue.add(ALEMBIC_LEVELS, 0, "NONE", {
                    name : "no alembic",
                    successChance : 0,
                    value : 0
                });
    public static var ALEMBIC_LEVEL_SIMPLE : Int = EnumValue.add(ALEMBIC_LEVELS, 1, "SIMPLE", {
                    name : "simple alembic",
                    successChance : 25,
                    value : 250
                });
    public static var ALEMBIC_LEVEL_GOOD : Int = EnumValue.add(ALEMBIC_LEVELS, 2, "GOOD", {
                    name : "good alembic",
                    successChance : 50,
                    value : 2500
                });
    public static var ALEMBIC_LEVEL_ANCIENT : Int = EnumValue.add(ALEMBIC_LEVELS, 3, "ANCIENT", {
                    name : "ancient alembic",
                    successChance : 75,
                    value : 25000
                });
    
    public static var FURNACE_LEVELS : Array<Dynamic> = [];
    public static var FURNACE_LEVEL_NONE : Int = EnumValue.add(FURNACE_LEVELS, 0, "NONE", {
                    name : "no pill furnace",
                    refineChances : [100, 0, 0, 0, 0, 0],
                    stoneLimit : 0,
                    value : 0
                });
    public static var FURNACE_LEVEL_SIMPLE : Int = EnumValue.add(FURNACE_LEVELS, 1, "SIMPLE", {
                    name : "simple pill furnace",
                    refineChances : [0, 40, 30, 20, 10, 0],
                    stoneLimit : 2,
                    value : 250
                });
    public static var FURNACE_LEVEL_GOOD : Int = EnumValue.add(FURNACE_LEVELS, 2, "GOOD", {
                    name : "good pill furnace",
                    refineChances : [0, 20, 30, 30, 20, 0],
                    stoneLimit : 4,
                    value : 2500
                });
    public static var FURNACE_LEVEL_ANCIENT : Int = EnumValue.add(FURNACE_LEVELS, 3, "ANCIENT", {
                    name : "ancient pill furnace",
                    refineChances : [0, 10, 20, 30, 40, 0],
                    stoneLimit : 8,
                    value : 25000
                });
    
    // State
    
    public static var BagSlot01 : Float;
    public static var BagSlot01Cap : Float;  //Copper Ore  
    public static var BagSlot02 : Float;
    public static var BagSlot02Cap : Float;  //Tin Ore  
    public static var BagSlot03 : Float;
    public static var BagSlot03Cap : Float;  //Bronze Bar  
    public static var BagSlot04 : Float;
    public static var BagSlot04Cap : Float;  //Iron Ore  
    public static var BagSlot05 : Float;
    public static var BagSlot05Cap : Float;  //Ebonbloom - not yet storable with current best bag  
    public static var BagSlot06 : Float;
    public static var BagSlot06Cap : Float;  //Ebon Ingot  
    public static var BagSlot07 : Float;
    public static var BagSlot07Cap : Float;  //Moonstone  
    public static var BagSlot08 : Float;
    public static var BagSlot08Cap : Float;  //Skymetal - not yet storable with current best bag  
    public static var BagSlot09 : Float;
    public static var BagSlot09Cap : Float;  //Divine Ice - not yet storable with current best bag  
    public static var BagSlot10 : Float;
    public static var BagSlot10Cap : Float;  //Orichalcum - not yet storable with current best bag  
    public static var BagSlot11 : Float;
    public static var BagSlot11Cap : Float;
    public static var BagSlot12 : Float;
    public static var BagSlot12Cap : Float;
    public static var BagSlot13 : Float;
    public static var BagSlot13Cap : Float;
    public static var BagSlot14 : Float;
    public static var BagSlot14Cap : Float;
    public static var BagSlot15 : Float;
    public static var BagSlot15Cap : Float;
    public static var BagSlot16 : Float;
    public static var BagSlot16Cap : Float;
    public static var BagSlot17 : Float;
    public static var BagSlot17Cap : Float;
    public static var BagSlot18 : Float;
    public static var BagSlot18Cap : Float;
    public static var BagSlot19 : Float;
    public static var BagSlot19Cap : Float;
    public static var BagSlot20 : Float;
    public static var BagSlot20Cap : Float;
    public static var BagSlot21 : Float;
    public static var BagSlot21Cap : Float;
    public static var BagSlot22 : Float;
    public static var BagSlot22Cap : Float;
    public static var BagSlot23 : Float;
    public static var BagSlot23Cap : Float;
    public static var BagSlot24 : Float;
    public static var BagSlot24Cap : Float;
    public static var BagSlot25 : Float;
    public static var BagSlot25Cap : Float;
    public static var BagSlot26 : Float;
    public static var BagSlot26Cap : Float;
    public static var BagSlot27 : Float;
    public static var BagSlot27Cap : Float;
    public static var BagSlot28 : Float;
    public static var BagSlot28Cap : Float;
    public static var BagSlot29 : Float;
    public static var BagSlot29Cap : Float;
    public static var BagSlot30 : Float;
    public static var BagSlot30Cap : Float;
    public static var BagSlot31 : Float;
    public static var BagSlot31Cap : Float;
    public static var BagSlot32 : Float;
    public static var BagSlot32Cap : Float;
    public static var BagSlot33 : Float;
    public static var BagSlot33Cap : Float;
    public static var BagSlot34 : Float;
    public static var BagSlot34Cap : Float;
    public static var BagSlot35 : Float;
    public static var BagSlot35Cap : Float;
    public static var BagSlot36 : Float;
    public static var BagSlot36Cap : Float;
    public static var BagSlot37 : Float;
    public static var BagSlot37Cap : Float;
    public static var BagSlot38 : Float;
    public static var BagSlot38Cap : Float;
    public static var BagSlot39 : Float;
    public static var BagSlot39Cap : Float;
    public static var BagSlot40 : Float;
    public static var BagSlot40Cap : Float;
    
    public static var alembicLevel : Int = 0;
    // Catalyst currently in the alembic, or null
    public static var alembicCatalyst : AlembicCatalyst = null;
    public static var furnaceLevel : Int = 0;
    // Times used Xianxia MC powers
    public static var xmcLuck : Int = 0;
    // Amount of 'stinky goo' produced when refining ingredients
    public static var gooProduced : Int = 0;
    
    // Map of substanceId -> count
    public static var substanceStock : Dynamic = { };
    // Map of essenceId -> count
    public static var essenceStock : Dynamic = { };
    // Map of essenceId -> count
    public static var residueStock : Dynamic = { };
    // Map of pigment color -> count
    public static var pigmentStock : Dynamic = { };
    
    // Map of itemId -> reagentType -> set of reagent id
    // ex. { FoxJewl: { RT_ESSENCE: { AE_FOX: true } } }
    // It is saved in a compressed form
    public static var ingredientKnowledge : Dynamic = { };
    // Set of tfId
    // ex. { TF_2_3: true }
    // It is saved in a compressed form (array of strings)
    public static var tfPillKnowledge : Dynamic = { };
    
    public function stateObjectName() : String
    {
        return "Crafting";
    }
    
    public function resetState() : Void
    {
        BagSlot01 = 0;
        BagSlot01Cap = 0;
        BagSlot02 = 0;
        BagSlot02Cap = 0;
        BagSlot03 = 0;
        BagSlot03Cap = 0;
        BagSlot04 = 0;
        BagSlot04Cap = 0;
        BagSlot05 = 0;
        BagSlot05Cap = 0;
        BagSlot06 = 0;
        BagSlot06Cap = 0;
        BagSlot07 = 0;
        BagSlot07Cap = 0;
        BagSlot08 = 0;
        BagSlot08Cap = 0;
        BagSlot09 = 0;
        BagSlot09Cap = 0;
        BagSlot10 = 0;
        BagSlot10Cap = 0;
        BagSlot11 = 0;
        BagSlot11Cap = 0;
        BagSlot12 = 0;
        BagSlot12Cap = 0;
        BagSlot13 = 0;
        BagSlot13Cap = 0;
        BagSlot14 = 0;
        BagSlot14Cap = 0;
        BagSlot15 = 0;
        BagSlot15Cap = 0;
        BagSlot16 = 0;
        BagSlot16Cap = 0;
        BagSlot17 = 0;
        BagSlot17Cap = 0;
        BagSlot18 = 0;
        BagSlot18Cap = 0;
        BagSlot19 = 0;
        BagSlot19Cap = 0;
        BagSlot20 = 0;
        BagSlot20Cap = 0;
        BagSlot21 = 0;
        BagSlot21Cap = 0;
        BagSlot22 = 0;
        BagSlot22Cap = 0;
        BagSlot23 = 0;
        BagSlot23Cap = 0;
        BagSlot24 = 0;
        BagSlot24Cap = 0;
        BagSlot25 = 0;
        BagSlot25Cap = 0;
        BagSlot26 = 0;
        BagSlot26Cap = 0;
        BagSlot27 = 0;
        BagSlot27Cap = 0;
        BagSlot28 = 0;
        BagSlot28Cap = 0;
        BagSlot29 = 0;
        BagSlot29Cap = 0;
        BagSlot30 = 0;
        BagSlot30Cap = 0;
        BagSlot31 = 0;
        BagSlot31Cap = 0;
        BagSlot32 = 0;
        BagSlot32Cap = 0;
        BagSlot33 = 0;
        BagSlot33Cap = 0;
        BagSlot34 = 0;
        BagSlot34Cap = 0;
        BagSlot35 = 0;
        BagSlot35Cap = 0;
        BagSlot36 = 0;
        BagSlot36Cap = 0;
        BagSlot37 = 0;
        BagSlot37Cap = 0;
        BagSlot38 = 0;
        BagSlot38Cap = 0;
        BagSlot39 = 0;
        BagSlot39Cap = 0;
        BagSlot40 = 0;
        BagSlot40Cap = 0;
        
        alembicLevel = 0;
        alembicCatalyst = null;
        furnaceLevel = 0;
        xmcLuck = 0;
        gooProduced = 0;
        substanceStock = { };
        essenceStock = { };
        residueStock = { };
        pigmentStock = { };
        // do not reset knowledge on ascension
        if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0)
        {
            ingredientKnowledge = { };
            tfPillKnowledge = { };
        }
    }
    
    public function saveToObject() : Dynamic
    {
        return {
            BagSlot01 : BagSlot01,
            BagSlot01Cap : BagSlot01Cap,
            BagSlot02 : BagSlot02,
            BagSlot02Cap : BagSlot02Cap,
            BagSlot03 : BagSlot03,
            BagSlot03Cap : BagSlot03Cap,
            BagSlot04 : BagSlot04,
            BagSlot04Cap : BagSlot04Cap,
            BagSlot05 : BagSlot05,
            BagSlot05Cap : BagSlot05Cap,
            BagSlot06 : BagSlot06,
            BagSlot06Cap : BagSlot06Cap,
            BagSlot07 : BagSlot07,
            BagSlot07Cap : BagSlot07Cap,
            BagSlot08 : BagSlot08,
            BagSlot08Cap : BagSlot08Cap,
            BagSlot09 : BagSlot09,
            BagSlot09Cap : BagSlot09Cap,
            BagSlot10 : BagSlot10,
            BagSlot10Cap : BagSlot10Cap,
            BagSlot11 : BagSlot11,
            BagSlot11Cap : BagSlot11Cap,
            BagSlot12 : BagSlot12,
            BagSlot12Cap : BagSlot12Cap,
            BagSlot13 : BagSlot13,
            BagSlot13Cap : BagSlot13Cap,
            BagSlot14 : BagSlot14,
            BagSlot14Cap : BagSlot14Cap,
            BagSlot15 : BagSlot15,
            BagSlot15Cap : BagSlot15Cap,
            BagSlot16 : BagSlot16,
            BagSlot16Cap : BagSlot16Cap,
            BagSlot17 : BagSlot17,
            BagSlot17Cap : BagSlot17Cap,
            BagSlot18 : BagSlot18,
            BagSlot18Cap : BagSlot18Cap,
            BagSlot19 : BagSlot19,
            BagSlot19Cap : BagSlot19Cap,
            BagSlot20 : BagSlot20,
            BagSlot20Cap : BagSlot20Cap,
            BagSlot21 : BagSlot21,
            BagSlot21Cap : BagSlot21Cap,
            BagSlot22 : BagSlot22,
            BagSlot22Cap : BagSlot22Cap,
            BagSlot23 : BagSlot23,
            BagSlot23Cap : BagSlot23Cap,
            BagSlot24 : BagSlot24,
            BagSlot24Cap : BagSlot24Cap,
            BagSlot25 : BagSlot25,
            BagSlot25Cap : BagSlot25Cap,
            BagSlot26 : BagSlot26,
            BagSlot26Cap : BagSlot26Cap,
            BagSlot27 : BagSlot27,
            BagSlot27Cap : BagSlot27Cap,
            BagSlot28 : BagSlot28,
            BagSlot28Cap : BagSlot28Cap,
            BagSlot29 : BagSlot29,
            BagSlot29Cap : BagSlot29Cap,
            BagSlot30 : BagSlot30,
            BagSlot30Cap : BagSlot30Cap,
            BagSlot31 : BagSlot31,
            BagSlot31Cap : BagSlot31Cap,
            BagSlot32 : BagSlot32,
            BagSlot32Cap : BagSlot32Cap,
            BagSlot33 : BagSlot33,
            BagSlot33Cap : BagSlot33Cap,
            BagSlot34 : BagSlot34,
            BagSlot34Cap : BagSlot34Cap,
            BagSlot35 : BagSlot35,
            BagSlot35Cap : BagSlot35Cap,
            BagSlot36 : BagSlot36,
            BagSlot36Cap : BagSlot36Cap,
            BagSlot37 : BagSlot37,
            BagSlot37Cap : BagSlot37Cap,
            BagSlot38 : BagSlot38,
            BagSlot38Cap : BagSlot38Cap,
            BagSlot39 : BagSlot39,
            BagSlot39Cap : BagSlot39Cap,
            BagSlot40 : BagSlot40,
            BagSlot40Cap : BagSlot40Cap,
            xmcLuck : xmcLuck,
            gooProduced : gooProduced,
            alembicLevel : alembicLevel,
            alembicCatalyst : (alembicCatalyst != null) ? alembicCatalyst.id : null,
            furnaceLevel : furnaceLevel,
            substanceStock : substanceStock,
            essenceStock : essenceStock,
            residueStock : residueStock,
            pigmentStock : pigmentStock,
            tfPillKnowledge : compressTfPillKnowledge(),
            ingredientKnowledge : compressIngredientKnowledge()
        };
    }
    
    public function loadFromObject(o : Dynamic, ignoreErrors : Bool) : Void
    {
        if (o != null)
        {
            BagSlot01 = Reflect.field(o, "BagSlot01");
            BagSlot01Cap = Reflect.field(o, "BagSlot01Cap");
            BagSlot02 = Reflect.field(o, "BagSlot02");
            BagSlot02Cap = Reflect.field(o, "BagSlot02Cap");
            BagSlot03 = Reflect.field(o, "BagSlot03");
            BagSlot03Cap = Reflect.field(o, "BagSlot03Cap");
            BagSlot04 = Reflect.field(o, "BagSlot04");
            BagSlot04Cap = Reflect.field(o, "BagSlot04Cap");
            BagSlot05 = Reflect.field(o, "BagSlot05");
            BagSlot05Cap = Reflect.field(o, "BagSlot05Cap");
            BagSlot06 = Reflect.field(o, "BagSlot06");
            BagSlot06Cap = Reflect.field(o, "BagSlot06Cap");
            BagSlot07 = Reflect.field(o, "BagSlot07");
            BagSlot07Cap = Reflect.field(o, "BagSlot07Cap");
            BagSlot08 = Reflect.field(o, "BagSlot08");
            BagSlot08Cap = Reflect.field(o, "BagSlot08Cap");
            BagSlot09 = Reflect.field(o, "BagSlot09");
            BagSlot09Cap = Reflect.field(o, "BagSlot09Cap");
            BagSlot10 = Reflect.field(o, "BagSlot10");
            BagSlot10Cap = Reflect.field(o, "BagSlot10Cap");
            BagSlot11 = Reflect.field(o, "BagSlot11");
            BagSlot11Cap = Reflect.field(o, "BagSlot11Cap");
            BagSlot12 = Reflect.field(o, "BagSlot12");
            BagSlot12Cap = Reflect.field(o, "BagSlot12Cap");
            BagSlot13 = Reflect.field(o, "BagSlot13");
            BagSlot13Cap = Reflect.field(o, "BagSlot13Cap");
            BagSlot14 = Reflect.field(o, "BagSlot14");
            BagSlot14Cap = Reflect.field(o, "BagSlot14Cap");
            BagSlot15 = Reflect.field(o, "BagSlot15");
            BagSlot15Cap = Reflect.field(o, "BagSlot15Cap");
            BagSlot16 = Reflect.field(o, "BagSlot16");
            BagSlot16Cap = Reflect.field(o, "BagSlot16Cap");
            BagSlot17 = Reflect.field(o, "BagSlot17");
            BagSlot17Cap = Reflect.field(o, "BagSlot17Cap");
            BagSlot18 = Reflect.field(o, "BagSlot18");
            BagSlot18Cap = Reflect.field(o, "BagSlot18Cap");
            BagSlot19 = Reflect.field(o, "BagSlot19");
            BagSlot19Cap = Reflect.field(o, "BagSlot19Cap");
            BagSlot20 = Reflect.field(o, "BagSlot20");
            BagSlot20Cap = Reflect.field(o, "BagSlot20Cap");
            BagSlot21 = Reflect.field(o, "BagSlot21");
            BagSlot21Cap = Reflect.field(o, "BagSlot21Cap");
            BagSlot22 = Reflect.field(o, "BagSlot22");
            BagSlot22Cap = Reflect.field(o, "BagSlot22Cap");
            BagSlot23 = Reflect.field(o, "BagSlot23");
            BagSlot23Cap = Reflect.field(o, "BagSlot23Cap");
            BagSlot24 = Reflect.field(o, "BagSlot24");
            BagSlot24Cap = Reflect.field(o, "BagSlot24Cap");
            BagSlot25 = Reflect.field(o, "BagSlot25");
            BagSlot25Cap = Reflect.field(o, "BagSlot25Cap");
            BagSlot26 = Reflect.field(o, "BagSlot26");
            BagSlot26Cap = Reflect.field(o, "BagSlot26Cap");
            BagSlot27 = Reflect.field(o, "BagSlot27");
            BagSlot27Cap = Reflect.field(o, "BagSlot27Cap");
            BagSlot28 = Reflect.field(o, "BagSlot28");
            BagSlot28Cap = Reflect.field(o, "BagSlot28Cap");
            BagSlot29 = Reflect.field(o, "BagSlot29");
            BagSlot29Cap = Reflect.field(o, "BagSlot29Cap");
            BagSlot30 = Reflect.field(o, "BagSlot30");
            BagSlot30Cap = Reflect.field(o, "BagSlot30Cap");
            BagSlot31 = Reflect.field(o, "BagSlot31");
            BagSlot31Cap = Reflect.field(o, "BagSlot31Cap");
            BagSlot32 = Reflect.field(o, "BagSlot32");
            BagSlot32Cap = Reflect.field(o, "BagSlot32Cap");
            BagSlot33 = Reflect.field(o, "BagSlot33");
            BagSlot33Cap = Reflect.field(o, "BagSlot33Cap");
            BagSlot34 = Reflect.field(o, "BagSlot34");
            BagSlot34Cap = Reflect.field(o, "BagSlot34Cap");
            BagSlot35 = Reflect.field(o, "BagSlot35");
            BagSlot35Cap = Reflect.field(o, "BagSlot35Cap");
            BagSlot36 = Reflect.field(o, "BagSlot36");
            BagSlot36Cap = Reflect.field(o, "BagSlot36Cap");
            BagSlot37 = Reflect.field(o, "BagSlot37");
            BagSlot37Cap = Reflect.field(o, "BagSlot37Cap");
            BagSlot38 = Reflect.field(o, "BagSlot38");
            BagSlot38Cap = Reflect.field(o, "BagSlot38Cap");
            BagSlot39 = Reflect.field(o, "BagSlot39");
            BagSlot39Cap = Reflect.field(o, "BagSlot39Cap");
            BagSlot40 = Reflect.field(o, "BagSlot40");
            BagSlot40Cap = Reflect.field(o, "BagSlot40Cap");
            
            xmcLuck = intOr(Reflect.field(o, "xmcLuck"), 0);
            gooProduced = intOr(Reflect.field(o, "gooProduced"), 0);
            alembicLevel = intOr(Reflect.field(o, "alembicLevel"), 0);
            alembicCatalyst = try cast(ItemType.lookupItem(stringOr(Reflect.field(o, "alembicCatalyst"), "")), AlembicCatalyst) catch(e:Dynamic) null;
            furnaceLevel = intOr(Reflect.field(o, "furnaceLevel"), 0);
            substanceStock = objectOr(Reflect.field(o, "substanceStock"), { });
            essenceStock = objectOr(Reflect.field(o, "essenceStock"), { });
            residueStock = objectOr(Reflect.field(o, "residueStock"), { });
            pigmentStock = objectOr(Reflect.field(o, "pigmentStock"), { });
            // Delete invalid elements
            for (k/* AS3HX WARNING could not determine type for var: k exp: ECall(EIdent(keys),[EIdent(substanceStock)]) type: null */ in keys(substanceStock))
            {
                if (AlchemyLib.Substances[k] == null)
                {
                    Reflect.deleteField(substanceStock, Std.string(k));
                }
            }
            for (k/* AS3HX WARNING could not determine type for var: k exp: ECall(EIdent(keys),[EIdent(essenceStock)]) type: null */ in keys(essenceStock))
            {
                if (AlchemyLib.Essences[k] == null)
                {
                    Reflect.deleteField(essenceStock, Std.string(k));
                }
            }
            for (k/* AS3HX WARNING could not determine type for var: k exp: ECall(EIdent(keys),[EIdent(residueStock)]) type: null */ in keys(residueStock))
            {
                if (AlchemyLib.Residues[k] == null)
                {
                    Reflect.deleteField(residueStock, Std.string(k));
                }
            }
            uncompressTfPillKnowledge(Reflect.field(o, "tfPillKnowledge"));
            uncompressIngredientKnowledge(Reflect.field(o, "ingredientKnowledge"));
        }
        // loading from old save
        else
        {
            
            resetState();
        }
    }
    
    public function isLuckyXianxiaMC() : Bool
    {
        return xmcLuck < 10 && flags[kFLAGS.PRIMARY_DIFFICULTY] == 7;
    }
    public function useXianxiaMCLuck() : Void
    {
        xmcLuck++;
    }
    
    /*
		public static const TYPE_ALCHEMY:int = 0;
		public static const TYPE_COOKING:int = 1;
		public static const TYPE_SMITHING:int = 2;
		public static const TYPE_TAILORING:int = 3;

		private var item1:ItemType = null;
		private var item1Quantity:int = 0;
		private var item2:ItemType = null;
		private var item2Quantity:int = 0;
		private var item3:ItemType = null;
		private var item3Quantity:int = 0;
		private var item4:ItemType = null;
		private var item4Quantity:int = 0;
		private var itemResult:ItemType = null;
		*/
    
    public var alchemyExtraction(default, never) : AlchemyExtraction = new AlchemyExtraction();
    public var mutagenPillCrafting(default, never) : MutagenPillCrafting = new MutagenPillCrafting();
    public var statPillCrafting(default, never) : StatPillCrafting = new StatPillCrafting();
    
    public function new()
    {
        super();
        Saves.registerSaveableState(this);
    }
    
    public function accessCraftingMaterialsBag() : Void
    {
        clearOutput();
        outputText("Would you like to put some crafting materials into the bag, and if so, with ones?\n\n");
        if (BagSlot01Cap > 0)
        {
            outputText("<b>Copper Ore:</b> " + BagSlot01 + " / " + BagSlot01Cap + "\n");
        }
        if (BagSlot02Cap > 0)
        {
            outputText("<b>Tin Ore:</b> " + BagSlot02 + " / " + BagSlot02Cap + "\n");
        }
        if (BagSlot03Cap > 0)
        {
            outputText("<b>Bronze Bar:</b> " + BagSlot03 + " / " + BagSlot03Cap + "\n");
        }
        if (BagSlot04Cap > 0)
        {
            outputText("<b>Iron Ore:</b> " + BagSlot04 + " / " + BagSlot04Cap + "\n");
        }
        //if (BagSlot05Cap > 0) outputText("<b>Ebonbloom:</b> "+BagSlot05+" / "+BagSlot05Cap+"\n");
        if (BagSlot06Cap > 0)
        {
            outputText("<b>Ebon Ingot:</b> " + BagSlot06 + " / " + BagSlot06Cap + "\n");
        }
        if (BagSlot07Cap > 0)
        {
            outputText("<b>Moonstone:</b> " + BagSlot07 + " / " + BagSlot07Cap + "\n");
        }
        //if (BagSlot08Cap > 0) outputText("<b>Skymetal:</b> "+BagSlot08+" / "+BagSlot08Cap+"\n");
        menu();
        //Copper Ore
        if (BagSlot01 < BagSlot01Cap)
        {
            if (player.hasItem(useables.COP_ORE, 1))
            {
                addButton(0, "CopperOre", craftingMaterialsCopperOre1UP);
            }
            else
            {
                addButtonDisabled(0, "CopperOre", "You don't have any copper ore to store.");
            }
        }
        else
        {
            addButtonDisabled(0, "CopperOre", "You can't store more copper ore in your bag.");
        }
        if (BagSlot01 > 0)
        {
            addButton(1, "CopperOre", craftingMaterialsCopperOre1Down);
        }
        else
        {
            addButtonDisabled(1, "CopperOre", "You don't have any copper ore in your bag.");
        }
        //Tin Ore
        if (BagSlot02 < BagSlot02Cap)
        {
            if (player.hasItem(useables.TIN_ORE, 1))
            {
                addButton(2, "TinOre", craftingMaterialsTinOre1UP);
            }
            else
            {
                addButtonDisabled(2, "TinOre", "You don't have any tin ore to store.");
            }
        }
        else
        {
            addButtonDisabled(2, "TinOre", "You can't store more tin ore in your bag.");
        }
        if (BagSlot02 > 0)
        {
            addButton(3, "TinOre", craftingMaterialsTinOre1Down);
        }
        else
        {
            addButtonDisabled(3, "TinOre", "You don't have any tin ore in your bag.");
        }
        //Bronze Bar
        if (BagSlot03 < BagSlot03Cap)
        {
            if (player.hasItem(useables.BRONZEB, 1))
            {
                addButton(5, "BronzeBar", craftingMaterialsBronzeBar1UP);
            }
            else
            {
                addButtonDisabled(5, "BronzeBar", "You don't have any bronze bar to store.");
            }
        }
        else
        {
            addButtonDisabled(5, "BronzeBar", "You can't store more copper ore in your bag.");
        }
        if (BagSlot03 > 0)
        {
            addButton(6, "BronzeBar", craftingMaterialsBronzeBar1Down);
        }
        else
        {
            addButtonDisabled(6, "BronzeBar", "You don't have any bronze bar in your bag.");
        }
        //Iron Ore
        if (BagSlot04 < BagSlot04Cap)
        {
            if (player.hasItem(useables.IRONORE, 1))
            {
                addButton(7, "IronOre", craftingMaterialsIronOre1UP);
            }
            else
            {
                addButtonDisabled(7, "IronOre", "You don't have any iron ore to store.");
            }
        }
        else
        {
            addButtonDisabled(7, "IronOre", "You can't store more iron ore in your bag.");
        }
        
        if (BagSlot04 > 0)
        {
            addButton(8, "IronOre", craftingMaterialsIronOre1Down);
        }
        else
        {
            addButtonDisabled(8, "IronOre", "You don't have any iron ore in your bag.");
        }
        //Ebon Ingot
        if (BagSlot06 < BagSlot06Cap)
        {
            if (player.hasItem(useables.EBONING, 1))
            {
                addButton(10, "EbonIngot", craftingMaterialsEbonIngot1UP);
            }
            else
            {
                addButtonDisabled(10, "EbonIngot", "You don't have any ebon ingot to store.");
            }
        }
        else
        {
            addButtonDisabled(10, "EbonIngot", "You can't store more ebon ingots in your bag.");
        }
        
        if (BagSlot06 > 0)
        {
            addButton(11, "EbonIngot", craftingMaterialsEbonIngot1Down);
        }
        else
        {
            addButtonDisabled(11, "EbonIngot", "You don't have any ebon ingot in your bag.");
        }
        //Moonstone
        if (BagSlot07 < BagSlot07Cap)
        {
            if (player.hasItem(useables.MOONSTO, 1))
            {
                addButton(12, "Moonstone", craftingMaterialsMoonstone1UP);
            }
            else
            {
                addButtonDisabled(12, "Moonstone", "You don't have any moonstone to store.");
            }
        }
        else
        {
            addButtonDisabled(12, "Moonstone", "You can't store more moonstones in your bag.");
        }
        
        if (BagSlot07 > 0)
        {
            addButton(13, "Moonstone", craftingMaterialsMoonstone1Down);
        }
        else
        {
            addButtonDisabled(13, "Moonstone", "You don't have any moonstone in your bag.");
        }
        addButton(14, "Back", craftingMain);
    }
    private function craftingMaterialsCopperOre1UP() : Void
    {
        player.destroyItems(useables.COP_ORE, 1);
        BagSlot01 += 1;
        doNext(accessCraftingMaterialsBag);
    }
    private function craftingMaterialsCopperOre1Down() : Void
    {
        outputText("\n");
        BagSlot01 -= 1;
        inventory.takeItem(useables.COP_ORE, accessCraftingMaterialsBag);
    }
    private function craftingMaterialsTinOre1UP() : Void
    {
        player.destroyItems(useables.TIN_ORE, 1);
        BagSlot02 += 1;
        doNext(accessCraftingMaterialsBag);
    }
    private function craftingMaterialsTinOre1Down() : Void
    {
        outputText("\n");
        BagSlot02 -= 1;
        inventory.takeItem(useables.TIN_ORE, accessCraftingMaterialsBag);
    }
    private function craftingMaterialsBronzeBar1UP() : Void
    {
        player.destroyItems(useables.BRONZEB, 1);
        BagSlot03 += 1;
        doNext(accessCraftingMaterialsBag);
    }
    private function craftingMaterialsBronzeBar1Down() : Void
    {
        outputText("\n");
        BagSlot03 -= 1;
        inventory.takeItem(useables.BRONZEB, accessCraftingMaterialsBag);
    }
    private function craftingMaterialsIronOre1UP() : Void
    {
        player.destroyItems(useables.IRONORE, 1);
        BagSlot04 += 1;
        doNext(accessCraftingMaterialsBag);
    }
    private function craftingMaterialsIronOre1Down() : Void
    {
        outputText("\n");
        BagSlot04 -= 1;
        inventory.takeItem(useables.IRONORE, accessCraftingMaterialsBag);
    }
    private function craftingMaterialsEbonIngot1UP() : Void
    {
        player.destroyItems(useables.EBONING, 1);
        BagSlot06 += 1;
        doNext(accessCraftingMaterialsBag);
    }
    private function craftingMaterialsEbonIngot1Down() : Void
    {
        outputText("\n");
        BagSlot06 -= 1;
        inventory.takeItem(useables.EBONING, accessCraftingMaterialsBag);
    }
    private function craftingMaterialsMoonstone1UP() : Void
    {
        player.destroyItems(useables.MOONSTO, 1);
        BagSlot07 += 1;
        doNext(accessCraftingMaterialsBag);
    }
    private function craftingMaterialsMoonstone1Down() : Void
    {
        outputText("\n");
        BagSlot07 -= 1;
        inventory.takeItem(useables.MOONSTO, accessCraftingMaterialsBag);
    }
    /*
		public function accessCraftingMenu(type:int, page:int = 1):void {
			clearOutput();
			outputText("What would you like to craft?");
			menu();
			if (type == TYPE_ALCHEMY) {

			}
			else if (type == TYPE_COOKING) {

			}
			else if (type == TYPE_SMITHING) {

			}
			else if (type == TYPE_TAILORING) {

			}
			addButton(14, "Back", campActions);
		}

		private function createCraftingRecipe(item:*, recipe:Array):void {
			var button:int = 0;
			var temp:int = 0;
			var goal:int = 14;
			while (temp < goal)
			{
				if (buttonIsVisible(temp)) {
					button++;
				}
				if (button == 4 || button == 9) button++;
				temp++;
			}
			addButton(button, item.shortName, displayCraftingRequirement, item, recipe);
		}

		private function meetsItemRequirement(id:int):Boolean {
			if (id == 1) {
				if (item1 == null) return true;
				if (player.hasItem(item1, item1Quantity)) return true;
			}
			else if (id == 2) {
				if (item2 == null) return true;
				if (player.hasItem(item2, item2Quantity)) return true;
			}
			else if (id == 3) {
				if (item3 == null) return true;
				if (player.hasItem(item3, item3Quantity)) return true;
			}
			else if (id == 4) {
				if (item4 == null) return true;
				if (player.hasItem(item4, item4Quantity)) return true;
			}
			return false;
		}

		private function displayCraftingRequirement(item:ItemType, recipe:Array):void {
			//Item #1
			if (recipe[0] != undefined) item1 = recipe[0];
			else item1 = null;
			if (recipe[1] != undefined) item1Quantity = recipe[1];
			//Item #2
			if (recipe[2] != undefined) item2 = recipe[2];
			else item2 = null;
			if (recipe[3] != undefined) item2Quantity = recipe[3];
			//Item #3
			if (recipe[4] != undefined) item3 = recipe[4];
			else item3 = null;
			if (recipe[5] != undefined) item3Quantity = recipe[5];
			//Item #4
			if (recipe[6] != undefined) item4 = recipe[6];
			else item4 = null;
			if (recipe[7] != undefined) item4Quantity = recipe[7];
			//Set result item
			itemResult = item;
			clearOutput();
			outputText("<b>Item:</b> " + item.longName + "\n\n");
			outputText("<b><u>Items Needed:</u></b>\n");
			if (item1 != null) {
				if (player.hasItem(item1, item1Quantity)) outputText("[font-green]" + player.itemCount(item1) + " / " + item1Quantity + " " + item1.longName + "[/font]");
				else outputText("[font-dred]" + player.itemCount(item1) + " / " + item1Quantity + " " + item1.longName + "[/font]");
				outputText("\n");
			}
			if (item2 != null) {
				if (player.hasItem(item2, item2Quantity)) outputText("[font-green]" + player.itemCount(item2) + " / " + item2Quantity + " " + item2.longName + "[/font]");
				else outputText("[font-dred]" + player.itemCount(item2) + " / " + item2Quantity + " " + item2.longName + "[/font]");
				outputText("\n");
			}
			if (item3 != null) {
				if (player.hasItem(item3, item3Quantity)) outputText("[font-green]" + player.itemCount(item3) + " / " + item3Quantity + " " + item3.longName + "[/font]");
				else outputText("[font-dred]" + player.itemCount(item3) + " / " + item3Quantity + " " + item3.longName + "[/font]");
				outputText("\n");
			}
			if (item4 != null) {
				if (player.hasItem(item4, item4Quantity)) outputText("[font-green]" + player.itemCount(item4) + " / " + item4Quantity + " " + item4.longName + "[/font]");
				else outputText("[font-dred]" + player.itemCount(item4) + " / " + item4Quantity + " " + item4.longName + "[/font]");
				outputText("\n");
			}
			outputText("\n");
			//Is it okay to craft this shit?
			if (meetsItemRequirement(1) && meetsItemRequirement(2) && meetsItemRequirement(3) && meetsItemRequirement(4)) {
				outputText("Would you like to craft this item?");
				doYesNo(craftItem, accessCraftingMenu);
			}
			else {
				outputText("You do not have the required ingredients to craft this item.");
				doNext(accessCraftingMenu);
			}
		}

		private function craftItem():void {
			clearOutput();
			if (item1 != null) player.destroyItems(item1, item1Quantity);
			if (item2 != null) player.destroyItems(item2, item2Quantity);
			if (item3 != null) player.destroyItems(item3, item3Quantity);
			if (item4 != null) player.destroyItems(item4, item4Quantity);
			inventory.takeItem(itemResult, accessCraftingMenu);
		}*/
    
    
    public function feedAetherTwinsMaterialFromOreBag(itype : ItemType) : Void
    {
        switch (itype)
        {
            case useables.COP_ORE:BagSlot01 -= 1;
            case useables.TIN_ORE:BagSlot02 -= 1;
            case useables.BRONZEB:BagSlot03 -= 1;
            case useables.IRONORE:BagSlot04 -= 1;
            case useables.EBONING:BagSlot06 -= 1;
            case useables.MOONSTO:BagSlot07 -= 1;
        }
        return;
    }
    public function roomForMaterial(itype : ItemType) : Float
    {
        switch (itype)
        {
            case useables.COP_ORE:if (BagSlot01 < BagSlot01Cap)
                {
                    return BagSlot01;
                }
            case useables.TIN_ORE:if (BagSlot02 < BagSlot02Cap)
                {
                    return BagSlot02;
                }
            case useables.BRONZEB:if (BagSlot03 < BagSlot03Cap)
                {
                    return BagSlot03;
                }
            case useables.IRONORE:if (BagSlot04 < BagSlot04Cap)
                {
                    return BagSlot04;
                }
            case useables.EBONING:if (BagSlot06 < BagSlot06Cap)
                {
                    return BagSlot06;
                }
            case useables.MOONSTO:if (BagSlot07 < BagSlot07Cap)
                {
                    return BagSlot07;
                }
        }
        return -1;
    }
    public function placeMaterialInBag(itype : ItemType) : Float
    {
        switch (itype)
        {
            case useables.COP_ORE:craftingMaterialsCopperOre1UP();
            case useables.TIN_ORE:craftingMaterialsTinOre1UP();
            case useables.BRONZEB:craftingMaterialsBronzeBar1UP();
            case useables.IRONORE:craftingMaterialsIronOre1UP();
            case useables.EBONING:craftingMaterialsEbonIngot1UP();
            case useables.MOONSTO:craftingMaterialsMoonstone1UP();
        }
        return -1;
    }
    public function hasMaterial(itype : ItemType) : Float
    {
        switch (itype)
        {
            case useables.COP_ORE:return BagSlot01;
            case useables.TIN_ORE:return BagSlot02;
            case useables.BRONZEB:return BagSlot03;
            case useables.IRONORE:return BagSlot04;
            case useables.EBONING:return BagSlot06;
            case useables.MOONSTO:return BagSlot07;
        }
        return -1;
    }
    public function useMaterial(itype : ItemType, amount : Float = 1) : Bool
    {
        switch (itype)
        {
            case useables.COP_ORE, useables.TIN_ORE, useables.BRONZEB, useables.IRONORE, useables.EBONING, useables.MOONSTO:

                switch (itype)
                {case useables.COP_ORE:if (BagSlot01 >= amount)
                        {
                            BagSlot01 -= amount;
                            return true;
                        }
                        else
                        {
                            return false;
                        }
                }

                switch (itype)
                {case useables.TIN_ORE:if (BagSlot02 >= amount)
                        {
                            BagSlot02 -= amount;
                            return true;
                        }
                        else
                        {
                            return false;
                        }
                }

                switch (itype)
                {case useables.BRONZEB:if (BagSlot03 >= amount)
                        {
                            BagSlot03 -= amount;
                            return true;
                        }
                        else
                        {
                            return false;
                        }
                }

                switch (itype)
                {case useables.IRONORE:if (BagSlot04 >= amount)
                        {
                            BagSlot04 -= amount;
                            return true;
                        }
                        else
                        {
                            return false;
                        }
                }

                switch (itype)
                {case useables.EBONING:if (BagSlot06 >= amount)
                        {
                            BagSlot06 -= amount;
                            return true;
                        }
                        else
                        {
                            return false;
                        }
                }if (BagSlot07 >= amount)
                {
                    BagSlot07 -= amount;
                    return true;
                }
                else
                {
                    return false;
                }
        }
        return false;
    }
    
    public function craftingMain() : Void
    {
        clearOutput();
        
        if (alembicLevel > 0)
        {
            outputText("You can use your " + alchemyExtraction.alembicName() + " to extract alchemical reagents from consumable items.\n");
        }
        if (furnaceLevel > 0)
        {
            outputText("With " + mutagenPillCrafting.furnaceName() + " you can refine alchemical reagents into pills.\n");
        }
        outputText("If you have pigments and foundations, you can mix them into hair dyes and eye drops.\n");
        
        outputText("\nWhat will you do?");
        
        menu();
        // [Extract ] [Mut.Pill] [StatPill] [Dyes    ] [Stock   ]
        // [        ] [        ] [        ] [        ] [        ]
        // [        ] [        ] [Bag     ] [Cheat   ] [Back    ]
        button(0).show("Extract", alchemyExtraction.extractionMenu).hint("Refined mutagens into alchemical reagents using your alembic.").icon("I_Potion_Empty").disableIf(alembicLevel == 0, "You don't have an alembic!");
        button(1).show("Mutagen Pills", mutagenPillCrafting.craftingMenu).hint("Craft mutagen pills in your alchemical furnace.").icon("I_MutagenPill_5").disableIf(furnaceLevel == 0, "You don't have an alchemical furnace!");
        button(2).show("Stat Pills", statPillCrafting.craftingMenu).hint("Craft enhancing pills in your alchemical furnace.").icon("I_StatBonusPill_5").disableIf(furnaceLevel == 0, "You don't have an alchemical furnace!");
        button(3).show("Dyes", dyeCraftingMenu).hint("Mix dyes using pigments.").icon("I_HairDye");
        button(4).show("Stock", checkStock).hint("Check your stock of crafting materials.");
        button(12).show("Bag", accessCraftingMaterialsBag).hint("Manage your bag with crafting materials.").disableIf(BagSlot01Cap <= 0, "You'll need a bag to do that.");
        if (debug)
        {
            button(13).show("Cheat", craftingCheats);
        }
        button(14).show("Back", camp.campActions).icon("Back");
    }
    
    public function checkStock(withMenu : Bool = false) : Void
    {
        clearOutput();
        
        var printAlchemyReagentStock : Int->Void = function(type : Int) : Void
        {
            var a : Array<Dynamic>;
            // Array of [AlchemyReagent, quantity:int, name:String]
            var list : Array<Dynamic>;
            list = listAlchemyReagents(type).sortOn("2");
            if (list.length == 0)
            {
                outputText(" none\n");
            }
            else
            {
                outputText("<ul>");
                for (a in list)
                {
                    outputText("<li>" + Reflect.field(a, Std.string(1)) + " x " + Reflect.field(a, Std.string(2)) + "</li>");
                }
                outputText("</ul>");
            }
        }
        outputText("<b>Reagent storage capacity: </b>" + maxReagentCount() + " each.");
        outputText("\n");
        outputText("\n<b><u>Alchemical substances</u></b>:");
        printAlchemyReagentStock(AlchemyLib.RT_SUBSTANCE);
        outputText("\n<b><u>Alchemical essences</u></b>:");
        printAlchemyReagentStock(AlchemyLib.RT_ESSENCE);
        outputText("\n<b><u>Alchemical residues</u></b>:");
        printAlchemyReagentStock(AlchemyLib.RT_RESIDUE);
        outputText("\n<b><u>Alchemical pigments</u></b>:");
        printAlchemyReagentStock(AlchemyLib.RT_PIGMENT);
        flushOutputTextToGUI();
        if (withMenu)
        {
            menu();
            button(14).show("Back", craftingMain).icon("Back");
        }
    }
    
    private function craftingCheats() : Void
    {
        clearOutput();
        outputText("You have:");
        outputText("<ul>");
        outputText("<li>" + alchemyExtraction.alembicName() + "</li>");
        outputText("<li>" + mutagenPillCrafting.furnaceName() + "</li>");
        outputText("</ul>");
        var setAlembic : Int->Void = function(level : Int) : Void
        {
            alembicLevel = level;
            craftingCheats();
        }
        var setFurnace : Int->Void = function(level : Int) : Void
        {
            furnaceLevel = level;
            craftingCheats();
        }
        var cheatReagents : Void->Void = function() : Void
        {
            var i : Int;
            for (i in 1...AlchemyLib.Substances.length)
            {
                if (AlchemyLib.Substances[i] != null)
                {
                    addSubstance(i, 10);
                }
            }
            for (i in 1...AlchemyLib.Essences.length)
            {
                if (AlchemyLib.Essences[i] != null)
                {
                    addEssence(i, 10);
                }
            }
            for (i in 1...AlchemyLib.Residues.length)
            {
                if (AlchemyLib.Residues[i] != null)
                {
                    addResidue(i, 10);
                }
            }
            
            craftingMain();
            checkStock();
        }
        var cheatSpawnItems : Void->Void = function() : Void
        {
            var storage : Array<Dynamic> = [];
            for (type/* AS3HX WARNING could not determine type for var: type exp: EField(EIdent(useables),List_AllCatalysts) type: null */ in useables.List_AllCatalysts)
            {
                var slot : ItemSlotClass = new ItemSlotClass();
                slot.unlocked = true;
                slot.setItemAndQty(type, 1);
                storage.push(slot);
            }
            for (id in Reflect.fields(statPillCrafting.ValidIngredients))
            {
                slot = new ItemSlotClass();
                slot.unlocked = true;
                slot.setItemAndQty(ItemType.lookupItem(id), 10);
                storage.push(slot);
            }
            inventory.transferMenu(storage, 0, storage.length, craftingMain, "Cheat dimension", null, true, false);
        }
        var cheatKnowledge : Void->Void = function() : Void
        {
            for (s in 1...AlchemyLib.Substances.length)
            {
                if (AlchemyLib.Substances[s] == null)
                {
                    continue;
                }
                for (e in 1...AlchemyLib.Essences.length)
                {
                    if (AlchemyLib.Essences[e] == null)
                    {
                        continue;
                    }
                    setTfPillKnown(s, e);
                }
            }
            for (o/* AS3HX WARNING could not determine type for var: o exp: ECall(EIdent(values),[EIdent(consumables)]) type: null */ in values(consumables))
            {
                var item : Consumable = try cast(o, Consumable) catch(e:Dynamic) null;
                if (item == null)
                {
                    continue;
                }
                for (ar/* AS3HX WARNING could not determine type for var: ar exp: ECall(EField(EIdent(item),getAllRefineReagents),[]) type: null */ in item.getAllRefineReagents())
                {
                    setReagentKnown(item.id, ar.type, ar.key());
                }
            }
            craftingCheats();
        }
        menu();
        // [Alembic1] [Furnace1] [        ] [        ] [Knowledg]
        // [Alembic2] [Furnace2] [        ] [        ] [Alc.Reag]
        // [Alembic3] [Furnace3] [        ] [ Items  ] [ Back   ]
        button(0).show("Alembic1", curry(setAlembic, 1));
        button(1).show("Furnace1", curry(setFurnace, 1));
        button(4).show("Knowledge", cheatKnowledge);
        button(5).show("Alembic2", curry(setAlembic, 2));
        button(6).show("Furnace2", curry(setFurnace, 2));
        button(9).show("Alc.Reags", cheatReagents).hint("Get 10 of every alchemical reagent (except pigments)");
        button(10).show("Alembic3", curry(setAlembic, 3));
        button(11).show("Furnace3", curry(setFurnace, 3));
        button(13).show("Items", cheatSpawnItems).hint("Spawn items like alembic catalysts.");
        button(14).show("Back", craftingMain);
    }
    
    //=========//
    // ALCHEMY //
    //=========//
    
    
    public function maxReagentCount() : Int
    {
        return 100;
    }
    public function addSubstance(id : Int, change : Int = +1) : Int
    {
        if (AlchemyLib.Substances[id] == null)
        {
            throw new Error("Invalid alchemical substance " + id);
        }
        var count : Int = Reflect.field(substanceStock, Std.string(id));
        count = boundInt(0, count + change, maxReagentCount());
        if (count > 0)
        {
            Reflect.setField(substanceStock, Std.string(id), count);
        }
        else
        {
            Reflect.deleteField(substanceStock, Std.string(id));
        }
        return count;
    }
    public function addEssence(id : Int, change : Int = +1) : Int
    {
        if (AlchemyLib.Essences[id] == null)
        {
            throw new Error("Invalid alchemical essence " + id);
        }
        var count : Int = Reflect.field(essenceStock, Std.string(id));
        count = boundInt(0, count + change, maxReagentCount());
        if (count > 0)
        {
            Reflect.setField(essenceStock, Std.string(id), count);
        }
        else
        {
            Reflect.deleteField(essenceStock, Std.string(id));
        }
        return count;
    }
    public function addResidue(id : Int, change : Int = +1) : Int
    {
        if (AlchemyLib.Residues[id] == null)
        {
            throw new Error("Invalid alchemical residue " + id);
        }
        var count : Int = Reflect.field(residueStock, Std.string(id));
        count = boundInt(0, count + change, maxReagentCount());
        if (count > 0)
        {
            Reflect.setField(residueStock, Std.string(id), count);
        }
        else
        {
            Reflect.deleteField(residueStock, Std.string(id));
        }
        return count;
    }
    public function addPigment(id : String, change : Int = +1) : Int
    {
        var count : Int = Reflect.field(pigmentStock, id);
        count = boundInt(0, count + change, maxReagentCount());
        if (count > 0)
        {
            Reflect.setField(pigmentStock, id, count);
        }
        else
        {
            Reflect.deleteField(pigmentStock, id);
        }
        return count;
    }
    public function addAlchemyReagent(ac : AlchemyReagent, change : Int = +1) : Int
    {
        var _sw1_ = (ac.type);        

        switch (_sw1_)
        {
            case AlchemyLib.RT_SUBSTANCE:
                return addSubstance(ac.intValue, change);
            case AlchemyLib.RT_ESSENCE:
                return addEssence(ac.intValue, change);
            case AlchemyLib.RT_RESIDUE:
                return addResidue(ac.intValue, change);
            case AlchemyLib.RT_PIGMENT:
                return addPigment(ac.stringValue, change);
        }
        return 0;
    }
    // Array of [AlchemyReagent, quantity:int, name:String, value:int|String]
    public function listAlchemyReagents(type : Int) : Array<Dynamic>
    {
        var result : Array<Dynamic> = [];
        var key : String;
        var ac : AlchemyReagent;
        switch (type)
        {
            case AlchemyLib.RT_SUBSTANCE:
                for (key in Reflect.fields(substanceStock))
                {
                    if (Reflect.field(substanceStock, key) > 0)
                    {
                        ac = AlchemyReagent.substance(as3hx.Compat.parseInt(key));
                        result.push([ac, Reflect.field(substanceStock, key), ac.name(), as3hx.Compat.parseInt(key)]);
                    }
                }
            case AlchemyLib.RT_ESSENCE:
                for (key in Reflect.fields(essenceStock))
                {
                    if (Reflect.field(essenceStock, key) > 0)
                    {
                        ac = AlchemyReagent.essence(as3hx.Compat.parseInt(key));
                        result.push([ac, Reflect.field(essenceStock, key), ac.name(), as3hx.Compat.parseInt(key)]);
                    }
                }
            case AlchemyLib.RT_RESIDUE:
                for (key in Reflect.fields(residueStock))
                {
                    if (Reflect.field(residueStock, key) > 0)
                    {
                        ac = AlchemyReagent.residue(as3hx.Compat.parseInt(key));
                        result.push([ac, Reflect.field(residueStock, key), ac.name(), as3hx.Compat.parseInt(key)]);
                    }
                }
            case AlchemyLib.RT_PIGMENT:
                for (key in Reflect.fields(pigmentStock))
                {
                    if (Reflect.field(pigmentStock, key) > 0)
                    {
                        ac = AlchemyReagent.pigment(key);
                        result.push([ac, Reflect.field(pigmentStock, key), ac.name(), key]);
                    }
                }
        }
        return result;
    }
    
    //================================//
    // ALCHEMY - KNOWLEDGE MANAGEMENT //
    //================================//
    // { itemId: { reagentType: { reagentId: true } } }
    // compressed into
    // { itemId: [ compressedRT1, compressedRT2, compressedRT3, compressedRT4 ]
    // where compressedRTX is knowledge of reagent type X in form:
    // "*" - all known, "0" - all unknown
    // else array of values
    // e.g.
    // { FoxJewl: {
    //              RT_SUBSTANCE: { 2 :true, 19:true, /* some unknown */ }
    //              RT_ESSENCE: { all: true },
    //              RT_RESIDUE: { 5: true, /* some unknown */ },
    //              RT_PIGMENT: {}
    // }          }
    // =>
    // { FoxJewl: [ [2,19], "*", [5], "0" ] }
    private function compressIngredientKnowledge() : Dynamic
    {
        var compressOneEntry : Dynamic->Consumable->Int->Dynamic = function(source : Dynamic, itype : Consumable, rtype : Int) : Dynamic
        {
            if (source == null)
            {
                return "0";
            }
            var reagents : Array<Dynamic> = itype.getRefineReagents(rtype);
            var hasUnknown : Bool = false;
            var hasKnown : Bool = false;
            for (ar in reagents)
            {
                if (Reflect.field(source, Std.string(ar.key())) != null)
                {
                    hasKnown = true;
                }
                else
                {
                    hasUnknown = true;
                }
                if (hasKnown && hasUnknown)
                {
                    break;
                }
            }
            if (hasKnown && !hasUnknown)
            {
                return "*";
            }
            if (!hasKnown && hasUnknown)
            {
                return "0";
            }
            var result : Array<Dynamic> = [];
            for (ar in reagents)
            {
                if (Reflect.field(source, Std.string(ar.key())) != null)
                {
                    result.push(ar.key());
                }
            }
            return result;
        }
        var result : Dynamic = { };
        for (itemId in Reflect.fields(ingredientKnowledge))
        {
            var source : Dynamic = Reflect.field(ingredientKnowledge, itemId);
            if (source == null)
            {
                continue;
            }
            var itype : Consumable = try cast(ItemType.lookupItem(itemId), Consumable) catch(e:Dynamic) null;
            if (itype == null)
            {
                continue;
            }
            var data : Array<Dynamic> = [];
            for (rt in 1  /* SUBSTANCE */  ...4  /* PIGMENT */   + 1)
            {
                data.push(compressOneEntry(Reflect.field(source, Std.string(rt)), itype, rt));
            }
            Reflect.setField(result, itemId, data);
        }
        return result;
    }
    private function uncompressIngredientKnowledge(compressed : Dynamic) : Void
    {
        var uncompressOneEntry : Dynamic->Consumable->Int->Dynamic = function(source : Dynamic, itype : Consumable, rtype : Int) : Dynamic
        {
            if (source == null || source == "0")
            {
                return { };
            }
            var result : Dynamic = { };
            if (source == "*")
            {
                for (ar/* AS3HX WARNING could not determine type for var: ar exp: ECall(EField(EIdent(itype),getRefineReagents),[EIdent(rtype)]) type: null */ in itype.getRefineReagents(rtype))
                {
                    Reflect.setField(result, Std.string(ar.key()), true);
                }
            }
            for (key/* AS3HX WARNING could not determine type for var: key exp: EParent(EBinop(as,EIdent(source),EIdent(Array),false)) type: null */ in (try cast(source, Array</*AS3HX WARNING no type*/>) catch(e:Dynamic) null))
            {
                Reflect.setField(result, Std.string(key), true);
            }
            return result;
        }
        ingredientKnowledge = { };
        for (itemId in Reflect.fields(compressed))
        {
            var itemType : Consumable = try cast(ItemType.lookupItem(itemId), Consumable) catch(e:Dynamic) null;
            if (itemType == null)
            {
                continue;
            }
            var sourceData : Array<Dynamic> = try cast(Reflect.field(compressed, itemId), Array</*AS3HX WARNING no type*/>) catch(e:Dynamic) null;
            var itemEntry : Dynamic = { };
            for (rt in 1  /* SUBSTANCE */  ...4  /* PIGMENT */   + 1)
            {
                Reflect.setField(itemEntry, Std.string(rt), uncompressOneEntry(sourceData[rt - 1], itemType, rt));
            }
            Reflect.setField(ingredientKnowledge, itemId, itemEntry);
        }
    }
    // { TF_1_2:true, TF_4_5:true } -> ["TF_1_2", "TF_4_5"]
    private function compressTfPillKnowledge() : Array<Dynamic>
    {
        return keys(tfPillKnowledge);
    }
    private function uncompressTfPillKnowledge(compressed : Array<Dynamic>) : Void
    {
        tfPillKnowledge = { };
        for (tf in compressed)
        {
            Reflect.setField(tfPillKnowledge, Std.string(tf), true);
        }
    }
    
    public function isTfPillKnown(substance : Int, essence : Int) : Bool
    {
        return !!Reflect.field(tfPillKnowledge, Std.string("TF_" + substance + "_" + essence));
    }
    public function setTfPillKnown(substance : Int, essence : Int) : Void
    {
        Reflect.setField(tfPillKnowledge, Std.string("TF_" + substance + "_" + essence), substance);
    }
    public function isReagentKnown(itemId : String, reagentType : Int, reagentKey : Dynamic) : Bool
    {
        var o : Dynamic = Reflect.field(ingredientKnowledge, itemId);
        if (o == null)
        {
            return false;
        }
        o = Reflect.field(o, Std.string(reagentType));
        if (o == null)
        {
            return false;
        }
        return !!Reflect.field(o, Std.string(reagentKey));
    }
    public function setReagentKnown(itemId : String, reagentType : Int, reagentKey : Dynamic) : Void
    {
        var ik : Dynamic = Reflect.field(ingredientKnowledge, itemId);
        if (ik == null)
        {
            ik = (Reflect.setField(ingredientKnowledge, itemId, { }));
        }
        var rk : Dynamic = Reflect.field(ik, Std.string(reagentType));
        if (rk == null)
        {
            rk = (Reflect.setField(ik, Std.string(reagentType), { }));
        }
        Reflect.setField(rk, Std.string(reagentKey), true);
    }
    public function alchemyFurnaceObject() : EnumValue
    {
        return Crafting.FURNACE_LEVELS[furnaceLevel];
    }
    public function alchemyFurnaceStoneSafeLimit() : Int
    {
        return alchemyFurnaceObject().stoneLimit;
    }
    /**
		 * List reagents of type. On click, **take one from storage** and call `callback(value)`
		 * @param type AlchemyLib.RT_XXXX
		 * @param callback function(value:int|String):void
		 * @param backFn function():void
		 * @param current int|String, selected reagent.
		 */
    public function selectReagent(type : Int, callback : Function, backFn : Function, current : Dynamic) : Void
    {
        clearOutput();
        mainView.linkHandler = function(event : String) : Void
                {
                    if (type == AlchemyLib.RT_PIGMENT)
                    {
                        addPigment(event, -1);
                        callback(event);
                    }
                    else
                    {
                        addAlchemyReagent(AlchemyReagent.getReagent(type, as3hx.Compat.parseInt(event)), -1);
                        callback(as3hx.Compat.parseInt(event));
                    }
                };
        outputText("<b>Alchemical " + AlchemyLib.ReagentTypes[type].name + "s</b>:");
        var list : Array<Dynamic> = SceneLib.crafting.listAlchemyReagents(type).sortOn("2");
        if (list.length == 0)
        {
            outputText("\nYou don't have any! Refine ingredients in the alembic.");
        }
        else
        {
            outputText("<ul>");
            for (element in list)
            {
                outputText("<li>");
                outputText(mkLink(Reflect.field(element, Std.string(2)) + " (" + Reflect.field(element, Std.string(1)) + ")", Std.string(Reflect.field(element, Std.string(3)))));
                if (Reflect.field(element, Std.string(3)) == current)
                {
                    outputText(" - selected");
                }
                outputText("</li>");
            }
            outputText("</ul>");
        }
        
        menu();
        button(14).show("Back", backFn).icon("Back");
    }
    //======================//
    // ALCHEMY - DYE MIXING //
    //======================//
    
    private var selectedPigment : String = "";
    private function selectPigment(pigment : String) : Void
    {
        if (selectedPigment != null)
        
        // Give back old pigment{
            
            addPigment(selectedPigment);
        }
        selectedPigment = pigment;
        dyeCraftingMenu();
    }
    public function dyeCraftingMenu() : Void
    {
        clearOutput();
        
        // if we're returning from crafting and used last pigment
        var dyeFnd : Int = player.itemCount(useables.DYE_FOUNDATION);
        var oilFnd : Int = player.itemCount(useables.OIL_FOUNDATION);
        var dropFnd : Int = player.itemCount(useables.DROP_FOUNDATION);
        outputText("You prepare the glassware to mix some dyes. ");
        outputText("\n");
        outputText("\n<b>Selected pigment</b>: " + ((selectedPigment != null) ? selectedPigment : "<i>none</i>"));
        outputText("\n<b>Dye foundations</b>: " + dyeFnd);
        outputText("\n<b>Skin oil foundations</b>: " + oilFnd);
        outputText("\n<b>Eyedrop foundations</b>: " + dropFnd);
        
        if (keys(pigmentStock).length == 0)
        {
            outputText("\n\n<b>You don't have any pigments. Pigments can be extracted from consumables.</b> ");
        }
        if (dyeFnd == 0 && oilFnd == 0 && dropFnd == 0)
        {
            outputText("\n\n<b>You have no foundations. Buy some from hair dye vendor.</b>");
        }
        
        menu();
        button(0).show("Pigment", curry(selectReagent, AlchemyLib.RT_PIGMENT, selectPigment, dyeCraftingMenu, selectedPigment)).hint("Select a pigment to use").disableIf(keys(pigmentStock).length == 0);
        button(1).show("Craft Dye", craftHairDye).hint("Craft " + selectedPigment + " hair dye.\n\nIt can be applied to fur, scales, and chiting with the use of additional reagents.").icon("I_HairDye").disableIf(dyeFnd == 0, "++\n<b>You need a dye foundation!</b>").disableIf(!selectedPigment, "Select a pigment");
        button(2).show("Craft Oil", craftSkinDye).hint("Craft " + selectedPigment + " skin oil.").icon("I_SkinOil").disableIf(oilFnd == 0, "++\n<b>You need an oil foundation!</b>").disableIf(!selectedPigment, "Select a pigment");
        button(3).show("Craft Eyedrops", craftEyeDye).hint("Craft " + selectedPigment + " eye drops.").icon("I_EyeDye").disableIf(dropFnd == 0, "++\n<b>You need an eyedrop foundation!</b>").disableIf(!selectedPigment, "Select a pigment");
        
        button(14).show("Back", function() : Void
                        {
                            if (selectedPigment != null)
                            {
                                addPigment(selectedPigment);
                            }
                            selectedPigment = "";
                            craftingMain();
                        }).icon("Back");
    }
    private function craftHairDye() : Void
    {
        clearOutput();
        player.giveAlchemyXP(1);
        outputText("You pour the pigment into foundation and stir it with a spoon. The viscous mixture quickly turns " + selectedPigment + ". You stir it for one more minute to get a uniform coloring, and then cork the vial.\n");
        player.destroyItems(useables.DYE_FOUNDATION, 1, true);
        inventory.takeItem(itemTemplates.createHairDye(selectedPigment, 1), dyeCraftingMenu);
        selectedPigment = "";
    }
    private function craftSkinDye() : Void
    {
        clearOutput();
        player.giveAlchemyXP(1);
        outputText("You pour the pigment into foundation and stir it with a spoon. The viscous mixture quickly turns " + selectedPigment + ". You stir it for one more minute to get a uniform coloring, and then cork the bottle.\n");
        player.destroyItems(useables.OIL_FOUNDATION, 1, true);
        inventory.takeItem(itemTemplates.createSkinOil(selectedPigment), dyeCraftingMenu);
        selectedPigment = "";
    }
    private function craftEyeDye() : Void
    {
        clearOutput();
        player.giveAlchemyXP(1);
        outputText("You pour the pigment into foundation and stir it with a spoon. The mixture quickly turns " + selectedPigment + ". You stir it for one more minute to get a uniform coloring, and then cork the vial.\n");
        player.destroyItems(useables.DROP_FOUNDATION, 1, true);
        inventory.takeItem(itemTemplates.createEyeDye(selectedPigment), dyeCraftingMenu);
        selectedPigment = "";
    }
}

