/**
 * Created by aimozg on 01.05.2017.
 */
package classes.bodyParts;

import classes.Creature;
import classes.internals.Utils;

class SaveableBodyPart extends BodyPart
{
    private var keyInSaveData : String;
    public function new(creature : Creature, keyInSaveData : String, publicPrimitives : Array<Dynamic>)
    {
        super(creature, publicPrimitives);
        this.keyInSaveData = keyInSaveData;
    }
    
    public function loadFromSaveData(savedata : Dynamic) : Void
    {
        restore(false);
        var o : Dynamic = objectOr(Reflect.field(savedata, keyInSaveData), null);
        try
        {
            if (o != null)
            {
                loadFromObject(o, false);
                return;
            }
        }
        catch (e : Dynamic)
        {
            trace(e);
        }
        loadFromOldSave(savedata);
    }
    private function loadFromOldSave(savedata : Dynamic) : Void
    {
    }
    private function saveToOldSave(savedata : Dynamic) : Void
    {
    }
    public function saveToSaveData(savedata : Dynamic) : Void
    {
        Reflect.setField(savedata, keyInSaveData, saveToObject());
        saveToOldSave(savedata);
    }
}
