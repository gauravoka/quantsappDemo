//
//  Spinner.swift
//  quantsappdemo
//
//  Created by Gaurav Oka on 03/12/20.
//

import Foundation
import UIKit

open class Spinner {
    
    internal static var spinner: UIActivityIndicatorView?
    public static var style: UIActivityIndicatorView.Style = .whiteLarge
    public static var baseBackColor = UIColor(white: 0, alpha: 0.6)
    public static var baseColor = UIColor(red: 12/255, green: 65/255, blue: 142/255, alpha: 1)
    
    
    
    public static func start(style: UIActivityIndicatorView.Style = style, backColor: UIColor = baseBackColor, baseColor: UIColor = baseColor) {
        DispatchQueue.main.async {
            if spinner == nil, let window = UIApplication.shared.keyWindow {
                let frame = UIScreen.main.bounds
                spinner = UIActivityIndicatorView(frame: frame)
                spinner!.backgroundColor = backColor
                spinner!.style = style
                spinner?.color = baseColor
                window.addSubview(spinner!)
                spinner!.startAnimating()
            }
            
        }
    }
    
    
    public static func stop() {
        if spinner != nil {
        
                spinner!.stopAnimating()
            
            spinner!.removeFromSuperview()
            spinner = nil
        }
    }
    
    public static func update() {
        if spinner != nil {
            stop()
            start()
        }
    }
    
}
