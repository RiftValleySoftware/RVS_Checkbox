![Icon](img/icon.png)

# RVS_Checkbox

- **Table of Contents**
    - [INTRODUCTION](#INTRO)
    - [WHAT PROBLEM DOES THIS SOLVE?](#WHATPROBLEM)
        - [So, What's the Problem?](#WHATSTHEPROBLEM)
        - [Why Does the RVS_Checkbox Solve This Problem?](#WHY)
    - [DEPENDENCIES](#DEPENDENCIES)
    - [INSTALLATION](#INSTALLATION)
        - [Swift Package Manager](#SPM)
            - [Adding the Package Directly to One Target](#SINGLETARGET)
            - [Adding the Package Directly to Another Target](#ADDITIONALTARGET)
        - [CocoaPods](#COCOAPODS)
        - [AFTER INCLUDING THE PACKAGE OR LIBRARY](#AFTER)
        - [Carthage](#CARTHAGE)
        - [Directly Accessing the GitHub Repo](#GITHUBREPO)

## <a id="INTRO"></a>INTRODUCTION
This project is a robust, Swift-only, high-quality, "drop-in replacement" for the traditional [`UISwitch`](https://developer.apple.com/documentation/uikit/uiswitch), provided by Apple. It derives from [`UIControl`](https://developer.apple.com/documentation/uikit/uicontrol), and provides almost exactly the same API as `UISwitch`.

## <a id="WHATPROBLEM"></a>WHAT PROBLEM DOES THIS SOLVE?
The classic `UISwitch`:

![The Standard UISwitch Control](img/UISwitch.png)

Is a great UI element, and is used in place of the classic ["checkbox"](https://developer.apple.com/documentation/appkit/nsbutton) for Mac:

![The Standard Mac Checkbox Control](img/CheckBoxes_Selected.png)

Which doesn't actually work as well, in the "fat finger" world of iOS UI.
### <a id="WHATSTHEPROBLEM"></a>So, What's the Problem?
The issue is that the `UISwitch` is a big, rather awkwardly-shaped element. It is "lozenge"-shaped, and always horizontal, so can require a bit of creativity, when it comes to fitting it into a UI. Also, it has a specific design aesthetic, and can be difficult to customize *(to be fair, Apple doesn't encourage us to customize **ANY** UI, so that's no surprise).*

Because of the horizontal aspect of the control, it is fairly "natural" to have the label to the left:

![A Switch, With the Label on the Left](img/UISwitchLabels-Left.png)

...or the right:

![A Switch, With the Label on the Right](img/UISwitchLabels-Right.png)

But it looks "awkward" to have it below the switch:

![A Switch, With the Label on the Bottom](img/UISwitchLabels-Bottom.png)

This is especially true, if you use "label buttons," like I do (run the test harness, to see them in action).
It is also a bit "weird," as the slider appearance seems to ask for a swipe gesture, as opposed to a tap gesture (which is really what we want). That means that the gesture also requires some "mental runway."
The `RVS_Checkbox` allows a square aspect, and a directionless (tap) action, like a regular checkbox.

`UISwitch` also has a strictly "binary" action. If you have three choices, you are expected to use a [`UISegmentedControl`](https://developer.apple.com/documentation/uikit/uisegmentedcontrol), which is actually quite sensible. Apple obviously put a lot of research into their UI paradygm, and there's a good reason for this. Mobile interfaces are a compromise, at best.

### <a id="WHY"></a>Why Does the RVS_Checkbox Solve This Problem?
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
        <td><img src="img/OnDefault.png" alt="The Default Image for the ON State." /></td>
        <td><img src="img/SFOn.png" alt="The SF Symbols Image for the ON State." /></td>
        <td><img src="img/BioHazard.png" alt="An Example Customer-Supplied Image for the ON State." /></td>
    </tr>
    <tr>
        <td><strong>OFF</strong></td>
        <td><img src="img/OffDefault.png" alt="The Default Image for the OFF State." /></td>
        <td><img src="img/SFOff.png" alt="The SF Symbols Image for the OFF State." /></td>
        <td><img src="img/Radiation.png" alt="An Example Customer-Supplied Image for the OFF State." /></td>
    </tr>
    <tr>
        <td><strong>CLEAR</strong></td>
        <td><img src="img/ClearDefault.png" alt="The Default Image for the CLEAR State." /></td>
        <td><img src="img/SFClear.png" alt="The SF Symbols Image for the CLEAR State." /></td>
        <td><img src="img/Clear.png" alt="An Example Customer-Supplied Image for the CLEAR State." /></td>
    </tr>
    </tbody>
</table>

The "DEFAULT" and "SF SYMBOLS" images are "baked into" the class, and the "USER-PROVIDED" images are three arbitrary images that were added in the storyboard (you can see these in the test harness).

The images will resize with the control, and will scale to fill (so the control needs to be sized to the aspect ratio of the images, for undistorted display).

## <a id="DEPENDENCIES"></a>DEPENDENCIES

There are no dependencies for the module. If you will be running [the test harness](https://github.com/RiftValleySoftware/RVS_Checkbox/tree/main/TestHarness/RVS_Checkbox_TestHarness), you will need to load [the RVS_Generic_Swift_Toolbox project](https://github.com/RiftValleySoftware/RVS_Generic_Swift_Toolbox), as well. Again, **THIS IS NOT NECESSARY TO USE THE PACKAGE. IT IS ONLY FOR THE TEST HARNESS!**

## <a id="INSTALLATION"></a>INSTALLATION

The control is provided as a [Swift Package Manager](https://swift.org/package-manager/) package, a [CocoaPod](https://cocoapods.org), and can be installed using [Carthage](https://github.com/Carthage/Carthage). You can also simply drag [the project](https://github.com/RiftValleySoftware/RVS_Checkbox/tree/main/RVS_Checkbox.xcodeproj) into your own project, straight from a local repo, or even just include [the single source file](https://github.com/RiftValleySoftware/RVS_Checkbox/blob/main/Sources/RVS_Checkbox/RVS_Checkbox.swift) (I like to keep the number of source files to a minimum for these types of projects).

### <a id="SPM"></a>Swift Package Manager

The repo that you should include with SPM, is [`git@github.com:RiftValleySoftware/RVS_Checkbox.git`](git@github.com:RiftValleySoftware/RVS_Checkbox.git).

Either by directly editing the [`Package.swift`](https://swift.org/package-manager/#importing-dependencies) file, or by using the project GUI, add the package:

#### <a id="SINGLETARGET"></a>Adding the Package Directly to One Target:

![Step 1: Add A Package](img/00-Package.png)

Step 1: In the "Swift Packages" tab of the main project, select the "+" button, to add a package.

![Step 2: Enter the URI](img/01-Package.png)

Step 2: In the resulting modal screen, enter the GitHub URI: [`git@github.com:RiftValleySoftware/RVS_Checkbox.git`](git@github.com:RiftValleySoftware/RVS_Checkbox.git).

![Step 3: Enter the Version](img/02-Package.png)

Step 3: Enter the current version (if you used the URI, then this is already set).

![Step 4: Add the Package to Your Target](img/03-Package.png)

Step 4: Add the package to your target. You can only add the package to one target, at this point.

#### <a id="ADDITIONALTARGET"></a>Adding the Package to Another Target:

If you have the package imported, you now have it available like any other framework, and you can add it manually to any target, using the General Tab:

![Step 5: Adding to A Target](img/04-Package.png)

Step 5: Adding the package to a target in the General Tab.

![Step 6: Selecting the Framework](img/05-Package.png)

Step 6: Selecting the imported framework.

### <a id="COCOAPODS"></a>CocoaPods

The Pod URI is [`https://cocoapods.org/pods/RVS_Checkbox`](https://cocoapods.org/pods/RVS_Checkbox).

### <a id="AFTER"></a>AFTER INCLUDING THE PACKAGE OR LIBRARY

At this point, you will need to import the module in the Swift source files that will be accessing it:

```
import RVS_Checkbox
```

### <a id="CARTHAGE"></a>Carthage

If you are using Carthage, then you should add the following line to your Cartfile:

```
github "RiftValleySoftware/RVS_Checkbox"
```

Then, open Terminal, and navigate to the top of the `RVS_Checkbox` directory, and type this into Terminal:

```
carthage update
```

It will creat a directory at the same level as the Cartfile, called "`Carthage`." Inside of this directory, will be another directory, called "`Checkouts`." Inside of that directory, will be another one, called "`RVS_Checkbox`." You want to go into "`Sources/RVS_Checkout`," and access the `RVS_Checkbox.swift` file. Drag this into your project, and associate it with your app build target.

![The Carthage Checkouts Directory](img/Checkouts.png)

### <a id="GITHUBREPO"></a>Directly Accessing the GitHub Repo

The GitHub repo is [`https://github.com/RiftValleySoftware/RVS_Checkbox`](https://github.com/RiftValleySoftware/RVS_Checkbox).

You can access the repo directly, and clone it, or add it as [a Git Submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules) to your project.

If you do this, be aware that you only need to add one single file to your project; [the `RVS_Checkbox.swift` file](https://github.com/RiftValleySoftware/RVS_Checkbox/blob/main/Sources/RVS_Checkbox/RVS_Checkbox.swift).

It is advisable to directly integrate this file into your project, as opposed to building a library. It is only one source file, and integrating it will be easiest all around.

If we integrate directly, then there is no need to import the module. The `RVS_Checkbox` class will be directly available in the module namespace.
