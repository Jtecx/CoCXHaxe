package classes.bodyParts;

import classes.Creature;

/**
	 * Container class for the players underbody
	 * @since December 31, 2016
	 * @author Stadler76
	 */
class UnderBody extends BodyPart
{
    
    public var skin : Skin;
    
    public function new(creature : Creature)
    {
        super(creature, []);
        this.skin = new Skin(creature);
        addPublicJsonables(["skin"]);
    }
    
    public function skinFurScales(args : Array<Dynamic> = null) : String
    {
        return skin.skinFurScales.apply(null, args);
    }
    
    public function copySkin(p : Dynamic = null) : Void
    {
        skin.setProps(creature.skin);
        if (p != null)
        {
            skin.setProps(p);
        }
    }
    
    override public function restore(keepTone : Bool = true) : Void
    {
        super.restore(keepTone);
        skin.restore(keepTone);
    }
}
