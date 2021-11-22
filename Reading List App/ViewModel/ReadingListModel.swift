//
//  ReadingListModel.swift
//  Reading List App
//
//  Created by CodeWithChris on 2021-04-23.
//

import Foundation
import Firebase

class ReadingListModel: ObservableObject {
    // Variables to temporarily store the genres and books information from the database
    @Published var genres : [String] = []
    // Dictionary to match Genres to an array of Books
    @Published var books : [String: [Book]] = [:]
    
    @Published var statuses : [String] = ["Plan to read", "Reading", "On hold", "Completed"]

    init() {
        getGenres()
    }
    
    // TODO: Complete all Firestore functions
    /// Adds a document with auto-genrated ID to the books collection in the Firestore database
    ///
    /// Parameters:
    ///     - book: The book to add to the database
    func addBook(book: Book) {
        
        let db = Firestore.firestore()
        
        let books = db.collection("books")
        
        books.document().setData(["title" : book.title, "author": book.author, "genre": book.genre, "status": book.status, "pages": book.pages, "ratings": book.rating])
       
    }
    
    /// Deletes a specific book document in the books collection in the Firestore database
    ///
    /// Parameters:
    ///     - book: The book to delete in  the database
    func deleteBook(book: Book) {
        
        let db = Firestore.firestore()
        
        let books = db.collection("books")
        
        let bookDoc = books.document(book.id)
        
        bookDoc.delete()
        
    }
    
    /// Updates a book document's genre, status, and rating fields, in the books collection in the Firestore database
    ///
    /// Parameters:
    ///     - book: The book to update in the database
    func updateBookData(book: Book) {
        
        let db = Firestore.firestore()
        
        let books = db.collection("books")
        
        let bookDoc = books.document(book.id)
        
        bookDoc.updateData(["genre": book.genre, "status": book.status, "rating": book.rating])    }
    
    /// Queries the books collection in the Firestore database and finds all book documents with the matching "genre" field value. Updates the "books" class field with the queried book documents' data
    ///
    /// Parameters:
    ///     - genre: The genre to match when querying the book documents
    func getBooksByGenre(genre: String) {
        let db = Firestore.firestore()
        
        // Get a reference to the books collection
        let consoles = db.collection("books")
        
        // Create a query to the database for books with the appropriate genre
        let query = consoles.whereField("genre", in: [genre])
        
        // Execute the query
        query.getDocuments { (querySnapshot, error) in
            // Check for errors
            if let error = error {
                // Handle error by printing out error description
                print(error.localizedDescription)
            } else if let querySnapshot = querySnapshot {
                // Print out data and ID for each document matching the query
                var allBooks: [Book] = []
                for doc in querySnapshot.documents {
                    let data = doc.data()
                    
                    let id = doc.documentID
                    let title = data["title"] as? String ?? ""
                    let author = data["author"] as? String ?? ""
                    let genre = data["genre"] as? String ?? ""
                    let status = data["status"] as? String ?? ""
                    let pages = data["pages"] as? Int ?? 0
                    let rating = data["rating"] as? Int ?? 1
                    
                    allBooks.append(Book(id: id, title: title, author: author, genre: genre, status: status, pages: pages, rating: rating))
                }
                self.books[genre] = allBooks
            } else {
                // No data was returned
                print("No data returned")
            }
            
        }
        
        
    }

    /// Adds a genre document with the genre as the document ID to the genres collection
    ///
    /// Parameters:
    ///     - genre: The name of the genre to add to the Firestore database
    func addGenre(genre: String) {
        
        let db = Firestore.firestore()
        
        // Get a reference to the "genres" collection
        let genres = db.collection("genres")
        
        genres.document(genre).setData([:])
        
    }
    
    /// Gets all genre documents in the genres collection in the Firestore database and updates the "genres" class field with the genre document ID names.
    ///
    /// Parameters:
    ///     - genre: The genre to match when querying the book documents
    func getGenres() {
        
        let db = Firestore.firestore()
        
        // Get a reference to the "genres" collection
        let genres = db.collection("genres")
        
        // Get all documents from the collection
        genres.getDocuments { (querySnapshot, error) in
            
            // Check for an error and handle it appropriately
            if let error = error {
                // Handle error by printing out error description
                print(error.localizedDescription)
                
            } else if let querySnapshot = querySnapshot {
                // Handle the data
                // Loop through each document and get the genres by document ID
                var allGenres: [String] = []
                for doc in querySnapshot.documents {
                    allGenres.append(doc.documentID)
                }
                self.genres = allGenres
            } else {
                // No data was returned
                print("No data returned")
            }
        }
    }
        
        
        
    }

