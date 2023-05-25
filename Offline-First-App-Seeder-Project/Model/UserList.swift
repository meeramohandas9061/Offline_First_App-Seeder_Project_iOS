//
//  UserList.swift
//  Offline-First-App-Seeder-Project
//
//  Created by Meera Mohandas on 02/05/23.
//

import Foundation

class UserList: Codable {
    var id: Int {
        didSet {
            print("id")
        }
    }
    var firstName: String
    var lastName: String
    var age: Int
    
    init(id: Int, firstName: String, lastName: String, age: Int) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
}

class CommentListM: Codable {
    var comment: String
    
    var creation_date: String
    var username: String
   
    
    init(comment: String, creation_date: String, username: String) {
        self.comment = comment
        self.creation_date = creation_date
        self.username = username
    }
}
