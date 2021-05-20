import UIKit

extension UIColor {
    static var primaryColor: UIColor {
        return UIColor(hexString: "#c8a39a")
    }

    static var offWhite: UIColor {
        return UIColor(hexString: "#f5f5f5")
    }

    static var mediumGray: UIColor {
        return UIColor(hexString: "#8b909f")
    }

    convenience init(hexString: String, alpha: CGFloat = 1.0) {
            let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            let scanner = Scanner(string: hexString)
            if (hexString.hasPrefix("#")) {
                scanner.scanLocation = 1
            }
            var color: UInt32 = 0
            scanner.scanHexInt32(&color)
            let mask = 0x000000FF
            let r = Int(color >> 16) & mask
            let g = Int(color >> 8) & mask
            let b = Int(color) & mask
            let red   = CGFloat(r) / 255.0
            let green = CGFloat(g) / 255.0
            let blue  = CGFloat(b) / 255.0
            self.init(red:red, green:green, blue:blue, alpha:alpha)
        }
}
