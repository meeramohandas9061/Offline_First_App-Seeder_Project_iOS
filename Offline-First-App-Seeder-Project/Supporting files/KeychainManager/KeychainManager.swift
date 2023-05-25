//
//  KeychainManager.swift
//  Offline-First-App-Seeder-Project
//
//  Created by Meera Mohandas on 03/05/23.
//

import Foundation

class KeyChainManager {
    
    enum Keys: String {
        case sampleData = "sampleData"
    }
    
    class func save(key: Keys, data: String) {
        let forKey = key.rawValue
        let dataString = data.data(using: .utf8)!
        
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : forKey,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock,
            kSecValueData as String   : dataString ] as [String : Any]
        
        let statusDelete = SecItemDelete(query as CFDictionary)
        if statusDelete == errSecSuccess
        {
            //            print("Deleted")
            
        }
        else
        {
            //            print("Not Deleted")
            
        }
        
        let statusAdd = SecItemAdd(query as CFDictionary, nil)
        if statusAdd == errSecSuccess
        {
            //            print("Added")
            
        }
        else
        {
            //            print("Not Added")
            
        }
        
        let fields: [String: Any] = [
            kSecAttrAccount as String: forKey,
            kSecValueData as String: dataString
        ]
        let status = SecItemUpdate(query as CFDictionary, fields as CFDictionary)
        if status == errSecSuccess
        {
            //            print("Updated")
            
        }
        else
        {
            //            print("Not Updated")
            
        }
    }
    
    class func clearKeychain() {
        let secItemClasses = [kSecClassGenericPassword, kSecClassInternetPassword, kSecClassCertificate, kSecClassKey, kSecClassIdentity]
        for itemClass in secItemClasses
        {
            let spec: NSDictionary = [kSecClass: itemClass]
            SecItemDelete(spec)
        }
    }
    
    class func load(key: Keys) -> String? {
        let forKey = key.rawValue
        
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : forKey,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]
        
        var dataTypeRef: AnyObject? = nil
        
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == noErr {
            if let data = dataTypeRef as? Data {
                let newString = String(data: data, encoding: .utf8)
                return newString
            }
            else{
                return nil
            }
        } else {
            return nil
        }
    }
    
    class func createUniqueID() -> String {
        let uuid: CFUUID = CFUUIDCreate(nil)
        let cfStr: CFString = CFUUIDCreateString(nil, uuid)
        
        let swiftString: String = cfStr as String
        return swiftString
    }
    
    class func initialize() {
        
    }
}

extension Data {
    
    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }
    
    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.load(as: T.self) }
    }
}
