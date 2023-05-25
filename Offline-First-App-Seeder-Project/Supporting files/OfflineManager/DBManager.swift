//
//  DBManager.swift
//  Offline-First-App-Seeder-Project
//
//  Created by Meera Mohandas on 04/05/23.
//

import Foundation
import SQLite3

class DBManager {
    
    // Singleton instance
    static let shared = DBManager()
    // Pointer to hold the database object
    var db : OpaquePointer?
    // Declares and initializes path
    var path : String = "myDataBaseName.sqlite"
    
    init() {
        self.db = createDB()
        self.createTable()
    }
    
// MARK: - Function to create a SQLite database
    
    func createDB() -> OpaquePointer? {
        // Create a file URL for the database file
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(path)
        // Pointer to hold the database object
        var db : OpaquePointer? = nil
        // Open the database connection
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            print("There is error in creating DB")
            return nil
        }else {
            print("Database has been created with path \(path)")
            return db
        }
    }
    
//MARK: - Function to create a table in a SQLite database
    
    func createTable()  {
        // SQL statement to create a table
        let query = "CREATE TABLE IF NOT EXISTS comments(username TEXT PRIMARY KEY, comment TEXT, creation_date TEXT);"
        var statement : OpaquePointer? = nil
        
        // Execute the create table query
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Table creation success")
            }else {
                print("Table creation fail")
            }
        } else {
            print("Prepration fail")
        }
    }
    
//MARK: - Function to insert data into a SQLite table
    
    func insert(username: String, comment: String,  creation_date: String)
    {
        let persons = read()
        for p in persons
        {
            if p.username == username
            {
                return
            }
        }
        // SQL statement to insert data into the table
        let insertStatementString = "INSERT INTO comments (username, comment, creation_date) VALUES (?, ?, ?);"
        // Prepare the SQL statement
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            // Bind the values to the statement
            sqlite3_bind_text(insertStatement, 1, (username as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (comment as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (creation_date as NSString).utf8String, -1, nil)
            
            // Execute the statement
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        // Finalize the statement
        sqlite3_finalize(insertStatement)
    }
    
//MARK: - Function to read data from a SQLite table
    
    func read() -> [CommentListM] {
        // SQL statement to read data from the table
        let queryStatementString = "SELECT * FROM comments;"
        // Pointer to hold the database object
        var queryStatement: OpaquePointer? = nil
        //Array for comment list
        var commentsArray : [CommentListM] = []
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            // Execute the statement and iterate through the result rows
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                // Retrieve the values from the result row
                let username = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let comment = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let creation_date = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                commentsArray.append(CommentListM(comment: comment, creation_date: creation_date, username: username))
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        // Finalize the statement
        sqlite3_finalize(queryStatement)
        return commentsArray
    }
    
//MARK: - Function to delete an item from a SQLite table
    
    func deleteByID(id:Int) {
        // SQL statement to delete an item from the table
        let deleteQuery = "DELETE FROM comments WHERE username = ?;"
        // Prepare the SQL statement
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, deleteQuery, -1, &statement, nil) == SQLITE_OK {
            // the ID of the item to be deleted
            let idToDelete: Int32 = Int32(id)
            // Bind the value to the statement
            sqlite3_bind_int(statement, 1, idToDelete)
            // Execute the statement
            if sqlite3_step(statement) != SQLITE_DONE {
                print("Error deleting item")
            } else {
                print("deleted successfully")
            }
            sqlite3_finalize(statement)
        }
    }
    
//MARK: - Function to delete all items from a SQLite table
    
    func deleteTableItems () {
        // SQL statement to delete all items from the table
        let deleteQuery = "DELETE FROM comments;"
        // Execute the statement
        if sqlite3_exec(db, deleteQuery, nil, nil, nil) != SQLITE_OK {
            print("Error deleting items")
        } else {
            print("Items in db deleted sccessfully")
        }
    }
    
    //MARK: - Function to close the SQLite database connection
    
    func closeDBConnection () {
        // Close the database connection
        if sqlite3_close(db) == SQLITE_OK {
            print("Successfully closed connection to database.")
        } else {
            print("Unable to close database.")
        }
    }
    deinit {
        if db != nil {
            sqlite3_close(db)
        }
    }
}
