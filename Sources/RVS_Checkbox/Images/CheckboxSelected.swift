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

//// Bezier Drawing
let bezierPath = UIBezierPath()
bezierPath.move(to: CGPoint(x: 450, y: 0))
bezierPath.addCurve(to: CGPoint(x: 0, y: 450), controlPoint1: CGPoint(x: 201.5, y: 0), controlPoint2: CGPoint(x: 0, y: 201.5))
bezierPath.addCurve(to: CGPoint(x: 450, y: 900), controlPoint1: CGPoint(x: 0, y: 698.5), controlPoint2: CGPoint(x: 201.5, y: 900))
bezierPath.addCurve(to: CGPoint(x: 900, y: 450), controlPoint1: CGPoint(x: 698.5, y: 900), controlPoint2: CGPoint(x: 900, y: 698.5))
bezierPath.addCurve(to: CGPoint(x: 450, y: 0), controlPoint1: CGPoint(x: 900, y: 201.5), controlPoint2: CGPoint(x: 698.5, y: 0))
bezierPath.close()
bezierPath.move(to: CGPoint(x: 688.3, y: 252.9))
bezierPath.addCurve(to: CGPoint(x: 685.3, y: 253.7), controlPoint1: CGPoint(x: 687.3, y: 253.4), controlPoint2: CGPoint(x: 686.3, y: 253.7))
bezierPath.addCurve(to: CGPoint(x: 674.7, y: 249.1), controlPoint1: CGPoint(x: 681.8, y: 253.7), controlPoint2: CGPoint(x: 678.2, y: 252.2))
bezierPath.addCurve(to: CGPoint(x: 663.3, y: 239.2), controlPoint1: CGPoint(x: 671.2, y: 246.1), controlPoint2: CGPoint(x: 667.4, y: 242.8))
bezierPath.addCurve(to: CGPoint(x: 650.8, y: 229.3), controlPoint1: CGPoint(x: 659.2, y: 235.7), controlPoint2: CGPoint(x: 655.1, y: 232.4))
bezierPath.addCurve(to: CGPoint(x: 636.8, y: 224.7), controlPoint1: CGPoint(x: 646.5, y: 226.3), controlPoint2: CGPoint(x: 641.8, y: 224.7))
bezierPath.addCurve(to: CGPoint(x: 607.9, y: 256.6), controlPoint1: CGPoint(x: 629.2, y: 224.7), controlPoint2: CGPoint(x: 619.6, y: 235.3))
bezierPath.addCurve(to: CGPoint(x: 561.2, y: 353.4), controlPoint1: CGPoint(x: 596.2, y: 277.9), controlPoint2: CGPoint(x: 580.7, y: 310.1))
bezierPath.addCurve(to: CGPoint(x: 487.5, y: 517.1), controlPoint1: CGPoint(x: 541.7, y: 396.7), controlPoint2: CGPoint(x: 517.2, y: 451.2))
bezierPath.addCurve(to: CGPoint(x: 377, y: 749.5), controlPoint1: CGPoint(x: 457.9, y: 582.9), controlPoint2: CGPoint(x: 421, y: 660.4))
bezierPath.addCurve(to: CGPoint(x: 370.9, y: 752.2), controlPoint1: CGPoint(x: 376, y: 751), controlPoint2: CGPoint(x: 374, y: 751.9))
bezierPath.addCurve(to: CGPoint(x: 360.3, y: 752.6), controlPoint1: CGPoint(x: 367.9, y: 752.4), controlPoint2: CGPoint(x: 364.3, y: 752.6))
bezierPath.addCurve(to: CGPoint(x: 351.9, y: 750.7), controlPoint1: CGPoint(x: 356.2, y: 752.6), controlPoint2: CGPoint(x: 353.5, y: 752))
bezierPath.addCurve(to: CGPoint(x: 348.1, y: 744.2), controlPoint1: CGPoint(x: 350.4, y: 749.4), controlPoint2: CGPoint(x: 349.1, y: 747.3))
bezierPath.addCurve(to: CGPoint(x: 334.1, y: 705.5), controlPoint1: CGPoint(x: 345.1, y: 735.1), controlPoint2: CGPoint(x: 340.4, y: 722.2))
bezierPath.addCurve(to: CGPoint(x: 312.8, y: 651.2), controlPoint1: CGPoint(x: 327.8, y: 688.8), controlPoint2: CGPoint(x: 320.7, y: 670.7))
bezierPath.addCurve(to: CGPoint(x: 287, y: 591.6), controlPoint1: CGPoint(x: 304.9, y: 631.7), controlPoint2: CGPoint(x: 296.3, y: 611.8))
bezierPath.addCurve(to: CGPoint(x: 258.5, y: 536.2), controlPoint1: CGPoint(x: 277.6, y: 571.4), controlPoint2: CGPoint(x: 268.1, y: 552.9))
bezierPath.addCurve(to: CGPoint(x: 230, y: 495.6), controlPoint1: CGPoint(x: 248.9, y: 519.5), controlPoint2: CGPoint(x: 239.4, y: 506))
bezierPath.addCurve(to: CGPoint(x: 203.8, y: 480), controlPoint1: CGPoint(x: 220.6, y: 485.2), controlPoint2: CGPoint(x: 211.9, y: 480))
bezierPath.addCurve(to: CGPoint(x: 195.1, y: 481.5), controlPoint1: CGPoint(x: 200.8, y: 480), controlPoint2: CGPoint(x: 197.8, y: 480.5))
bezierPath.addCurve(to: CGPoint(x: 187.1, y: 484.5), controlPoint1: CGPoint(x: 192.3, y: 482.5), controlPoint2: CGPoint(x: 189.7, y: 483.5))
bezierPath.addCurve(to: CGPoint(x: 183.3, y: 481.8), controlPoint1: CGPoint(x: 186.1, y: 484.5), controlPoint2: CGPoint(x: 184.8, y: 483.6))
bezierPath.addCurve(to: CGPoint(x: 180.3, y: 477.6), controlPoint1: CGPoint(x: 181.8, y: 480), controlPoint2: CGPoint(x: 180.8, y: 478.6))
bezierPath.addCurve(to: CGPoint(x: 180.7, y: 476.8), controlPoint1: CGPoint(x: 180.3, y: 477.1), controlPoint2: CGPoint(x: 180.4, y: 476.8))
bezierPath.addCurve(to: CGPoint(x: 181.1, y: 476), controlPoint1: CGPoint(x: 180.9, y: 476.8), controlPoint2: CGPoint(x: 181.1, y: 476.6))
bezierPath.addCurve(to: CGPoint(x: 194.4, y: 466.1), controlPoint1: CGPoint(x: 181.6, y: 475.5), controlPoint2: CGPoint(x: 186, y: 472.2))
bezierPath.addCurve(to: CGPoint(x: 224, y: 446), controlPoint1: CGPoint(x: 202.8, y: 460), controlPoint2: CGPoint(x: 212.6, y: 453.3))
bezierPath.addCurve(to: CGPoint(x: 258.6, y: 425.9), controlPoint1: CGPoint(x: 235.4, y: 438.7), controlPoint2: CGPoint(x: 246.9, y: 432))
bezierPath.addCurve(to: CGPoint(x: 287.5, y: 416.8), controlPoint1: CGPoint(x: 270.2, y: 419.8), controlPoint2: CGPoint(x: 279.9, y: 416.8))
bezierPath.addCurve(to: CGPoint(x: 303.8, y: 431.6), controlPoint1: CGPoint(x: 293.1, y: 416.8), controlPoint2: CGPoint(x: 298.5, y: 421.7))
bezierPath.addCurve(to: CGPoint(x: 323.2, y: 476.4), controlPoint1: CGPoint(x: 309.1, y: 441.5), controlPoint2: CGPoint(x: 315.6, y: 456.4))
bezierPath.addCurve(to: CGPoint(x: 350.2, y: 552), controlPoint1: CGPoint(x: 330.8, y: 496.4), controlPoint2: CGPoint(x: 339.8, y: 521.6))
bezierPath.addCurve(to: CGPoint(x: 388.6, y: 659.8), controlPoint1: CGPoint(x: 360.6, y: 582.4), controlPoint2: CGPoint(x: 373.4, y: 618.3))
bezierPath.addCurve(to: CGPoint(x: 439.9, y: 552.3), controlPoint1: CGPoint(x: 406.8, y: 626.4), controlPoint2: CGPoint(x: 423.9, y: 590.6))
bezierPath.addCurve(to: CGPoint(x: 485.1, y: 438.4), controlPoint1: CGPoint(x: 455.8, y: 514.1), controlPoint2: CGPoint(x: 470.9, y: 476.1))
bezierPath.addCurve(to: CGPoint(x: 525.3, y: 329.8), controlPoint1: CGPoint(x: 499.3, y: 400.7), controlPoint2: CGPoint(x: 512.7, y: 364.5))
bezierPath.addCurve(to: CGPoint(x: 561, y: 237.9), controlPoint1: CGPoint(x: 537.9, y: 295.1), controlPoint2: CGPoint(x: 549.9, y: 264.5))
bezierPath.addCurve(to: CGPoint(x: 593.3, y: 174.5), controlPoint1: CGPoint(x: 572.1, y: 211.3), controlPoint2: CGPoint(x: 582.9, y: 190.2))
bezierPath.addCurve(to: CGPoint(x: 624.1, y: 151), controlPoint1: CGPoint(x: 603.7, y: 158.8), controlPoint2: CGPoint(x: 613.9, y: 151))
bezierPath.addCurve(to: CGPoint(x: 653, y: 173), controlPoint1: CGPoint(x: 633.2, y: 151), controlPoint2: CGPoint(x: 642.8, y: 158.3))
bezierPath.addCurve(to: CGPoint(x: 663.6, y: 189.3), controlPoint1: CGPoint(x: 656, y: 177.6), controlPoint2: CGPoint(x: 659.6, y: 183))
bezierPath.addCurve(to: CGPoint(x: 675, y: 209), controlPoint1: CGPoint(x: 667.6, y: 195.6), controlPoint2: CGPoint(x: 671.4, y: 202.2))
bezierPath.addCurve(to: CGPoint(x: 684.5, y: 229.5), controlPoint1: CGPoint(x: 678.5, y: 215.8), controlPoint2: CGPoint(x: 681.7, y: 222.7))
bezierPath.addCurve(to: CGPoint(x: 690.2, y: 248.1), controlPoint1: CGPoint(x: 687.3, y: 236.3), controlPoint2: CGPoint(x: 689.2, y: 242.5))
bezierPath.addCurve(to: CGPoint(x: 688.3, y: 252.9), controlPoint1: CGPoint(x: 689.8, y: 250.8), controlPoint2: CGPoint(x: 689.3, y: 252.4))
bezierPath.close()
fillColor.setFill()
bezierPath.fill()
