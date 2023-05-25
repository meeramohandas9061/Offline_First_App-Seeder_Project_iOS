//
//  ConnectionManager.swift
//  Offline-First-App-Seeder-Project
//
//  Created by Meera Mohandas on 08/05/23.
//

import Foundation

//Protocol for network status
protocol NetworkStatusDelegate {
    func networkStatusDidChange(status: Reachability.Connection)
}

//Network status
enum networkStatus: String {
    case cellular = "cellular"
    case wifi = "wifi"
    case noConnection = "noConnection"
}

class ConnectionManager {
    
    //Singleton instance
    static let sharedInstance = ConnectionManager()
    private var reachability : Reachability!
    var delegate: NetworkStatusDelegate?
    var networkStatus: networkStatus = .cellular
    
//MARK: - Function to start monitoring reachability
    
    func observeReachability(){
        self.reachability = try! Reachability()
        NotificationCenter.default.addObserver(self, selector:#selector(self.reachabilityChanged), name: .reachabilityChanged, object: reachability)
        do {
            try self.reachability.startNotifier()
        }
        catch(let error) {
            print("Error occured while starting reachability notifications : \(error.localizedDescription)")
        }
    }
    
//MARK: - Called when reachability change
    
    @objc func reachabilityChanged(note: Notification) {
        
        if let reachability = note.object as? Reachability {
            delegate?.networkStatusDidChange(status: reachability.connection)
        }
        
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .cellular:
            networkStatus = .cellular
            Defaults.shared.setValue("cellular", forKey: .networkStatus)
            break
        case .wifi:
            networkStatus = .wifi
            Defaults.shared.setValue("wifi", forKey: .networkStatus)
            break
        case .unavailable:
            networkStatus = .noConnection
            Defaults.shared.setValue("noNetwork", forKey: .networkStatus)
            break
        }
    }
}
