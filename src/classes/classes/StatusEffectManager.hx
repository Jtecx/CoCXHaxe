package classes;

import flash.utils.Dictionary;

class StatusEffectManager
{
    private var statusEffects : Dictionary;
    private var actor : Creature;
    
    /**
     *
     * @param owner {Creature} Optional. Creature to associate with this manager for buff add/remove.
     */
    public function new(owner : Creature = null)
    {
        if (owner != null)
        {
            this.attach(owner);
        }
        this.removeStatuses();
    }
    
    /**
     * Associate an actor (Creature) to this status manager. Overwrites any existing association.
     * @param actor {Creature}
     */
    public function attach(actor : Creature) : Void
    {
        this.actor = actor;
    }
    
    public function hasStatusEffect(stype : StatusEffectType) : Bool
    {
        return this.statusEffects[stype.id] != null;
    }
    
    public function statusEffectByType(stype : StatusEffectType) : StatusEffectClass
    {
        return this.statusEffects[stype.id] || null;
    }
    
    public function createStatusEffect(stype : StatusEffectType, v1 : Float, v2 : Float, v3 : Float, v4 : Float, fireEvent : Bool = true) : StatusEffectClass
    {
        if (this.hasStatusEffect(stype))
        {
            return null;
        }
        var sec : StatusEffectClass = stype.create(v1, v2, v3, v4);
        this.addStatusEffect(sec);
        return sec;
    }
    
    public function createOrFindStatusEffect(stype : StatusEffectType, v1 : Float = 0, v2 : Float = 0, v3 : Float = 0, v4 : Float = 0, fireEvent : Bool = true) : StatusEffectClass
    {
        if (this.hasStatusEffect(stype))
        {
            return this.statusEffectByType(stype);
        }
        return this.createStatusEffect(stype, v1, v2, v3, v4, fireEvent);
    }
    
    public function addStatusEffect(sec : StatusEffectClass) : Void
    {
        if (this.hasStatusEffect(sec.stype))
        {
            trace("addStatusEffect: stype " + sec.stype.id + " already exists");
            return;
        }
        
        if (sec.host != this.actor)
        
        // Automatically transfer status effects?{
            
            sec.remove();
            sec.attach(this.actor  /*,fireEvent*/  );
        }
        else
        {
            this.statusEffects[sec.stype.id] = sec;
            sec.addedToHostList(this.actor, true);
        }
    }
    
    public function removeStatusEffect(stype : StatusEffectType) : StatusEffectClass
    {
        var sec : StatusEffectClass = this.statusEffectByType(stype);
        if (sec != null)
        {
            sec.removedFromHostList(true);
            ;
            return sec;
        }
        return null;
    }
    
    public function removeStatusEffectInstance(sec : StatusEffectClass) : Void
    /* Not trusting that the supplied StatusEffectClass instance exists on this
           StatusEffectManager.
         */
    {
        
        this.removeStatusEffect(sec.stype);
    }
    
    public function changeStatusValue(stype : StatusEffectType, statusValueNum : Float = 1, newNum : Float = 0) : Void
    {
        if (statusValueNum < 1 || statusValueNum > 4)
        {
            CoC_Settings.error("ChangeStatusValue called with invalid status value number.");
            return;
        }
        var sac : StatusEffectClass = this.statusEffectByType(stype);
        //Various Errors preventing action
        if (sac == null)
        {
            return;
        }
        if (statusValueNum == 1)
        {
            sac.value1 = newNum;
        }
        if (statusValueNum == 2)
        {
            sac.value2 = newNum;
        }
        if (statusValueNum == 3)
        {
            sac.value3 = newNum;
        }
        if (statusValueNum == 4)
        {
            sac.value4 = newNum;
        }
    }
    
    public function addStatusValue(stype : StatusEffectType, statusValueNum : Float = 1, bonus : Float = 0) : Void
    {
        if (statusValueNum < 1 || statusValueNum > 4)
        {
            CoC_Settings.error("ChangeStatusValue called with invalid status value number.");
            return;
        }
        var sac : StatusEffectClass = this.statusEffectByType(stype);
        //Various Errors preventing action
        if (sac == null)
        {
            return;
        }
        if (statusValueNum == 1)
        {
            sac.value1 += bonus;
        }
        if (statusValueNum == 2)
        {
            sac.value2 += bonus;
        }
        if (statusValueNum == 3)
        {
            sac.value3 += bonus;
        }
        if (statusValueNum == 4)
        {
            sac.value4 += bonus;
        }
    }
    
    public function createOrAddStatusEffect(stype : StatusEffectType, statusValueNum : Float = 1, bonus : Float = 0) : Void
    {
        if (statusValueNum < 1 || statusValueNum > 4)
        {
            CoC_Settings.error("ChangeStatusValue called with invalid status value number.");
            return;
        }
        if (!this.hasStatusEffect(stype))
        {
            createStatusEffect(stype, 0, 0, 0, 0);
        }
        addStatusValue(stype, statusValueNum, bonus);
    }
    
    public function getStatusValue(stype : StatusEffectType, statusValueNum : Float) : Float
    {
        if (statusValueNum < 1 || statusValueNum > 4)
        {
            CoC_Settings.error("getStatusValue called with invalid status value number.");
            return 0;
        }
        var sac : StatusEffectClass = this.statusEffectByType(stype);
        if (sac == null)
        {
            return 0;
        }
        if (statusValueNum == 1)
        {
            return sac.value1;
        }
        if (statusValueNum == 2)
        {
            return sac.value2;
        }
        if (statusValueNum == 3)
        {
            return sac.value3;
        }
        if (statusValueNum == 4)
        {
            return sac.value4;
        }
        return 0;
    }
    
    public function removeStatuses() : Void
    {
        this.statusEffects = new Dictionary();
    }
    
    public function asArray() : Array<Dynamic>
    {
        var array : Array<Dynamic> = [];
        for (sec/* AS3HX WARNING could not determine type for var: sec exp: EField(EIdent(this),statusEffects) type: null */ in this.statusEffects)
        {
            array.push(sec);
        }
        return array;
    }
}

