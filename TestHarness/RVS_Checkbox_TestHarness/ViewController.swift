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
 */
class ViewController: UIViewController {
    /* ################################################################## */
    /**
     */
    @IBOutlet weak var checkboxObject: RVS_Checkbox!
    
    /* ################################################################## */
    /**
     */
    @IBOutlet weak var standardLabelButton: UIButton!

    /* ################################################################## */
    /**
     */
    @IBOutlet weak var threeStateLabelButton: UIButton!

    /* ################################################################## */
    /**
     */
    @IBOutlet weak var stateSwitch: UISwitch!
    
    /* ################################################################## */
    /**
     */
    @IBOutlet weak var useOffImageSwitch: UISwitch!
    
    /* ################################################################## */
    /**
     */
    @IBOutlet weak var useOffImageLabelButton: UIButton!

    /* ################################################################## */
    /**
     */
    @IBOutlet weak var animatedSwitch: UISwitch!

    /* ################################################################## */
    /**
     */
    @IBOutlet weak var animatedSwitchLabelButton: UIButton!

    /* ################################################################## */
    /**
     */
    @IBOutlet weak var valueChangedSegmentedSwitch: UISegmentedControl!

    /* ################################################################## */
    /**
     */
    @IBOutlet weak var tintSelectorSegmentedSwitch: UISegmentedControl!
    
    /* ################################################################## */
    /**
     */
    @IBOutlet weak var imageSelectorSegmentedSwitch: UISegmentedControl!

    /* ################################################################## */
    /**
     */
    @IBAction func standardLabelButtonHit(_: Any) {
        stateSwitch.setOn(false, animated: true)
        stateSwitchChanged(stateSwitch)
   }
    
    /* ################################################################## */
    /**
     */
    @IBAction func threeStateLabelButtonHit(_: Any) {
        stateSwitch.setOn(true, animated: true)
        stateSwitchChanged(stateSwitch)
    }

    /* ################################################################## */
    /**
     */
    @IBAction func stateSwitchChanged(_ inSwitch: UISwitch) {
        checkboxObject?.isThreeState = inSwitch.isOn
        standardLabelButton?.isEnabled = inSwitch.isOn
        threeStateLabelButton?.isEnabled = !inSwitch.isOn
        useOffImageSwitch?.isEnabled = !inSwitch.isOn
        useOffImageLabelButton?.isEnabled = !inSwitch.isOn
        valueChangedSegmentedSwitch?.setEnabled(inSwitch.isOn, forSegmentAt: RVS_Checkbox.States.off.rawValue + 1)
        setSegmentedSwitch()
    }

    /* ################################################################## */
    /**
     */
    @IBAction func animatedSwitchChanged(_ inSwitch: UISwitch) {
    }

    /* ################################################################## */
    /**
     */
    @IBAction func animatedSwitchLabelButtonHit(_: Any) {
        animatedSwitch.setOn(!(animatedSwitch?.isOn ?? true), animated: true)
    }

    /* ################################################################## */
    /**
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
     */
    @IBAction func useOffImageLabelButtonHit(_: Any) {
        useOffImageSwitch.setOn(!useOffImageSwitch.isOn, animated: true)
        useOffImageSwitchChanged(useOffImageSwitch)
   }

    /* ################################################################## */
    /**
     */
    @IBAction func useOffImageSwitchChanged(_ inSwitch: UISwitch) {
        checkboxObject?.useOffImageForClear = inSwitch.isOn
    }

    /* ################################################################## */
    /**
     */
    @IBAction func tintSelectorSegmentedSwitchChanged(_ sender: UISegmentedControl) {
        setSelectedTint()
    }

    /* ################################################################## */
    /**
     */
    @IBAction func imageSelectorSegmentedSwitchChanged(_ sender: UISegmentedControl) {
        setSelectedImage()
    }

    /* ################################################################## */
    /**
     */
    @IBAction func touchDown(_ inCheckboxObject: RVS_Checkbox) {
        print("I got called for a touchDown, by \(String(describing: inCheckboxObject))")
    }

    /* ################################################################## */
    /**
     */
    @IBAction func touchUpInside(_ inCheckboxObject: RVS_Checkbox) {
        print("I got called for a touchUpInside, by \(String(describing: inCheckboxObject))")
    }

    /* ################################################################## */
    /**
     */
    @IBAction func touchUpOutside(_ inCheckboxObject: RVS_Checkbox) {
        print("I got called for a touchUpOutside, by \(String(describing: inCheckboxObject))")
    }

    /* ################################################################## */
    /**
     */
    @IBAction func valueChanged(_ inCheckboxObject: RVS_Checkbox) {
        print("I got called for a valueChanged, by \(String(describing: inCheckboxObject))")
        let value = inCheckboxObject.value
        valueChangedSegmentedSwitch?.selectedSegmentIndex = value + 1
    }

    /* ################################################################## */
    /**
     */
    @IBAction func primaryActionTriggered(_ inCheckboxObject: RVS_Checkbox) {
        print("I got called for a primaryActionTriggered, by \(String(describing: inCheckboxObject))")
    }
    
    /* ################################################################## */
    /**
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        standardLabelButton?.setTitle((standardLabelButton?.title(for: .normal) ?? "ERROR").localizedVariant, for: .normal)
        threeStateLabelButton?.setTitle((threeStateLabelButton?.title(for: .normal) ?? "ERROR").localizedVariant, for: .normal)
        useOffImageLabelButton?.setTitle((useOffImageLabelButton?.title(for: .normal) ?? "ERROR").localizedVariant, for: .normal)
        animatedSwitchLabelButton?.setTitle((animatedSwitchLabelButton?.title(for: .normal) ?? "ERROR").localizedVariant, for: .normal)
        if let valueChangedSegmentedSwitch = valueChangedSegmentedSwitch {
            valueChangedSegmentedSwitch.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
            valueChangedSegmentedSwitch.setTitleTextAttributes([.foregroundColor: UIColor.label], for: .normal)
            valueChangedSegmentedSwitch.setTitleTextAttributes([.foregroundColor: UIColor.label.withAlphaComponent(0.25)], for: .disabled)
            valueChangedSegmentedSwitch.setEnabled(checkboxObject?.isThreeState ?? false, forSegmentAt: RVS_Checkbox.States.off.rawValue + 1)
            for index in 0..<valueChangedSegmentedSwitch.numberOfSegments {
                valueChangedSegmentedSwitch.setTitle((valueChangedSegmentedSwitch.titleForSegment(at: index) ?? "ERROR").localizedVariant, forSegmentAt: index)
            }
        }
        
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
        }

        if let imageSelectorSegmentedSwitch = imageSelectorSegmentedSwitch {
            imageSelectorSegmentedSwitch.selectedSegmentIndex = checkboxObject?.isUsingSFSymbols ?? false ? 1 : 0
        }
        
        setSegmentedSwitch()
        setSelectedTint()
        setSelectedImage()
    }
    
    /* ################################################################## */
    /**
     */
    func setSelectedImage() {
        if let imageIndex = imageSelectorSegmentedSwitch?.selectedSegmentIndex {
            var offImage: UIImage?
            var clearImage: UIImage?
            var onImage: UIImage?

            switch imageIndex {
                case 1:
                    checkboxObject?.isUsingSFSymbols = true
                case 2:
                    onImage = UIImage(named: "TestImage-2")
                    clearImage = UIImage(named: "TestImage-1")
                    offImage = UIImage(named: "TestImage-0")
                    fallthrough
                default:
                    checkboxObject?.isUsingSFSymbols = false
                    break
            }
            
            checkboxObject?.offImage = offImage
            checkboxObject?.clearImage = clearImage
            checkboxObject?.onImage = onImage
        }
    }
    
    /* ################################################################## */
    /**
     */
    func setSelectedTint() {
        if let index = tintSelectorSegmentedSwitch?.selectedSegmentIndex,
           let color = 0 == index ? UIColor(named: "AccentColor") : 1 == index ? .label : UIColor(named: "Tint-\(index)") {
            checkboxObject?.tintColor = color
        }
    }

    /* ################################################################## */
    /**
     */
    func setSegmentedSwitch() {
        valueChangedSegmentedSwitch?.selectedSegmentIndex = (checkboxObject?.value ?? 1) + 1
    }
}
