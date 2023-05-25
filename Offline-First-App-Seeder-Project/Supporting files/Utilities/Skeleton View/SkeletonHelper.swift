//
//  SkeletonHelper.swift
//  Offline-First-App-Seeder-Project
//
//  Created by Meera Mohandas on 25/05/23.
//

import Foundation
import UIKit

public struct SkeletonConfiguration {
    var gradientSpeed          : CFTimeInterval    = 1.5
    var transitionSpeedStart   : CFTimeInterval    = 0.2
    var transitionSpeedDismiss : CFTimeInterval    = 0.2
    var isAnimatableDismiss    : Bool              = true
    var eachItemHeight         : CGFloat           = 6
    var eachItemWidth          : CGFloat           = 88
    var cornerRadius           : CGFloat           = 0
    var paddingX               : CGFloat           = 0
    var paddingY               : CGFloat           = 0
    var numberOfLines          : Int               = 3
    var isAnimatable           : Bool              = true
    var isGradient             : Bool              = true
    var isSizeConsiderable     : Bool              = false
    var isMaskSizeConsiderable : Bool              = false
    var styleType              : SkeletonStyleType = .fill
    var backGroundColor                         = UIColor(hexString: "#B8B8B8").alpha(0.3)
    var slidingColor                            = UIColor(hexString: "#D3D3D3").alpha(0.3)
    var maskBackGroundColor : UIColor           = UIColor.white
    var edgeInset: UIEdgeInsets                 = .zero
    var isHeightConsiderable : Bool =  false
    var isTopAnchor          : Bool =  false
    var isBottomAnchor       : Bool =  false
    var isAutoText           : Bool =  true
    var lineHeight             : CGFloat           = 6
    var lineGap                : CGFloat           = 10
    var isLastLineAdjustable   : Bool              = false
    var lastLinePercentage     : CGFloat           = 0.74
    var isFirstLineAdjustable  : Bool              = false
    var firstLinePercentage    : CGFloat           = 0.68


}

public enum SkeletonStyle {
    case gridSquare
    case gridCircle
    case listWithSquareImg
    case listWithCircularImage
}

public enum SkeletonStyleType {
    case fill
    case lines
}


public class SkeletonHelper {
    
    static func createGradientLayer(on frame : CGRect, backgroundColor: UIColor, slidingColor: UIColor) -> CAGradientLayer {
        
        let grdLayer        = CAGradientLayer()
        grdLayer.frame      = frame
        grdLayer.startPoint = CGPoint(x : 0, y : 0.5)
        grdLayer.endPoint   = CGPoint(x   : 1.0, y   : 0.5)
        grdLayer.locations  = [0.25, 0.5, 0.75, 1.0]
        grdLayer.colors     = [backgroundColor.cgColor, slidingColor.cgColor, backgroundColor.cgColor]

        return grdLayer
    }
    
    static func createNormalLayer(on frame : CGRect, color: UIColor) -> CALayer {
        let grdLayer = CALayer()
        grdLayer.frame = frame
        grdLayer.backgroundColor = color.cgColor
        return grdLayer
    }

    
    static func addBoxes(width: CGFloat, height : CGFloat, paddingX :CGFloat, paddingY :CGFloat ,frame : UIBezierPath, cornerRadius: CGFloat){
        
        let boxFr = UIBezierPath(roundedRect: CGRect(x: (0 + paddingX), y: (0 + paddingY), width: (width), height: (height)), cornerRadius: cornerRadius)
        
        frame.append(boxFr)
    }
    
    static func addBoxes(width: CGFloat, height : CGFloat, paddingX :CGFloat, paddingY :CGFloat,offset: UIEdgeInsets ,frame : UIBezierPath, cornerRadius: CGFloat){
        
        let boxFr = UIBezierPath(roundedRect: CGRect(x: (0 + paddingX + offset.left), y: (0 + paddingY + offset.top), width: (width - offset.right), height: (height - offset.bottom)), cornerRadius: cornerRadius)
        
        frame.append(boxFr)
    }

    static func addLines(numberOfLines: Int,x : CGFloat,lineGap : CGFloat, paddingX :CGFloat, paddingY :CGFloat, offset : UIEdgeInsets,width: CGFloat,height : CGFloat,isLastLineAdjustable: Bool,lastLinePercentage: CGFloat, isFirstLineAdjustable: Bool,firstLinePercentage: CGFloat,frame : UIBezierPath,cornerRadius: CGFloat) {
        
        
        if isLastLineAdjustable {
            let lastLine   = numberOfLines > 1 ? (numberOfLines - 1) : -1
            let percentage = lastLinePercentage >= 1 ? 1 : lastLinePercentage <= 0 ? 0 : lastLinePercentage
            
            for i in 0..<numberOfLines {
                let y = i == 0 ? 0 : ((height + lineGap) * CGFloat(i))

                if i == lastLine {
                    let lineFr = UIBezierPath(roundedRect: CGRect(x: (x + paddingX + offset.left), y: (y + paddingY + offset.top), width: (width * percentage), height: (height - offset.bottom)), cornerRadius: cornerRadius)
                    frame.append(lineFr)
                }else {
                    let lineFr = UIBezierPath(roundedRect: CGRect(x: (x + paddingX + offset.left), y: (y + paddingY + offset.top), width: (width - offset.right), height: (height - offset.bottom)), cornerRadius: cornerRadius)
                    frame.append(lineFr)

                }
                
            }
        }else if isFirstLineAdjustable {
            let percentage = firstLinePercentage >= 1 ? 1 : firstLinePercentage <= 0 ? 0 : firstLinePercentage
            
            for i in 0..<numberOfLines {
                let y = i == 0 ? 0 : ((height + lineGap) * CGFloat(i))
                
                if i == 0 {
                    let lineFr = UIBezierPath(roundedRect: CGRect(x: (x + paddingX + offset.left), y: (y + paddingY + offset.top), width: (width * percentage), height: (height - offset.bottom)), cornerRadius: cornerRadius)
                    frame.append(lineFr)
                }else {
                    let lineFr = UIBezierPath(roundedRect: CGRect(x: (x + paddingX + offset.left), y: (y + paddingY + offset.top), width: (width - offset.right), height: (height - offset.bottom)), cornerRadius: cornerRadius)
                    frame.append(lineFr)
                    
                }
                
            }
        }else {
            for i in 0..<numberOfLines {
                let y = i == 0 ? 0 : ((height + lineGap) * CGFloat(i))
                //let lineFr = UIBezierPath(roundedRect: CGRect(x: x, y: CGFloat(y), width: width, height: height),cornerRadius: cornerRadius)

                let lineFr = UIBezierPath(roundedRect: CGRect(x: (x + paddingX + offset.left), y: (y + paddingY + offset.top), width: (width - offset.right), height: (height - offset.bottom)), cornerRadius: cornerRadius)
                frame.append(lineFr)

            }

        }
        
        
    }
    
    static func addCircle(x : CGFloat,offset : CGFloat,widthHeight : CGFloat,frame : UIBezierPath){
        let boxFr = UIBezierPath(roundedRect: CGRect(x: x, y: 10 + offset, width: widthHeight, height: widthHeight),cornerRadius: widthHeight/2)
        frame.append(boxFr)
    }
    

}
