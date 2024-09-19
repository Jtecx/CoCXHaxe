package classes;

import flash.errors.Error;
import classes.internals.Utils;
import flash.utils.Dictionary;

/**
 * A template to dynamically create parametrized items.
 *
 * Templated items have id in format "template_id;params_json"
 * Example: 'Dye;{"color":"black"}'
 */
class ItemTemplate extends Utils
{
    private static var TEMPLATES : Dictionary = new Dictionary();
    public static function lookupTemplate(templateId : String) : ItemTemplate
    {
        return Reflect.field(TEMPLATES, templateId);
    }
    public static function getLibrary() : Dictionary
    {
        return TEMPLATES;
    }
    
    /**
	 * Unique id
	 */
    public var templateId : String;
    /**
	 * Display name (mostly for debugging)
	 */
    public var name : String;
    /**
	 * Description of parameters and created items
	 *
	 * @property {String} category Item category ("weapon"|"armor"|...)
	 * @property {Array} params Parameter desciptions
	 * @property
	 */
    public var metadata : Dynamic;
    
    public function new(templateId : String, name : String, metadata : Dynamic)
    {
        super();
        this.templateId = templateId;
        this.name = name;
        this.metadata = metadata || { };
        if (Lambda.has(TEMPLATES, templateId))
        {
            CoC_Settings.error("Duplicate ItemTemplate " + templateId);
        }
        Reflect.setField(TEMPLATES, templateId, this);
    }
    
    public function createItem(parameters : Dynamic) : ItemType
    {
        CoC_Settings.errorAMC("ItemTemplate", "createItem");
        return null;
    }
    
    public static function createTemplatedItem(templateId : String, params : Dynamic) : ItemType
    {
        var template : ItemTemplate = lookupTemplate(templateId);
        if (template == null)
        {
            CoC_Settings.error("Unknown item template " + templateId);
            return null;
        }
        if (Std.is(params, String))
        {
            try
            {
                params = haxe.Json.parse(params);
            }
            catch (e : Error)
            {
                CoC_Settings.error("Invalid template param string: " + params);
                return null;
            }
        }
        return template.createItem(params);
    }
}

