//
//  Defaults.swift
//  Offline-First-App-Seeder-Project
//
//  Created by Meera Mohandas on 10/05/23.
//

import Foundation
import UIKit

class Defaults {
    static var shared = Defaults()
    let defaults = UserDefaults.standard
    private init(){}
    
}

//MARK: - Keys
extension Defaults {
    enum Keys: String {
        case networkStatus     = "NetworkStatus"
    }
    
}

//MARK: - get the value
extension Defaults {
    
    func initialize() {
        
    }
    
    //Clear values
    func clear() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    //Get the values
    func getValue(forKey: Keys) -> String {
        if let value = defaults.value(forKey: forKey.rawValue) as? String {
            return value
        }else {
            return ""
        }
    }
    
    //Set the string values
    func setValue(_ item: String, forKey: Keys) {
        defaults.set(item, forKey: forKey.rawValue)
    }
    
    //Set boolean values
    func setValue(_ item: Bool, forKey: Keys) {
        defaults.set(item, forKey: forKey.rawValue)
    }
    
    //Get values for the respective key
    func getValue(forKey: Keys) -> Bool {
        if let value = defaults.value(forKey: forKey.rawValue) as? Bool {
            return value
        }else {
            return false
        }
    }
    
    //Remove the value for the respective key
    func removeValue(forKey: Keys) {
        defaults.removeObject(forKey: forKey.rawValue)
    }
    
    //Function to get the network status when any changes occurs
    func networkStatus() -> String? {
        if let value = defaults.value(forKey: Keys.networkStatus.rawValue) as? String {
            return value
        }else {
            return nil
        }
    }
}

