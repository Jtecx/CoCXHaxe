/**
 * Created by JTecx on 21.08.21.
 * Based on PerkLib, created by Aimozg.
 * NOTE: THIS IS DEPRECATED. DO NOT USE THIS FILE FOR FUTURE MUTATIONS -JTecx
 */
package classes;

import flash.errors.Error;
import classes.globalFlags.KFLAGS;

class MutationsLib
{
    public var game(get, never) : CoC;

    private function get_game() : CoC
    {
        return CoC.instance;
    }
    
    public static var processedMutations : Dynamic = { };
    public static var db : Array<Dynamic> = ["Black Heart", "Draconic Heart", "Frozen heart", "Heart of the storm", "Obsidian Heart", 
        "Mantis-like Agility", "Oni Musculature", 
        "Hollow Fangs", "Venom Glands", 
        "Orc Adrenal Glands", "Salamander Adrenal Glands", 
        "Fey Arcane Bloodstream", "Hinezumi burning blood", "Vampiric Bloodsteam", 
        "Natural punching bag", "Pig/Boar Fat", "Whale fat", "Yeti Fat", 
        "Draconic Lungs", "Drake Lungs", "Melkie Lungs", 
        "Displacer Metabolism", "Manticore Metabolism", 
        "Floral Ovaries", "Lacta Bovina Ovaries", 
        "Easter bunny balls", "Minotaur Testicles", "Nuki Nuts", 
        "Gazer Eye", "Gorgon's Eyes", 
        "Ecliptic Mind", "Elvish Peripheral NervSys", "Ratatoskr Smarts", "Raiju Cathode", "Shark Olfactory System", 
        "Draconic Bones", "Harpy Hollow Bones", "Lizan Marrow", 
        "Kitsune Thyroid Gland", 
        "Kitsune Parathyroid Glands", 
        "Arachnid Book Lung", "Cat-like Nimbleness", "Scylla Ink Glands", "Tracheal System", "Twin Heart"
    ];
    
    public static function mutationsUpdate(id : String) : Bool
    {
        if (CoC.instance.flags[kFLAGS.MOD_SAVE_VERSION] >= 35.015)
        {
            return false;
        }
        
        //Special mutations counts.
        //Displacer, Gorgon = 2, Scylla = 1, Tracheal = 4.
        var id2 : String = id;
        var idT : Int = 1;
        var changed : Bool = false;
        
        //Just in case there are other perks that use Primitive/Evolved/Final form, even though I highly doubt it.
        //Extra layer of redundancy.
        if (id.indexOf("(Primitive)") >= 0)
        {
            id2 = StringTools.replace(id, " (Primitive)", "");
            idT = 2;
        }
        if (id.indexOf("(Evolved)") >= 0)
        {
            id2 = StringTools.replace(id, " (Evolved)", "");
            idT = 3;
        }
        if (id.indexOf("(Final Form)") >= 0)
        {
            id2 = StringTools.replace(id, " (Final Form)", "");
            idT = 4;
        }
        
        //This is due to Orm shifting Evolved/Final Form to Primitive/Evolved/Final Form.
        if (CoC.instance.flags[kFLAGS.MOD_SAVE_VERSION] <= 34 && idT >= 3)
        {
            idT -= 1;
        }
        
        for (mutate in db)
        {
            if (id2.indexOf(mutate) >= 0)
            {
                id2 = id2 + " IM";
                if ((processedMutations.exists(id2) && Reflect.field(processedMutations, id2) < idT) || !(processedMutations.exists(id2)))
                
                //Mutations Level tracker{
                    
                    if (CoC.instance.flags[kFLAGS.MOD_SAVE_VERSION] <= 32)
                    {
                        if (processedMutations.exists(id2))
                        {
                            CoC.instance.player.perkPoints += idT - Reflect.field(processedMutations, id2);
                        }
                        else
                        {
                            CoC.instance.player.perkPoints += idT;
                        }
                    }
                    Reflect.setField(processedMutations, id2, idT);
                    changed = true;
                }
            }
        }
        
        //Old IDs that need post-conversion processing.
        if (id2.indexOf("Easter bunny balls") >= 0)
        {
            id2 = StringTools.replace(id2, "Easter bunny balls", "Easter Bunny Egg Bag");
        }
        if (id2.indexOf("Heart of the storm") >= 0)
        {
            id2 = StringTools.replace(id2, "Heart of the storm", "Heart Of The Storm");
        }
        if (id2.indexOf(",") >= 0)
        {
            id2 = StringTools.replace(id2, ",", "");
        }
        
        if (changed)
        
        //if (!(PerkType.lookupPerk(id2) is IMutationPerkType)){
            
            //	throw new Error("IM still broken!");
            try
            {
                var ptype : IMutationPerkType = try cast(PerkType.lookupPerk(id2), IMutationPerkType) catch(e:Dynamic) null;
                ptype.acquireMutation(CoC.instance.player, "none", idT);
            }
            catch (e : Error)
            {
                trace(e);
                EngineCore.outputText("Your Internal Mutations were not able to be upgraded successfully. Please use public v.0.8.s4 to upgrade your save before using this version.");
            }
        }
        
        return changed;
    }

    public function new()
    {
    }
}

