//
//  UIColor.swift
//  AgileTv_GitCatch
//
//  Created by Luciano Uchoa on 10/02/25.
//

import UIKit

extension UIColor {
    
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        if hexSanitized.count == 3 {
            let redHex = hexSanitized[hexSanitized.startIndex]
            let greenHex = hexSanitized[hexSanitized.index(hexSanitized.startIndex, offsetBy: 1)]
            let blueHex = hexSanitized[hexSanitized.index(hexSanitized.startIndex, offsetBy: 2)]
            
            hexSanitized = "\(redHex)\(redHex)\(greenHex)\(greenHex)\(blueHex)\(blueHex)"
        }
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let green = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let blue = CGFloat(rgb & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
