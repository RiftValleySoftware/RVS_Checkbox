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
// MARK: - Three-State UIKit Checkbox -
/* ###################################################################################################################################### */
/**
 */
open class RVS_Checkbox: UIControl {
    /* ################################################################################################################################## */
    // MARK: - States Enum -
    /* ################################################################################################################################## */
    /**
     */
    public enum States: Int {
        // Control is in "off" state, which displays an "X" in the default.
        case off = -1
        
        // Control is in "clear" state, which displays an empty circle in the default.
        case clear
        
        // Control is in "on" state, which displays a "√" in the default.
        case on
    }
    
    /* ################################################################## */
    /**
     */
    private var _drawingImage: UIImage?
    
    /* ################################################################## */
    /**
     */
    private var _previousState: States = .clear

    /* ################################################################## */
    /**
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
    /**
     */
    private var _currentImage: UIImage? { image(forState: checkboxState) }

    /* ################################################################## */
    /**
     */
    private var _nextImage: UIImage? { image(forState: _nextState) }
    
    /* ################################################################## */
    /**
     */
    private func image(forState inState: States) -> UIImage? {
        var ret: UIImage?
        let color = tintColor ?? .label
        
        switch inState {
            case .clear:
                ret = (useOffImageForClear && !isThreeState ? offImage : clearImage)?.withTintColor(color)
            case .on:
                ret = onImage?.withTintColor(color)
            case .off:
                ret = offImage?.withTintColor(color)
        }
        
        return ret
    }

    /* ################################################################## */
    /**
     */
    public var checkboxState: States = .clear {
        didSet {
            if !isThreeState,
               .off == checkboxState {
                checkboxState = .clear
            }
            _drawingImage = image(forState: checkboxState)
            setNeedsLayout()
        }
    }

    /* ################################################################## */
    /**
     */
    public var value: Int {
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
     */
    public var nextState: States { _nextState }

    /* ################################################################## */
    /**
     */
    public var isClear: Bool {
        get { .clear == checkboxState }
        set { checkboxState = .clear }
    }
    
    /* ################################################################## */
    /**
     */
    public var isOff: Bool {
        get { isThreeState ? .off == checkboxState : .on != checkboxState }
        set { checkboxState = isThreeState ? .off : .clear }
    }

    /* ################################################################## */
    /**
     */
    @IBInspectable open var onImage: UIImage! = RVS_Checkbox_Image_On()

    /* ################################################################## */
    /**
     */
    @IBInspectable open var offImage: UIImage! = RVS_Checkbox_Image_Off()
    
    /* ################################################################## */
    /**
     */
    @IBInspectable open var clearImage: UIImage! = RVS_Checkbox_Image_Clear()

    /* ################################################################## */
    /**
     */
    @IBInspectable open var isThreeState: Bool = false {
        didSet {
            if !isThreeState,
               .off == checkboxState {
                checkboxState = .clear
            }
            
            _drawingImage = nil
            setNeedsDisplay()
        }
    }

    /* ################################################################## */
    /**
     */
    @IBInspectable public var isOn: Bool {
        get { .on == checkboxState }
        set { checkboxState = .on }
    }

    /* ################################################################## */
    /**
     */
    @IBInspectable public var useOffImageForClear: Bool = false {
        didSet {
            _drawingImage = nil
            setNeedsDisplay()
        }
    }

    /* ################################################################## */
    /**
     */
    public func setOn(_ inIsOn: Bool, animated inIsAnimated: Bool = false) {
        setState(inIsOn ? .on : .off, animated: inIsAnimated)
    }
    
    /* ################################################################## */
    /**
     */
    public func clear(animated inIsAnimated: Bool = false) {
        setState(.clear, animated: inIsAnimated)
    }

    /* ################################################################## */
    /**
     */
    public func setState(_ inState: States, animated inIsAnimated: Bool = false) {
        if inIsAnimated {
            _drawingImage = image(forState: checkboxState)?.withTintColor(tintColor.withAlphaComponent(0.75))
            setNeedsDisplay()
            UIView.transition(with: self,
                              duration: 0.25,
                              options: .transitionCrossDissolve,
                              animations: { [weak self] in self?._drawingImage = self?._nextImage },
                              completion: { [weak self] _ in self?.checkboxState = inState })
        } else {
            checkboxState = inState
        }
    }

    /* ################################################################## */
    /**
     */
    override public func draw(_ inRect: CGRect) {
        if let currentImage = _drawingImage ?? image(forState: checkboxState) {
            currentImage.draw(in: inRect, blendMode: .normal, alpha: isTracking && isTouchInside ? 0.75 : 1.0)
        }
    }
    
    /* ################################################################## */
    /**
     */
    override public func beginTracking(_ inTouch: UITouch, with inEvent: UIEvent?) -> Bool {
        defer { setNeedsDisplay() }
        return super.beginTracking(inTouch, with: inEvent)
    }
    
    /* ################################################################## */
    /**
     */
    override public func continueTracking(_ inTouch: UITouch, with inEvent: UIEvent?) -> Bool {
        defer { setNeedsDisplay() }
        return super.continueTracking(inTouch, with: inEvent)
    }
    
    /* ################################################################## */
    /**
     */
    override public func endTracking(_ inTouch: UITouch?, with inEvent: UIEvent?) {
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
     */
    override public func cancelTracking(with inEvent: UIEvent?) {
        super.cancelTracking(with: inEvent)
        setNeedsDisplay()
    }
}
