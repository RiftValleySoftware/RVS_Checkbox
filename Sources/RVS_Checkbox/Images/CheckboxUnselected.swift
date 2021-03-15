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

//// Color Declarations
let fillColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)

//// Bezier 2 Drawing
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
fillColor.setFill()
bezier2Path.fill()
