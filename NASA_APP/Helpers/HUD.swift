//
//  HUD.swift
//  NASA_APP
//
//  Created by Decagon on 16/01/2022.
//

import Foundation
import ProgressHUD

final class HUD {
    class func show(status: String) {
        DispatchQueue.main.async {
            ProgressHUD.show(status)
            ProgressHUD.animationType = .circleStrokeSpin
            ProgressHUD.colorBackground = .black
            ProgressHUD.colorHUD = foodlyPurple!
            ProgressHUD.colorAnimation = foodlyPurple!
        }
    }
    
    class func hide() {
        DispatchQueue.main.async {
         ProgressHUD.dismiss()
        }
    }
}

