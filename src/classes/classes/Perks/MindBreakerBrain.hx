/**
 * Created by aimozg on 27.01.14.
 */
package classes.perks;

import classes.PerkClass;
import classes.PerkType;
import classes.PerkLib;

class MindBreakerBrain extends PerkType
{
    
    override public function desc(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _desc;
        }
        return "Repeated mental exercise as well as the increasing size of the mindbreaker collective psionic network allowed your brain to increase beyond normal size. Empowers all of mindbreaker your abilities by " + params.value1 * 50 + "% and allow you to store more stolen knowledge with Brain Melt. Your current tier is " + params.value1 + "";
    }
    
    override public function name(params : PerkClass = null) : String
    {
        if (!player || params == null)
        {
            return _name;
        }
        var suffix : Array<Dynamic> = ["", "Gamma", "Beta", "Alpha", "Omega", "Prime"];
        var sufval : Int = (player) ? player.perkv1(PerkLib.MindbreakerBrain1toX) : 0;
        if (sufval > 5)
        {
            sufval = 5;
        }
        return "Mindbreaker Brain " + suffix[sufval] + "";
    }
    
    public function new()
    {
        super("Mindbreaker Brain", "Mindbreaker Brain", 
                "NOT RELEVANT TEXT"
        );
    }
    
    override public function keepOnAscension(respec : Bool = false) : Bool
    {
        return true;
    }
}

