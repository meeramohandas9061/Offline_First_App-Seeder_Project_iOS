//
//  BaseVC.swift
//  Offline-First-App-Seeder-Project
//
//  Created by Meera Mohandas on 03/05/23.
//

import Foundation
import UIKit

class BaseVC: UIViewController, UIGestureRecognizerDelegate {
    private static let sharedLoader = Loader()
    
    var isPresentedVC: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //enablePopGesture()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
    }
    
    //    func enablePopGesture(enable: Bool = false) {
    //        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = enable
    //    }
    
    /// Show loader
    func showLoader() {
        DispatchQueue.main.async {
            BaseVC.sharedLoader.showLoader(view: self.view)
        }
    }
    
    /// hide loader
    func hideLoader() {
        DispatchQueue.main.async {
            BaseVC.sharedLoader.hideLoader()
        }
    }
    
    
    func setupBackButton() {
        let backButton = UIBarButtonItem(image: UIImage(named: "Back"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(didTapBackButton))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    /// Back Action
    @objc func didTapBackButton() {
        //Pop view to previous view
        navigationController?.popViewController(animated: true)
    }
    
}
/// Storyboards
struct Storyboards {
    static let main    = UIStoryboard(name : "Main", bundle : Bundle.main)
}
