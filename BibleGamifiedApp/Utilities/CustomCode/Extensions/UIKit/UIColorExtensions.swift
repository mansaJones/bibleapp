//
//  UIColorExtensions.swift
//  StructureApp
// 
//  Created By: IndiaNIC Infotech Ltd
//  Created on: 11/11/17 10:25 AM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  

#if canImport(UIKit)
import UIKit
/// Color
public typealias Color = UIColor
#endif

#if canImport(Cocoa)
import Cocoa
/// Color
public typealias Color = NSColor
#endif

#if !os(watchOS)
import CoreImage
#endif

// MARK: - Application colors
public extension UIColor {

    struct app {
            public static let darkGreen = #colorLiteral(red: 0.3689999878, green: 0.7919999957, blue: 0.5059999824, alpha: 1)
            public static let darkRed = #colorLiteral(red: 0.8119999766, green: 0.2860000134, blue: 0.3959999979, alpha: 1)
            public static let darkYellow = #colorLiteral(red: 0.9649999738, green: 0.851000011, blue: 0.4900000095, alpha: 1)
            public static let darkPurple = #colorLiteral(red: 0.1689999998, green: 0.1840000004, blue: 0.6510000229, alpha: 1)
            public static let offWhite = #colorLiteral(red: 0.7854374647, green: 0.8212075233, blue: 0.8543733954, alpha: 1)
            public static let white = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            public static let darkBlack = #colorLiteral(red: 0.05558743328, green: 0.09099692851, blue: 0.1325429082, alpha: 1)
            public static let lightPurple = #colorLiteral(red: 0.3370000124, green: 0.1570000052, blue: 0.9330000281, alpha: 1)
            public static let chartNI = #colorLiteral(red: 0.8389999866, green: 0.7099999785, blue: 0.9919999838, alpha: 1)
            public static let chartISO = #colorLiteral(red: 0.4629999995, green: 0.3019999862, blue: 0.9449999928, alpha: 1)
            public static let darkGray = #colorLiteral(red: 0.4860000014, green: 0.4860000014, blue: 0.5759999752, alpha: 1)
            public static let viewBGColor = #colorLiteral(red: 0.08600000292, green: 0.1099999994, blue: 0.1650000066, alpha: 1)
            public static let textfieldBorder = UIColor(hex: "F0F0F0")
            public static let offlineColor = UIColor(hex: "F4F4F8")
            public static let navBarBG = UIColor(named: "navBarBG") ?? UIColor(hex: "5527EE")
        }

    /// The Structure for defining the colors for the Label
    struct Label {

        /// Primary Color for Title Label. - Hex - 1F2124
        ///
        ///     UIColor.label.title
        ///
        public static let white                     = UIColor(hex: "FFFFFF")

        /// Primary Color for Sub Title Label. - Hex - 1F2124
        ///
        ///     UIColor.label.subTitle
        ///
        public static let black                     = UIColor(hex: "000000")

    }

    /// The Structure for defining the colors for the Button
    struct Button {

        /// Primary Color for Title Label. - Hex - 1F2124
        ///
        ///     UIColor.button.title
        ///
        public static let title                     = UIColor(hex: "1F2124")

        /// Primary Color for Sub Title Label. - Hex - 1F2124
        ///
        ///     UIColor.button.subTitle
        ///
        public static let subTitle                  = UIColor(hex: "A2A5AA")

    }

}

// MARK: - Flat UI colors
public extension UIColor {

    /// Flat UI colors
     struct FlatUI {
        // http://flatuicolors.com.

        /// Flat UI color hex #1ABC9C
        public static let turquoise                     = UIColor(hex: "1ABC9C")

        /// Flat UI color hex #16A085
        public static let greenSea                      = UIColor(hex: "16A085")

        /// Flat UI color hex #2ECC71
        public static let emerald                       = UIColor(hex: "2ECC71")

        /// Flat UI color hex #27AE60
        public static let nephritis                     = UIColor(hex: "27AE60")

        /// Flat UI color hex #3498DB
        public static let peterRiver                    = UIColor(hex: "3498DB")

        /// Flat UI color hex #2980B9
        public static let belizeHole                    = UIColor(hex: "2980B9")

        /// Flat UI color hex #9B59B6
        public static let amethyst                      = UIColor(hex: "9B59B6")

        /// Flat UI color hex #8E44AD
        public static let wisteria                      = UIColor(hex: "8E44AD")

        /// Flat UI color hex #34495E
        public static let wetAsphalt                    = UIColor(hex: "34495E")

        /// Flat UI color hex #2C3E50
        public static let midnightBlue                  = UIColor(hex: "2C3E50")

        /// Flat UI color hex #F1C40F
        public static let sunFlower                     = UIColor(hex: "F1C40F")

        /// Flat UI color hex #F39C12
        public static let flatOrange                    = UIColor(hex: "F39C12")

        /// Flat UI color hex #E67E22
        public static let carrot                        = UIColor(hex: "E67E22")

        /// Flat UI color hex #D35400
        public static let pumkin                        = UIColor(hex: "D35400")

        /// Flat UI color hex #E74C3C
        public static let alizarin                      = UIColor(hex: "E74C3C")

        /// Flat UI color hex #C0392B
        public static let pomegranate                   = UIColor(hex: "C0392B")

        /// Flat UI color hex #ECF0F1
        public static let clouds                        = UIColor(hex: "ECF0F1")

        /// Flat UI color hex #BDC3C7
        public static let silver                        = UIColor(hex: "BDC3C7")

        /// Flat UI color hex #7F8C8D
        public static let asbestos                      = UIColor(hex: "7F8C8D")

        /// Flat UI color hex #95A5A6
        public static let concerte                      = UIColor(hex: "95A5A6")

    }

}

public extension UIColor {

    /// Initializes and returns a color object using the specified Hex values.
    ///
    ///
    ///     UIColor(hex: "95A5A6")
    /// or
    ///
    ///     UIColor(hex: "#95A5A6")
    ///
    ///
    /// - Parameters:
    ///   - hex: Hex String of the color. example: "95A5A6" or "#95A5A6"
    ///
    /// - Returns:
    /// The color object. The color information represented by this object is in an RGB colorspace. On applications linked for iOS 10 or later, the color is specified in an extended range sRGB color space. On earlier versions of iOS, the color is specified in a device RGB colorspace.
     convenience init(hex: String) {

        var cString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            let start = cString.index(cString.startIndex, offsetBy: 1)
            cString = String(cString[start...])
        }

        let rVal, gVal, bVal, aVal: CGFloat

        if cString.count == 6 {
            let scanner = Scanner(string: cString)
            var hexNumber: UInt64 = 0

            if scanner.scanHexInt64(&hexNumber) {
                rVal = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                gVal = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                bVal = CGFloat(hexNumber & 0x0000ff) / 255
                aVal = 1.0

                self.init(red: rVal, green: gVal, blue: bVal, alpha: aVal)
                return
            }
        }

        self.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return

    }

    /// Initializes and returns a color object using the specified opacity and RGB component values.
    ///
    ///
    ///
    ///     UIColor(red: 240, green: 240, blue: 240)
    /// or
    ///
    ///     UIColor(red: 240, green: 240, blue: 240, alpha: 1.0)
    ///
    ///
    /// - Parameters:
    ///   - red: The red value of the color object. On applications linked for iOS 10 or later, the color is specified in an extended color space, and the input value is never clamped. On earlier versions of iOS, red values below 0.0 are interpreted as 0.0, and values above 1.0 are interpreted as 1.0.
    ///   - green: The green value of the color object. On applications linked for iOS 10 or later, the color is specified in an extended color space, and the input value is never clamped. On earlier versions of iOS, green values below 0.0 are interpreted as 0.0, and values above 1.0 are interpreted as 1.0.
    ///   - blue: The blue value of the color object. On applications linked for iOS 10 or later, the color is specified in an extended color space, and the input value is never clamped. On earlier versions of iOS, blue values below 0.0 are interpreted as 0.0, and values above 1.0 are interpreted as 1.0.
    ///   - alpha: The opacity value of the color object, specified as a value from 0.0 to 1.0. Alpha values below 0.0 are interpreted as 0.0, and values above 1.0 are interpreted as 1.0.
    ///
    /// - Returns:
    /// The color object. The color information represented by this object is in an RGB colorspace. On applications linked for iOS 10 or later, the color is specified in an extended range sRGB color space. On earlier versions of iOS, the color is specified in a device RGB colorspace.
     convenience init(red: Int, green: Int, blue: Int, alpha: Float = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha))
    }

    /// Hexadecimal value string (read-only).
    var hexString: String {

        var rVal: CGFloat = 0
        var gVal: CGFloat = 0
        var bVal: CGFloat = 0
        var aVal: CGFloat = 0

        getRed(&rVal, green: &gVal, blue: &bVal, alpha: &aVal)

        let rgb: Int = (Int)(rVal*255)<<16 | (Int)(gVal*255)<<8 | (Int)(bVal*255)<<0

        return String(format: "#%06x", rgb)

    }

    // swiftlint:disable next large_tuple
    /// SwifterSwift: RGB components for a Color (between 0 and 255).
    ///
    ///        UIColor.red.rgbComponents.red -> 255
    ///        NSColor.green.rgbComponents.green -> 255
    ///        UIColor.blue.rgbComponents.blue -> 255
    ///
    var rgbComponents: (red: Int, green: Int, blue: Int) {
        var components: [CGFloat] {
            let comps = cgColor.components!
            if comps.count == 4 { return comps }
            return [comps[0], comps[0], comps[0], comps[1]]
        }
        let red = components[0]
        let green = components[1]
        let blue = components[2]
        return (red: Int(red * 255.0), green: Int(green * 255.0), blue: Int(blue * 255.0))
    }

    /// Random color in Swift 4.0
     static var random: UIColor {

        //        let randomRed:CGFloat = CGFloat(drand48())
        //        let randomGreen:CGFloat = CGFloat(drand48())
        //        let randomBlue:CGFloat = CGFloat(drand48())

        let randomRed: CGFloat = .random()
        let randomGreen: CGFloat = .random()
        let randomBlue: CGFloat = .random()
        //        print(randomRed, randomGreen, randomBlue)
        return self.init(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }

    /// Random color in Swift 4.2
    //    public static var random: UIColor {
    //        let red = Int.random(in: 0..<255)
    //        let green = Int.random(in: 0..<255)
    //        let blue = Int.random(in: 0..<255)
    //        return UIColor(red: red, green: green, blue: blue)
    //    }

}

extension UIColor {

    func inverse () -> UIColor {
        var r: CGFloat = 0.0; var g: CGFloat = 0.0; var b: CGFloat = 0.0; var a: CGFloat = 0.0
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: 1.0-r, green: 1.0 - g, blue: 1.0 - b, alpha: a)
        }
        return .black // Return a default colour
    }

    /**
     Determines if the color object is dark or light.

     It is useful when you need to know whether you should display the text in black or white.

     - returns: A boolean value to know whether the color is light. If true the color is light, dark otherwise.
     */
    func isLight() -> Bool {

      let components = toRGBAComponents()
      let brightness = ((components.r * 299.0) + (components.g * 587.0) + (components.b * 114.0)) / 1000.0

      return brightness >= 0.5
    }

    /**
     Returns the RGBA (red, green, blue, alpha) components.

     - returns: The RGBA components as a tuple (r, g, b, a).
     */
    final func toRGBAComponents() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
      var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0

      #if os(iOS) || os(tvOS) || os(watchOS)
        getRed(&r, green: &g, blue: &b, alpha: &a)

        return (r, g, b, a)
      #elseif os(OSX)
        guard let rgbaColor = self.usingColorSpace(.deviceRGB) else {
          fatalError("Could not convert color to RGBA.")
        }

        rgbaColor.getRed(&r, green: &g, blue: &b, alpha: &a)

        return (r, g, b, a)
      #endif
    }

}

extension CGFloat {

    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }

}

@IBDesignable class GradientView: UIView {
    @IBInspectable var firstColor: UIColor = UIColor.red
    @IBInspectable var secondColor: UIColor = UIColor.green

    @IBInspectable var vertical: Bool = true

    lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [firstColor.cgColor, secondColor.cgColor]
        layer.startPoint = CGPoint.zero
        return layer
    }()

    // MARK: -

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        applyGradient()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        applyGradient()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        applyGradient()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradientFrame()
    }

    // MARK: -

    func applyGradient() {
        updateGradientDirection()
        layer.sublayers = [gradientLayer]
    }

    func updateGradientFrame() {
        gradientLayer.frame = bounds
    }

    func updateGradientDirection() {
        gradientLayer.endPoint = vertical ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0)
    }
}

@IBDesignable class ThreeColorsGradientView: UIView {
    @IBInspectable var firstColor: UIColor = UIColor.red
    @IBInspectable var secondColor: UIColor = UIColor.green
    @IBInspectable var thirdColor: UIColor = UIColor.blue

    @IBInspectable var vertical: Bool = true {
        didSet {
            updateGradientDirection()
        }
    }

    lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [firstColor.cgColor, secondColor.cgColor, thirdColor.cgColor]
        layer.startPoint = CGPoint.zero
        return layer
    }()

    // MARK: -

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        applyGradient()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        applyGradient()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        applyGradient()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradientFrame()
    }

    // MARK: -

    func applyGradient() {
        updateGradientDirection()
        layer.sublayers = [gradientLayer]
    }

    func updateGradientFrame() {
        gradientLayer.frame = bounds
    }

    func updateGradientDirection() {
        gradientLayer.endPoint = vertical ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0)
    }
}

@IBDesignable class RadialGradientView: UIView {

    @IBInspectable var outsideColor: UIColor = UIColor.red
    @IBInspectable var insideColor: UIColor = UIColor.green

    override func awakeFromNib() {
        super.awakeFromNib()

        applyGradient()
    }

    func applyGradient() {
        let colors = [insideColor.cgColor, outsideColor.cgColor] as CFArray
        let endRadius = sqrt(pow(frame.width/2, 2) + pow(frame.height/2, 2))
        let center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: nil)
        let context = UIGraphicsGetCurrentContext()

        context?.drawRadialGradient(gradient!, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: endRadius, options: CGGradientDrawingOptions.drawsBeforeStartLocation)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        #if TARGET_INTERFACE_BUILDER
            applyGradient()
        #endif
    }
}
