package classes;

import haxe.Constraints.Function;
import classes.Image;
import classes.globalFlags.KFLAGS;
import classes.CoC;
import coc.view.MainView;
import com.bit101.components.TextFieldVScroll;
import flash.display.Loader;
import flash.display.Stage;
import flash.display.MovieClip;
import flash.errors.IOError;
import flash.net.*;
import flash.events.*;
import flash.system.Security;
import flash.text.TextField;
import flash.text.TextFormat;

/**
	 * ...
	 * @author Yoffy, Fake-Name
	 */
@:final class ImageManager
{
    //Hashmap of all images
    private static var _imageTable : Dynamic = {};
    
    // map of all the potential image paths from the xml file
    private static var _allImagePaths : Dynamic = {};
    // Used to map fully-qualified paths to relative paths so we can lookup the information used to load them.
    private static var _fqPathMap : Dynamic = {};
    
    private var mStage : Stage;
    
    //Maximum image box size
    private var MAXSIZE(default, never) : Int = 400;
    
    public var xmlLoadError : Bool = false;
    private var logErrors : Bool = false;
    
    //The magic embedding sauce. Skips around sandbox issue by embedding the
    //xml into the swf. Makes it possible to load images even from a browser.
    @:meta(Embed(source="../../img/images.xml",mimeType="application/octet-stream"))

    
    private static var XML_IMAGES : Class<Dynamic>;
    private var _imgListXML : FastXML;
    private var _mainView : MainView;
    
    public function new(stage : Stage, mainView : MainView)
    {
        _mainView = mainView;
        mStage = stage;
        _imgListXML = new FastXML(Type.createInstance(XML_IMAGES, []));
        if (Security.sandboxType != Security.REMOTE)
        
        //trace("Creating Image File hashmap");{
            
            loadImageList();
        }
    }
    
    public function loadImageList() : Void
    {
        for (i in 0..._imgListXML.node.ImageList.innerData.node.ImageSet.innerData.length())
        {
            for (j in 0..._imgListXML.nodes.ImageList.node.ImageSet.innerData[i].ImageFile.length())
            {
                for (k in 0..._imgListXML.node.ExtensionList.innerData.node.ExtensionType.innerData.length())
                
                // Programmatic extension concatenation! Woot.{
                    
                    Reflect.setField(_allImagePaths, Std.string(_imgListXML.nodes.ImageList.node.ImageSet.innerData[i].ImageFile[j] + "." + _imgListXML.nodes.ExtensionList.node.ExtensionType.innerData[k]), ".");
                }
            }
        }
        for (imgPath in Reflect.fields(_allImagePaths))
        
        // trace(_allImagePaths[imgPath], " : ", imgPath){
            
            this.loadImageAtPath(imgPath);
        }
    }
    
    private function loadImageAtPath(imPath : String) : Void
    {
        var imgLoader : Loader = new Loader();
        
        var f : Function = function(key : String) : Function
        {
            return function(e : Event) : Void
            {
                fileLoaded(e, key);
            };
        }
        
        imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, f(imPath));
        imgLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, fileNotFound);
        var req : URLRequest = new URLRequest(imPath);
        imgLoader.load(req);
    }
    
    private function fileLoaded(e : Event, imPath : String) : Void
    {
        if (_allImagePaths.exists(imPath))
        {
            var extImage : Image;
            // split the image name out from the image path.
            
            // trace("ImageFile - ", _allImagePaths[imPath], imPath);
            var imId : String = Reflect.field(_allImagePaths, imPath);
            extImage = new Image(imId, imPath, e.target.width, e.target.height);
            
            // Store the fully-qualified<->image mapping for later use.
            Reflect.setField(_fqPathMap, Std.string(e.target.url), extImage);
            
            if (Reflect.field(_imageTable, Std.string(extImage.id)) == null)
            {
                Reflect.setField(_imageTable, Std.string(extImage.id), new Array<Dynamic>(extImage));
            }
            // trace("Pushing additional image onto array", extImage.id, extImage)
            else
            {
                
                Reflect.field(_imageTable, Std.string(extImage.id)).push(extImage);
            }
            
            // If there is a underscore in the image path, the image is intended to be one of a set for the imageID
            // Therefore, we split the index integer off, increment it by one, and try to load that path
            var underscorePt : Int = imPath.lastIndexOf("_");
            if (underscorePt != -1)
            {
                var decimalPt : Int = imPath.lastIndexOf(".");
                var prefix : String = imPath.substring(0, underscorePt + 1);
                var num : String = imPath.substring(underscorePt + 1, decimalPt);
                num = Std.string(as3hx.Compat.parseInt(num) + 1);
                
                
                // Try all possible extensions.
                for (k in 0..._imgListXML.node.ExtensionList.innerData.node.ExtensionType.innerData.length())
                
                // Programmatic extension concatenation! Woot.{
                    
                    var newPath : String = prefix + num + "." + _imgListXML.nodes.ExtensionList.node.ExtensionType.innerData[k];
                    trace("Trying to load sequential image at URL =", newPath, "Previous base URL = ", imPath);
                    Reflect.setField(_allImagePaths, newPath, imId);
                    loadImageAtPath(newPath);
                }
            }
        }
        else
        {
            CoC_Settings.error("Error in image loading. Tried to load image that was not tried to load? Wat.");
        }
    }
    
    private function fileNotFound(e : IOErrorEvent) : Void
    {  //trace("File not Found: " + e);  
        
    }
    
    public function getLoadedImageCount() : Int
    {
        var cnt : Int = 0;
        for (set/* AS3HX WARNING could not determine type for var: set exp: EIdent(_imageTable) type: Dynamic */ in _imageTable)
        {
            cnt += set.length;
        }
        return cnt;
    }
    
    // Find the image data for the given image URL and return the displayed height
    public function getImageHeight(imageURL : String) : Int
    // Slice off the leading directories and extension to get the image name
    {
        
        
        
        
        var imageTarget : Image = Reflect.field(_fqPathMap, imageURL);
        
        if (imageTarget == null)
        {
            return 1;
        }
        else
        {
            var ratio : Float = imageTarget.width / imageTarget.height;
            
            // Image resized vertically
            if (ratio >= 1)
            {
                return Math.ceil(imageTarget.height * (MAXSIZE / imageTarget.width));
            }
            // Image was scaled horizontally, return max height
            else
            {
                
                {
                    return MAXSIZE;
                }
            }
        }
    }
    
    public function showImage(imageID : String, align : String = "left") : String
    {
        var imageString : String = "";
        
        if (CoC.instance.flags[kFLAGS.IMAGEPACK_OFF] > 0)
        {
            return "";
        }
        
        if (logErrors)
        {
            trace("showing imageID - ", imageID);
        }
        var imageIndex : Int = 0;
        var image : Image = null;
        if (Reflect.field(_imageTable, imageID) != null)
        
        // More than 1 image? Pick one at random.{
            
            if (Reflect.field(_imageTable, imageID).length > 0)
            {
                imageIndex = Math.floor(Math.random() * Reflect.field(_imageTable, imageID).length);
                if (logErrors)
                {
                    trace("Have multiple image possibilities. Displaying image", imageIndex, "selected randomly.");
                }
                image = Reflect.field(Reflect.field(_imageTable, imageID), Std.string(imageIndex));
            }
        }
        
        if (image != null)
        {
            if (align == "left" || align == "right")
            
            //Scale images down to fit the box{
                
                var ratio : Float = image.width / image.height;
                var scaler : Float;
                
                if (ratio >= 1)
                {
                    scaler = MAXSIZE / image.width;
                    imageString = "<img src='" + image.url + "' width='" + MAXSIZE + "' height='" + Math.ceil(image.height * scaler) + "' align='" + align + "' id='img'>";
                }
                else
                {
                    scaler = MAXSIZE / image.height;
                    imageString = "<img src='" + image.url + "' width='" + Math.ceil(image.width * scaler) + "' height='" + MAXSIZE + "' align='" + align + "' id='img'>";
                }
            }
        }
        //trace("Loading image: " + imageID + ", html: " + imageString);
        fixupImage();
        return imageString;
    }
    
    // Begin our image fixing code
    private function fixupImage() : Void
    {
        mStage.addEventListener(Event.ADDED, fixupListener);
    }
    
    // Event listener hooks into the stage to find objects added to the display list at any point in the heirarchy
    private function fixupListener(e : Event) : Void
    // We're looking for Loader objects -- there /could/ be other types of loaders in future, but right now,
    {
        
        // the only thing that will create loaders is the mainText field when it parses an <img> tag
        if (Std.is(e.target, Loader))
        {
            mStage.removeEventListener(Event.ADDED, fixupListener);
            var loader : Loader = try cast(e.target, Loader) catch(e:Dynamic) null;
            
            // Hook the loader to notify us when the image has finished loading
            // this gaurantees that anything we do to the content of mainText will ONLY happen after a scene's calls
            // to outputText has finished
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, doFixup);
        }
    }
    
    /**
		 * Meat of the image padding fix.
		 * The images XY position is relative to its position inside of the containing TextField. Compare the image.Y + image.height
		 * to the maximal Y position of text in the TextField /once the image has reflowed the text, possibly adding more height to the text.
		 * Handwave the difference in this pixel height as a line count (this could be more accurate by using TextMetrics, but fuck it) and
		 * add this many blank lines to the text.
		 * Critical point; once the new lines have been added to the text, force an update of the scrollbar UI element (its actually a seperate
		 * UI component that "targets" the TextField, and not actually a part of the TextField itself) to account for the new text height.
		 *
		 * Handwavey Bullshit Internals:
		 * TextField.htmlText doesn't continually "parse" content added to it, it's done at the end of a frame when the property has changed.
		 * 		(TextField has two internal properties to check its current displayed content after parsing, and what other code has told it to have there,
		 * 	     the difference is only resolved on EVENT.EXIT_FRAME or EVENT.ENTER_FRAME, I'm not sure which but thats basically the mechanic in play)
		 * TextField never directly updates the UIScrollBar, it's kinda the other way around but not really; the UIScrollBar targets a specific DisplayObject
		 * and targets specific properties thereof. It's probably (internally) adding a listener to EVENT.CHANGE which, I believe, will only be fired when
		 * the textfields internal text property is updated (ie not htmlText but the comparison with it). Anything that changes the actual content layout
		 * of the TextField (and thus the maxScrollV property, which tracks the maximum number of lines displayed via the text field) does not fire the event.
		 *
		 * In summary. ADOBE DURR. This kind of stupid, half-implemented interaction between base UI components is systematic.
		 * @param	e
		 */
    private function doFixup(e : Event) : Void
    // Remove the Completion event listener
    {
        
        e.target.removeEventListener(Event.COMPLETE, doFixup);
        var imgRef : Loader = try cast(e.target.loader, Loader) catch(e:Dynamic) null;
        var mainText : TextField = _mainView.mainText;
        var scrollBar : TextFieldVScroll = _mainView.scrollBar;
        
        var imgRefTopY : Int = imgRef.getBounds(mainText).y;  // 272  
        var imgHeight : Int = getImageHeight(imgRef.contentLoaderInfo.url);  // 400  
        var imgRefBottomY : Int = as3hx.Compat.parseInt(imgRefTopY + imgHeight);
        var totalTextHeight : Int = mainText.textHeight;  // 264 -- Total displayed pixel height of text  
        
        if (totalTextHeight > imgRefBottomY)
        
        // Total displayed text height should be larger than the image{
            
            return;
        }
        
        // Here comes the bullshit... get ready
        var txFormat : TextFormat = mainText.defaultTextFormat;
        var lineHeight : Int = as3hx.Compat.parseInt(txFormat.size);
        lineHeight += 4;
        var padLines : Int = Math.ceil((imgRefBottomY - totalTextHeight) / lineHeight);
        
        
        // Generate the paddings
        var padding : String = "";
        for (i in 0...padLines)
        {
            padding += "\n";
        }
        mainText.htmlText += padding;
        scrollBar.draw();
    }
}

