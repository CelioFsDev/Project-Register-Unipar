//
//  BooksViewModel.swift
//  Project Register Unipar
//
//  Created by Celio Ferreira on 19/09/22.
//

import Foundation
import Combine
import FirebaseFirestore

class BooksViewModel: ObservableObject {
    @Published var books = [Book]()
    
    private var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    deinit {
        unsubscribe()
    }
    func unsubscribe(){
        if listenerRegistration != nil {
            listenerRegistration?.remove()
            listenerRegistration = nil
        }
    }
    func subscribe(){
        if listenerRegistration == nil {
            listenerRegistration = db.collection("books").addSnapshotListener{(querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documentes")
                    return
                }
                
                self.books = documents.compactMap{querySnapshot in try? querySnapshot.data(as: Book.self)
                    
                }
            }
        }
    }
    
    
    func removeBooks(atOffsets indexSet: IndexSet){
        let books = indexSet.lazy.map { self.books[$0]}
        books.forEach { book in
            if let documenteId = book.id {
                db.collection ("books").document(documenteId).delete {
                    error in if let error = error {
                        print("Unable to remove document: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    
}
