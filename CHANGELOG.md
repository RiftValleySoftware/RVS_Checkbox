# RVS_Checkbox Change Log

## 3.0.5

- **February 10, 2026**

- Documentation improvements. No functional changes.

## 3.0.4

- **July 13, 2025**

- Improved the code commenting, and the project documentation.

## 3.0.3

- **July 12, 2025**

- Had to add code documentation for one overridden property.

## 3.0.2

- **July 12, 2025**

- Had to increase the tools version.

## 3.0.1

- **July 12, 2025**

- Fixed the docc generator.

## 3.0.0

- **July 12, 2025**

- Big improvements/changes.
- The "default" checkbox (circular) type is gone. Instead, the SFSymbols variant is now default.
- There is now support for full-color images.
- Moved the isUsingSFSymbols property to a programmatic-only one.
- Improved the way that the control dynamically reacts to settings changes.
- Code cleanup.
- Documentation cleanup.

## 2.0.2

- **November 14, 2024**

- Added `@unchecked Sendable` to the hardcoded image classes.

## 2.0.1

- **January 6, 2024**

- Updated the dependencies.
- Added privacy statements.
- I had to remove SwiftLint, as it no longer works in the latest Xcode.

## 2.0.0

- **April 27, 2023**

- Even though the API hasn't changed, we now derive from [`UISwitch`](https://developer.apple.com/documentation/uikit/uiswitch), so it is now a _true_ "drop in" replacement for the switch.

## 1.2.3

- **October 6, 2022**

- Updated a dependency. No API changes.

## 1.2.2

- **September 16, 2022**

- Updated a dependency and tools.
- Had to change "open" to "public," but should not affect the API.""""

## 1.2.1

- **July 10, 2022**

- Updated a dependency. No other changes.

## 1.2.0

- **May 31, 2022**

- Removed the dash-notation.
- Updated to the latest packages.

## 1.1.10

- **April 2, 2022**

- No change, but I had to update the version number, as my project was complaining.

## 1.1.10

- **March 15, 2022**

- Updated the tools. No code or API changes.

## 1.1.9

- **January 27, 2022**

- Added support for DocC. No code or API changes.

## 1.1.8

- **December 14, 2021**

- Updated to the latest tools.

## 1.1.7

- **October 4, 2021**

- The images now retain aspect when drawn (Aspect Fit mode).

## 1.1.6

- **September 23, 2021**

- Updated to the latest toolchains.

## 1.1.5

- **May 13, 2021**

- Renamed the Cartfile, to prevent a loop.
- Made sure that the correct libraries (or not libraries) were being included for the various example builds.
- Moved SwiftLint out, so the system version will be used.

## 1.1.4

- **March 27, 2021**

- I needed to add a decisive refresh call to the setState(), and set the value prior to the animation being executed.

## 1.1.3

- **March 23, 2021**

- The background needed to be forced clear.

## 1.1.2

- **March 23, 2021**

- Improved the documentation to include the test harness app.
- Some minor code changes in the library, in an attempt to avoid the Interface Builder designables issue.
- Improved the code documentation of the test harness app.

## 1.1.1

- **March 20, 2021**

- Added support for haptics, and finalized the documentation.

- Changed main project to dylib.

## 1.0.3.2000

- **March 20, 2021**

- Added a Carthage example target to the test harness.
- Added dynamically-created examples to the test harness.

## 1.0.2.2000

- **March 19, 2021**

- Tweaks to the Podspec.
- Continued work on the documentation.

## 1.0.1.2000

- **March 19, 2021**

- Added CocoaPods PodSpec

## 1.0.0.2000

- **March 19, 2021**

- Initial release.
