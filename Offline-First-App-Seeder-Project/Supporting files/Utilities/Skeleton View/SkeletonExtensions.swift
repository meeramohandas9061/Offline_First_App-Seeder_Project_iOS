//
//  SkeletonExtensions.swift
//  Offline-First-App-Seeder-Project
//
//  Created by Meera Mohandas on 25/05/23.
//

import Foundation
import UIKit

//MARK: - Add Gradient Animation -
extension CALayer {
    
    public func addGradAnimCustom(withDirection direction: GradientDirection, duration: CFTimeInterval = 1) {
            let startPointAnim = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.startPoint))
            startPointAnim.fromValue = direction.startPoint.from
            startPointAnim.toValue = direction.startPoint.to
            
            let endPointAnim = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.endPoint))
            endPointAnim.fromValue = direction.endPoint.from
            endPointAnim.toValue = direction.endPoint.to
            
            let animGroup = CAAnimationGroup()
            animGroup.animations = [startPointAnim, endPointAnim]
            animGroup.duration = duration
            animGroup.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
            animGroup.repeatCount = .infinity
            animGroup.isRemovedOnCompletion = false
            self.add(animGroup, forKey: nil)
        
        }
    }


typealias GradientAnimationPoint = (from: CGPoint, to: CGPoint)

public enum GradientDirection {
    case leftRight
    case rightLeft
    case topBottom
    case bottomTop
    case topLeftBottomRight
    case bottomRightTopLeft
    
    // codebeat:disable[ABC]
    var startPoint: GradientAnimationPoint {
        switch self {
        case .leftRight:
            return (from: CGPoint(x: -1, y: 0.5), to: CGPoint(x: 1, y: 0.5))
        case .rightLeft:
            return (from: CGPoint(x: 1, y: 0.5), to: CGPoint(x: -1, y: 0.5))
        case .topBottom:
            return (from: CGPoint(x: 0.5, y: -1), to: CGPoint(x: 0.5, y: 1))
        case .bottomTop:
            return (from: CGPoint(x: 0.5, y: 1), to: CGPoint(x: 0.5, y: -1))
        case .topLeftBottomRight:
            return (from: CGPoint(x: -1, y: -1), to: CGPoint(x: 1, y: 1))
        case .bottomRightTopLeft:
            return (from: CGPoint(x: 1, y: 1), to: CGPoint(x: -1, y: -1))
        }
    }
    
    var endPoint: GradientAnimationPoint {
        switch self {
        case .leftRight:
            return (from: CGPoint(x: 0, y: 0.5), to: CGPoint(x: 2, y: 0.5))
        case .rightLeft:
            return ( from: CGPoint(x: 2, y: 0.5), to: CGPoint(x: 0, y: 0.5))
        case .topBottom:
            return ( from: CGPoint(x: 0.5, y: 0), to: CGPoint(x: 0.5, y: 2))
        case .bottomTop:
            return ( from: CGPoint(x: 0.5, y: 2), to: CGPoint(x: 0.5, y: 0))
        case .topLeftBottomRight:
            return ( from: CGPoint(x: 0, y: 0), to: CGPoint(x: 2, y: 2))
        case .bottomRightTopLeft:
            return ( from: CGPoint(x: 2, y: 2), to: CGPoint(x: 0, y: 0))
        }
    }
    // codebeat:enable[ABC]
}



//MARK: - Add Mask -
extension CAGradientLayer{
    
//    func addMask(with color : UIColor, on frame : UIBezierPath, of view : UIView){
//        let skeletonShape = CAShapeLayer()
//        skeletonShape.path = frame.cgPath
//        skeletonShape.fillColor = color.cgColor
//        skeletonShape.frame = view.frame
//        self.mask = skeletonShape
//    }
    
}

extension CALayer {
    func addMask(with color : UIColor, on frame : UIBezierPath, of view : UIView){
        let skeletonShape = CAShapeLayer()
        skeletonShape.path = frame.cgPath
        skeletonShape.fillColor = color.cgColor
        skeletonShape.frame = view.frame
        self.mask = skeletonShape
    }

}

extension UIBezierPath {
    
    func addFrame(){
        
    }
}


extension UIColor {
    convenience init(_ hex: UInt) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func isLight() -> Bool {
        guard let components = cgColor.components,
            components.count >= 3 else { return false }
        let brightness = ((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000
        return !(brightness < 0.5)
    }
    
    public var complementaryColor: UIColor {
        if #available(iOS 13, tvOS 13, *) {
            return UIColor { _ in
                return self.isLight() ? self.darker : self.lighter
            }
        } else {
            return isLight() ? darker : lighter
        }
    }
    
    public var lighter: UIColor {
        return adjust(by: 1.35)
    }
    
    public var darker: UIColor {
        return adjust(by: 0.94)
    }
    
    func adjust(by percent: CGFloat) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return UIColor(hue: h, saturation: s, brightness: b * percent, alpha: a)
    }
    
    func makeGradient() -> [UIColor] {
        return [self, self.complementaryColor, self]
    }
    
    static func getRandomColor() -> UIColor {
         //Generate between 0 to 1
         let red:CGFloat = CGFloat(drand48())
         let green:CGFloat = CGFloat(drand48())
         let blue:CGFloat = CGFloat(drand48())

         return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }

    func alpha(_ alpha: CGFloat) -> UIColor{
        return self.withAlphaComponent(alpha)
    }

    
}
