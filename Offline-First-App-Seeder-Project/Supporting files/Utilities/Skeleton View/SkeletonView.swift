//
//  SkeletonView.swift
//  Offline-First-App-Seeder-Project
//
//  Created by Meera Mohandas on 25/05/23.
//

import Foundation
import UIKit


public class SkeletonView: NSObject {
    
    private var onView                             = UIView()
    private var skeletonView                       = UIView()
    private var maximumGridItems   : Int           = 1
    private var numOfList          : Int?
    private var gapOfList          : CGFloat       = 0

    public var gapBackgroundColor : UIColor        = UIColor(0xecf0f1)
    public var numberOfLines      : Int            = 3
    public var gradientSpeed      : CFTimeInterval = 1.5
    public var transitionSpeedStart      : CFTimeInterval = 0.2
    public var transitionSpeedDismiss      : CFTimeInterval = 0.2

    public var isAnimatableDismiss: Bool           = true
    public var eachItemHeight     : CGFloat        = 6
    public var eachItemWidth      : CGFloat        = 88
    public var cornerRadius       : CGFloat        = 0
    
    public var backGroundColor                     = UIColor(hexString: "#B8B8B8").alpha(0.3)
    public var slidingColor                        = UIColor(hexString: "#D3D3D3").alpha(0.3)
    
    public var maskBackGroundColor                 = UIColor.white
    public var edgeInset: UIEdgeInsets             = .zero
    public var paddingX            : CGFloat           = 0
    public var paddingY            : CGFloat           = 0

    public var isAnimatable           : Bool              = true
    public var isGradient             : Bool              = true
    public var styleType              : SkeletonStyleType = .fill
    public var isMaskSizeConsiderable : Bool              = false
    public var isSizeConsiderable     : Bool              = false
    public var isHeightConsiderable   : Bool              =  true
    public var isAutoText             : Bool              = true
    public var lineHeight             : CGFloat           = 6
    public var lineGap                : CGFloat           = 10
    public var isLastLineAdjustable   : Bool              = false
    public var lastLinePercentage     : CGFloat           = 0.74
    public var isFirstLineAdjustable  : Bool              = false
    public var firstLinePercentage    : CGFloat           = 0.68


    
    private var skStyle : SkeletonStyle {
        return .gridSquare
    }
    
    
    public init(on : UIView, style  : SkeletonStyleType) {
        onView    = on
        styleType = style
    }
    
    
    public func startAnimating(){
        onView.layoutIfNeeded()
        
        let viewHeight          = onView.frame.height
        let viewWidth           = onView.frame.width
        let itemHeight          = eachItemHeight
        let itemWidth           = eachItemWidth

        var numberOfItems : Int{
            return 1
        }
        
        
        if isMaskSizeConsiderable {
            skeletonView.frame = CGRect(x: 0, y: 0, width: itemWidth, height: itemHeight)
        }else {
            skeletonView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
        }
        
        let gradientFrame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
        let grd = SkeletonHelper.createGradientLayer(on: gradientFrame, backgroundColor: backGroundColor, slidingColor: slidingColor)

        skeletonView.layer.addSublayer(grd)
        
        if isAnimatable {
            grd.addGradAnimCustom(withDirection: .leftRight, duration: gradientSpeed)
        }

        let skeletonPath = UIBezierPath()
        
        for i in 0...numberOfItems {
            
            let offset = CGFloat(i) * itemHeight
            
            if skStyle == .listWithCircularImage || skStyle == .listWithSquareImg {
                if skStyle == .listWithCircularImage{
                    SkeletonHelper.addCircle(x: 10, offset: offset, widthHeight: eachItemWidth, frame: skeletonPath)
                }else{
//                    SkeletonHelper.addBoxes(x: 10, offset: offset, widthHeight: eachItemWidth, frame: skeletonPath, cornerRadius: cornerRadius)
                }
                var lines : CGFloat{
                    let max = (eachItemHeight-20)/20 + 1
                    if max < CGFloat(numberOfLines){
                        return max
                    }else{
                        return CGFloat(numberOfLines)
                    }
                }
                SkeletonHelper.addLines(numberOfLines: Int(numberOfLines), x: 0, lineGap: lineGap, paddingX: paddingX, paddingY: paddingY, offset: edgeInset, width: eachItemWidth, height: lineHeight,isLastLineAdjustable: isLastLineAdjustable,lastLinePercentage: lastLinePercentage,isFirstLineAdjustable: isFirstLineAdjustable,firstLinePercentage: firstLinePercentage, frame: skeletonPath, cornerRadius: cornerRadius)

            }else if skStyle == .gridCircle || skStyle == .gridSquare {
                
                if styleType == .fill {
                    
//                    SkeletonHelper.addBoxes(width: eachItemWidth, height: eachItemHeight, paddingX: paddingX, paddingY: paddingY, frame: skeletonPath, cornerRadius: cornerRadius)
                    
                    if isSizeConsiderable {
                        SkeletonHelper.addBoxes(width: eachItemWidth, height: eachItemHeight, paddingX: paddingX, paddingY: paddingY,offset: edgeInset,frame: skeletonPath, cornerRadius: cornerRadius)

                    }else {
                        
                        if isHeightConsiderable {
                            SkeletonHelper.addBoxes(width: viewWidth, height: eachItemHeight, paddingX: paddingX, paddingY: paddingY,offset: edgeInset,frame: skeletonPath, cornerRadius: cornerRadius)

                        }else {
                            SkeletonHelper.addBoxes(width: viewWidth, height: viewHeight, paddingX: paddingX, paddingY: paddingY,offset: edgeInset,frame: skeletonPath, cornerRadius: cornerRadius)

                        }

                    }


                }else {
                    SkeletonHelper.addLines(numberOfLines: Int(numberOfLines), x: 0, lineGap: lineGap, paddingX: paddingX, paddingY: paddingY, offset: edgeInset, width: eachItemWidth, height: lineHeight,isLastLineAdjustable: isLastLineAdjustable,lastLinePercentage: lastLinePercentage,isFirstLineAdjustable: isFirstLineAdjustable,firstLinePercentage: firstLinePercentage, frame: skeletonPath, cornerRadius: cornerRadius)

                }
                
            }
            
        }
        
        grd.addMask(with: .white, on: skeletonPath, of: skeletonView)

        skeletonView.backgroundColor    = maskBackGroundColor
        skeletonView.layer.cornerRadius = cornerRadius
        
        if !skeletonView.isDescendant(of: onView) {
            if isAnimatableDismiss{
                UIView.transition(with: self.onView, duration: transitionSpeedStart, options: [.transitionCrossDissolve], animations: {
                    self.onView.addSubview(self.skeletonView)
                }, completion: nil)
            }else{
                self.onView.addSubview(self.skeletonView)
            }
        }
        
    }
    
    public func stopAnimating(){
        if onView.isKind(of: UILabel.self), isAutoText {
            //(onView as! UILabel).text = onView.tempText
        }
        
        if skeletonView.isDescendant(of: onView) {
            if isAnimatableDismiss{
                UIView.transition(with: self.onView, duration: transitionSpeedDismiss, options: [.transitionCrossDissolve], animations: {
                    self.skeletonView.backgroundColor = .clear
                    self.skeletonView.alpha = 0
                }, completion: { (isCompleted) in
                    self.skeletonView.removeFromSuperview()
                    self.skeletonView = UIView()

                })
            }else{
                self.skeletonView.backgroundColor = .clear
                self.skeletonView.alpha = 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    self.skeletonView.removeFromSuperview()
                    self.skeletonView = UIView()

                }
            }
        }
    }
    
}
