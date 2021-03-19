![Icon](img/icon.png)

# RVS_Checkbox

## INTRODUCTION
This project is a robust, Swift-only, high-quality, "drop-in replacement" for the traditional [`UISwitch`](https://developer.apple.com/documentation/uikit/uiswitch), provided by Apple. It derives from [`UIControl`](https://developer.apple.com/documentation/uikit/uicontrol), and provides almost exactly the same API as `UISwitch`.

## WHAT PROBLEM DOES THIS SOLVE?
The classic `UISwitch`:

![Icon](img/UISwitch.png)

Is a great UI element, and is used in place of the classic ["checkbox"](https://developer.apple.com/documentation/appkit/nsbutton) for Mac:

![Icon](img/CheckBoxes_Selected.png)

Which doesn't actually work as well, in the "fat finger" world of iOS UI.
### So, What's the Problem?
The issue is that the `UISwitch` is a big, rather awkwardly-shaped element. It is "lozenge"-shaped, and always horizontal, so can require a bit of creativity, when it comes to fitting it into a UI. Also, it has a specific design aesthetic, and can be difficult to customize *(to be fair, Apple doesn't encourage us to customize **ANY** UI, so that's no surprise).*

Because of the horizontal aspect of the control, it is fairly "natural" to have the label to the left:

![Icon](img/UISwitchLabels-Left.png)

...or the right:

![Icon](img/UISwitchLabels-Right.png)

But it looks "awkward" to have it below the switch:

![Icon](img/UISwitchLabels-Bottom.png)

This is especially true, if you use "label buttons," like I do (run the test harness, to see them in action).
It is also a bit "weird," as the slider appearance seems to ask for a swipe gesture, as opposed to a tap gesture (which is really what we want). That means that the gesture also requires some "mental runway."
The `RVS_Checkbox` allows a square aspect, and a directionless (tap) action, like a regular checkbox.

`UISwitch` also has a strictly "binary" action. If you have three choices, you are expected to use a [`UISegmentedControl`](https://developer.apple.com/documentation/uikit/uisegmentedcontrol), which is actually quite sensible. Apple obviously put a lot of research into their UI paradygm, and there's a good reason for this. Mobile interfaces are a compromise, at best.

### Why Does the RVS_Checkbox Solve This Problem?
Glad you asked. The `RVS_Checkbox` comes with two "built-in" appearances: A default, circular checkbox, and a fairly "classic" appearance that uses the built-in [SF Symbols](https://developer.apple.com/design/human-interface-guidelines/sf-symbols/overview/) to mimic the way the Mac checkboxes appear.

You can also add your own images.

Images are simple. They are always rendered in ["template" mode](https://developer.apple.com/documentation/uikit/uiimage/renderingmode/alwaystemplate), so they are "silhouettes," and are colored by the control's tint.

Additionally, `RVS_Checkbox` brings the "three-state" checkbox that is found in the Mac, to iOS. That means it is possible to have an "OFF," "ON," and "indeterminate" mode (I call it "CLEAR"). The default appearence is the circular checkbox, and the default mode is "binary," like UISwitch.

Here are what the images looks like (the color is controlled by the [`tintColor` property](https://developer.apple.com/documentation/uikit/uiview/1622467-tintcolor) of the control):
<table style="text-align:center">
    <thead>
        <tr>
            <td>&nbsp;</td>
            <td><strong>DEFAULT</strong></td>
            <td><strong>SF SYMBOLS</strong></td>
            <td><strong>USER-PROVIDED</strong></td>
        </tr>
    </thead>
    <tbody>
    <tr>
        <td><strong>ON</strong></td>
        <td><img src="img/OnDefault.png" /></td>
        <td><img src="img/SFOn.png" /></td>
        <td><img src="img/BioHazard.png" /></td>
    </tr>
    <tr>
        <td><strong>OFF</strong></td>
        <td><img src="img/OffDefault.png" /></td>
        <td><img src="img/SFOff.png" /></td>
        <td><img src="img/Radiation.png" /></td>
    </tr>
    <tr>
        <td><strong>CLEAR</strong></td>
        <td><img src="img/ClearDefault.png" /></td>
        <td><img src="img/SFClear.png" /></td>
        <td><img src="img/Clear.png" /></td>
    </tr>
    </tbody>
</table>

The "DEFAULT" and "SF SYMBOLS" images are "baked into" the class, and the "USER-PROVIDED" images are three arbitrary images that were added in the storyboard (you can see these in the test harness).

The images will resize with the control, and will scale to fill (so the control needs to be sized to the aspect ratio of the images, for undistorted display).

## INSTALLATION

The control is provided as a [Swift Package Manager](https://swift.org/package-manager/) package, a [Pod](https://cocoapods.org), and can be installed using [Carthage](https://github.com/Carthage/Carthage).
