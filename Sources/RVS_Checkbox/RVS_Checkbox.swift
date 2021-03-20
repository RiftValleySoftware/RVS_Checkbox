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
 
 Version 1.1.0
*/

import UIKit

/* ###################################################################################################################################### */
// MARK: - Three-State UIKit Checkbox -
/* ###################################################################################################################################### */
/**
 This class provides a simple Swift-only module that implements a "checkbox" to replace the standard UISwitch.
 The switch can behave exactly like a standard UISwitch, but also has a "three-state" option, where it has definitely off, definitely on, and clear, which is a sort of "undefined" state. Default is two-state (like UISwitch).
 The class can use the SFSymbols checkbox symbols, but these are a bit awkward for UIKit (which is why UIKit doesn't use them), so we have three dynamically-generated "artisanal" images that can be used to
 implement a round checkbox, which is friendlier for fat fingers.
 You can also supply three images to use for the control (or only two, if you are sticking with the "two-state" version).
 All images are drawn template mode, using the control `tintColor`.
 Like the UISwitch class, you can specifically call `setOn(_:animated:)`, and it will animate the transition. You can also call `setClear(animated:)`, if in three-state mode.
 This uses haptics, in the same manner as UISwitch, except that you can turn them off, by setting `useHaptics` to false.
 */
@IBDesignable
open class RVS_Checkbox: UIControl {
    #if os(iOS) // This prevents the IB errors from showing up, under SPM (From SO Answer: https://stackoverflow.com/a/66334661/879365).
    /* ###################################################################################################################################### */
    // MARK: -
    // MARK: - INTERNAL DEFAULT DYNAMIC IMAGES
    // MARK: -
    /* ###################################################################################################################################### */
    /* ###################################################################################################################################### */
    // MARK: - Image Base Class
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

        /* ################################################################################################################################## */
        // MARK: - Subclasses MUST Override This -
        /* ################################################################################################################################## */
        /* ################################################################## */
        /**
         This needs to be overridden.
         
         This supplies a rendered image. It will use the myFillColor value (default myFillColor is label color).
         */
        var asImage: UIImage! { preconditionFailure("This Computed Property Must be Overridden by Subclasses!" ) }
    }

    /* ###################################################################################################################################### */
    // MARK: - Clear (No State) Image
    /* ###################################################################################################################################### */
    /**
     This is the "clear" (blank circle) image. In a two-state checkbox, it is also the "Off" value image.
     */
    class RVS_Checkbox_Image_Clear: RVS_Checkbox_Image {
        /* ################################################################## */
        /**
         This supplies a rendered image. It will use the myFillColor.
         */
        override var asImage: UIImage! {
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: 900, height: 900))
            let img = renderer.image { _ in
                let ovalPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 900, height: 900))
                myFillColor.setFill()
                ovalPath.fill()
            }
            return img
        }
    }

    /* ###################################################################################################################################### */
    // MARK: - Selected (On) Image
    /* ###################################################################################################################################### */
    /**
     This is the "Checked," or "√" image. In a two-state checkbox, it is also the "On" value image.
     */
    class RVS_Checkbox_Image_On: RVS_Checkbox_Image {
        /* ################################################################## */
        /**
         This supplies a rendered image. It will use the myFillColor.
         */
        override var asImage: UIImage! {
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: 900, height: 900))
            let img = renderer.image { _ in
                let bezierPath = UIBezierPath()
                bezierPath.move(to: CGPoint(x: 450, y: 0))
                bezierPath.addCurve(to: CGPoint(x: 0, y: 450), controlPoint1: CGPoint(x: 201.5, y: 0), controlPoint2: CGPoint(x: 0, y: 201.5))
                bezierPath.addCurve(to: CGPoint(x: 450, y: 900), controlPoint1: CGPoint(x: 0, y: 698.5), controlPoint2: CGPoint(x: 201.5, y: 900))
                bezierPath.addCurve(to: CGPoint(x: 900, y: 450), controlPoint1: CGPoint(x: 698.5, y: 900), controlPoint2: CGPoint(x: 900, y: 698.5))
                bezierPath.addCurve(to: CGPoint(x: 450, y: 0), controlPoint1: CGPoint(x: 900, y: 201.5), controlPoint2: CGPoint(x: 698.5, y: 0))
                bezierPath.close()
                bezierPath.move(to: CGPoint(x: 688.3, y: 252.9))
                bezierPath.addCurve(to: CGPoint(x: 685.3, y: 253.7), controlPoint1: CGPoint(x: 687.3, y: 253.4), controlPoint2: CGPoint(x: 686.3, y: 253.7))
                bezierPath.addCurve(to: CGPoint(x: 674.7, y: 249.1), controlPoint1: CGPoint(x: 681.8, y: 253.7), controlPoint2: CGPoint(x: 678.2, y: 252.2))
                bezierPath.addCurve(to: CGPoint(x: 663.3, y: 239.2), controlPoint1: CGPoint(x: 671.2, y: 246.1), controlPoint2: CGPoint(x: 667.4, y: 242.8))
                bezierPath.addCurve(to: CGPoint(x: 650.8, y: 229.3), controlPoint1: CGPoint(x: 659.2, y: 235.7), controlPoint2: CGPoint(x: 655.1, y: 232.4))
                bezierPath.addCurve(to: CGPoint(x: 636.8, y: 224.7), controlPoint1: CGPoint(x: 646.5, y: 226.3), controlPoint2: CGPoint(x: 641.8, y: 224.7))
                bezierPath.addCurve(to: CGPoint(x: 607.9, y: 256.6), controlPoint1: CGPoint(x: 629.2, y: 224.7), controlPoint2: CGPoint(x: 619.6, y: 235.3))
                bezierPath.addCurve(to: CGPoint(x: 561.2, y: 353.4), controlPoint1: CGPoint(x: 596.2, y: 277.9), controlPoint2: CGPoint(x: 580.7, y: 310.1))
                bezierPath.addCurve(to: CGPoint(x: 487.5, y: 517.1), controlPoint1: CGPoint(x: 541.7, y: 396.7), controlPoint2: CGPoint(x: 517.2, y: 451.2))
                bezierPath.addCurve(to: CGPoint(x: 377, y: 749.5), controlPoint1: CGPoint(x: 457.9, y: 582.9), controlPoint2: CGPoint(x: 421, y: 660.4))
                bezierPath.addCurve(to: CGPoint(x: 370.9, y: 752.2), controlPoint1: CGPoint(x: 376, y: 751), controlPoint2: CGPoint(x: 374, y: 751.9))
                bezierPath.addCurve(to: CGPoint(x: 360.3, y: 752.6), controlPoint1: CGPoint(x: 367.9, y: 752.4), controlPoint2: CGPoint(x: 364.3, y: 752.6))
                bezierPath.addCurve(to: CGPoint(x: 351.9, y: 750.7), controlPoint1: CGPoint(x: 356.2, y: 752.6), controlPoint2: CGPoint(x: 353.5, y: 752))
                bezierPath.addCurve(to: CGPoint(x: 348.1, y: 744.2), controlPoint1: CGPoint(x: 350.4, y: 749.4), controlPoint2: CGPoint(x: 349.1, y: 747.3))
                bezierPath.addCurve(to: CGPoint(x: 334.1, y: 705.5), controlPoint1: CGPoint(x: 345.1, y: 735.1), controlPoint2: CGPoint(x: 340.4, y: 722.2))
                bezierPath.addCurve(to: CGPoint(x: 312.8, y: 651.2), controlPoint1: CGPoint(x: 327.8, y: 688.8), controlPoint2: CGPoint(x: 320.7, y: 670.7))
                bezierPath.addCurve(to: CGPoint(x: 287, y: 591.6), controlPoint1: CGPoint(x: 304.9, y: 631.7), controlPoint2: CGPoint(x: 296.3, y: 611.8))
                bezierPath.addCurve(to: CGPoint(x: 258.5, y: 536.2), controlPoint1: CGPoint(x: 277.6, y: 571.4), controlPoint2: CGPoint(x: 268.1, y: 552.9))
                bezierPath.addCurve(to: CGPoint(x: 230, y: 495.6), controlPoint1: CGPoint(x: 248.9, y: 519.5), controlPoint2: CGPoint(x: 239.4, y: 506))
                bezierPath.addCurve(to: CGPoint(x: 203.8, y: 480), controlPoint1: CGPoint(x: 220.6, y: 485.2), controlPoint2: CGPoint(x: 211.9, y: 480))
                bezierPath.addCurve(to: CGPoint(x: 195.1, y: 481.5), controlPoint1: CGPoint(x: 200.8, y: 480), controlPoint2: CGPoint(x: 197.8, y: 480.5))
                bezierPath.addCurve(to: CGPoint(x: 187.1, y: 484.5), controlPoint1: CGPoint(x: 192.3, y: 482.5), controlPoint2: CGPoint(x: 189.7, y: 483.5))
                bezierPath.addCurve(to: CGPoint(x: 183.3, y: 481.8), controlPoint1: CGPoint(x: 186.1, y: 484.5), controlPoint2: CGPoint(x: 184.8, y: 483.6))
                bezierPath.addCurve(to: CGPoint(x: 180.3, y: 477.6), controlPoint1: CGPoint(x: 181.8, y: 480), controlPoint2: CGPoint(x: 180.8, y: 478.6))
                bezierPath.addCurve(to: CGPoint(x: 180.7, y: 476.8), controlPoint1: CGPoint(x: 180.3, y: 477.1), controlPoint2: CGPoint(x: 180.4, y: 476.8))
                bezierPath.addCurve(to: CGPoint(x: 181.1, y: 476), controlPoint1: CGPoint(x: 180.9, y: 476.8), controlPoint2: CGPoint(x: 181.1, y: 476.6))
                bezierPath.addCurve(to: CGPoint(x: 194.4, y: 466.1), controlPoint1: CGPoint(x: 181.6, y: 475.5), controlPoint2: CGPoint(x: 186, y: 472.2))
                bezierPath.addCurve(to: CGPoint(x: 224, y: 446), controlPoint1: CGPoint(x: 202.8, y: 460), controlPoint2: CGPoint(x: 212.6, y: 453.3))
                bezierPath.addCurve(to: CGPoint(x: 258.6, y: 425.9), controlPoint1: CGPoint(x: 235.4, y: 438.7), controlPoint2: CGPoint(x: 246.9, y: 432))
                bezierPath.addCurve(to: CGPoint(x: 287.5, y: 416.8), controlPoint1: CGPoint(x: 270.2, y: 419.8), controlPoint2: CGPoint(x: 279.9, y: 416.8))
                bezierPath.addCurve(to: CGPoint(x: 303.8, y: 431.6), controlPoint1: CGPoint(x: 293.1, y: 416.8), controlPoint2: CGPoint(x: 298.5, y: 421.7))
                bezierPath.addCurve(to: CGPoint(x: 323.2, y: 476.4), controlPoint1: CGPoint(x: 309.1, y: 441.5), controlPoint2: CGPoint(x: 315.6, y: 456.4))
                bezierPath.addCurve(to: CGPoint(x: 350.2, y: 552), controlPoint1: CGPoint(x: 330.8, y: 496.4), controlPoint2: CGPoint(x: 339.8, y: 521.6))
                bezierPath.addCurve(to: CGPoint(x: 388.6, y: 659.8), controlPoint1: CGPoint(x: 360.6, y: 582.4), controlPoint2: CGPoint(x: 373.4, y: 618.3))
                bezierPath.addCurve(to: CGPoint(x: 439.9, y: 552.3), controlPoint1: CGPoint(x: 406.8, y: 626.4), controlPoint2: CGPoint(x: 423.9, y: 590.6))
                bezierPath.addCurve(to: CGPoint(x: 485.1, y: 438.4), controlPoint1: CGPoint(x: 455.8, y: 514.1), controlPoint2: CGPoint(x: 470.9, y: 476.1))
                bezierPath.addCurve(to: CGPoint(x: 525.3, y: 329.8), controlPoint1: CGPoint(x: 499.3, y: 400.7), controlPoint2: CGPoint(x: 512.7, y: 364.5))
                bezierPath.addCurve(to: CGPoint(x: 561, y: 237.9), controlPoint1: CGPoint(x: 537.9, y: 295.1), controlPoint2: CGPoint(x: 549.9, y: 264.5))
                bezierPath.addCurve(to: CGPoint(x: 593.3, y: 174.5), controlPoint1: CGPoint(x: 572.1, y: 211.3), controlPoint2: CGPoint(x: 582.9, y: 190.2))
                bezierPath.addCurve(to: CGPoint(x: 624.1, y: 151), controlPoint1: CGPoint(x: 603.7, y: 158.8), controlPoint2: CGPoint(x: 613.9, y: 151))
                bezierPath.addCurve(to: CGPoint(x: 653, y: 173), controlPoint1: CGPoint(x: 633.2, y: 151), controlPoint2: CGPoint(x: 642.8, y: 158.3))
                bezierPath.addCurve(to: CGPoint(x: 663.6, y: 189.3), controlPoint1: CGPoint(x: 656, y: 177.6), controlPoint2: CGPoint(x: 659.6, y: 183))
                bezierPath.addCurve(to: CGPoint(x: 675, y: 209), controlPoint1: CGPoint(x: 667.6, y: 195.6), controlPoint2: CGPoint(x: 671.4, y: 202.2))
                bezierPath.addCurve(to: CGPoint(x: 684.5, y: 229.5), controlPoint1: CGPoint(x: 678.5, y: 215.8), controlPoint2: CGPoint(x: 681.7, y: 222.7))
                bezierPath.addCurve(to: CGPoint(x: 690.2, y: 248.1), controlPoint1: CGPoint(x: 687.3, y: 236.3), controlPoint2: CGPoint(x: 689.2, y: 242.5))
                bezierPath.addCurve(to: CGPoint(x: 688.3, y: 252.9), controlPoint1: CGPoint(x: 689.8, y: 250.8), controlPoint2: CGPoint(x: 689.3, y: 252.4))
                bezierPath.close()
                myFillColor.setFill()
                bezierPath.fill()
            }
            return img
        }
    }

    /* ###################################################################################################################################### */
    // MARK: - Unselected (Off) Image
    /* ###################################################################################################################################### */
    /**
     This is the "Unchecked," or "X" image. In a two-state checkbox, it is ignored.
     */
    class RVS_Checkbox_Image_Off: RVS_Checkbox_Image {
        /* ################################################################## */
        /**
         This supplies a rendered image. It will use the myFillColor.
         */
        override var asImage: UIImage! {
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: 900, height: 900))
            let img = renderer.image { _ in
                let bezier2Path = UIBezierPath()
                bezier2Path.move(to: CGPoint(x: 450, y: 0))
                bezier2Path.addCurve(to: CGPoint(x: 0, y: 450), controlPoint1: CGPoint(x: 201.5, y: 0), controlPoint2: CGPoint(x: 0, y: 201.5))
                bezier2Path.addCurve(to: CGPoint(x: 450, y: 900), controlPoint1: CGPoint(x: 0, y: 698.5), controlPoint2: CGPoint(x: 201.5, y: 900))
                bezier2Path.addCurve(to: CGPoint(x: 900, y: 450), controlPoint1: CGPoint(x: 698.5, y: 900), controlPoint2: CGPoint(x: 900, y: 698.5))
                bezier2Path.addCurve(to: CGPoint(x: 450, y: 0), controlPoint1: CGPoint(x: 900, y: 201.5), controlPoint2: CGPoint(x: 698.5, y: 0))
                bezier2Path.close()
                bezier2Path.move(to: CGPoint(x: 519.5, y: 509.7))
                bezier2Path.addLine(to: CGPoint(x: 537.4, y: 550.2))
                bezier2Path.addLine(to: CGPoint(x: 554.5, y: 590.3))
                bezier2Path.addCurve(to: CGPoint(x: 620.9, y: 674.9), controlPoint1: CGPoint(x: 578.4, y: 646.7), controlPoint2: CGPoint(x: 600.5, y: 674.9))
                bezier2Path.addCurve(to: CGPoint(x: 685.7, y: 606.8), controlPoint1: CGPoint(x: 650.6, y: 674.9), controlPoint2: CGPoint(x: 672.2, y: 652.2))
                bezier2Path.addCurve(to: CGPoint(x: 700.4, y: 623.9), controlPoint1: CGPoint(x: 695.5, y: 611), controlPoint2: CGPoint(x: 700.4, y: 616.8))
                bezier2Path.addCurve(to: CGPoint(x: 676.5, y: 678.4), controlPoint1: CGPoint(x: 700.4, y: 635.6), controlPoint2: CGPoint(x: 692.4, y: 653.8))
                bezier2Path.addCurve(to: CGPoint(x: 595.3, y: 733.7), controlPoint1: CGPoint(x: 652.6, y: 715.3), controlPoint2: CGPoint(x: 625.5, y: 733.7))
                bezier2Path.addCurve(to: CGPoint(x: 537, y: 697.9), controlPoint1: CGPoint(x: 573.5, y: 733.7), controlPoint2: CGPoint(x: 554.1, y: 721.8))
                bezier2Path.addCurve(to: CGPoint(x: 464.7, y: 551.1), controlPoint1: CGPoint(x: 519.9, y: 674), controlPoint2: CGPoint(x: 495.8, y: 625.1))
                bezier2Path.addLine(to: CGPoint(x: 442.8, y: 498.2))
                bezier2Path.addLine(to: CGPoint(x: 434, y: 515.3))
                bezier2Path.addCurve(to: CGPoint(x: 202.3, y: 733.7), controlPoint1: CGPoint(x: 357.8, y: 660.9), controlPoint2: CGPoint(x: 280.6, y: 733.7))
                bezier2Path.addCurve(to: CGPoint(x: 147.7, y: 720.2), controlPoint1: CGPoint(x: 185.6, y: 733.7), controlPoint2: CGPoint(x: 167.4, y: 729.2))
                bezier2Path.addLine(to: CGPoint(x: 206.2, y: 663.3))
                bezier2Path.addCurve(to: CGPoint(x: 239.6, y: 671.7), controlPoint1: CGPoint(x: 216.6, y: 668.9), controlPoint2: CGPoint(x: 227.7, y: 671.7))
                bezier2Path.addCurve(to: CGPoint(x: 347.9, y: 592.1), controlPoint1: CGPoint(x: 274.4, y: 671.7), controlPoint2: CGPoint(x: 310.5, y: 645.2))
                bezier2Path.addCurve(to: CGPoint(x: 419.2, y: 475.5), controlPoint1: CGPoint(x: 379.2, y: 548.1), controlPoint2: CGPoint(x: 403, y: 509.2))
                bezier2Path.addLine(to: CGPoint(x: 427.2, y: 459.6))
                bezier2Path.addLine(to: CGPoint(x: 402.5, y: 401.5))
                bezier2Path.addLine(to: CGPoint(x: 387.4, y: 364.1))
                bezier2Path.addCurve(to: CGPoint(x: 367.9, y: 321.1), controlPoint1: CGPoint(x: 382.1, y: 351.1), controlPoint2: CGPoint(x: 375.6, y: 336.8))
                bezier2Path.addCurve(to: CGPoint(x: 350, y: 282.9), controlPoint1: CGPoint(x: 357.8, y: 299.6), controlPoint2: CGPoint(x: 351.8, y: 286.9))
                bezier2Path.addCurve(to: CGPoint(x: 306.6, y: 232), controlPoint1: CGPoint(x: 335.4, y: 249), controlPoint2: CGPoint(x: 320.9, y: 232))
                bezier2Path.addCurve(to: CGPoint(x: 240.5, y: 307.3), controlPoint1: CGPoint(x: 280.6, y: 232), controlPoint2: CGPoint(x: 258.6, y: 257.1))
                bezier2Path.addCurve(to: CGPoint(x: 227.8, y: 290.6), controlPoint1: CGPoint(x: 232, y: 305.2), controlPoint2: CGPoint(x: 227.8, y: 299.6))
                bezier2Path.addCurve(to: CGPoint(x: 264.4, y: 209.4), controlPoint1: CGPoint(x: 227.8, y: 265.4), controlPoint2: CGPoint(x: 240, y: 238.3))
                bezier2Path.addCurve(to: CGPoint(x: 333.7, y: 166), controlPoint1: CGPoint(x: 288.8, y: 180.5), controlPoint2: CGPoint(x: 311.9, y: 166))
                bezier2Path.addCurve(to: CGPoint(x: 380.3, y: 195.8), controlPoint1: CGPoint(x: 351, y: 166), controlPoint2: CGPoint(x: 366.5, y: 175.9))
                bezier2Path.addCurve(to: CGPoint(x: 440.4, y: 319.9), controlPoint1: CGPoint(x: 394.1, y: 215.7), controlPoint2: CGPoint(x: 414.2, y: 257.1))
                bezier2Path.addLine(to: CGPoint(x: 471.8, y: 395.6))
                bezier2Path.addLine(to: CGPoint(x: 485.3, y: 371.7))
                bezier2Path.addLine(to: CGPoint(x: 510.8, y: 326.7))
                bezier2Path.addCurve(to: CGPoint(x: 694.5, y: 166.5), controlPoint1: CGPoint(x: 571.9, y: 220), controlPoint2: CGPoint(x: 633.1, y: 166.5))
                bezier2Path.addCurve(to: CGPoint(x: 752.2, y: 179.2), controlPoint1: CGPoint(x: 714.9, y: 166.5), controlPoint2: CGPoint(x: 734.2, y: 170.7))
                bezier2Path.addLine(to: CGPoint(x: 694.9, y: 236.5))
                bezier2Path.addCurve(to: CGPoint(x: 665.9, y: 226.9), controlPoint1: CGPoint(x: 683.8, y: 230.1), controlPoint2: CGPoint(x: 674.1, y: 226.9))
                bezier2Path.addCurve(to: CGPoint(x: 593.9, y: 266.7), controlPoint1: CGPoint(x: 641.8, y: 226.9), controlPoint2: CGPoint(x: 617.8, y: 240.2))
                bezier2Path.addCurve(to: CGPoint(x: 500, y: 411.1), controlPoint1: CGPoint(x: 570, y: 293.2), controlPoint2: CGPoint(x: 538.7, y: 341.4))
                bezier2Path.addLine(to: CGPoint(x: 487.7, y: 433.1))
                bezier2Path.addLine(to: CGPoint(x: 519.5, y: 509.7))
                bezier2Path.close()
                myFillColor.setFill()
                bezier2Path.fill()
            }
            return img
        }
    }
    
    /* ################################################################################################################################## */
    // MARK: -
    // MARK: - PRIVATE PROPERTIES AND METHODS -
    // MARK: -
    /* ################################################################################################################################## */
    // MARK: Static Constants
    /* ################################################################## */
    /**
     This is the transparency for a "tracking" control.
     */
    private static let _sDimmedAlpha = CGFloat(0.5)
    
    /* ################################################################## */
    /**
     The timing of animated transitions, in seconds.
     */
    private static let _sTransitionDelay = TimeInterval(0.25)
    
    /* ################################################################## */
    /**
     The "off" SFSymbol for that mode.
     */
    private static let _sSFOff = "square"
    
    /* ################################################################## */
    /**
     The "clear" SFSymbol for that mode.
     */
    private static let _sSFClear = "minus.square"
    
    /* ################################################################## */
    /**
     The "on" SFSymbol for that mode.
     */
    private static let _sSFOn = "checkmark.square.fill"

    /* ################################################################## */
    /**
     The SFSymbol Configuration (large).
     */
    private static let _sSFConfig = UIImage.SymbolConfiguration(scale: .large)
    
    /* ################################################################## */
    // MARK: Instance Properties
    /* ################################################################## */
    /**
     This is the image to use when actually drawing the control.
     */
    private var _drawingImage: UIImage?
    
    /* ################################################################## */
    /**
     This is used in three-state mode, to determine which direction the toggle should go, from clear.
     */
    private var _previousState: States = .clear
    
    /* ################################################################## */
    /**
     This will provide haptic/audio feedback for opening and closing the control.
     */
    private var _selectionFeedbackGenerator: UISelectionFeedbackGenerator?

    /* ################################################################## */
    // MARK: Instance Computed Properties
    /* ################################################################## */
    /**
     This returns the predicted next state, when the swicth will next be selected.
     */
    private var _nextState: States {
        var ret = checkboxState
        
        switch ret {
        case .clear:
            ret = isThreeState ? (.on != _previousState ? .on : .off) : .on
        case .on, .off:
            _previousState = ret
            ret = .clear
        }
        
        return ret
    }

    /* ################################################################## */
    // MARK: Instance Methods
    /* ################################################################## */
    /**
     This returns the appropriate image to use for the current state and settings.
     
     - parameter forState: The state that we wish to get an image for.
     - returns: A UIImage for the proper image. Nil, if undefined (should never happen)
     */
    private func _image(forState inState: States) -> UIImage? {
        var ret: UIImage?
        let color = isEnabled ? tintColor ?? .label : .lightGray
        let sfClearImageName = isThreeState ? Self._sSFClear : Self._sSFOff
        
        if isUsingSFSymbols {   // This allows us to reselect the clear image, in case we changed something.
            clearImage = nil
        }
        
        onImage = onImage ?? (isUsingSFSymbols ? UIImage(systemName: Self._sSFOn, withConfiguration: Self._sSFConfig) ?? RVS_Checkbox_Image_On() : RVS_Checkbox_Image_On())
        clearImage = clearImage ?? (isUsingSFSymbols ? UIImage(systemName: sfClearImageName, withConfiguration: Self._sSFConfig) ?? RVS_Checkbox_Image_Clear() : RVS_Checkbox_Image_Clear())
        offImage = offImage ?? (isUsingSFSymbols ? UIImage(systemName: Self._sSFOff, withConfiguration: Self._sSFConfig) ?? RVS_Checkbox_Image_Off() : RVS_Checkbox_Image_Off())

        switch inState {
        case .clear:
            ret = (useOffImageForClear && !isThreeState && !isUsingSFSymbols ? offImage : clearImage)?.withTintColor(color)
        case .on:
            ret = onImage?.withTintColor(color)
        case .off:
            ret = offImage?.withTintColor(color)
        }
        
        return ret
    }

    /* ################################################################## */
    /**
     This forces the control to redraw from scratch.
     */
    private func _refresh() {
        if !isThreeState,
           .off == checkboxState {
            checkboxState = .clear
        }
        
        _drawingImage = nil
        if useHaptics {
            _selectionFeedbackGenerator = _selectionFeedbackGenerator ?? UISelectionFeedbackGenerator()
            _selectionFeedbackGenerator?.prepare()
        }
        
        setNeedsDisplay()
    }

    /* ################################################################################################################################## */
    // MARK: -
    // MARK: - PUBLIC ENUMS -
    // MARK: -
    /* ################################################################################################################################## */
    /**
     These Int-based enum values define the possible switch states.
     */
    public enum States: Int {
        /// Control is in "off" state, which displays an "X" in the default.
        case off = -1
        
        /// Control is in "clear" state, which displays an empty circle in the default.
        case clear
        
        /// Control is in "on" state, which displays a "√" in the default.
        case on
    }
    
    /* ################################################################################################################################## */
    // MARK: -
    // MARK: - PUBLIC STORED PROPERTIES -
    // MARK: -
    /* ################################################################################################################################## */
    /* ################################################################## */
    /**
     This is the public, read-only accessor for the next state.
     */
    open var nextState: States { _nextState }

    /* ################################################################## */
    /**
     This holds the control's current state (before any changes).
     */
    open var checkboxState: States = .clear {
        didSet {
            _selectionFeedbackGenerator?.selectionChanged()
            _refresh()
        }
    }

    /* ################################################################################################################################## */
    // MARK: -
    // MARK: - PUBLIC INSPECTABLE STORED PROPERTIES -
    // MARK: -
    /* ################################################################################################################################## */
    /* ################################################################## */
    /**
     This is the image to be displayed in an "ON" state.
     */
    @IBInspectable open var onImage: UIImage? {
        didSet { _refresh() }
    }

    /* ################################################################## */
    /**
     This is the image to be displayed in an "OFF" state.
     */
    @IBInspectable open var offImage: UIImage? {
        didSet { _refresh() }
    }
    
    /* ################################################################## */
    /**
     This is the image to be displayed in a "CLEAR" ("OFF," if two-state) state.
     */
    @IBInspectable open var clearImage: UIImage? {
        didSet { _refresh() }
    }

    /* ################################################################## */
    /**
     If this is true, then control is three state (OFF-CLEAR-ON). Otherwise (default), it is two state (OFF-ON).
     */
    @IBInspectable open var isThreeState: Bool = false {
        didSet { _refresh() }
    }

    /* ################################################################## */
    /**
     If true, then the control will not use the dynamically-generated images, and will, instead, use standard SFSymbols square images.
     If the user supplies images, then this will be ignored.
     */
    @IBInspectable open var isUsingSFSymbols: Bool = false {
        didSet { _refresh() }
    }

    /* ################################################################## */
    /**
     If this is true (default is false), then CLEAR will use the image supplied for the three-state OFF.
     This is ignored in three-state mode, or SFSymbols mode (which already does that).
     */
    @IBInspectable open var useOffImageForClear: Bool = false {
        didSet { _refresh() }
    }

    /* ################################################################## */
    /**
     If this is true (default), then the control will use subtle haptics. These will not happen for programmatic set; only for direct UI interaction.
     */
    @IBInspectable open var useHaptics: Bool = true {
        didSet {
            if useHaptics {
                _selectionFeedbackGenerator = _selectionFeedbackGenerator ?? UISelectionFeedbackGenerator()
                _selectionFeedbackGenerator?.prepare()
                _selectionFeedbackGenerator?.selectionChanged()
            } else {
                _selectionFeedbackGenerator = nil
            }
            _refresh()
        }
    }
    #endif
}

/* ###################################################################################################################################### */
// MARK: -
// MARK: - PUBLIC COMPUTED PROPERTIES -
// MARK: -
/* ###################################################################################################################################### */
extension RVS_Checkbox {
    /* ################################################################## */
    /**
     This is the control value, as an Int:
        - -1: OFF
        -  0: CLEAR (Or OFF, in two-state)
        -  1: ON
     */
    open var value: Int {
        get { checkboxState.rawValue }
        set {
            let lowerBound = isThreeState ? States.off.rawValue : States.clear.rawValue
            let upperBound = States.on.rawValue
            
            precondition((lowerBound...upperBound).contains(newValue), "Value Out of Range!")
            
            checkboxState = States(rawValue: newValue) ?? .clear
        }
    }

    /* ################################################################## */
    /**
     This returns true, if the control is currently in "CLEAR" state (which is also off, for two-state).
     READ-ONLY
     */
    open var isClear: Bool { .clear == checkboxState }
    
    /* ################################################################## */
    /**
     This returns true, if the control is in "OFF" state (three state), or either "off" or "clear" (two-state).
     READ-ONLY
     */
    open var isOff: Bool { isThreeState ? .off == checkboxState : .on != checkboxState }

    /* ################################################################################################################################## */
    // MARK: -
    // MARK: - PUBLIC INSPECTABLE COMPUTED PROPERTIES -
    // MARK: -
    /* ################################################################################################################################## */
    /* ################################################################## */
    /**
     This returns true, if the control is in ON state.
     If explicitly set to false, the checkbox is set to OFF (or CLEAR for two  state).
     */
    @IBInspectable open var isOn: Bool {
        get { .on == checkboxState }
        set { checkboxState = newValue ? .on : !isThreeState ? .clear : .off }
    }
}

/* ###################################################################################################################################### */
// MARK: -
// MARK: - PUBLIC INSTANCE METHODS -
// MARK: -
/* ###################################################################################################################################### */
extension RVS_Checkbox {
    /* ################################################################## */
    /**
     This sets the control to either ON or OFF. It can be animated.
     
     - parameter inIsOn: If true, the control is set to ON. If false, the control is set to OFF (or CLEAR, in two-state)
     - parameter animated: If true, the change is animated.
     */
    open func setOn(_ inIsOn: Bool, animated inIsAnimated: Bool = false) {
        setState(inIsOn ? .on : .off, animated: inIsAnimated)
    }
    
    /* ################################################################## */
    /**
     This sets the control to CLEAR (or OFF, in two-state). It can be animated.
     
     - parameter animated: If true, the change is animated.
     */
    open func setClear(animated inIsAnimated: Bool = false) {
        setState(.clear, animated: inIsAnimated)
    }

    /* ################################################################## */
    /**
     This explicitly sets the control state. It can be animated.
     
     - parameter inState: The control state.
     - parameter animated: If true, the change is animated.
     */
    open func setState(_ inState: States, animated inIsAnimated: Bool = false) {
        if inIsAnimated {
            let state = !isThreeState && .off == inState ? .clear : inState
            var finalImage: UIImage?
            if let tint = tintColor,
               isEnabled {
                _drawingImage = _image(forState: checkboxState)?.withTintColor(tint.withAlphaComponent(Self._sDimmedAlpha))
                finalImage = _image(forState: state)?.withTintColor(tint)
            } else {
                _drawingImage = _image(forState: checkboxState)
                finalImage = _image(forState: state)
            }

            setNeedsDisplay()
            
            UIView.transition(with: self,
                              duration: Self._sTransitionDelay,
                              options: .transitionCrossDissolve,
                              animations: { [weak self] in self?._drawingImage = finalImage },
                              completion: { [weak self] _ in
                                self?._selectionFeedbackGenerator = nil // This makes sure we don't get haptic feedback for the set (copies UISwitch behavior).
                                self?.checkboxState = inState
                              })
        } else {
            _selectionFeedbackGenerator = nil // This makes sure we don't get haptic feedback for the set (copies UISwitch behavior).
            checkboxState = inState
        }
    }

    /* ################################################################## */
    /**
     This explicitly sets the control state. It can be animated.
     
     - parameter inValue: This is the desired control value, as an Int.
       If the number is any negative number, it is considered OFF. If it is any positive number, it is considered ON. 0 is CLEAR.
       If in two-state, negative numbers are the same as 0.
     - parameter animated: If true, the change is animated.
     */
    open func setValue(_ inValue: Int, animated inIsAnimated: Bool = false) {
        let value = max(isThreeState ? -1 : 0, min(1, inValue))
        var state: States = .clear

        switch value {
        case -1:
            state = .off
        case 1:
            state = .on
        default:
            state = .clear
        }
        
        setState(state, animated: inIsAnimated)
    }
}

/* ###################################################################################################################################### */
// MARK: -
// MARK: - PUBLIC BASE CLASS OVERRIDES -
// MARK: -
/* ###################################################################################################################################### */
extension RVS_Checkbox {
    /* ################################################################## */
    /**
     The tint color.
     The override is to force a redraw.
     */
    override open var tintColor: UIColor? {
        get { super.tintColor }
        set {
            super.tintColor = newValue
            _refresh()
        }
    }
    
    /* ################################################################## */
    /**
     The enabled state.
     The override is to force a redraw.
     */
    override open var isEnabled: Bool {
        get { super.isEnabled }
        set {
            super.isEnabled = newValue
            _refresh()
        }
    }
    
    /* ################################################################## */
    /**
     This draws the control, dimming, if tracking, and over the control.
     
     - parameter inRect: The rect to draw.
     */
    override open func draw(_ inRect: CGRect) {
        if let currentImage = _drawingImage ?? _image(forState: checkboxState) {
            let alpha = (isTracking && isTouchInside) || !isEnabled ? Self._sDimmedAlpha : 1.0
            currentImage.draw(in: inRect, blendMode: .normal, alpha: alpha)
        }
    }
    
    /* ################################################################## */
    /**
     Called when the user starts a press.
     
     - parameter inTouch: The touch instance (passed to superclass).
     - parameter with: The event (passed to superclass).
     - returns: True, if the touch is approved.
     */
    override open func beginTracking(_ inTouch: UITouch, with inEvent: UIEvent?) -> Bool {
        defer { setNeedsDisplay() }
        return super.beginTracking(inTouch, with: inEvent)
    }
    
    /* ################################################################## */
    /**
     Called when the user starts a press.
     
     - parameter inTouch: The touch instance (passed to superclass).
     - parameter with: The event (passed to superclass).
     - returns: True, if the drag/touch should continue.
     */
    override open func continueTracking(_ inTouch: UITouch, with inEvent: UIEvent?) -> Bool {
        defer { setNeedsDisplay() }
        return super.continueTracking(inTouch, with: inEvent)
    }
    
    /* ################################################################## */
    /**
     Called when the user ends a press.
     If the touch ends inside the control, the value is changed, and messages are sent.
     
     - parameter inTouch: The touch instance (passed to superclass).
     - parameter with: The event (passed to superclass).
     */
    override open func endTracking(_ inTouch: UITouch?, with inEvent: UIEvent?) {
        super.endTracking(inTouch, with: inEvent)
        if isTouchInside {
            checkboxState = _nextState
            sendActions(for: .valueChanged)
            sendActions(for: .primaryActionTriggered)
        }
        setNeedsDisplay()
    }
    
    /* ################################################################## */
    /**
     Called when a touch is canceled.
     
     - parameter with: The event (passed to superclass).
     */
    override open func cancelTracking(with inEvent: UIEvent?) {
        super.cancelTracking(with: inEvent)
        setNeedsDisplay()
    }
}
