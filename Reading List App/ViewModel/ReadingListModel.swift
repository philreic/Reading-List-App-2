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
        
    }
    
    /// Updates a book document's genre, status, and rating fields, in the books collection in the Firestore database
    ///
    /// Parameters:
    ///     - book: The book to update in the database
    func updateBookData(book: Book) {
        
    }
    
    /// Queries the books collection in the Firestore database and finds all book documents with the matching "genre" field value. Updates the "books" class field with the queried book documents' data
    ///
    /// Parameters:
    ///     - genre: The genre to match when querying the book documents
    func getBooksByGenre(genre: String) {
        
    }

    /// Adds a genre document with the genre as the document ID to the genres collection
    ///
    /// Parameters:
    ///     - genre: The name of the genre to add to the Firestore database
    func addGenre(genre: String) {
        
    }
    
    /// Gets all genre documents in the genres collection in the Firestore database and updates the "genres" class field with the genre document ID names.
    ///
    /// Parameters:
    ///     - genre: The genre to match when querying the book documents
    func getGenres() {
        
    }
}
