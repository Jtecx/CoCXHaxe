/**
 * Created by aimozg on 11.01.14.
 */
package classes.internals;

import classes.CoCSettings;

class ChainedDrop implements RandomDrop
{
    private var items : Array<Dynamic> = [];
    private var probs : Array<Dynamic> = [];
    private var defaultItem : Dynamic;
    public function new(defaultItem : Dynamic = null)
    {
        this.defaultItem = defaultItem;
    }
    public function add(item : Dynamic, prob : Float) : ChainedDrop
    {
        if (prob < 0 || prob > 1)
        {
            CoC_Settings.error("Invalid probability value " + prob);
        }
        items.push(item);
        probs.push(prob);
        return this;
    }
    public function elseDrop(item : Dynamic) : ChainedDrop
    {
        this.defaultItem = item;
        return this;
    }
    
    public function roll() : Dynamic
    {
        for (i in 0...items.length)
        {
            if (Math.random() < probs[i])
            {
                return items[i];
            }
        }
        return defaultItem;
    }
}

