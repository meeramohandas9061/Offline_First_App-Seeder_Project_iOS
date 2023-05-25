//
//  APIUrl.swift
//  Offline-First-App-Seeder-Project
//
//  Created by Meera Mohandas on 08/05/23.
//
//

import Foundation

enum APIURL {
    case getComments(String)
}

extension APIURL {
    var url: URL {
        
        let baseURL = "https://us-central1-involvement-api.cloudfunction.net/capstoneApi/apps/YDk6ZvYJ9bRgBt60cLN9/comments"
        var returnURL = ""
        /// this is to skip percentage encoding(queryallowed) for getAvailableSlotsForSP API
        var shouldSkipQueryAllowed: Bool = false
        
        switch self {
            
        case .getComments(let id):
            returnURL = baseURL + "?item_id=\(id)"
        }
        
        print("RequestURL::",returnURL)
        
        if shouldSkipQueryAllowed {
            shouldSkipQueryAllowed = false
            return URL(string: returnURL)!
        } else {
            return URL(string: returnURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        }
    }
}
