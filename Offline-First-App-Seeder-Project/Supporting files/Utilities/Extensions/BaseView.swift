//
//  BaseView.swift
//  Offline-First-App-Seeder-Project
//
//  Created by Meera Mohandas on 03/05/23.
//

import Foundation
import UIKit


//@IBDesignable
class BaseViewBlue: UIView {
    @IBInspectable
    var shadow: UIColor? {
        get {
            let color = UIColor.init(hexString: "#A4C1E6")
            return color
        }
        set {
            layer.backgroundColor = UIColor.white.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            let color = UIColor.init(hexString: "#A4C1E6")
            layer.shadowColor = color.cgColor
            layer.shadowOffset = shadowOffset
            layer.shadowOpacity = shadowOpacity
            layer.shadowRadius = newValue
            layer.cornerRadius = 15

        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
       var shadowOpacity: Float {
           get {
               return layer.shadowOpacity
           }
           set {
               layer.shadowOpacity = newValue
           }
       }
       
}

//@IBDesignable
class BaseView: UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.4
            layer.shadowRadius = newValue

        }
    }
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.shadowColor!)
            return color
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowBack: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.backgroundColor!)
            return color
        }
        set {
            layer.backgroundColor = newValue?.cgColor
        }
    }
    
    func updateLayout() {
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
    }
}

//@IBDesignable
class BaseViewShadow: UIView {
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
            updateLayout()
        }
    }
    
    private var privateShadowColor: UIColor = .black
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            return privateShadowColor
        }
        set {
            privateShadowColor = newValue!
            layer.shadowColor = newValue?.cgColor
            updateLayout()

        }
    }
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
            updateLayout()

        }
    }
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
            updateLayout()
        }
    }
    
    
    func updateLayout() {
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = privateShadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
    }
    
    
}

//@IBDesignable
class GradientView: BaseView {
    @IBInspectable var firstColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    @IBInspectable var secondColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
}
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor, secondColor].map{$0.cgColor}
}
    @IBInspectable var isHorizontal: Bool = true {
        didSet {
            updateViewHorizontal()
        }
    }
    func updateViewHorizontal() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor, secondColor].map{$0.cgColor}
        if (self.isHorizontal) {
            layer.startPoint = CGPoint(x: 0, y: 0)
            layer.endPoint = CGPoint (x: 1, y: 0.5)
        } else {
            layer.startPoint = CGPoint(x: 0, y: 0)
            layer.endPoint = CGPoint (x: 0.5, y: 1)
        }
}
}



//@IBDesignable
class GradientImageView: UIImageView {
    @IBInspectable var firstColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    @IBInspectable var secondColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor, secondColor].map{$0.cgColor}
    }
    @IBInspectable var isHorizontal: Bool = true {
        didSet {
            updateViewHorizontal()
        }
    }
    func updateViewHorizontal() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor, secondColor].map{$0.cgColor}
        if (self.isHorizontal) {
            layer.startPoint = CGPoint(x: 0, y: 0)
            layer.endPoint = CGPoint (x: 1, y: 0.5)
        } else {
            layer.startPoint = CGPoint(x: 0, y: 0)
            layer.endPoint = CGPoint (x: 0.5, y: 1)
        }
    }
}


//  View with additional properties
//@IBDesignable
class ExtendedView: UIView {
    
    private var shadowColorP   : UIColor = .black
    private var shadowRadiusP  : CGFloat = 1.0
    private var shadowOffsetP  : CGSize  = .zero
    private var shadowOpacityP : Float   = 1.0
    private var zPositionP     : CGFloat = 0
    
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return shadowRadiusP
        }
        set {
            layer.shadowRadius = newValue
            shadowRadiusP = newValue
            updateView()
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            return shadowColorP
        }
        set {
            layer.shadowColor = newValue?.cgColor
            shadowColorP = newValue == nil ? UIColor.black : newValue!
            updateView()
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return shadowOffsetP
        }
        set {
            layer.shadowOffset = newValue
            shadowOffsetP = newValue
            updateView()
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return shadowOpacityP
        }
        set {
            layer.shadowOpacity = newValue
            shadowOpacityP = newValue
            updateView()
        }
    }
    
    @IBInspectable
    var zPosition: CGFloat {
        get {
            return zPositionP
        }
        set {
            layer.zPosition = newValue
            zPositionP = newValue
            updateView()
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func updateView() {
        layer.shadowColor   = shadowColorP.cgColor
        layer.shadowOffset  = shadowOffsetP
        layer.shadowOpacity = shadowOpacityP
        layer.shadowRadius  = shadowRadius
        layer.zPosition     = zPositionP
    }
    
}

//  UIButton with additional properties
//@IBDesignable
class ExtendedButton: UIButton {
    
    private var shadowColorP   : UIColor = .black
    private var shadowRadiusP  : CGFloat = 1.0
    private var shadowOffsetP  : CGSize  = .zero
    private var shadowOpacityP : Float   = 1.0
    private var zPositionP     : CGFloat = 0
    
    var parentTag: Int?
    var isShare: Bool?
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return shadowRadiusP
        }
        set {
            layer.shadowRadius = newValue
            shadowRadiusP = newValue
            updateView()
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            return shadowColorP
        }
        set {
            layer.shadowColor = newValue?.cgColor
            shadowColorP = newValue == nil ? UIColor.black : newValue!
            updateView()
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return shadowOffsetP
        }
        set {
            layer.shadowOffset = newValue
            shadowOffsetP = newValue
            updateView()
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return shadowOpacityP
        }
        set {
            layer.shadowOpacity = newValue
            shadowOpacityP = newValue
            updateView()
        }
    }
    
    @IBInspectable
    var zPosition: CGFloat {
        get {
            return zPositionP
        }
        set {
            layer.zPosition = newValue
            zPositionP = newValue
            updateView()
        }
    }
    
    
    func updateView() {
        layer.shadowColor   = shadowColorP.cgColor
        layer.shadowOffset  = shadowOffsetP
        layer.shadowOpacity = shadowOpacityP
        layer.shadowRadius  = shadowRadius
        layer.zPosition     = zPositionP
    }
    
}


class ExtendedImageView: UIImageView {

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
}

//@IBDesignable
class ExtendedSwitch: UISwitch {
    private var defaultHeight: CGFloat = 31
    private var defaultWidth: CGFloat = 51

    @IBInspectable
    var alterHeight: CGFloat {
        get {
            return defaultHeight
        }
        set {
            defaultHeight = newValue
            update()
        }
    }
    
    @IBInspectable
    var alterWidth: CGFloat {
        get {
            return defaultWidth
        }
        set {
            defaultWidth = newValue
            update()
        }
    }
    
    func update() {
        let standardHeight: CGFloat = 31
        let standardWidth: CGFloat = 51

        let heightRatio = defaultHeight / standardHeight
        let widthRatio = defaultWidth / standardWidth

        transform = CGAffineTransform(scaleX: widthRatio, y: heightRatio)
    }
    
}

class ExtendedDashedView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var dashWidth: CGFloat = 0
    @IBInspectable var dashColor: UIColor = .clear
    @IBInspectable var dashLength: CGFloat = 0
    @IBInspectable var dashSpace: CGFloat = 0

    var dashBorderLayer: CAShapeLayer?

    override func layoutSubviews() {
        super.layoutSubviews()
        dashBorderLayer?.removeFromSuperlayer()
        let dashBorder = CAShapeLayer()
        dashBorder.lineWidth = dashWidth
        dashBorder.strokeColor = dashColor.cgColor
        dashBorder.lineDashPattern = [dashLength, dashSpace] as [NSNumber]
        dashBorder.frame = bounds
        dashBorder.fillColor = nil
//        dashBorder.lineCap = .round
//        dashBorder.lineJoin = .round
            
        if cornerRadius > 0 {
            dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        } else {
            dashBorder.path = UIBezierPath(rect: bounds).cgPath
        }
        layer.addSublayer(dashBorder)
        self.dashBorderLayer = dashBorder
    }
    
    func setDash(color: UIColor, isDotted: Bool = true, radius: CGFloat = 23) {
        dashColor = color
        dashSpace = isDotted ? 3 : 0
        dashWidth = 7
        dashLength = 8
        cornerRadius = radius
        layoutSubviews()
    }
    
    
}

