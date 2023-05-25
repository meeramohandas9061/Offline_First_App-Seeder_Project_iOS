//
//  ViewController.swift
//  Offline-First-App-Seeder-Project
//
//  Created by Meera Mohandas on 27/04/23.
//

import UIKit
import Foundation
import Network

class CommentListingVC: BaseVC, NetworkStatusDelegate {

    
    @IBOutlet weak var tblUserList: UITableView!
    @IBOutlet weak var txtCommenterName: UITextField!
    @IBOutlet weak var txtComment: UITextField!
    @IBOutlet weak var btnPostComment: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    let db = DBManager()
    let reachability = try! Reachability()
    var viewModel = CommentsVM()
    var commentsArray = [CommentListM]()
    var commenterName = ""
    var comment = ""
    var networkStatus: networkStatus = .cellular
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblUserList.delegate = self
        tblUserList.dataSource = self
        btnDelete.isEnabled = false
        ConnectionManager.sharedInstance.delegate = self
        dataSyncOnOfflineAndOnline()
    }
    
    func dataSyncOnOfflineAndOnline () {
        if Defaults.shared.networkStatus() == "noNetwork" {
            commentsArray = db.read()
            let initialCommentArray = commentsArray
            for data in initialCommentArray {
                // Insert data into table
                self.db.insert(username: data.username, comment: data.comment, creation_date: data.creation_date)
            }
        }
        else {
            getCommentsLists { [weak self] (commentsArray) in
                self?.commentsArray = commentsArray
                let initialCommentArray = commentsArray
                for data in initialCommentArray {
                    // Insert data into table
                    self?.db.insert(username: data.username, comment: data.comment, creation_date: data.creation_date)
                }
 
            }
            syncAction()
        }
        // Reload the table view using the main dispatch queue
        DispatchQueue.main.async {
            self.tblUserList.reloadData()
        }
    }
    
    //Delegate to check for network connection
    func networkStatusDidChange(status: Reachability.Connection) {
        if status == .cellular || status == .wifi {
            syncAction()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        dataSyncOnOfflineAndOnline()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Close the database connection
        db.closeDBConnection()
    }
    
    //Clear entered data in textfield after posting the comment
    func clearPreviousData() {
        comment = ""
        commenterName = ""
        txtComment.text = ""
        txtCommenterName.text = ""
    }
    
    //Post comments
    @IBAction func btnPostAction(_ sender: UIButton) {
        if !(comment.isEmpty && commenterName.isEmpty) {
            postComments(itemId: "52995", comment: comment, commenterName: commenterName)
            clearPreviousData()
        } else {
            clearPreviousData()
            showAlert(withTitle: "Input Validation failed", message: "Fields cannot be empty!")
        }
    }
    
    //Not using now
    @IBAction func btnDeleteAction(_ sender: UIButton) {
        db.deleteTableItems()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.tblUserList.reloadData()
        }
    }
    
    //Enter comment text
    @IBAction func txtCommentAction(_ sender: UITextField) {
        comment = txtComment.text ?? ""
    }
    
    //Enter comment's name
    @IBAction func txtCommenterNameAction(_ sender: UITextField) {
        commenterName = txtCommenterName.text ?? ""
    }
    
}

//MARK: - Tableview delegates
extension CommentListingVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblUserList.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        cell.lblDetails.text = commentsArray[indexPath.row].comment + " \(commentsArray[indexPath.row].username)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}


//MARK: - Network Services


extension CommentListingVC {
    
    func getCommentsLists(completionHandler: @escaping ([CommentListM]) -> Void) {
        showLoader()
        let url = URL(string: "https://us-central1-involvement-api.cloudfunctions.net/capstoneApi/apps/YDk6ZvYJ9bRgBt60cLN9/comments?item_id=52995")!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching films: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            if let data = data,
               let filmSummary = try? JSONDecoder().decode([CommentListM].self, from: data) {
                completionHandler(filmSummary)
                self.commentsArray = filmSummary
            }
            self.hideLoader()
            DispatchQueue.main.async {
                self.tblUserList.reloadData()
            }
            
        })
        task.resume()
    }
    
    func postComments(itemId: String, comment: String, commenterName: String ) {
        // prepare json data
        let json: [String: Any] = ["item_id": itemId, "username": commenterName, "comment" : comment ]
        print("post comment params", json)
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        let url = URL(string: "https://us-central1-involvement-api.cloudfunctions.net/capstoneApi/apps/YDk6ZvYJ9bRgBt60cLN9/comments")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                let url = "https://us-central1-involvement-api.cloudfunctions.net/capstoneApi/apps/YDk6ZvYJ9bRgBt60cLN9/comments"
                DataSendLater.sharedManager.saveForLater(url: url, params: json)
                DataSendLater.sharedManager.synchronizeSaves()
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print("post data response", responseJSON)
            }
            self.getCommentsLists { [weak self] (commentsArray) in
                self?.commentsArray = commentsArray
                let initialCommentArray = commentsArray
                for data in initialCommentArray {
                    self?.db.insert(username: data.username, comment: data.comment, creation_date: data.creation_date)
                }
                // Reload the table view using the main dispatch queue
                DispatchQueue.main.async {
                    self?.tblUserList.reloadData()
                }
            }
        }
        task.resume()
    }
    
    
    func syncAction() {
        for (url, parameters) in DataSendLater.sharedManager.getAllSaves(){
            if let urlString = url as? String, let URLType = URL(string: urlString) {
                if let params = parameters as? [[String: Any]]{
                    for param in params{
                        var json: [String:Any] = [:]
                        json = param
                        let jsonData = try? JSONSerialization.data(withJSONObject: json)
                        
                        // create post request
                        let url = URL(string: "https://us-central1-involvement-api.cloudfunctions.net/capstoneApi/apps/YDk6ZvYJ9bRgBt60cLN9/comments")!
                        var request = URLRequest(url: url)
                        request.httpMethod = "POST"
                        
                        //HTTP Headers
                        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                        
                        // insert json data to the request
                        request.httpBody = jsonData
                        
                        let task = URLSession.shared.dataTask(with: request) { data, response, error in
                            guard let data = data, error == nil else {
                                print(error?.localizedDescription ?? "No data")
                                return
                            }
                            //Remove saved data
                            DataSendLater.sharedManager.removeFromSaves(url: urlString, params: param)
                            //Synchronize the changes
                            DataSendLater.sharedManager.synchronizeSaves()
                            print("data", data)
                            let responseJSON = String(data: data, encoding: .utf8)
                            if let responseJSON = responseJSON  {
                                print("post data response", responseJSON)
                                    DataSendLater.sharedManager.removeFromSaves(url: urlString, params: param)
                                    DataSendLater.sharedManager.synchronizeSaves()
                                    print("post data response", responseJSON)
                                //Call getCommentsLists to show the updated data in tableView
                                self.getCommentsLists { [weak self] (commentsArray) in
                                    self?.commentsArray = commentsArray
                                    let initialCommentArray = commentsArray
                                    for data in initialCommentArray {
                                        //Insert data into table
                                        self?.db.insert(username: data.username, comment: data.comment, creation_date: data.creation_date)
                                    }
                                    // Reload the table view using the main dispatch queue
                                    DispatchQueue.main.async {
                                        self?.tblUserList.reloadData()
                                    }
                                }
                            }
                        }
                        
                        task.resume()

                    }
                }
            }
            
        }
        
    }
}
