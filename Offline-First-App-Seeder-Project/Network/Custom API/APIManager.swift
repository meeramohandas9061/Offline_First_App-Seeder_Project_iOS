//
//  APIManager.swift
//  Offline-First-App-Seeder-Project
//
//  Created by Meera Mohandas on 08/05/23.
//

import Foundation
import UIKit

public typealias WebAPICompletionHandler = (Bool, Data?, Error?) -> (Void)
public typealias WebAPICompletionHandlerWithResponse = (Bool, Data?, Error?, HTTPURLResponse?) -> (Void)
public typealias Json = [String: Any]

enum HTTPMethod : String
{
    case GET    = "GET"
    case POST   = "POST"
    case PUT    = "PUT"
    case DELETE = "DELETE"
    case PATCH  = "PATCH"
}

// MARK:- Properties
@objc public class APIManager: NSObject {
    
    // Singleton instance
    @objc public static let shared = APIManager()
    // URL session object for calling web-services
    fileprivate var urlSession : URLSession
    //HTTP Headers
    let strApplicationJson = "application/json"
    //HTTP Headers
    let strContentType = "Content-Type"
    //Set authorization
    let strAuthorization = "Authorization"

    // Default initializers
    override init() {
        // Configuring NSURLSession
        let urlSessionConfig                            = URLSessionConfiguration.default
        urlSessionConfig.timeoutIntervalForRequest      = 120.0
        urlSessionConfig.httpMaximumConnectionsPerHost  = 5
        urlSessionConfig.requestCachePolicy             = .reloadIgnoringLocalAndRemoteCacheData
        urlSession                                      = URLSession(configuration: urlSessionConfig)
        
        super.init()
    }
    
}

//MARK: - Setup headers, methods, request for Network calls

extension APIManager {
    
    func getComments(id: String, completion: @escaping WebAPICompletionHandler) {
        print("params",id)
        let url            = APIURL.getComments(id).url
        var request        = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        request.setValue(strApplicationJson, forHTTPHeaderField: strContentType)
        request.allHTTPHeaderFields = NetworkManager.shared.getHeader()
        callWebService(withRequest: request, andCompletionHandler: completion)
    }
 

}

extension APIManager {
    
    //Configuring WebService
    fileprivate func callWebService(withRequest request : URLRequest, andCompletionHandler completionHandler : @escaping WebAPICompletionHandler) {
        // Create a data task with the request
        let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
            
            var newRequest = request
            let httpResponse = response as? HTTPURLResponse
            // Check the response status code
            let success      = httpResponse != nil ? (httpResponse!.statusCode >= 200 && httpResponse!.statusCode < 300) : false
            if !success {
                //CAN USE LATER
                //CheckTokenExpiredOrNot
//                if !SSTokenManager.shared.evaluateTokenExpiryAutoRenewal(data: data) {
//                    completionHandler(success, data, error)
//                }else {
//                    SSTokenManager.shared.refreshTokenAutoRenewal { (isSucceeded) in
//                        if isSucceeded {
//                            newRequest.allHTTPHeaderFields = NetworkManager.shared.getHeader()
//                            self.callWebService(withRequest: newRequest, andCompletionHandler: completionHandler)
//                        }else {
//                            completionHandler(success, data, error)
//                        }
//                    }
//                }
            }else {
                completionHandler(success, data, error)
            }
        }
        dataTask.resume()
    }
    
    func dataFromJSON(json : Any) -> Data? {
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
            return data
        }
        catch _
        {
            return nil
        }
    }
    
//    fileprivate func setCommonHTTPHeaders(request : URLRequest) -> URLRequest {
//        var request = request
//        request.setValue(strApplicationJson, forHTTPHeaderField: strContentType)
//        let header = KeyChainManager.load(key: KeyChainManager.Keys(rawValue: "token")) ?? ""
//        request.setValue(header, forHTTPHeaderField: strAuthorization)
//        return request
//    }
}

extension APIManager {
    /*
     FOR UPLOADING IMAGES
    func uploadImage(imageData: Data, imageName: String = "ProfileImage", completion : @escaping WebAPICompletionHandler) {
        
        let url            = APIURL.profileImage.url
        var request        = URLRequest(url: url)
        request.httpMethod = HTTPMethod.POST.rawValue
        let boundary = generateBoundaryString()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let filename = "\(imageName).jpg"
        let mimetype = "image/jpg"
        let filePathKey = "file"
        
        let body = NSMutableData()
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageData)
        body.appendString(string: "\r\n")
        body.appendString(string: "--\(boundary)--\r\n")
        request.httpBody = body as Data
        request.allHTTPHeaderFields = NetworkManager.shared.getHeader()

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error!)")
                completion(false, data, error)
                return
            }
            
            //print response
//            print("response = \(response!)")
            
            // print reponse body
            let responseString = String(data: data!, encoding: .utf8)
//            print("response data = \(responseString!)")
            let httpResponse = response as? HTTPURLResponse
            let success      = httpResponse != nil ? (httpResponse!.statusCode >= 200 && httpResponse!.statusCode < 300) : false
            
            completion(success, data, error)
        }
        
        task.resume()
    }
    */
    private func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
}

extension NSMutableData {
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
