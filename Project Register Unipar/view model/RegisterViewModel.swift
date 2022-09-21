//
//  RegisterViewModel.swift
//  Project Register Unipar
//
//  Created by Celio Ferreira on 19/09/22.
//

import Foundation
import Combine
import FirebaseFirestore

class RegisterViewModel: ObservableObject {
    
    @Published var register: Register
    @Published var modified = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(register: Register = Register(title: "", fornecedor: "", phone: "", image: "")){
        self.register = register
        
        self.$register
            .dropFirst()
            .sink{[weak self] register in
                self?.modified = true
            }
            .store(in: &self.cancellables)
    }
    
    private var db = Firestore.firestore()
    
    private func addRegister(_ register: Register) {
        do {
            let _ = try db.collection("registros").addDocument(from: register)
        }
        catch {
            print(error)
        }
    }
    private func updateRegister(_ register: Register) {
        if let documenteId = register.id{
            do {
                try db.collection("registros").document(documenteId).setData(from: register)
            }
            catch {
                print(error)
            }
        }
    }
    
    private func updateOrAddRegister() {
        if let _ = register.id {
            self.updateRegister(self.register)
        }else {
            addRegister(register)
        }
    }
    private func removeRegister(){
        if let documenId = register.id {
            db.collection("registros").document(documenId).delete {
            error in
                if let error = error {
                    print(error.localizedDescription)
                }
        }
        }
    }
    func handleDoneTapped() {
        self.updateOrAddRegister()
    }
    func handleDeleteTapped(){
        self.removeRegister()
    }
}
