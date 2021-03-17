/**
 © Copyright 2021, The Great Rift Valley Software Company

 LICENSE:

 MIT License

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,
 modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
 CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

 The Great Rift Valley Software Company: https://riftvalleysoftware.com
*/

import UIKit

/* ###################################################################################################################################### */
// MARK: - Image Base Class -
/* ###################################################################################################################################### */
/**
 This provides a base class for the three images to be used as switch elements.
 The default uses code-drawn images that render in template mode, and use the tint color.
 */
class RVS_Checkbox_Image: UIImage {
    /* ################################################################################################################################## */
    // MARK: - Instance Stored Properties -
    /* ################################################################################################################################## */
    /* ################################################################## */
    /**
     This is the tint color to be used for rendering templates (or tinting other images in subclasses). Default is the label color.
     */
    var myFillColor: UIColor = .label
    
    /* ################################################################## */
    /**
     This is the rendering mode. It is ignored for the default, but is available for subclasses.
     */
    var myRenderingMode: UIImage.RenderingMode = .automatic
    
    /* ################################################################################################################################## */
    // MARK: - Overrides of Base Class Methods -
    /* ################################################################################################################################## */
    /* ################################################################## */
    /**
     Draws the image, in the current context (Rect).
     
    - parameter in: The container rect for drawing.
     */
    override func draw(in inRect: CGRect) {
        asImage?.draw(in: inRect)
    }
    
    /* ################################################################## */
    /**
     Draws the image, in the current context (Point).
     
    - parameter at: The top, left point for drawing.
     */
    override func draw(at inPoint: CGPoint) {
        asImage?.draw(at: inPoint)
    }
    
    /* ################################################################## */
    /**
    This returns the image, but tinted (in the default, this always colors the image completely).
     
     - parameter inTintColor: The color to use for tinting.
     - returns: The image, but tinted (using the supplied color).
     */
    override func withTintColor(_ inTintColor: UIColor) -> UIImage {
        myFillColor = inTintColor
        return asImage ?? super.withTintColor(inTintColor)
    }

    /* ################################################################## */
    /**
     This returns the image, but tinted (in the default, this always colors the image completely), and also with the supplied rendering mode (in the default, this is ignored).
      
     - parameter inTintColor: The color to use for tinting.
     - parameter renderingMode: The rendering mode (ignored, in the default).
      - returns: The image, but tinted (using the supplied color).
     */
    override func withTintColor(_ inTintColor: UIColor, renderingMode inRenderingMode: UIImage.RenderingMode) -> UIImage {
        myRenderingMode = inRenderingMode
        return withTintColor(inTintColor)
    }

    /* ################################################################################################################################## */
    // MARK: - Subclasses MUST Override This -
    /* ################################################################################################################################## */
    /* ################################################################## */
    /**
     This needs to be overridden.
     
     This supplies a rendered image. It will use the myFillColor and myRenderingMode values (default ignores myRenderingMode, as it is always template, and default myFillColor is label color).
     */
    var asImage: UIImage! {
        get {
            preconditionFailure("This Computed Property Must be Overridden by Subclasses!" )
        }
    }
}
