/**
 * Created by aimozg on 02.04.2017.
 */
package classes.internals;


class CounterGroup extends ArrayWithDefault
{
    public function new(array : Array<Dynamic>)
    {
        super(array);
    }
    
    override private function defaultValue() : Dynamic
    {
        return 0;
    }
}

