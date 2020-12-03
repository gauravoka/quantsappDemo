//
//  SetupUI.swift
//  quantsappdemo
//
//  Created by Gaurav Oka on 03/12/20.
//

import Foundation
import UIKit

class setupUI: NSObject {
    
    
    class func setUpElevation(view: UIView) {
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
    }
    
    class func setUpElevationWelcomeScreen(view: UIView) {
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.9
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 5
    }
    
    
}
