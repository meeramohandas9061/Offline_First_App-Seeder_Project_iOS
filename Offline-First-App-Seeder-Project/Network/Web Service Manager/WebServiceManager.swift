//
//  WebServiceManager.swift
//  Offline-First-App-Seeder-Project
//
//  Created by Meera Mohandas on 08/05/23.
//

import Foundation

/// Response cases
enum WebServiceResponseType {
    case success
    case error(String)
    case failure(Error)
}

//Webservice status
enum WebServiceStatusType: String {
    case success = "SUCCESS"
    case failed = "FAILED"
}

/// Response cases
enum ViewModelResponseType {
    case success
    case error(String)
    case failure(String)
}

//Error codes
enum ErrorCodeType: String {
    case notFound = "NOT_FOUND"
    case serverError = "INTERNAL_SERVER_ERROR"
    case code = "code"
    case constraintViolation = "constraint-violation"
}

typealias Parameter = [String: Any]

class WebServiceManager {
    /// shared instance
    static let shared = WebServiceManager()
    /// intialise privately
    private init(){}

    
  
    
    
  

    
}

