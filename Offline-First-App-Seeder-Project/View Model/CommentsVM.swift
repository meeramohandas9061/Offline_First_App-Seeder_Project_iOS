//
//  CommentsVM.swift
//  Offline-First-App-Seeder-Project
//
//  Created by Meera Mohandas on 08/05/23.
//

import Foundation

class CommentsVM  {
    
    func getComments(id: String ,completion: @escaping(WebServiceResponseType, Any) -> Void) {
        
        APIManager.shared.getComments(id: id) { (isSucceeded, data, error) -> (Void) in
            if isSucceeded {
               
                    if let dataObject = getJSON(fromData: data ?? Data())  {
                        completion(.success, dataObject as! [Any] )
                        print(dataObject)
                    }else {
                        let errorMessage = "Errorrrrr"
                        completion(.error(errorMessage), ["Error"])
                    }
                
            }else {
             print("something went wrong")
            }
            
        }
    }
}
