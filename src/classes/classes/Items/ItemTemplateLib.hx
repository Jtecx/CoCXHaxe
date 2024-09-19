package classes.items;

import flash.errors.Error;
import classes.ItemTemplate;
import classes.items.alchemy.MutagenPill;
import classes.items.alchemy.StatBonusPill;
import classes.items.consumables.EyeDye;
import classes.items.consumables.HairDye;
import classes.items.consumables.SkinOil;
import classes.items.dynamic.DynamicArmor;
import classes.items.dynamic.DynamicRing;
import classes.items.dynamic.DynamicShield;
import classes.items.dynamic.DynamicWeapon;
import classes.items.dynamic.DynamicWeaponRange;

class ItemTemplateLib
{
    public static var instance : ItemTemplateLib;
    
    public var THairDye(default, never) : ItemTemplate = mk("HairDye", "Hair Dye", HairDye, {
                    category : "consumable",
                    params : [
                    {
                        name : "color",
                        type : "text",
                        value : "White"
                    }, 
                    /** Affects price */
                    {
                        name : "rarity",
                        type : "number",
                        value : 1,
                        min : 1,
                        max : 4
                    }
            ]
                });
    
    public function createHairDye(color : String, rarity : Int) : HairDye
    {
        return try cast(THairDye.createItem({
                    color : color,
                    rarity : rarity
                }), HairDye) catch(e:Dynamic) null;
    }
    
    public var TSkinOil(default, never) : ItemTemplate = mk("SkinOil", "Skin Oil", SkinOil, {
                    category : "consumable",
                    params : [
                    {
                        name : "color",
                        type : "text",
                        value : "white"
                    }
            ]
                });
    
    public function createSkinOil(color : String) : SkinOil
    {
        return try cast(TSkinOil.createItem({
                    color : color
                }), SkinOil) catch(e:Dynamic) null;
    }
    
    public var TEyeDye(default, never) : ItemTemplate = mk("EyeDye", "Eye Dye", EyeDye, {
                    category : "consumable",
                    params : [
                    {
                        name : "color",
                        type : "text",
                        value : "white"
                    }
            ]
                });
    
    public function createEyeDye(color : String) : EyeDye
    {
        return try cast(TEyeDye.createItem({
                    color : color
                }), EyeDye) catch(e:Dynamic) null;
    }
    
    public var TMutagenPill(default, never) : ItemTemplate = mk("MutagenPill", "Mutagen Pill", MutagenPill, {
                    category : "consumable",
                    params : [
                    {
                        name : "tf",
                        type : "text",
                        value : "TF_1_1"
                    }, 
                    {
                        name : "p",
                        type : "number",
                        value : 1,
                        min : 1,
                        max : 5
                    }
            ]
                });
    
    public function createMutagenPill(substance : Int, essence : Int, power : Int) : MutagenPill
    {
        return try cast(TMutagenPill.createItem({
                    tf : "TF_" + substance + "_" + essence,
                    p : power
                }), MutagenPill) catch(e:Dynamic) null;
    }
    
    public var TStatBonussPill(default, never) : ItemTemplate = mk("StatBonusPill", "Stat Bonus Pill", StatBonusPill, {
                    category : "consumable",
                    params : [
                    {
                        name : "r",
                        type : "number",
                        value : 1,
                        min : 1,
                        max : 12
                    }, 
                    {
                        name : "p",
                        type : "number",
                        value : 1,
                        min : 1,
                        max : 5
                    }
            ]
                });
    
    public function createStatBonusPill(residue : Int, power : Int) : StatBonusPill
    {
        return try cast(TStatBonussPill.createItem({
                    r : residue,
                    p : power
                }), StatBonusPill) catch(e:Dynamic) null;
    }
    
    // Generic dynamic items
    
    public var TDynamicWeapon(default, never) : ItemTemplate = mk("DynamicWeapon", "Enchanted Weapon", DynamicWeapon, {
                    category : "weapon",
                    params : [
                    {
                        name : "t",
                        label : "Subtype",
                        type : "text",
                        value : "sword"
                    }, 
                    {
                        name : "r",
                        label : "Rarity",
                        type : "number",
                        value : 0,
                        min : 0,
                        max : 4
                    }, 
                    {
                        name : "q",
                        label : "Quality",
                        type : "number",
                        value : 0,
                        min : -15,
                        max : 15
                    }, 
                    {
                        name : "c",
                        label : "Curse",
                        type : "number",
                        value : 0,
                        min : 0,
                        max : 3
                    }, 
                    {
                        name : "e",
                        label : "Effects",
                        type : "enchantments",
                        value : []
                    }
            ]
                });
    
    public function createWeapon(subtype : String, rarity : Int, quality : Int, curseStatus : Int, effects : Array<Dynamic>) : DynamicWeapon
    {
        return try cast(DynamicItems.createItem(TDynamicWeapon, subtype, rarity, quality, curseStatus, effects), DynamicWeapon) catch(e:Dynamic) null;
    }
    
    public var TDynamicWeaponRange(default, never) : ItemTemplate = mk("DynamicWeaponRange", "Enchanted Weapon Ranged", DynamicWeapon, {
                    category : "weaponRange",
                    params : [
                    {
                        name : "t",
                        label : "Subtype",
                        type : "text",
                        value : "sword"
                    }, 
                    {
                        name : "r",
                        label : "Rarity",
                        type : "number",
                        value : 0,
                        min : 0,
                        max : 4
                    }, 
                    {
                        name : "q",
                        label : "Quality",
                        type : "number",
                        value : 0,
                        min : -15,
                        max : 15
                    }, 
                    {
                        name : "c",
                        label : "Curse",
                        type : "number",
                        value : 0,
                        min : 0,
                        max : 3
                    }, 
                    {
                        name : "e",
                        label : "Effects",
                        type : "enchantments",
                        value : []
                    }
            ]
                });
    
    public function createWeaponRange(subtype : String, rarity : Int, quality : Int, curseStatus : Int, effects : Array<Dynamic>) : DynamicWeaponRange
    {
        return try cast(DynamicItems.createItem(TDynamicWeaponRange, subtype, rarity, quality, curseStatus, effects), DynamicWeaponRange) catch(e:Dynamic) null;
    }
    
    public var TDynamicShield(default, never) : ItemTemplate = mk("DynamicShield", /* id, don't fix the typo */"Enchanted Shield", DynamicShield, {
                    category : "armor",
                    params : [
                    {
                        name : "t",
                        label : "Subtype",
                        type : "text",
                        value : "sword"
                    }, 
                    {
                        name : "r",
                        label : "Rarity",
                        type : "number",
                        value : 0,
                        min : 0,
                        max : 4
                    }, 
                    {
                        name : "q",
                        label : "Quality",
                        type : "number",
                        value : 0,
                        min : -15,
                        max : 15
                    }, 
                    {
                        name : "c",
                        label : "Curse",
                        type : "number",
                        value : 0,
                        min : 0,
                        max : 3
                    }, 
                    {
                        name : "e",
                        label : "Effects",
                        type : "enchantments",
                        value : []
                    }
            ]
                });
    
    public function createShield(subtype : String, rarity : Int, quality : Int, curseStatus : Int, effects : Array<Dynamic>) : DynamicShield
    {
        return try cast(DynamicItems.createItem(TDynamicShield, subtype, rarity, quality, curseStatus, effects), DynamicShield) catch(e:Dynamic) null;
    }
    
    public var TDynamicArmor(default, never) : ItemTemplate = mk("DynamicArmo", /* id, don't fix the typo */"Enchanted Armor", DynamicArmor, {
                    category : "armor",
                    params : [
                    {
                        name : "t",
                        label : "Subtype",
                        type : "text",
                        value : "sword"
                    }, 
                    {
                        name : "r",
                        label : "Rarity",
                        type : "number",
                        value : 0,
                        min : 0,
                        max : 4
                    }, 
                    {
                        name : "q",
                        label : "Quality",
                        type : "number",
                        value : 0,
                        min : -15,
                        max : 15
                    }, 
                    {
                        name : "c",
                        label : "Curse",
                        type : "number",
                        value : 0,
                        min : 0,
                        max : 3
                    }, 
                    {
                        name : "e",
                        label : "Effects",
                        type : "enchantments",
                        value : []
                    }
            ]
                });
    
    public function createArmor(subtype : String, rarity : Int, quality : Int, curseStatus : Int, effects : Array<Dynamic>) : DynamicArmor
    {
        return try cast(DynamicItems.createItem(TDynamicArmor, subtype, rarity, quality, curseStatus, effects), DynamicArmor) catch(e:Dynamic) null;
    }
    
    public var TDynamicRing(default, never) : ItemTemplate = mk("DynamicRing", "Enchanted Ring", DynamicRing, {
                    category : "armor",
                    params : [
                    {
                        name : "t",
                        label : "Subtype",
                        type : "text",
                        value : "ring"
                    }, 
                    {
                        name : "r",
                        label : "Rarity",
                        type : "number",
                        value : 0,
                        min : 0,
                        max : 4
                    }, 
                    {
                        name : "q",
                        label : "Quality",
                        type : "number",
                        value : 0,
                        min : -15,
                        max : 15
                    }, 
                    {
                        name : "c",
                        label : "Curse",
                        type : "number",
                        value : 0,
                        min : 0,
                        max : 3
                    }, 
                    {
                        name : "e",
                        label : "Effects",
                        type : "enchantments",
                        value : []
                    }
            ]
                });
    
    public function createRing(rarity : Int, quality : Int, curseStatus : Int, effects : Array<Dynamic>) : DynamicRing
    {
        return try cast(DynamicItems.createItem(TDynamicRing, "ring", rarity, quality, curseStatus, effects), DynamicRing) catch(e:Dynamic) null;
    }
    
    /**
	 * @param itemClass constructor should be (id:String, params:Object)
	 * @param metadata template metadata. Used for debugging and in save editor
	 */
    private function mk(templateId : String, name : String, itemClass : Class<Dynamic>, metadata : Dynamic) : SimpleItemTemplate
    {
        return new SimpleItemTemplate(templateId, name, itemClass, metadata);
    }
    
    public function new()
    {
        if (instance != null)
        {
            throw new Error("Duplicate ItemTemplateLib");
        }
        instance = this;
    }
}

