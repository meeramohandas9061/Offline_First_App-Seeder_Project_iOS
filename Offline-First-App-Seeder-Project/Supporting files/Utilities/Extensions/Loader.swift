//
//  Loader.swift
//  Offline-First-App-Seeder-Project
//
//  Created by Meera Mohandas on 25/05/23.
//

import Foundation
import UIKit

class LoaderManager {
    static let shared = LoaderManager()
    var isLoaderShowing: Bool = false
}

class Loader {
    private var activityIndicator = UIActivityIndicatorView()
    private let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    private var bgView: UIView = UIView()
    
    ///Show loader
    /// - Parameters: view of type `UIView`
    func showLoader(view: UIView) {
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        bgView.removeFromSuperview()
        effectView.frame = CGRect(x: view.frame.midX - 35, y: view.frame.midY - 35 , width: 70, height: 70)
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
//        activityIndicator.color = UIColor.blue
        activityIndicator.frame = CGRect(x: 16.5, y: 16.5, width: 37, height: 37)
        activityIndicator.startAnimating()
        bgView.frame = view.frame
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        effectView.contentView.addSubview(activityIndicator)
        bgView.addSubview(effectView)
        view.addSubview(bgView)
        LoaderManager.shared.isLoaderShowing = true
    }
    
    /// hide indicator
    func hideLoader() {
        DispatchQueue.main.async {
            self.effectView.removeFromSuperview()
            self.activityIndicator.removeFromSuperview()
            self.bgView.removeFromSuperview()
            LoaderManager.shared.isLoaderShowing = false
        }
    }
    
}
