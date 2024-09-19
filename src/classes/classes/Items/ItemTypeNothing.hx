package classes.items;

import classes.ItemType;

class ItemTypeNothing extends ItemType
{
    
    override private function get_category() : String
    {
        return CATEGORY_OTHER;
    }
    
    override private function get_isNothing() : Bool
    {
        return true;
    }
    
    public function new()
    {
        super("NOTHING!");
    }
}

