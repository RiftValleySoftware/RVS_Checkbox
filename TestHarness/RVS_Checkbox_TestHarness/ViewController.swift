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
    }
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        standardLabelButton?.setTitle((standardLabelButton?.title(for: .normal) ?? "ERROR").localizedVariant, for: .normal)
        threeStateLabelButton?.setTitle((threeStateLabelButton?.title(for: .normal) ?? "ERROR").localizedVariant, for: .normal)
        useOffImageLabelButton?.setTitle((useOffImageLabelButton?.title(for: .normal) ?? "ERROR").localizedVariant, for: .normal)
        checkboxObject?.draw(view.bounds)
    }
}
