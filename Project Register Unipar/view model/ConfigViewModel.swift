//
//  RegistersViewModel.swift
//  Project Register Unipar
//
//  Created by Celio Ferreira on 19/09/22.
//

import Foundation
import Combine
import FirebaseFirestore

class ConfigViewModel: ObservableObject {
    
    @Published var registers = [Register]()
    
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
            listenerRegistration = db.collection("registros").addSnapshotListener{(
                querySnapshot, error) in
                guard let documents = querySnapshot?.documents
                else {
                    print("No documentes")
                    return
                }
                
                self.registers = documents.compactMap{querySnapshot in try? querySnapshot.data(as: Register.self)
                    
                }
            }
        }
    }
    
    
    func removeRegisters(atOffsets indexSet: IndexSet){
        let registers = indexSet.lazy.map { self.registers[$0]}
        registers.forEach { register in
            if let documenteId = register.id {
                db.collection ("registros").document(documenteId).delete {
                    error in if let error = error {
                        print("Unable to remove document: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}
