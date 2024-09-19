package classes.scenes.combat;


class TeaseOptions
{
    //Tags used for bonus damage and chance later on
    public var breasts : Bool = false;
    public var penis : Bool = false;
    public var balls : Bool = false;
    public var vagina : Bool = false;
    public var anus : Bool = false;
    public var ass : Bool = false;
    //If auto = true, set up bonuses using above flags
    public var auto : Bool = true;
    public var damage : Float = 0;
    public var chance : Float = 0;
    public var bonusDamage : Float = 0;
    public var bonusChance : Float = 0;
    
    public function new(
            breasts : Bool = false,
            penis : Bool = false,
            balls : Bool = false,
            vagina : Bool = false,
            anus : Bool = false,
            ass : Bool = false,
            auto : Bool = true,
            damage : Float = 0,
            chance : Float = 0,
            bonusDamage : Float = 0,
            bonusChance : Float = 0)
    {
        this.breasts = breasts;
        this.penis = penis;
        this.balls = balls;
        this.vagina = vagina;
        this.anus = anus;
        this.auto = auto;
        this.damage = damage;
        this.chance = chance;
        this.bonusDamage = bonusDamage;
        this.bonusChance = bonusChance;
    }
}



