/**
 * Created by Ormael on 04.06.21.
 */
package classes.items;

import classes.ItemType;
import classes.PerkLib;
import classes.Player;
import classes.scenes.combat.CombatAbility;

class FlyingSwords extends Equipable
{
    public var verb(get, never) : String;
    public var attack(get, never) : Float;
    public var perk(get, never) : String;
    public var element(get, never) : Int;
    public var count(get, never) : Int;

    private var _verb : String;
    private var _attack : Float;
    private var _perk : String;
    private var _element : Int;
    private var _count : Int;
    
    override private function get_category() : String
    {
        return CATEGORY_FLYING_SWORD;
    }
    
    public function new(id : String, shortName : String, name : String, longName : String, verb : String, attack : Float, value : Float = 0, description : String = null, perk : String = "", count : Int = 1, element : Int = -1)
    {
        super(id, shortName, name, longName, value, description);
        this._verb = verb;
        this._attack = attack;
        this._perk = perk;
        this._count = count;
        this._element = ((element == -1)) ? CombatAbility.TAG_PHYSICAL : element;
    }
    
    private static var SLOTS : Array<Dynamic> = [SLOT_FLYING_SWORD];
    override public function slots() : Array<Dynamic>
    {
        return SLOTS;
    }
    
    private function get_verb() : String
    {
        return _verb;
    }
    
    private function get_attack() : Float
    {
        return _attack;
    }
    
    private function get_perk() : String
    {
        return _perk;
    }
    
    private function get_element() : Int
    {
        return _element;
    }
    
    private function get_count() : Int
    {
        return _count;
    }
    
    override public function effectDescriptionParts() : Array<Dynamic>
    {
        var list : Array<Dynamic> = super.effectDescriptionParts();
        //Size
        var desc : String = "Size: (" + perk;
        var suffix : String = ")";
        if (count == 1)
        {
            desc += suffix;
        }
        else
        {
            desc += " (set of " + count + ")" + suffix;
        }
        
        list.push([15, desc]);
        //Attack
        list.push([20, "Attack: " + attack]);
        //Element
        list.push([25, "Element: " + CombatAbility.AllTags[element].name]);
        return list;
    }
    
    override public function canEquip(doOutput : Bool, slot : Int) : Bool
    {
        if (!game.player.hasPerk(PerkLib.FlyingSwordPath))
        {
            if (doOutput)
            {
                outputText("You need first to learn fine control over flying swords to equip this one.");
            }
            return false;
        }
        return true;
    }
}

