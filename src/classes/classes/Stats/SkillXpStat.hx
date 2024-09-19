package classes.stats;

import classes.CoC;
import classes.Creature;
import classes.Player;
import classes.internals.Jsonable;
import classes.internals.Utils;

class SkillXpStat extends Utils implements IStat implements Jsonable
{
    public var skillFullName(get, never) : String;
    public var statName(get, never) : String;
    public var host(get, never) : Creature;
    public var value(get, never) : Float;
    public var min(get, never) : Float;
    public var max(get, never) : Float;

    public var player : Player;
    public var skillId : String;
    public var skillName : String;
    public var iconId : String;
    public var xp : Float = 0;
    public var level : Float = 0;
    
    public function new(
            player : Player,
            skillId : String,
            skillName : String,
            iconId : String)
    {
        super();
        this.player = player;
        this.skillId = skillId;
        this.skillName = skillName;
        this.iconId = iconId;
    }
    
    private function onLevelUp() : Void
    {  // Implement (optionally) in subclasses  
        
    }
    public function maxLevel() : Float
    // Implement in subclasses
    {
        
        return 1;
    }
    private function get_skillFullName() : String
    {
        return skillName + " Skill";
    }
    public function xpToNextLevel() : Float
    // Implement in subclasses
    {
        
        return 1000;
    }
    public function describe(format : Bool) : String
    {
        var s : String = "";
        
        if (format)
        {
            s += "<b>";
        }
        s += skillFullName + ":";
        if (format)
        {
            s += "</b>";
        }
        s += " ";
        
        s += "" + level + " / " + maxLevel();
        
        s += " (Exp: ";
        if (level == maxLevel())
        {
            s += "MAX";
        }
        else
        {
            s += "" + xp + "/" + xpToNextLevel();
        }
        s += ")";
        
        return s;
    }
    public function giveXp(amount : Float) : Void
    {
        if (amount == 0)
        {
            return;
        }
        var oldRatio : Float = xp / xpToNextLevel();
        xp += amount;
        CoC.instance.mainView.notificationView.popupProgressBar2(
                skillName, iconId, 
                skillName + " XP +" + amount, 
                oldRatio, 
                xp / xpToNextLevel()
        );
        while (level < maxLevel())
        {
            var tnl : Float = xpToNextLevel();
            if (xp < tnl)
            {
                break;
            }
            level++;
            xp -= tnl;
            CoC.instance.mainView.notificationView.popupIconText(
                    skillName, iconId, 
                    skillName + " leveled up to " + level + "!"
            );
            onLevelUp();
        }
    }
    private function get_statName() : String
    {
        return skillId;
    }
    private function get_host() : Creature
    {
        return player;
    }
    private function get_value() : Float
    {
        return xp;
    }
    private function get_min() : Float
    {
        return 0;
    }
    private function get_max() : Float
    {
        return xpToNextLevel();
    }
    
    public function saveToObject() : Dynamic
    {
        return {
            xp : xp,
            level : level
        };
    }
    
    public function loadFromObject(o : Dynamic, ignoreErrors : Bool) : Void
    {
        if (o != null)
        {
            xp = numberOr(Reflect.field(o, "xp"), 0);
            level = numberOr(Reflect.field(o, "level"), 0);
        }
        else
        {
            xp = 0;
            level = 0;
        }
    }
}

