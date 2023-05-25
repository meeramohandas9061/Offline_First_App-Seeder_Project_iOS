//
//  NetworkManager.swift
//  Offline-First-App-Seeder-Project
//
//  Created by Meera Mohandas on 08/05/23.
//

import Foundation

class NetworkManager {
    static var shared = NetworkManager()
    /// Get header with secret key
    func getHeaderAuth() -> [String: String] {
        let header = ["HASURA_GRAPHQL_UNAUTHORIZED_ROLE": "GUEST"]
        return header
    }
    
    /// Get header with token key
    func getHeader() -> [String: String] {
//        let bearer = "Bearer " + (KeyChainManager.load(key: "token") ?? "")
//        print("BearerToken:",bearer)
//        let header = ["Authorization": bearer]
//        return header
        return [:]
    }
}

// Mark: - Supporting Methods
extension NetworkManager {
//To do
    
}
