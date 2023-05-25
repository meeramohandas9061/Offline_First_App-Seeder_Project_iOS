//
//  AppDelegate.swift
//  Offline-First-App-Seeder-Project
//
//  Created by Meera Mohandas on 27/04/23.
//

import UIKit
import AVFoundation
import IQKeyboardManagerSwift
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var nav: UINavigationController?
    let db = DBManager()
    var classInstance = CommentListingVC()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ConnectionManager.sharedInstance.observeReachability()
        setUpInterfaceStyle()
        setupKeyboardManager()
        setRootViewController()
        
        return true
    }
    
    //MARK: - Setup interface style
    func setUpInterfaceStyle() {
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
            UIWindow.appearance().overrideUserInterfaceStyle = .light
            UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).overrideUserInterfaceStyle = .light
        }
    }
    
    //MARK: - Setup Root viewcontroller
    func setRootViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootScreen = storyboard.instantiateViewController(withIdentifier: "CommentListingVC") as! CommentListingVC
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = rootScreen
    }
    
    //MARK: - CREATE DATABASE AND TABLE
    func applicationDidBecomeActive(_ application: UIApplication) {
        let db = DBManager()
        db.createDB()
        db.createTable()
    }
    
    //MARK: - setup keybord manager
    func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.previousNextDisplayMode = .default
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 25
    }
    
    
    //MARK: - CoreData
    
    lazy var persistentContainer: NSPersistentContainer = {
            /*
             The persistent container for the application. This implementation
             creates and returns a container, having loaded the store for the
             application to it. This property is optional since there are legitimate
             error conditions that could cause the creation of the store to fail.
             */
        let container = NSPersistentContainer(name: "CoreDataModel")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
        
        // MARK: - Core Data Saving support
        
        func saveContext () {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }

}

