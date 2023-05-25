//
//  UIView.swift
//  Offline-First-App-Seeder-Project
//
//  Created by Meera Mohandas on 03/05/23.
//

import Foundation
import UIKit

extension UIView
{
    func setViewStyle(cornerRadius:CGFloat, borderColor:UIColor, borderWidth:CGFloat, backGroundColor:UIColor)
    {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.backgroundColor = backGroundColor.cgColor
        
    }
    
    func flash(numberOfFlashes: Float) {
       let flash = CABasicAnimation(keyPath: "opacity")
       flash.duration = 0.9
       flash.fromValue = 1
       flash.toValue = 0.3
       flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
       flash.autoreverses = true
       flash.repeatCount = numberOfFlashes
       layer.add(flash, forKey: nil)
   }
    
    func blurView()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    
    func setShadow() {
        
    }
    
   
}

///blurr effect
public extension UIView {
    @discardableResult
    func addBlur(style: UIBlurEffect.Style = .prominent) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: style)
        let blurBackground = UIVisualEffectView(effect: blurEffect)
        addSubview(blurBackground)
        blurBackground.translatesAutoresizingMaskIntoConstraints = false
        blurBackground.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        blurBackground.topAnchor.constraint(equalTo: topAnchor).isActive = true
        blurBackground.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        blurBackground.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        return blurBackground
    }
}
extension UIView {
    //https://stackoverflow.com/a/43295741/10476608
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity

        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}
