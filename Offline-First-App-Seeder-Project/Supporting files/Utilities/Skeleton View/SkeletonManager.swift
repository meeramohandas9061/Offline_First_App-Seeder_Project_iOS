//
//  SkeletonManager.swift
//  Offline-First-App-Seeder-Project
//
//  Created by Meera Mohandas on 25/05/23.
//

import Foundation
import UIKit

extension UIView {
    
    private struct SkeletonKeys {
        static var key           = "skeletonKey"
        static var textKey       = "skeletonTextKey"
        static var textColorKey  = "skeletonTextColorKey"

    }

    var skeleton: SkeletonView? {
        get { (objc_getAssociatedObject(self, &SkeletonKeys.key) as? SkeletonView) }
        
        set { objc_setAssociatedObject(self, &SkeletonKeys.key, newValue, .OBJC_ASSOCIATION_RETAIN) }
    }
    var tempText: String? {
        get { (objc_getAssociatedObject(self, &SkeletonKeys.textKey) as? String) }
        
        set { objc_setAssociatedObject(self, &SkeletonKeys.textKey, newValue, .OBJC_ASSOCIATION_RETAIN) }
    }
    
    var tempTextColor: UIColor? {
        get { (objc_getAssociatedObject(self, &SkeletonKeys.textColorKey) as? UIColor) ?? .clear }
        
        set { objc_setAssociatedObject(self, &SkeletonKeys.textColorKey, newValue, .OBJC_ASSOCIATION_RETAIN) }
    }

    func loadSkeleton(config: SkeletonConfiguration? = nil, style: SkeletonStyleType = .fill, isAutoText: Bool = false) {
        if self.isKind(of: UILabel.self) {
            self.tempTextColor           = (self as! UILabel).textColor
            (self as! UILabel).textColor = .clear
        }
        if self.isKind(of: UIButton.self) {
            self.tempTextColor           = (self as! UIButton).titleColor(for: [])
            (self as! UIButton).setTitleColor(.clear, for: [])
        }
        
        self.layoutIfNeeded()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
            if let config = config {
                let skeletonView = self.skeleton == nil ? SkeletonView(on: self, style: style) : self.skeleton!
                
                if config.isSizeConsiderable {
                    skeletonView.paddingX               = config.paddingX
                    skeletonView.paddingY               = config.paddingY
                    skeletonView.isGradient             = config.isGradient
                    skeletonView.isAnimatable           = config.isAnimatable
                    skeletonView.cornerRadius           = config.cornerRadius
                    skeletonView.numberOfLines          = config.numberOfLines
                    skeletonView.eachItemWidth          = config.eachItemWidth
                    skeletonView.gradientSpeed          = config.gradientSpeed
                    skeletonView.eachItemHeight         = config.eachItemHeight
                    skeletonView.backGroundColor        = config.backGroundColor
                    skeletonView.slidingColor           = config.slidingColor
                    skeletonView.transitionSpeedStart   = config.transitionSpeedStart
                    skeletonView.transitionSpeedDismiss = config.transitionSpeedDismiss
                    skeletonView.isAnimatableDismiss    = config.isAnimatableDismiss
                    skeletonView.maskBackGroundColor    = config.maskBackGroundColor
                    skeletonView.edgeInset              = config.edgeInset
                    skeletonView.isSizeConsiderable     = config.isSizeConsiderable
                    skeletonView.isAutoText             = true
                    skeletonView.lineHeight             = config.lineHeight
                    skeletonView.lineGap                = config.lineGap
                    skeletonView.isLastLineAdjustable   = config.isLastLineAdjustable
                    skeletonView.lastLinePercentage     = config.lastLinePercentage
                    skeletonView.isFirstLineAdjustable  = config.isFirstLineAdjustable
                    skeletonView.firstLinePercentage    = config.firstLinePercentage

                    if config.isHeightConsiderable {
                        var edge = config.edgeInset
                        if config.isBottomAnchor {
                            edge.top = self.frame.height - config.eachItemHeight
                        }
                        if config.isTopAnchor {
                            edge.bottom = self.frame.height - config.eachItemHeight
                        }
                        skeletonView.edgeInset = edge
                        skeletonView.isHeightConsiderable = config.isHeightConsiderable
                    }

                }else {
                    skeletonView.eachItemHeight         = self.frame.height
                    skeletonView.eachItemWidth          = self.frame.width
                    skeletonView.paddingX               = config.paddingX
                    skeletonView.paddingY               = config.paddingY
                    skeletonView.isGradient             = config.isGradient
                    skeletonView.isAnimatable           = config.isAnimatable
                    skeletonView.cornerRadius           = config.cornerRadius
                    skeletonView.numberOfLines          = config.numberOfLines
                    skeletonView.gradientSpeed          = config.gradientSpeed
                    skeletonView.backGroundColor        = config.backGroundColor
                    skeletonView.slidingColor           = config.slidingColor
                    skeletonView.transitionSpeedStart   = config.transitionSpeedStart
                    skeletonView.transitionSpeedDismiss = config.transitionSpeedDismiss
                    skeletonView.isAnimatableDismiss    = config.isAnimatableDismiss
                    skeletonView.maskBackGroundColor    = config.maskBackGroundColor
                    skeletonView.edgeInset              = config.edgeInset
                    skeletonView.isSizeConsiderable     = config.isSizeConsiderable
                    skeletonView.isAutoText             = isAutoText
                    skeletonView.lineHeight             = config.lineHeight
                    skeletonView.lineGap                = config.lineGap
                    skeletonView.isLastLineAdjustable   = config.isLastLineAdjustable
                    skeletonView.lastLinePercentage     = config.lastLinePercentage
                    skeletonView.isFirstLineAdjustable  = config.isFirstLineAdjustable
                    skeletonView.firstLinePercentage    = config.firstLinePercentage

                    if config.isHeightConsiderable {
                        var edge = config.edgeInset
                        if config.isBottomAnchor {
                            edge.top = self.frame.height - config.eachItemHeight
                        }
                        if config.isTopAnchor {
                            edge.bottom = self.frame.height - config.eachItemHeight
                        }
                        skeletonView.edgeInset = edge
                        skeletonView.isHeightConsiderable = config.isHeightConsiderable
                    }
                
                    
                }
                
                self.skeleton                        = skeletonView

            }else {
                let skeletonView                     = SkeletonView(on : self, style : style)
                skeletonView.eachItemHeight          = self.frame.height
                skeletonView.eachItemWidth           = self.frame.width
                skeletonView.isAutoText              = isAutoText
                self.skeleton                        = skeletonView
                
            }
            
        }
        
    }

    func showSkeleton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
            self.skeleton?.startAnimating()
            self.isUserInteractionEnabled = false
        }
    }
    
    func hideSkeleton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.skeleton?.stopAnimating()
            self.isUserInteractionEnabled = true
            
            if self.isKind(of: UILabel.self) {
                (self as! UILabel).textColor = self.tempTextColor
            }
            if self.isKind(of: UIButton.self) {
                (self as! UIButton).setTitleColor(self.tempTextColor, for: [])
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.02 + (self.skeleton?.transitionSpeedDismiss ?? 0.2)) {
                self.skeleton = nil
            }
            
        }
    }
    
    func loadSkeletonWithSubviews() {
        layoutIfNeeded()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
            self.loadSkeleton()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
                for item in self.subviews {
                    item.loadSkeleton()
                }
            }
        }
    }
    
    func showSkeletonWithSubviews() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
            self.showSkeleton()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
                for item in self.subviews {
                    item.showSkeleton()
                }
                
            }
            
        }
    }
    
    func hideSkeletonWithSubviews() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            for item in self.subviews {
                item.hideSkeleton()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                self.hideSkeleton()
                
            }
        }
    }
    

}
