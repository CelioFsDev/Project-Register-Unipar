//
//  BookViewModel.swift
//  Project Register Unipar
//
//  Created by Celio Ferreira on 19/09/22.
//

import Foundation
import Combine
import FirebaseFirestore

class Book1ViewModel: ObservableObject {
    
    @Published var book: Book
    @Published var modified = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(book: Book = Book(title: "", author: "", numberOfPages: 0, image: "")){
        self.book = book
        
        self.$book
            .dropFirst()
            .sink{[weak self] book in
                self?.modified = true
            }
            .store(in: &self.cancellables)
    }
    
    private var db = Firestore.firestore()
    
    private func addBook(_ book: Book) {
        do {
            let _ = try db.collection("books").addDocument(from: book)
        }
        catch {
            print(error)
        }
    }
    private func updateBook(_ book: Book) {
        if let documenteId = book.id{
            do {
                try db.collection("books").document(documenteId).setData(from: book)
            }
            catch {
                print(error)
            }
        }
    }
    
    private func updateOrAddBook() {
        if let _ = book.id {
            self.updateBook(self.book)
        }else {
            addBook(book)
        }
    }
    private func removeBook(){
        if let documenId = book.id {
            db.collection("books").document(documenId).delete {
            error in
                if let error = error {
                    print(error.localizedDescription)
                }
        }
        }
    }
    func handleDoneTapped() {
        self.updateOrAddBook()
    }
    func handleDeleteTapped(){
        self.removeBook()
    }
}
