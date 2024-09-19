package classes;

import classes.internals.Utils;

class StatusEffectClass extends Utils
{
    public var stype(get, never) : StatusEffectType;
    public var host(get, never) : Creature;
    public var playerHost(get, never) : Player;
    private static var game(get, never) : CoC;

    //constructor
    public function new(stype : StatusEffectType)
    {
        super();
        this._stype = stype;
    }
    //data
    private var _stype : StatusEffectType;
    private var _host : Creature;
    public var value1 : Float = 0;
    public var value2 : Float = 0;
    public var value3 : Float = 0;
    public var value4 : Float = 0;
    //MEMBER FUNCTIONS
    private function get_stype() : StatusEffectType
    {
        return _stype;
    }
    private function get_host() : Creature
    {
        return _host;
    }
    public function value(index : Int) : Float
    {
        if (index == 1)
        {
            return value1;
        }
        if (index == 2)
        {
            return value2;
        }
        if (index == 3)
        {
            return value3;
        }
        if (index == 4)
        {
            return value4;
        }
        return 0;
    }
    /**
	 * Returns null if host is not a Player
	 */
    private function get_playerHost() : Player
    {
        return try cast(_host, Player) catch(e:Dynamic) null;
    }
    
    public function toString() : String
    {
        return "[" + _stype + "," + value1 + "," + value2 + "," + value3 + "," + value4 + "]";
    }
    // ==============================
    // EVENTS - to be overridden in subclasses
    // ===============================
    
    /**
	 * Called when the effect is applied to the creature, after adding to its list of effects.
	 */
    public function onAttach() : Void
    {  // do nothing  
        
    }
    /**
	 * Called when the effect is removed from the creature, after removing from its list of effects.
	 */
    public function onRemove() : Void
    {  // do nothing  
        
    }
    /**
	 * Called after combat in player.clearStatuses()
	 */
    public function onCombatEnd() : Void
    {  // do nothing  
        
    }
    /**
	 * Called during combat in combatStatusesUpdate() for player, then for monster
	 */
    public function onCombatRound() : Void
    {  // do nothing  
        
    }
    public function remove() : Void
    {
        if (_host == null)
        {
            return;
        }
        _host.removeStatusEffectInstance(this  /*,fireEvent*/  );
        _host = null;
    }
    public function removedFromHostList(fireEvent : Bool) : Void
    {
        if (fireEvent)
        {
            onRemove();
            _host.onStatusRemove(this);
        }
        _host = null;
    }
    public function addedToHostList(host : Creature, fireEvent : Bool) : Void
    {
        _host = host;
        if (fireEvent)
        {
            onAttach();
            _host.onStatusAttach(this);
        }
    }
    public function attach(host : Creature) : Void
    {
        if (_host == host)
        {
            return;
        }
        if (_host != null)
        {
            remove();
        }
        _host = host;
        host.addStatusEffect(this  /*,fireEvent*/  );
    }
    
    private static function register(id : String, statusEffectClass : Class<Dynamic>, arity : Int = 0) : StatusEffectType
    {
        return new StatusEffectType(id, statusEffectClass || StatusEffectClass, arity);
    }
    private static function get_game() : CoC
    {
        return CoC.instance;
    }
}

