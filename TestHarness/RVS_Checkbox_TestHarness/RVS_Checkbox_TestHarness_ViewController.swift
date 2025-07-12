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
*/

import UIKit
import RVS_Checkbox
import RVS_Generic_Swift_Toolbox

/* ###################################################################################################################################### */
// MARK: - Main View Controller -
/* ###################################################################################################################################### */
/**
 This presents a single screen, with a bunch of inter-related controls, affecting a single storyboard-established instance of RVS_Checkbox.
 
 Additionally, there are five more instances that are not directly controlled by this view controller, although three of them are dynamically created.
 
 Switches use "label buttons." This is a pattern that I use to mimic the way Web browsers work, with `<label></label>` elements, that affect the control with which they are associated.
 */
class RVS_Checkbox_TestHarness_ViewController: UIViewController {
    /* ################################################################## */
    /**
     Reference to the lefthand dynamically-generated checkbox.
     */
    weak var leftDynamicCheckbox: RVS_Checkbox?

    /* ################################################################## */
    /**
     Reference to the center dynamically-generated checkbox.
     */
    weak var centerDynamicCheckbox: RVS_Checkbox?

    /* ################################################################## */
    /**
     Reference to the righthand dynamically-generated checkbox.
     */
    weak var rightDynamicCheckbox: RVS_Checkbox?

    /* ################################################################################################################################## */
    // MARK: - IB Properties
    /* ################################################################################################################################## */
    /* ################################################################## */
    /**
     This is the last item in the vertical stack view that will hold the dynamic checkboxes.
     */
    @IBOutlet weak var dynamicContainer: UIStackView?
    
    /* ################################################################## */
    /**
     This is the label button for the two-state side of the`stateSwitch`. It is disabled, when the switch is in two-state mode.
     */
    @IBOutlet weak var standardLabelButton: UIButton?

    /* ################################################################## */
    /**
     This is the label button for the three-state side of the `stateSwitch`. It is disabled, when the switch is in three-state mode.
    */
    @IBOutlet weak var threeStateLabelButton: UIButton?

    /* ################################################################## */
    /**
     The three-state switch. If OFF, the `checkboxObject` will be in two-state mode. If ON, the `checkboxObject` will be in three-state mode.
     */
    @IBOutlet weak var stateSwitch: UISwitch?
    
    /* ################################################################## */
    /**
     The switch that controls the use of the OFF image for CLEAR, in default and custom modes.
     */
    @IBOutlet weak var useOffImageSwitch: UISwitch?
    
    /* ################################################################## */
    /**
     The label for the above switch.
     */
    @IBOutlet weak var useOffImageLabelButton: UIButton?

    /* ################################################################## */
    /**
     The switch that controls the use of haptics.
     */
    @IBOutlet weak var useHapticsSwitch: UISwitch?

    /* ################################################################## */
    /**
     The label for the above switch.
     */
    @IBOutlet weak var useHapticsSwitchLabelButton: UIButton?

    /* ################################################################## */
    /**
     This switch just toggles the enabled state of the checkbox.
     */
    @IBOutlet weak var enabledSwitch: UISwitch?
    
    /* ################################################################## */
    /**
     The label for the above switch.
     */
    @IBOutlet weak var enabledSwitchLabelButton: UIButton?
    
    /* ################################################################## */
    /**
     This switch controls whether or not the setXX() methods are animated.
    */
    @IBOutlet weak var animatedSwitch: UISwitch?

    /* ################################################################## */
    /**
     The label for the above switch.
     */
    @IBOutlet weak var animatedSwitchLabelButton: UIButton?

    /* ################################################################## */
    /**
     This switch is tied to the checkbox value.
     */
    @IBOutlet weak var valueChangedSegmentedSwitch: UISegmentedControl?

    /* ################################################################## */
    /**
     This switch selects the checkbox tinc color.
     */
    @IBOutlet weak var tintSelectorSegmentedSwitch: UISegmentedControl?

    /* ################################################################## */
    /**
     The label for the customized IB switches.
     */
    @IBOutlet weak var customHeaderLabel: UILabel?

    /* ################################################################## */
    /**
     The first custom checkbox
     */
    @IBOutlet weak var customCheckbox1: RVS_Checkbox?

    /* ################################################################## */
    /**
     The second custom checkbox
     */
    @IBOutlet weak var customCheckbox2: RVS_Checkbox?
    
    /* ################################################################## */
    /**
     The label for the dynamically-instantiated switches.
     */
    @IBOutlet weak var dynamicHeaderLabel: UILabel?
    
    /* ################################################################## */
    /**
     The label for the changeable image section.
     */
    @IBOutlet weak var imageHeaderLabel: UILabel?
    
    /* ################################################################## */
    /**
     */
    @IBOutlet weak var imageSelectorSegmentedSwitch: UISegmentedControl?
    
    /* ################################################################## */
    /**
     The image-display checkbox instance to be tested.
     */
    @IBOutlet weak var imageCheckboxInstance: RVS_Checkbox?
}

/* ###################################################################################################################################### */
// MARK: - IB Methods
/* ###################################################################################################################################### */
extension RVS_Checkbox_TestHarness_ViewController {
    /* ################################################################## */
    /**
     Called when the `stateSwitch`two-state  label button is hit. It just toggles the control, and also calls its handler.
     
     - parameter: Ignored
     */
    @IBAction func standardLabelButtonHit(_: Any) {
        guard let stateSwitch = self.stateSwitch else { return }
        stateSwitch.setOn(false, animated: true)
        self.stateSwitchChanged(stateSwitch)
   }
    
    /* ################################################################## */
    /**
     Called when the `stateSwitch`three-state  label button is hit. It just toggles the control, and also calls its handler.
     
     - parameter: Ignored
     */
    @IBAction func threeStateLabelButtonHit(_: Any) {
        guard let stateSwitch = self.stateSwitch else { return }
        stateSwitch.setOn(true, animated: true)
        self.stateSwitchChanged(stateSwitch)
    }

    /* ################################################################## */
    /**
     Called when the three-state switch changes value. The `checkboxObject.isThreeState` state is set, according to the switch value.
     */
    @IBAction func stateSwitchChanged(_ inSwitch: UISwitch) {
        self.imageCheckboxInstance?.isThreeState = inSwitch.isOn
        self.useOffImageSwitch?.setOn(!inSwitch.isOn, animated: true)
        self.useOffImageSwitch?.sendActions(for: .valueChanged)
        self.setSegmentedSwitch()
        self.setUpUI()
    }

    /* ################################################################## */
    /**
     Called when any switch changes.
     
     - parameter: The switch instance (ignored).
     */
    @IBAction func switchChanged(_: UISwitch) {
        self.setUpUI()
    }

    /* ################################################################## */
    /**
     Called when the `useOffImageSwitch` label button is hit. It just toggles the control, and also calls its handler.
     
      - parameter: Ignored
     */
    @IBAction func useOffImageLabelButtonHit(_: Any) {
        self.useOffImageSwitch?.setOn(!(self.useOffImageSwitch?.isOn ?? true), animated: true)
        self.useOffImageSwitch?.sendActions(for: .valueChanged)
    }
    
    /* ################################################################## */
    /**
     Called when the `useHapticsSwitch` label button is hit. It just toggles the control.
     
     - parameter: Ignored
     */
    @IBAction func useHapticsLabelButtonHit(_: Any) {
        self.useHapticsSwitch?.setOn(!(self.useHapticsSwitch?.isOn ?? true), animated: true)
        self.useHapticsSwitch?.sendActions(for: .valueChanged)
    }
    
    /* ################################################################## */
    /**
     Called when the `enabledSwitch` label button is hit. It just toggles the control.
     
     - parameter: Ignored
     */
    @IBAction func enabledSwitchLabelButtonHit(_: Any) {
        self.enabledSwitch?.setOn(!(self.enabledSwitch?.isOn ?? true), animated: true)
        self.enabledSwitch?.sendActions(for: .valueChanged)
    }

    /* ################################################################## */
    /**
     Called when the `animatedSwitch` label button is hit. It just toggles the control.
     
     - parameter: Ignored
     */
    @IBAction func animatedSwitchLabelButtonHit(_: Any) {
        self.animatedSwitch?.setOn(!(self.animatedSwitch?.isOn ?? true), animated: true)
        self.animatedSwitch?.sendActions(for: .valueChanged)
    }

    /* ################################################################## */
    /**
     Called when the user selects a new value in the segmented switch.
     This causes the control to change its value.
     Animation of the change is determined by the state of the `animatedSwitch` value.
     
     - parameter inSegmentedSwitch: The switch object
     */
    @IBAction func valueChangeSegmentedSwitchChanged(_ inSegmentedSwitch: UISegmentedControl) {
        let value = inSegmentedSwitch.selectedSegmentIndex - 1
        if let state = RVS_Checkbox.States(rawValue: value) {
            print("Setting a value of (\(state)), and it is \(self.animatedSwitch?.isOn ?? false ? "" : "not ")animated.")
            self.imageCheckboxInstance?.setState(state, animated: self.animatedSwitch?.isOn ?? false)
        } else {
            print("ERROR! Value (\(value)) is out of range.")
        }
    }

    /* ################################################################## */
    /**
     Called when the tint is changed.
     
     - parameter: Ignored
     */
    @IBAction func tintSelectorSegmentedSwitchChanged(_: Any) {
        self.setUpUI()
    }

    /* ################################################################## */
    /**
     Called when teh selected style is changed.
     - parameter: Ignored
     */
    @IBAction func imageSelectorSegmentedSwitchChanged(_: Any) {
        self.setUpUI()
    }
}

/* ###################################################################################################################################### */
// MARK: - Action Callback - Changes the Value Switch
/* ###################################################################################################################################### */
extension RVS_Checkbox_TestHarness_ViewController {
    /* ################################################################## */
    /**
     Called when the checkbox changes value.
     - parameter inCheckboxObject: The checkbox object making the call.
     */
    @IBAction func valueChanged(_ inCheckboxObject: RVS_Checkbox) {
        print("I got called for a valueChanged, by \(String(describing: inCheckboxObject))")
        let value = inCheckboxObject.value
        self.valueChangedSegmentedSwitch?.selectedSegmentIndex = value + 1
    }
}

/* ###################################################################################################################################### */
// MARK: - Action Callbacks - Displays in the Console
/* ###################################################################################################################################### */
extension RVS_Checkbox_TestHarness_ViewController {
    /* ################################################################## */
    /**
     Called for touch down events.
     
     - parameter inCheckboxObject: The checkbox object.
     */
    @IBAction func touchDown(_ inCheckboxObject: RVS_Checkbox) {
        print("I got called for a touchDown, by \(String(describing: inCheckboxObject))")
    }

    /* ################################################################## */
    /**
     Called for touch up (inside) events.
     
     - parameter inCheckboxObject: The checkbox object.
     */
    @IBAction func touchUpInside(_ inCheckboxObject: RVS_Checkbox) {
        print("I got called for a touchUpInside, by \(String(describing: inCheckboxObject))")
    }

    /* ################################################################## */
    /**
     Called for touch up (outside) events.
     
     - parameter inCheckboxObject: The checkbox object.
     */
    @IBAction func touchUpOutside(_ inCheckboxObject: RVS_Checkbox) {
        print("I got called for a touchUpOutside, by \(String(describing: inCheckboxObject))")
    }

    /* ################################################################## */
    /**
     Called for primary action events.
     
     - parameter inCheckboxObject: The checkbox object.
     */
    @IBAction func primaryActionTriggered(_ inCheckboxObject: RVS_Checkbox) {
        print("I got called for a primaryActionTriggered, by \(String(describing: inCheckboxObject))")
    }
}

/* ###################################################################################################################################### */
// MARK: - Base Class Overrides
/* ###################################################################################################################################### */
extension RVS_Checkbox_TestHarness_ViewController {
    /* ################################################################## */
    /**
     Called after the view hierarchy is loaded.
     
     We use this to set up the screen.
     */
    override func viewDidLoad() {
        /* ############################################################## */
        /**
         A simple recursive function for coercing image views to always display aspectFit.
         
         - paremeter inView: The view we are coercing. It will also recursively descend into its subviews.
         */
        func _imageAspectCoerce(_ inView: UIView?) {
            inView?.subviews.forEach { inView in
                _imageAspectCoerce(inView)
            }
            // We filter for just image views, so we don't pooch anything else.
            if let imageView = inView as? UIImageView {
                imageView.contentMode = .scaleAspectFit
            }
        }
        
        super.viewDidLoad()
        
        // Localizations
        self.standardLabelButton?.setTitle((self.standardLabelButton?.title(for: .normal) ?? "ERROR").localizedVariant, for: .normal)
        self.threeStateLabelButton?.setTitle((self.threeStateLabelButton?.title(for: .normal) ?? "ERROR").localizedVariant, for: .normal)
        self.useOffImageLabelButton?.setTitle((self.useOffImageLabelButton?.title(for: .normal) ?? "ERROR").localizedVariant, for: .normal)
        self.animatedSwitchLabelButton?.setTitle((self.animatedSwitchLabelButton?.title(for: .normal) ?? "ERROR").localizedVariant, for: .normal)
        self.enabledSwitchLabelButton?.setTitle((self.enabledSwitchLabelButton?.title(for: .normal) ?? "ERROR").localizedVariant, for: .normal)
        self.useHapticsSwitchLabelButton?.setTitle((self.useHapticsSwitchLabelButton?.title(for: .normal) ?? "ERROR").localizedVariant, for: .normal)
        self.customHeaderLabel?.text = (self.customHeaderLabel?.text ?? "ERROR").localizedVariant
        self.dynamicHeaderLabel?.text = (self.dynamicHeaderLabel?.text ?? "ERROR").localizedVariant
        self.imageHeaderLabel?.text = (self.imageHeaderLabel?.text ?? "ERROR").localizedVariant

        _imageAspectCoerce(self.imageSelectorSegmentedSwitch)

        // Set up the colors for the value segmented switch, and localize.
        if let valueChangedSegmentedSwitch = self.valueChangedSegmentedSwitch {
            valueChangedSegmentedSwitch.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
            valueChangedSegmentedSwitch.setTitleTextAttributes([.foregroundColor: UIColor.label], for: .normal)
            valueChangedSegmentedSwitch.setTitleTextAttributes([.foregroundColor: UIColor.label.withAlphaComponent(0.25)], for: .disabled)
            for index in 0..<valueChangedSegmentedSwitch.numberOfSegments {
                valueChangedSegmentedSwitch.setTitle((valueChangedSegmentedSwitch.titleForSegment(at: index) ?? "ERROR").localizedVariant, forSegmentAt: index)
            }
        }
        
        // Set up the little tint squares for the tint selector control.
        if let tintSelectorSegmentedSwitch = self.tintSelectorSegmentedSwitch {
            if let color = UIColor(named: "AccentColor"),
               let image = UIImage(systemName: "square.fill")?.withTintColor(color) {
                tintSelectorSegmentedSwitch.setImage(image.withRenderingMode(.alwaysOriginal), forSegmentAt: 0)
            }
            if let image = UIImage(systemName: "square.fill")?.withTintColor(.label) {
                tintSelectorSegmentedSwitch.setImage(image.withRenderingMode(.alwaysOriginal), forSegmentAt: 1)
            }
            for index in 2..<tintSelectorSegmentedSwitch.numberOfSegments {
                if let color = UIColor(named: "Tint-\(index)"),
                   let image = UIImage(systemName: "square.fill")?.withTintColor(color) {
                    tintSelectorSegmentedSwitch.setImage(image.withRenderingMode(.alwaysOriginal), forSegmentAt: index)
                }
            }
            
            // Select red, so it stands out.
            tintSelectorSegmentedSwitch.selectedSegmentIndex = tintSelectorSegmentedSwitch.numberOfSegments - 2
        }
        
        self.imageCheckboxInstance?.isEnabled = true
        self.customCheckbox1?.isEnabled = true
        self.customCheckbox2?.isEnabled = true
        
        self.setSegmentedSwitch()
        self.setUpDynamicCheckBoxes()
        self.setUpUI()
    }
}

/* ###################################################################################################################################### */
// MARK: - Instance Methods
/* ###################################################################################################################################### */
extension RVS_Checkbox_TestHarness_ViewController {
    /* ################################################################## */
    /**
     This sets up the three checkboxes along the bottom of the screen.
     
     We set up a center box, using SF Symbols, then add one to its left, using the default, and one to its right, using some custom images.

     We use programmatic Auto-Layout for this.
     */
    func setUpDynamicCheckBoxes() {
        if let dynamicContainer = self.dynamicContainer {    // Make sure we have the container.
            let testImageFormat = "TestImage-%d"

            let leftDynamicCheckbox = RVS_Checkbox()  // Create the instance
            dynamicContainer.addArrangedSubview(leftDynamicCheckbox)  // Add it to the container.
            leftDynamicCheckbox.tintColor = imageCheckboxInstance?.tintColor // We steal the tint color from the IB-instantiated checkbox.
            leftDynamicCheckbox.isUsingSFSymbols = true
            
            self.leftDynamicCheckbox = leftDynamicCheckbox

            let centerDynamicCheckbox = RVS_Checkbox()
            dynamicContainer.addArrangedSubview(centerDynamicCheckbox)
            centerDynamicCheckbox.tintColor = imageCheckboxInstance?.tintColor
            centerDynamicCheckbox.offImage = UIImage(named: "SLUG-OFF".localizedVariant)
            centerDynamicCheckbox.clearImage = UIImage(named: "SLUG-CLEAR".localizedVariant)
            centerDynamicCheckbox.onImage = UIImage(named: "SLUG-ON".localizedVariant)
            
            self.centerDynamicCheckbox = centerDynamicCheckbox

            let rightDynamicCheckbox = RVS_Checkbox()
            dynamicContainer.addArrangedSubview(rightDynamicCheckbox)
            rightDynamicCheckbox.tintColor = imageCheckboxInstance?.tintColor
            rightDynamicCheckbox.offImage = UIImage(named: String(format: testImageFormat, 0))
            rightDynamicCheckbox.clearImage = UIImage(named: String(format: testImageFormat, 1))
            rightDynamicCheckbox.onImage = UIImage(named: String(format: testImageFormat, 2))
            
            self.rightDynamicCheckbox = rightDynamicCheckbox
        }
    }
    
    /* ################################################################## */
    /**
     This sets up the screen to reflect the current settings.
     */
    func setUpUI() {
        standardLabelButton?.isEnabled = stateSwitch?.isOn ?? false
        threeStateLabelButton?.isEnabled = !(stateSwitch?.isOn ?? false)
        
        if stateSwitch?.isOn ?? false {
            valueChangedSegmentedSwitch?.setEnabled(true, forSegmentAt: RVS_Checkbox.States.clear.rawValue + 1)
        } else {
            if valueChangedSegmentedSwitch?.selectedSegmentIndex == RVS_Checkbox.States.clear.rawValue + 1 {
                valueChangedSegmentedSwitch?.selectedSegmentIndex = RVS_Checkbox.States.off.rawValue + 1
            }
            valueChangedSegmentedSwitch?.setEnabled(false, forSegmentAt: RVS_Checkbox.States.clear.rawValue + 1)
        }
        
        setSelectedImage()

        if let index = self.tintSelectorSegmentedSwitch?.selectedSegmentIndex,
           let color = 0 == index ? UIColor(named: "AccentColor") : 1 == index ? .label : UIColor(named: "Tint-\(index)") {
            self.imageCheckboxInstance?.tintColor = color
            self.customCheckbox1?.tintColor = color
            self.customCheckbox2?.tintColor = color
            self.leftDynamicCheckbox?.tintColor = color
            self.centerDynamicCheckbox?.tintColor = color
            self.rightDynamicCheckbox?.tintColor = color
        }
        
        self.imageCheckboxInstance?.useOffImageForClear = self.useOffImageSwitch?.isOn ?? false
        self.customCheckbox1?.useOffImageForClear = self.useOffImageSwitch?.isOn ?? false
        self.customCheckbox2?.useOffImageForClear = self.useOffImageSwitch?.isOn ?? false
        self.leftDynamicCheckbox?.useOffImageForClear = self.useOffImageSwitch?.isOn ?? false
        self.centerDynamicCheckbox?.useOffImageForClear = self.useOffImageSwitch?.isOn ?? false
        self.rightDynamicCheckbox?.useOffImageForClear = self.useOffImageSwitch?.isOn ?? false
        
        self.imageCheckboxInstance?.isThreeState = self.stateSwitch?.isOn ?? false
        self.customCheckbox1?.isThreeState = self.stateSwitch?.isOn ?? false
        self.customCheckbox2?.isThreeState = self.stateSwitch?.isOn ?? false
        self.leftDynamicCheckbox?.isThreeState = self.stateSwitch?.isOn ?? false
        self.centerDynamicCheckbox?.isThreeState = self.stateSwitch?.isOn ?? false
        self.rightDynamicCheckbox?.isThreeState = self.stateSwitch?.isOn ?? false
        
        self.imageCheckboxInstance?.isEnabled = self.enabledSwitch?.isOn ?? false
        self.customCheckbox1?.isEnabled = self.enabledSwitch?.isOn ?? false
        self.customCheckbox2?.isEnabled = self.enabledSwitch?.isOn ?? false
        self.leftDynamicCheckbox?.isEnabled = self.enabledSwitch?.isOn ?? false
        self.centerDynamicCheckbox?.isEnabled = self.enabledSwitch?.isOn ?? false
        self.rightDynamicCheckbox?.isEnabled = self.enabledSwitch?.isOn ?? false
        
        self.imageCheckboxInstance?.useHaptics = self.useHapticsSwitch?.isOn ?? false
        self.customCheckbox1?.useHaptics = self.useHapticsSwitch?.isOn ?? false
        self.customCheckbox2?.useHaptics = self.useHapticsSwitch?.isOn ?? false
        self.leftDynamicCheckbox?.useHaptics = self.useHapticsSwitch?.isOn ?? false
        self.centerDynamicCheckbox?.useHaptics = self.useHapticsSwitch?.isOn ?? false
        self.rightDynamicCheckbox?.useHaptics = self.useHapticsSwitch?.isOn ?? false
    }
    
    /* ################################################################## */
    /**
     This checks the `imageSelectorSegmentedSwitch`, and sets the appropriate type of
     control, based on its value.
     */
    func setSelectedImage() {
        if let imageIndex = self.imageSelectorSegmentedSwitch?.selectedSegmentIndex {
            var offImage: UIImage?
            var clearImage: UIImage?
            var onImage: UIImage?

            switch imageIndex {
            case 0:
                self.imageCheckboxInstance?.isUsingSFSymbols = true
            case 1:
                onImage = UIImage(named: "SLUG-ON".localizedVariant)
                clearImage = UIImage(named: "SLUG-CLEAR".localizedVariant)
                offImage = UIImage(named: "SLUG-OFF".localizedVariant)
            default:
                onImage = UIImage(named: "TestImage-2")
                clearImage = UIImage(named: "TestImage-1")
                offImage = UIImage(named: "TestImage-0")
            }
            
            self.imageCheckboxInstance?.offImage = offImage
            self.imageCheckboxInstance?.clearImage = clearImage
            self.imageCheckboxInstance?.onImage = onImage
            
            self.useOffImageSwitch?.isEnabled = self.imageCheckboxInstance?.isThreeState ?? false
            self.useOffImageLabelButton?.isEnabled = self.imageCheckboxInstance?.isThreeState ?? false
        }
    }

    /* ################################################################## */
    /**
     This simply sets the value of the `valueChangedSegmentedSwitch`, based on the control value.
     */
    func setSegmentedSwitch() {
        self.valueChangedSegmentedSwitch?.selectedSegmentIndex = (self.imageCheckboxInstance?.value ?? 1) + 1
    }
}
