//
//  DataSendLater.swift
//  Offline-First-App-Seeder-Project
//
//  Created by Meera Mohandas on 08/05/23.
//

import Foundation

public class DataSendLater : NSObject {
    private var saves: NSMutableDictionary!
    private var savesChanged = false
    private var savesCreated = false
    private let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as              NSString).appendingPathComponent("DataSendLaters")
    public var saveImmediately = false
    public class var sharedManager : DataSendLater {
        struct Static {
            static let instance : DataSendLater = DataSendLater()
        }
        
        Static.instance.initializeSaves()
        return Static.instance
    }
    
//MARK: - Function to initilize the saves data
    private func initializeSaves() {
        if !savesCreated {
            let fileManager = FileManager.default
            if !fileManager.fileExists(atPath: path) {
                saves = NSMutableDictionary()
            } else {
                saves = NSMutableDictionary(contentsOfFile: path)
            }
            savesCreated = true
        }
    }
    
//MARK: - Function to save data for later use
    
    public func saveForLater(url:String, params:[String:Any]){
        if let list = saves.object(forKey: url) as? NSMutableArray{
            list.add(params)
        } else{
            saves.setObject(NSMutableArray(array: [params]), forKey: url as NSCopying)
        }
        setSavesChanged()
    }
    
//MARK: - Synchronize the data that is saved
    public func synchronizeSaves(){
        if savesChanged {
            savesChanged = !saves.write(toFile: path, atomically: true)
        }
    }
    
//MARK: - Function to retrieve saved data associated with the URL
    public func getSavesForUrl(url:String, delete:Bool) -> [[String:AnyObject]]?{
        return (saves.object(forKey: url) as AnyObject).copy() as? [[String:AnyObject]]
    }
    
//MARK: - Function to get all the saved data
    public func getAllSaves() -> NSDictionary {
        return saves
    }
    
    public func removeFromSaves(url:String, params:[String:Any]){
        if let array = saves.object(forKey: url) as? NSMutableArray{
            array.remove(params)
            setSavesChanged()
        }
    }
    
//MARK: - Function to mark that the saves have been changed
    func setSavesChanged(){
        savesChanged = true
        if saveImmediately{
            synchronizeSaves()
        }
    }
}

