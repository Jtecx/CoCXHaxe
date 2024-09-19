/**
 * Created by aimozg on 11.01.14.
 */
package classes.internals;


class WeightedDrop implements RandomDrop
{
    private var items : Array<Dynamic> = [];
    private var sum : Float = 0;
    public function new(first : Dynamic = null, firstWeight : Float = 0)
    {
        if (first != null)
        {
            items.push([first, firstWeight]);
            sum += firstWeight;
        }
    }
    public function add(item : Dynamic, weight : Float = 1) : WeightedDrop
    {
        items.push([item, weight]);
        sum += weight;
        return this;
    }
    public function addMany(weight : Float, _items : Array<Dynamic> = null) : WeightedDrop
    {
        for (item in _items)
        {
            items.push([item, weight]);
            sum += weight;
        }
        return this;
    }
    // you can pass your own random value from 0 to 1 (so you can use your own RNG)
    public function roll() : Dynamic
    {
        var random : Float = Math.random() * sum;
        var item : Dynamic = null;
        while (random > 0 && items.length > 0)
        {
            var pair : Array<Dynamic> = items.shift();
            item = pair[0];
            random -= pair[1];
        }
        return item;
    }
    
    public function clone() : WeightedDrop
    {
        var other : WeightedDrop = new WeightedDrop();
        other.items = items.copy();
        other.sum = sum;
        return other;
    }
}
