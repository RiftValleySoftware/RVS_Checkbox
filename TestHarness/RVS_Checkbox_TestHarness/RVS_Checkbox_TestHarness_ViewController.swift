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
    @IBOutlet weak var dynamicContainer: UIView!
    
    /* ################################################################## */
    /**
     The main checkbox instance to be tested.
     */
    @IBOutlet weak var checkboxObject: RVS_Checkbox!
    
    /* ################################################################## */
    /**
     This is the label button for the two-state side of the`stateSwitch`. It is disabled, when the switch is in two-state mode.
     */
    @IBOutlet weak var standardLabelButton: UIButton!

    /* ################################################################## */
    /**
     This is the label button for the three-state side of the `stateSwitch`. It is disabled, when the switch is in three-state mode.
    */
    @IBOutlet weak var threeStateLabelButton: UIButton!

    /* ################################################################## */
    /**
     The three-state switch. If OFF, the `checkboxObject` will be in two-state mode. If ON, the `checkboxObject` will be in three-state mode.
     */
    @IBOutlet weak var stateSwitch: UISwitch!
    
    /* ################################################################## */
    /**
     The switch that controls the use of the OFF image for CLEAR, in default and custom modes.
     */
    @IBOutlet weak var useOffImageSwitch: UISwitch!
    
    /* ################################################################## */
    /**
     The label for the above switch.
     */
    @IBOutlet weak var useOffImageLabelButton: UIButton!

    /* ################################################################## */
    /**
     The switch that controls the use of haptics.
     */
    @IBOutlet weak var useHapticsSwitch: UISwitch!

    /* ################################################################## */
    /**
     The label for the above switch.
     */
    @IBOutlet weak var useHapticsSwitchLabelButton: UIButton!

    /* ################################################################## */
    /**
     This switch just toggles the enabled state of the checkbox.
     */
    @IBOutlet weak var enabledSwitch: UISwitch!
    
    /* ################################################################## */
    /**
     The label for the above switch.
     */
    @IBOutlet weak var enabledSwitchLabelButton: UIButton!
    
    /* ################################################################## */
    /**
     This switch controls whether or not the setXX() methods are animated.
    */
    @IBOutlet weak var animatedSwitch: UISwitch!

    /* ################################################################## */
    /**
     The label for the above switch.
     */
    @IBOutlet weak var animatedSwitchLabelButton: UIButton!

    /* ################################################################## */
    /**
     This switch is tied to the checkbox value.
     */
    @IBOutlet weak var valueChangedSegmentedSwitch: UISegmentedControl!

    /* ################################################################## */
    /**
     This switch selects the checkbox tinc color.
     */
    @IBOutlet weak var tintSelectorSegmentedSwitch: UISegmentedControl!
    
    /* ################################################################## */
    /**
     */
    @IBOutlet weak var imageSelectorSegmentedSwitch: UISegmentedControl!

    /* ################################################################## */
    /**
     The label for the customized IB switches.
     */
    @IBOutlet weak var customHeaderLabel: UILabel!
    
    /* ################################################################## */
    /**
     The first custom checkbox
     */
    @IBOutlet weak var customCheckbox1: RVS_Checkbox!

    /* ################################################################## */
    /**
     The second custom checkbox
     */
    @IBOutlet weak var customCheckbox2: RVS_Checkbox!
    
    /* ################################################################## */
    /**
     The label for the dynamically-instantiated switches.
     */
    @IBOutlet weak var dynamicHeaderLabel: UILabel!
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
        stateSwitch.setOn(false, animated: true)
        stateSwitchChanged(stateSwitch)
   }
    
    /* ################################################################## */
    /**
     Called when the `stateSwitch`three-state  label button is hit. It just toggles the control, and also calls its handler.
     
     - parameter: Ignored
     */
    @IBAction func threeStateLabelButtonHit(_: Any) {
        stateSwitch.setOn(true, animated: true)
        stateSwitchChanged(stateSwitch)
    }

    /* ################################################################## */
    /**
     Called when the three-state switch changes value. The `checkboxObject.isThreeState` state is set, according to the switch value.
     */
    @IBAction func stateSwitchChanged(_ inSwitch: UISwitch) {
        checkboxObject?.isThreeState = inSwitch.isOn
        setSegmentedSwitch()
        setUpUI()
    }
    
    /* ################################################################## */
    /**
     Called when the `useOffImageSwitch` label button is hit. It just toggles the control, and also calls its handler.
     
      - parameter: Ignored
     */
    @IBAction func useOffImageLabelButtonHit(_: Any) {
        useOffImageSwitch.setOn(!(useOffImageSwitch?.isOn ?? true), animated: true)
        useOffImageSwitchChanged(useOffImageSwitch)
   }

    /* ################################################################## */
    /**
     Called when the switch, controlling the use of the OFF image as the CLEAR image is requested.
     
     - parameter inSwitch: The switch instance.
     */
    @IBAction func useOffImageSwitchChanged(_ inSwitch: UISwitch) {
        checkboxObject?.useOffImageForClear = inSwitch.isOn
        setUpUI()
    }

    /* ################################################################## */
    /**
     Called when the switch, controlling the use of haptics is requested.
     
     - parameter inSwitch: The switch instance.
     */
    @IBAction func useHapticsSwitchChanged(_ inSwitch: UISwitch) {
        checkboxObject?.useHaptics = inSwitch.isOn
    }
    
    /* ################################################################## */
    /**
     Called when the `useHapticsSwitch` label button is hit. It just toggles the control.
     
     - parameter: Ignored
     */
    @IBAction func useHapticsLabelButtonHit(_: Any) {
        useHapticsSwitch.setOn(!(useHapticsSwitch?.isOn ?? true), animated: true)
        useHapticsSwitchChanged(useHapticsSwitch)
    }

    /* ################################################################## */
    /**
     Called when the switch, controlling the enabled state of the control is changed.
     
     - parameter inSwitch: The switch instance.
     */
    @IBAction func enabledSwitchChanged(_ inSwitch: UISwitch) {
        checkboxObject?.isEnabled = inSwitch.isOn
        setUpUI()
    }
    
    /* ################################################################## */
    /**
     Called when the `enabledSwitch` label button is hit. It just toggles the control.
     
     - parameter: Ignored
     */
    @IBAction func enabledSwitchLabelButtonHit(_: Any) {
        enabledSwitch.setOn(!(enabledSwitch?.isOn ?? true), animated: true)
        enabledSwitchChanged(enabledSwitch)
    }

    /* ################################################################## */
    /**
     Called when the `animatedSwitch` label button is hit. It just toggles the control.
     
     - parameter: Ignored
     */
    @IBAction func animatedSwitchLabelButtonHit(_: Any) {
        animatedSwitch.setOn(!(animatedSwitch?.isOn ?? true), animated: true)
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
            print("Setting a value of (\(state)), and it is \(animatedSwitch?.isOn ?? false ? "" : "not ")animated.")
            checkboxObject.setState(state, animated: animatedSwitch?.isOn ?? false)
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
        setUpUI()
    }

    /* ################################################################## */
    /**
     Called when teh selected style is changed.
     - parameter: Ignored
     */
    @IBAction func imageSelectorSegmentedSwitchChanged(_: Any) {
        setUpUI()
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
        valueChangedSegmentedSwitch?.selectedSegmentIndex = value + 1
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
        super.viewDidLoad()
        
        // Localizations
        standardLabelButton?.setTitle((standardLabelButton?.title(for: .normal) ?? "ERROR").localizedVariant, for: .normal)
        threeStateLabelButton?.setTitle((threeStateLabelButton?.title(for: .normal) ?? "ERROR").localizedVariant, for: .normal)
        useOffImageLabelButton?.setTitle((useOffImageLabelButton?.title(for: .normal) ?? "ERROR").localizedVariant, for: .normal)
        animatedSwitchLabelButton?.setTitle((animatedSwitchLabelButton?.title(for: .normal) ?? "ERROR").localizedVariant, for: .normal)
        enabledSwitchLabelButton?.setTitle((enabledSwitchLabelButton?.title(for: .normal) ?? "ERROR").localizedVariant, for: .normal)
        useHapticsSwitchLabelButton?.setTitle((useHapticsSwitchLabelButton?.title(for: .normal) ?? "ERROR").localizedVariant, for: .normal)
        customHeaderLabel?.text = (customHeaderLabel?.text ?? "ERROR").localizedVariant
        dynamicHeaderLabel?.text = (dynamicHeaderLabel?.text ?? "ERROR").localizedVariant

        // Set up the colors for the value segmented switch, and localize.
        if let valueChangedSegmentedSwitch = valueChangedSegmentedSwitch {
            valueChangedSegmentedSwitch.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
            valueChangedSegmentedSwitch.setTitleTextAttributes([.foregroundColor: UIColor.label], for: .normal)
            valueChangedSegmentedSwitch.setTitleTextAttributes([.foregroundColor: UIColor.label.withAlphaComponent(0.25)], for: .disabled)
            valueChangedSegmentedSwitch.setEnabled(checkboxObject?.isThreeState ?? false, forSegmentAt: RVS_Checkbox.States.off.rawValue + 1)
            for index in 0..<valueChangedSegmentedSwitch.numberOfSegments {
                valueChangedSegmentedSwitch.setTitle((valueChangedSegmentedSwitch.titleForSegment(at: index) ?? "ERROR").localizedVariant, forSegmentAt: index)
            }
        }
        
        // Set up the little tint squares for the tint selector control.
        if let tintSelectorSegmentedSwitch = tintSelectorSegmentedSwitch {
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
        
        checkboxObject?.isEnabled = true
        customCheckbox1?.isEnabled = true
        customCheckbox2?.isEnabled = true
        
        setUpUI()
        setSegmentedSwitch()
        setUpDynamicCheckBoxes()
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
        if let dynamicContainer = dynamicContainer {    // Make sure we have the container.
            let gap: CGFloat = 8
            let dynamicControlSize: CGFloat = 64
            let testImageFormat = "TestImage-%d"

            let leftDynamicCheckbox = RVS_Checkbox()  // Create the instance
            dynamicContainer.addSubview(leftDynamicCheckbox)  // Add it to the container.
            leftDynamicCheckbox.backgroundColor = .clear      // Nothing behind us (Just to be sure).
            leftDynamicCheckbox.tintColor = checkboxObject?.tintColor // We steal the tint color from the IB-instantiated checkbox.
            leftDynamicCheckbox.isUsingSFSymbols = true
            leftDynamicCheckbox.isThreeState = true
            leftDynamicCheckbox.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                leftDynamicCheckbox.rightAnchor.constraint(equalTo: dynamicContainer.centerXAnchor, constant: -(gap / 2)),
                leftDynamicCheckbox.widthAnchor.constraint(equalToConstant: dynamicControlSize),
                leftDynamicCheckbox.heightAnchor.constraint(equalToConstant: dynamicControlSize),
                leftDynamicCheckbox.topAnchor.constraint(equalTo: dynamicContainer.topAnchor),
                leftDynamicCheckbox.bottomAnchor.constraint(equalTo: dynamicContainer.bottomAnchor)
            ])
            
            self.leftDynamicCheckbox = leftDynamicCheckbox
            
            let rightDynamicCheckbox = RVS_Checkbox()
            dynamicContainer.addSubview(rightDynamicCheckbox)
            rightDynamicCheckbox.backgroundColor = .clear
            rightDynamicCheckbox.tintColor = checkboxObject?.tintColor
            rightDynamicCheckbox.offImage = UIImage(named: String(format: testImageFormat, 0))
            rightDynamicCheckbox.clearImage = UIImage(named: String(format: testImageFormat, 1))
            rightDynamicCheckbox.onImage = UIImage(named: String(format: testImageFormat, 2))
            rightDynamicCheckbox.isThreeState = true
            rightDynamicCheckbox.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                rightDynamicCheckbox.leftAnchor.constraint(equalTo: dynamicContainer.centerXAnchor, constant: (gap / 2)),
                rightDynamicCheckbox.widthAnchor.constraint(equalToConstant: dynamicControlSize),
                rightDynamicCheckbox.heightAnchor.constraint(equalToConstant: dynamicControlSize),
                rightDynamicCheckbox.topAnchor.constraint(equalTo: dynamicContainer.topAnchor),
                rightDynamicCheckbox.bottomAnchor.constraint(equalTo: dynamicContainer.bottomAnchor)
            ])
            
            self.rightDynamicCheckbox = rightDynamicCheckbox
        }
    }
    
    /* ################################################################## */
    /**
     This sets up a few of the displayed controls and whatnot.
     */
    func setUpUI() {
        enabledSwitch?.isOn = checkboxObject?.isEnabled ?? false
        useOffImageSwitch?.isOn = checkboxObject?.useOffImageForClear ?? false

        standardLabelButton?.isEnabled = stateSwitch?.isOn ?? false
        threeStateLabelButton?.isEnabled = !(stateSwitch?.isOn ?? false)
        
        valueChangedSegmentedSwitch?.setEnabled(stateSwitch?.isOn ?? false, forSegmentAt: RVS_Checkbox.States.off.rawValue + 1)
        
        setSelectedImage()
        
        if let index = self.tintSelectorSegmentedSwitch?.selectedSegmentIndex,
           let color = 0 == index ? UIColor(named: "AccentColor") : 1 == index ? .label : UIColor(named: "Tint-\(index)") {
            self.checkboxObject?.tintColor = color
            self.leftDynamicCheckbox?.tintColor = color
            self.rightDynamicCheckbox?.tintColor = color
            self.customCheckbox1?.tintColor = color
            self.customCheckbox2?.tintColor = color
        }
        
        self.checkboxObject?.useOffImageForClear = useOffImageSwitch?.isOn ?? false
        self.leftDynamicCheckbox?.useOffImageForClear = useOffImageSwitch?.isOn ?? false
        self.rightDynamicCheckbox?.useOffImageForClear = useOffImageSwitch?.isOn ?? false
        self.customCheckbox1?.useOffImageForClear = useOffImageSwitch?.isOn ?? false
        self.customCheckbox2?.useOffImageForClear = useOffImageSwitch?.isOn ?? false
        
        self.checkboxObject?.isThreeState = stateSwitch?.isOn ?? false
        self.leftDynamicCheckbox?.isThreeState = stateSwitch?.isOn ?? false
        self.rightDynamicCheckbox?.isThreeState = stateSwitch?.isOn ?? false
        self.customCheckbox1?.isThreeState = stateSwitch?.isOn ?? false
        self.customCheckbox2?.isThreeState = stateSwitch?.isOn ?? false
        
        self.checkboxObject?.isEnabled = enabledSwitch?.isOn ?? false
        self.leftDynamicCheckbox?.isEnabled = enabledSwitch?.isOn ?? false
        self.rightDynamicCheckbox?.isEnabled = enabledSwitch?.isOn ?? false
        self.customCheckbox1?.isEnabled = enabledSwitch?.isOn ?? false
        self.customCheckbox2?.isEnabled = enabledSwitch?.isOn ?? false
    }
    
    /* ################################################################## */
    /**
     This checks the `imageSelectorSegmentedSwitch`, and sets the appropriate type of
     control, based on its value.
     */
    func setSelectedImage() {
        if let imageIndex = imageSelectorSegmentedSwitch?.selectedSegmentIndex {
            var offImage: UIImage?
            var clearImage: UIImage?
            var onImage: UIImage?

            switch imageIndex {
            case 0:
                checkboxObject?.isUsingSFSymbols = true
            default:
                checkboxObject?.isUsingSFSymbols = false
                onImage = UIImage(named: "TestImage-2")
                clearImage = UIImage(named: "TestImage-1")
                offImage = UIImage(named: "TestImage-0")
            }
            
            checkboxObject?.offImage = offImage
            checkboxObject?.clearImage = clearImage
            checkboxObject?.onImage = onImage
            
            useOffImageSwitch?.isEnabled = checkboxObject?.isThreeState ?? false
            useOffImageLabelButton?.isEnabled = checkboxObject?.isThreeState ?? false
        }
    }

    /* ################################################################## */
    /**
     This simply sets the value of the `valueChangedSegmentedSwitch`, based on the control value.
     */
    func setSegmentedSwitch() {
        self.valueChangedSegmentedSwitch?.selectedSegmentIndex = (self.checkboxObject?.value ?? 1) + 1
    }
}
