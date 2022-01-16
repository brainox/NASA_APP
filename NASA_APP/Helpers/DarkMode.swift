//
//  DarkMode.swift
//  NASA_APP
//
//  Created by Decagon on 16/01/2022.
//

import UIKit

enum AssetsColor: String {
    case generalScreenBackgroundColor
    case buttonBackgroundColor
    case otherLabelColour
    case titleLabelColour
    case imageBackgroundColour
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor? {
        return UIColor(named: name.rawValue)
    }
}

let foodlyPurple = UIColor.appColor(.buttonBackgroundColor)
let backgroundColor = UIColor.appColor(.generalScreenBackgroundColor)
let labelColor = UIColor.appColor(.otherLabelColour)
let titleTextColor = UIColor.appColor(.titleLabelColour)
let imageBackgroundColour = UIColor.appColor(.imageBackgroundColour)
