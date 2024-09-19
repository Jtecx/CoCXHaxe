/**
 * Created by aimozg on 09.01.14.
 */
package classes.items;

import flash.errors.Error;
import haxe.Constraints.Function;
import classes.CoC;
import classes.DefaultDict;
import classes.EngineCore;
import classes.items.alchemy.AlchemyLib;
import classes.items.alchemy.AlchemyReagent;
import classes.Player;
import classes.scenes.Camp;
import classes.scenes.SceneLib;
import classes.internals.Utils;

/**
	 * An item, that is consumed by player, and disappears after use. Direct subclasses should override "doEffect" method
	 * and NOT "useItem" method.
	 */
class Consumable extends Useable
{
    private var mutations(get, never) : Mutations;
    private var changes(get, set) : Int;
    private var changeLimit(get, set) : Int;
    private var player(get, never) : Player;
    private var flags(get, never) : DefaultDict;
    private var camp(get, never) : Camp;
    public var isRefinable(get, never) : Bool;

    
    private function get_mutations() : Mutations
    {
        return CoC.instance.mutations;
    }
    private function get_changes() : Int
    {
        return mutations.changes;
    }
    private function set_changes(val : Int) : Int
    {
        mutations.changes = val;
        return val;
    }
    private function get_changeLimit() : Int
    {
        return mutations.changeLimit;
    }
    private function set_changeLimit(val : Int) : Int
    {
        mutations.changeLimit = val;
        return val;
    }
    
    private function get_player() : Player
    {
        return CoC.instance.player;
    }
    private function get_flags() : DefaultDict
    {
        return CoC.instance.flags;
    }
    private function get_camp() : Camp
    {
        return SceneLib.camp;
    }
    private function doNext(func : Function, args : Array<Dynamic> = null) : Void
    {
        EngineCore.doNext.apply(null, [func].concat(args));
    }
    private function rand(n : Float) : Int
    {
        return Utils.rand(n);
    }
    
    override private function get_category() : String
    {
        return CATEGORY_CONSUMABLE;
    }
    
    public function new(id : String, shortName : String = null, longName : String = null, value : Float = 0, description : String = null)
    {
        super(id, shortName, longName, value, description);
    }
    
    override private function get_description() : String
    {
        var desc : String = _description;
        //Type
        desc += "\n\nType: Consumable ";
        if (shortName == "Wingstick" || shortName == "MiniBangB")
        {
            desc += "(Thrown)";
        }
        if (shortName == "S.Hummus")
        {
            desc += "(Cheat Item)";
        }
        if (shortName == "BroBrew" || shortName == "BimboLq" || shortName == "P.Pearl")
        {
            desc += "(Rare Item)";
        }
        if (longName.indexOf("dye") >= 0)
        {
            desc += "(Dye)";
        }
        if (longName.indexOf("egg") >= 0)
        {
            desc += "(Egg)";
        }
        if (longName.indexOf("book") >= 0)
        {
            desc += "(Magic Book)";
        }
        //Value
        desc += "\nBase value: " + Std.string(value);
        return desc;
    }
    
    /**
		 * Delegate function for legacy 'Mutations.as' code.
		 * @param	... args stat change parameters
		 */
    private function dynStats(args : Array<Dynamic> = null) : Void
    {
        game.player.dynStats.apply(game.player, args);
    }
    
    // Random drop table: [weight:number, essence:int][];
    public var essences : Array<Dynamic> = null;
    // Random drop table: [weight:number, essence:int][];
    public var substances : Array<Dynamic> = null;
    // Random drop table: [weight:number, essence:int][];
    public var residues : Array<Dynamic> = null;
    // Random drop table: [weight:number, pigment:String][];
    public var pigments : Array<Dynamic> = null;
    
    public function getRefineReagents(type : Int) : Array<Dynamic>
    {
        var result : Array<Dynamic> = [];
        var source : Array<Dynamic>;
        switch (type)
        {
            case AlchemyLib.RT_ESSENCE:source = essences;
            case AlchemyLib.RT_SUBSTANCE:source = substances;
            case AlchemyLib.RT_RESIDUE:source = residues;
            case AlchemyLib.RT_PIGMENT:source = pigments;
        }
        for (k in source)
        {
            result.push(AlchemyReagent.getReagent(type, Reflect.field(k, Std.string(1))));
        }
        return result;
    }
    public function getAllRefineReagents() : Array<Dynamic>
    {
        return concat(
                getRefineReagents(AlchemyLib.RT_ESSENCE), 
                getRefineReagents(AlchemyLib.RT_RESIDUE), 
                getRefineReagents(AlchemyLib.RT_PIGMENT), 
                getRefineReagents(AlchemyLib.RT_SUBSTANCE)
        );
    }
    
    private function get_isRefinable() : Bool
    {
        return essences || substances || residues || pigments;
    }
    /**
		 * Configure essences extractable with alchemy
		 * @param substances Essence drop table - array of pairs [weight, essence]
		 * @param essences Substance drop table - array of pairs [weight, substance]
		 * @param residues Residue drop table - array of pairs [weight, residue]
		 * @param pigments Pigment drop table - array of pairs [weight, pigment] or array of colors
		 * @return this
		 */
    public function refineableInto(
            substances : Array<Dynamic>,
            essences : Array<Dynamic>,
            residues : Array<Dynamic> = null,
            pigments : Array<Dynamic> = null) : Consumable
    {
        var i : Int;
        if (substances != null && substances.length > 0)
        {
            if (!this.substances)
            {
                this.substances = [];
            }
            for (i in substances)
            {
                if (AlchemyLib.Substances[i] == null)
                {
                    throw new Error("Ingredient " + id + " has invalid refineableInto substance " + i);
                }
            }
            pushAll(this.substances, substances);
        }
        if (essences != null && essences.length > 0)
        {
            if (!this.essences)
            {
                this.essences = [];
            }
            for (i in essences)
            {
                if (AlchemyLib.Essences[i] == null)
                {
                    throw new Error("Ingredient " + id + " has invalid refineableInto essence " + i);
                }
            }
            pushAll(this.essences, essences);
        }
        if (residues != null && residues.length > 0)
        {
            if (!this.residues)
            {
                this.residues = [];
            }
            for (i in residues)
            {
                if (AlchemyLib.Residues[i] == null)
                {
                    throw new Error("Ingredient " + id + " has invalid refineableInto residue " + i);
                }
            }
            pushAll(this.residues, residues);
        }
        if (pigments != null && pigments.length > 0)
        {
            if (!this.pigments)
            {
                this.pigments = [];
            }
            for (p in pigments)
            {
                var w : Int = 1;
                var color : String;
                if (Std.is(p, Array))
                {
                    w = Reflect.field(p, Std.string(0));
                    color = Reflect.field(p, Std.string(1));
                }
                else
                {
                    color = Std.string(p);
                }
                if (color.indexOf(" and ") >= 0)
                {
                    this.pigments.push([w / 2, color.substring(0, color.indexOf(" and "))]);
                    this.pigments.push([w / 2, color.substring(color.indexOf(" and ") + 5)]);
                }
                else
                {
                    this.pigments.push([w, color]);
                }
            }
            // merge duplicates
            for (i in 0...this.pigments.length)
            {
                var j : Int = as3hx.Compat.parseInt(this.pigments.length - 1);
                while (j > i)
                {
                    if (this.pigments[i][1] == this.pigments[j][1])
                    {
                        this.pigments[i][0] += this.pigments[j][0];
                        this.pigments[j] = this.pigments[this.pigments.length - 1];
                        this.pigments.pop();
                    }
                    j--;
                }
            }
        }
        return this;
    }
    public function refine(chances : Array<Dynamic>) : AlchemyReagent
    {
        var sum : Float = chances[0];
        if (substances != null)
        {
            sum += chances[1];
        }
        if (essences != null)
        {
            sum += chances[2];
        }
        if (residues != null)
        {
            sum += chances[3];
        }
        if (pigments != null)
        {
            sum += chances[4];
        }
        if (sum <= 0)
        {
            return null;
        }
        var x : Float = Math.random() * sum;
        x -= chances[1];
        if (x <= 0)
        {
            return AlchemyReagent.substance(weightedRandom(substances));
        }
        x -= chances[2];
        if (x <= 0)
        {
            return AlchemyReagent.essence(weightedRandom(essences));
        }
        x -= chances[3];
        if (x <= 0)
        {
            return AlchemyReagent.residue(weightedRandom(residues));
        }
        x -= chances[4];
        if (x <= 0)
        {
            return AlchemyReagent.pigment(weightedRandom(pigments));
        }
        return null;
    }
}

