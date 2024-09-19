/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc;

import classes.Appearance;
import classes.bodyParts.Skin;
import classes.CockTypesEnum;
import classes.globalFlags.KFLAGS;
import classes.CoC;
import classes.scenes.SceneLib;
import classes.PerkLib;
import coc.xlogic.ExecContext;

class StoryContext extends ExecContext
{
    public var game : CoC;
    public function new(game : CoC)
    {
        super([
                game, 
                CoC, 
                {
                    Appearance : Appearance,
                    CockTypesEnum : CockTypesEnum,
                    kFLAGS : kFLAGS,
                    kGAMECLASS : CoC.instance,
                    Math : Math,
                    PerkLib : PerkLib,
                    SceneLib : SceneLib,
                    Skin : Skin
                }
        ]);
        this.game = game;
    }
}

