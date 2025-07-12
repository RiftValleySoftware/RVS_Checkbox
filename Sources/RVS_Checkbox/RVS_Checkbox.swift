/**
 © Copyright 2021-2025, The Great Rift Valley Software Company

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
 
 Version 3.0.3
*/

import UIKit

#if os(iOS) // This prevents the IB errors from showing up, under SPM (From SO Answer: https://stackoverflow.com/a/66334661/879365).
/* ###################################################################################################################################### */
// MARK: - Three-State UIKit Checkbox -
/* ###################################################################################################################################### */
/**
 This class provides a simple Swift-only module that implements a "checkbox" to replace the standard UISwitch.
 The switch can behave exactly like a standard UISwitch, but also has a "three-state" option, where it has definitely off, definitely on, and clear, which is a sort of "undefined" state. Default is two-state (like UISwitch).
 By default, the class uses the SFSymbols checkbox symbols, but these are sometimes considered a bit awkward for UIKit (which is why UIKit doesn't use them).
 You can also supply three of your own images to use for the control (or only two, if you are sticking with the "two-state" version).
 All images are drawn template mode, using the control ``tintColor``.
 Like the UISwitch class, you can specifically call ``setOn(_:animated:)``, and it will animate the transition. You can also call ``setClear(animated:)``, if in three-state mode.
 This uses haptics, in the same manner as UISwitch, except that you can turn them off, by setting ``useHaptics`` to false.
 */
@IBDesignable
open class RVS_Checkbox: UISwitch {
    /* ###################################################################################################################################### */
    // MARK: - INTERNAL DEFAULT DYNAMIC IMAGES
    /* ###################################################################################################################################### */
    /* ###################################################################################################################################### */
    // MARK: - Image Base Class
    /* ###################################################################################################################################### */
    /**
     This provides a base class for the three images to be used as switch elements.
     The default uses code-drawn images that render in template mode, and use the tint color.
     */
    class RVS_Checkbox_Image: UIImage, @unchecked Sendable {
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
            self.asImage?.draw(in: inRect)
        }
        
        /* ################################################################## */
        /**
         Draws the image, in the current context (Point).
         
        - parameter at: The top, left point for drawing.
         */
        override func draw(at inPoint: CGPoint) {
            self.asImage?.draw(at: inPoint)
        }
        
        /* ################################################################## */
        /**
        This returns the image, but tinted (in the default, this always colors the image completely).
         
         - parameter inTintColor: The color to use for tinting.
         - returns: The image, but tinted (using the supplied color).
         */
        override func withTintColor(_ inTintColor: UIColor) -> UIImage {
            self.myFillColor = inTintColor
            return self.asImage ?? super.withTintColor(inTintColor)
        }

        /* ################################################################################################################################## */
        // MARK: - Subclasses MUST Override This -
        /* ################################################################################################################################## */
        /* ################################################################## */
        /**
         This needs to be overridden.
         
         This supplies a rendered image. It will use the ``myFillColor`` value (default ``myFillColor`` is label color).
         */
        var asImage: UIImage! { preconditionFailure("This Computed Property Must be Overridden by Subclasses!" ) }
    }
    
    /* ################################################################################################################################## */
    // MARK: - PRIVATE PROPERTIES AND METHODS -
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
     This returns the predicted next state, when the switch will next be selected.
     */
    private var _nextState: States {
        var ret = self.checkboxState
        
        switch ret {
        case .clear:
            ret = self.isThreeState ? (.on != self._previousState ? .on : .off) : .on
        case .on, .off:
            self._previousState = ret
            ret = .clear
        }
        
        return ret
    }

    /* ################################################################## */
    // MARK: Instance Methods
    /* ################################################################## */
    /**
     This returns the appropriate image to use for the current state and settings.
     
     - parameter inState: The state that we wish to get an image for.
     - returns: A UIImage for the proper image. Nil, if undefined (should never happen)
     */
    private func _image(forState inState: States) -> UIImage? {
        var ret: UIImage?
        let color = self.isEnabled ? self.tintColor ?? .label : .lightGray
        
        let offImage = self.isUsingSFSymbols ? UIImage(systemName: Self._sSFOff, withConfiguration: Self._sSFConfig)?.withRenderingMode(.alwaysTemplate)
                                                : self.offImage ?? UIImage(systemName: "nosign")
        let clearImage = self.isUsingSFSymbols ? UIImage(systemName: Self._sSFClear, withConfiguration: Self._sSFConfig)?.withRenderingMode(.alwaysTemplate)
                                                : self.clearImage ?? UIImage(systemName: "nosign")
        let onImage = self.isUsingSFSymbols ? UIImage(systemName: Self._sSFOn, withConfiguration: Self._sSFConfig)?.withRenderingMode(.alwaysTemplate)
                                                : self.onImage ?? UIImage(systemName: "nosign")

        switch inState {
        case .clear:
            ret = (self.useOffImageForClear ? offImage : clearImage)
        case .on:
            ret = onImage
        case .off:
            ret = offImage
        }
        
        if .alwaysTemplate == ret?.renderingMode {
            ret = ret?.withTintColor(color)
        }
        
        return ret
    }

    /* ################################################################## */
    /**
     This forces the control to redraw from scratch.
     */
    private func _refresh() {
        if !self.isThreeState,
           .off == self.checkboxState {
            self.checkboxState = .clear
        }
        
        self._drawingImage = nil
        if self.useHaptics {
            self._selectionFeedbackGenerator = self._selectionFeedbackGenerator ?? UISelectionFeedbackGenerator()
            self._selectionFeedbackGenerator?.prepare()
        }
        
        self.setNeedsDisplay()
    }

    /* ################################################################################################################################## */
    // MARK: - PUBLIC ENUMS -
    /* ################################################################################################################################## */
    /**
     These Int-based enum values define the possible switch states.
     */
    public enum States: Int {
        /* ############################################################## */
        /**
         Control is in "off" state, which displays a 􀂒 in the default.
         */
        case off = -1
        
        /* ############################################################## */
        /**
         Control is in "clear" state, which displays a 􀃞 in the default.
         */
        case clear
        
        /* ############################################################## */
        /**
         Control is in "on" state, which displays a 􀃳 in the default.
         */
        case on
    }
    
    /* ################################################################################################################################## */
    // MARK: - PUBLIC STORED PROPERTIES -
    /* ################################################################################################################################## */
    /* ################################################################## */
    /**
     This is the public, read-only accessor for the next state.
     */
    open var nextState: States { self._nextState }

    /* ################################################################## */
    /**
     This holds the control's current state (before any changes).
     */
    open var checkboxState: States = .clear {
        didSet {
            self._selectionFeedbackGenerator?.selectionChanged()
            self._refresh()
        }
    }

    /* ################################################################## */
    /**
     If true, then the control will not use the dynamically-generated images, and will, instead, use standard SFSymbols square images.
     If the user supplies images, then this will be ignored.
     > NOTE: If either offImage or onImage is nil, then the checkbox will use SFSymbols. It must have BOTH to allow custom images.
     */
    open var isUsingSFSymbols: Bool = true {
        didSet {
            if !self.isUsingSFSymbols,
               nil == self.onImage || nil == self.offImage {
                self.isUsingSFSymbols = true
            }
            self._refresh()
        }
    }

    /* ################################################################################################################################## */
    // MARK: - PUBLIC INSPECTABLE STORED PROPERTIES -
    /* ################################################################################################################################## */
    /* ################################################################## */
    /**
     This is the image to be displayed in an "ON" state.
     > NOTE: If either ``offImage`` or ``onImage`` is nil, then the checkbox will use SFSymbols. It must have BOTH to allow custom images.
     */
    @IBInspectable open override var onImage: UIImage? {
        didSet {
            self.isUsingSFSymbols = nil == self.onImage || nil == self.offImage
            self._refresh()
        }
    }

    /* ################################################################## */
    /**
     This is the image to be displayed in an "OFF" state.
     > NOTE: If either ``offImage`` or ``onImage`` is nil, then the checkbox will use SFSymbols. It must have BOTH to allow custom images.
     */
    @IBInspectable open override var offImage: UIImage? {
        didSet {
            self.isUsingSFSymbols = nil == self.onImage || nil == self.offImage
            self._refresh()
        }
    }
    
    /* ################################################################## */
    /**
     This is the image to be displayed in a "CLEAR" ("OFF," if two-state) state.
     > NOTE: If a clear image is not avaialable, then ``useOffImageForClear`` is forced on. ``isUsingSFSymbols`` mode (default) will always have the image avaialable.
     */
    @IBInspectable open var clearImage: UIImage? {
        didSet {
            if !self.isUsingSFSymbols || !self.isThreeState,
               nil == self.clearImage || !self.isThreeState {
                self.useOffImageForClear = true
            }

            self._refresh()
        }
    }

    /* ################################################################## */
    /**
     If this is true, then control is three state (OFF-CLEAR-ON). Otherwise (default), it is two state (OFF-ON).
     > NOTE: If a clear image is not avaialable, then ``useOffImageForClear`` is forced on. ``isUsingSFSymbols`` mode (default) will always have the image avaialable.
     */
    @IBInspectable open var isThreeState: Bool = false { didSet { self._refresh() } }

    /* ################################################################## */
    /**
     If this is true (default is false), then CLEAR will use the image supplied for the three-state OFF.
     > NOTE: If a clear image is not avaialable, then ``useOffImageForClear`` is forced on. ``isUsingSFSymbols`` mode (default) will always have the image avaialable.
     */
    @IBInspectable open var useOffImageForClear: Bool = true {
        didSet {
            if !self.isUsingSFSymbols || !self.isThreeState,
               nil == self.clearImage || !self.isThreeState {
                self.useOffImageForClear = true
            }
            self._refresh()
        }
    }

    /* ################################################################## */
    /**
     If this is true (default), then the control will use subtle haptics. These will not happen for programmatic set; only for direct UI interaction.
     */
    @IBInspectable open var useHaptics: Bool = true {
        didSet {
            if self.useHaptics {
                self._selectionFeedbackGenerator = self._selectionFeedbackGenerator ?? UISelectionFeedbackGenerator()
                self._selectionFeedbackGenerator?.prepare()
            } else {
                self._selectionFeedbackGenerator = nil
            }
            self._refresh()
        }
    }
}

/* ###################################################################################################################################### */
// MARK: - PUBLIC COMPUTED PROPERTIES -
/* ###################################################################################################################################### */
extension RVS_Checkbox {
    /* ################################################################## */
    /**
     This is the control value, as an Int:
        - -1: OFF
        -  0: CLEAR (if two-state, this is not returned -OFF is returned, instead)
        -  1: ON
     */
    public var value: Int {
        get {
            switch self.checkboxState {
            case .off:
                return States.off.rawValue
                
            case .clear:
                return self.isThreeState ? States.clear.rawValue : States.off.rawValue
                
            case .on:
                return States.on.rawValue
            }
        }
        set {
            let lowerBound = States.off.rawValue
            let upperBound = States.on.rawValue
            
            precondition((lowerBound...upperBound).contains(newValue), "Value (\(newValue)) is not in the range \(lowerBound)...\(upperBound).")
            
            let newValueTemp = (States.clear.rawValue == newValue && !self.isThreeState) ? States.off.rawValue : newValue

            self.checkboxState = States(rawValue: newValueTemp) ?? .clear
        }
    }

    /* ################################################################## */
    /**
     This returns true, if the control is currently in "CLEAR" state (which is also off, for two-state).
     READ-ONLY
     */
    public var isClear: Bool { .clear == self.checkboxState }
    
    /* ################################################################## */
    /**
     This returns true, if the control is in "OFF" state (three state), or either "off" or "clear" (two-state).
     READ-ONLY
     */
    public var isOff: Bool { .off == self.checkboxState }
}

/* ################################################################################################################################## */
// MARK: - PUBLIC INSPECTABLE COMPUTED PROPERTIES -
/* ################################################################################################################################## */
extension RVS_Checkbox {
    /* ################################################################## */
    /**
     This returns true, if the control is in ON state.
     If explicitly set to false, the checkbox is set to OFF (or CLEAR for two  state).
     */
    open override var isOn: Bool {
        get { .on == self.checkboxState }
        set { self.checkboxState = newValue ? .on : .off }
    }
}

/* ###################################################################################################################################### */
// MARK: - PUBLIC INSTANCE METHODS -
/* ###################################################################################################################################### */
extension RVS_Checkbox {
    /* ################################################################## */
    /**
     This sets the control to either ON or OFF. It can be animated.
     
     - parameter inIsOn: If true, the control is set to ON. If false, the control is set to OFF (or CLEAR, in two-state)
     - parameter inIsAnimated: If true, the change is animated.
     */
    public override func setOn(_ inIsOn: Bool, animated inIsAnimated: Bool = false) {
        self.setState(inIsOn ? .on : .off, animated: inIsAnimated)
    }
    
    /* ################################################################## */
    /**
     This sets the control to CLEAR (or OFF, in two-state). It can be animated.
     
     - parameter inIsAnimated: If true, the change is animated.
     */
    public func setClear(animated inIsAnimated: Bool = false) {
        self.setState(.clear, animated: inIsAnimated)
    }

    /* ################################################################## */
    /**
     This explicitly sets the control state. It can be animated.
     
     - parameter inState: The control state.
     - parameter inIsAnimated: If true, the change is animated.
     */
    public func setState(_ inState: States, animated inIsAnimated: Bool = false) {
        if inIsAnimated {
            let state = !self.isThreeState && .off == inState ? .clear : inState
            var finalImage = self._image(forState: state)
            self._drawingImage = self._image(forState: self.checkboxState)

            if let color = self.tintColor {
                if .alwaysTemplate == self._drawingImage?.renderingMode {
                    self._drawingImage = self._image(forState: self.checkboxState)?.withTintColor(color.withAlphaComponent(Self._sDimmedAlpha))
                }
                if .alwaysTemplate == finalImage?.renderingMode {
                    finalImage = finalImage?.withTintColor(color)
                }
            }

            setNeedsDisplay()
            self._selectionFeedbackGenerator = nil // This makes sure we don't get haptic feedback for the set (copies UISwitch behavior).
            self.checkboxState = inState

            UIView.transition(with: self,
                              duration: Self._sTransitionDelay,
                              options: .transitionCrossDissolve,
                              animations: { [weak self] in self?._drawingImage = finalImage },
                              completion: { [weak self] _ in self?._refresh() })
        } else {
            self._selectionFeedbackGenerator = nil // This makes sure we don't get haptic feedback for the set (copies UISwitch behavior).
            self.checkboxState = inState
            self._refresh()
        }
    }

    /* ################################################################## */
    /**
     This explicitly sets the control state. It can be animated.
     
     - parameter inValue: This is the desired control value, as an Int.
       If the number is any negative number, it is considered OFF. If it is any positive number, it is considered ON. 0 is CLEAR.
       If in two-state, negative numbers are the same as 0.
     - parameter inIsAnimated: If true, the change is animated.
     */
    public func setValue(_ inValue: Int, animated inIsAnimated: Bool = false) {
        let value = max(self.isThreeState ? -1 : 0, min(1, inValue))
        var state: States = .clear

        switch value {
        case -1:
            state = .off
        case 1:
            state = .on
        default:
            state = .clear
        }
        
        self.setState(state, animated: inIsAnimated)
    }
}

/* ###################################################################################################################################### */
// MARK: - PUBLIC BASE CLASS OVERRIDES -
/* ###################################################################################################################################### */
extension RVS_Checkbox {
    /* ################################################################## */
    /**
     The property is overridden, so we will trigger a redraw, if it changes.
     */
    override open var tintColor: UIColor! {
        didSet {
            super.tintColor = self.tintColor
            self.setNeedsDisplay()
        }
    }
    
    /* ################################################################## */
    /**
     It's important for the background to be clear.
     */
    override open func layoutSubviews() {
        // This is because the standard UISwitch actually has an embedded subview, with the switch. This removes that, so we have the whole thing.
        self.subviews.forEach { $0.removeFromSuperview() }
        super.layoutSubviews()
        self.backgroundColor = .clear
    }
    
    /* ################################################################## */
    /**
     This draws the control, dimming, if tracking, and over the control.
     
     - parameter inRect: The rect to draw.
     */
    override open func draw(_ inRect: CGRect) {
        if let currentImage = self._drawingImage ?? self._image(forState: self.checkboxState) {
            let alpha = (isTracking && isTouchInside) || !isEnabled ? Self._sDimmedAlpha : 1.0
            let scaleX: CGFloat = inRect.size.width / currentImage.size.width
            let scaleY: CGFloat = inRect.size.height / currentImage.size.height
            let drawingScale = min(scaleX, scaleY)
            let newImageSize = CGSize(width: currentImage.size.width * drawingScale, height: currentImage.size.height * drawingScale)
            let destRect = CGRect(origin: CGPoint(x: (inRect.size.width - newImageSize.width) / 2, y: (inRect.size.height - newImageSize.height) / 2), size: newImageSize)
            currentImage.draw(in: destRect, blendMode: .normal, alpha: alpha)
        }
    }
    
    /* ################################################################## */
    /**
     Called when the user starts a press.
     
     - parameter inTouch: The touch instance (passed to superclass).
     - parameter inEvent: The event (passed to superclass).
     - returns: True, if the touch is approved.
     */
    override open func beginTracking(_ inTouch: UITouch, with inEvent: UIEvent?) -> Bool {
        defer { self.setNeedsDisplay() }
        return super.beginTracking(inTouch, with: inEvent)
    }
    
    /* ################################################################## */
    /**
     Called when the user starts a press.
     
     - parameter inTouch: The touch instance (passed to superclass).
     - parameter inEvent: The event (passed to superclass).
     - returns: True, if the drag/touch should continue.
     */
    override open func continueTracking(_ inTouch: UITouch, with inEvent: UIEvent?) -> Bool {
        defer { self.setNeedsDisplay() }
        return super.continueTracking(inTouch, with: inEvent)
    }
    
    /* ################################################################## */
    /**
     Called when the user ends a press.
     If the touch ends inside the control, the value is changed, and messages are sent.
     
     - parameter inTouch: The touch instance (passed to superclass).
     - parameter inEvent: The event (passed to superclass).
     */
    override open func endTracking(_ inTouch: UITouch?, with inEvent: UIEvent?) {
        super.endTracking(inTouch, with: inEvent)
        if self.isTouchInside {
            self.checkboxState = self._nextState
            self._selectionFeedbackGenerator?.selectionChanged()
            self._selectionFeedbackGenerator?.prepare()
            self.sendActions(for: .valueChanged)
            self.sendActions(for: .primaryActionTriggered)
        }
        self.setNeedsDisplay()
    }
    
    /* ################################################################## */
    /**
     Called when a touch is canceled.
     
     - parameter inEvent: The event (passed to superclass).
     */
    override open func cancelTracking(with inEvent: UIEvent?) {
        super.cancelTracking(with: inEvent)
        self.setNeedsDisplay()
    }
}
#else
    // This just gives IB something to stick in its place, for non-iOS builds.
    @IBDesignable
    class RVS_Checkbox: UIView { }
#endif
