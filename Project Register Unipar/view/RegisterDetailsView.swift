//
//  RegisterDetailsView.swift
//  Project Register Unipar
//
//  Created by Celio Ferreira on 19/09/22.
//

import SwiftUI

struct RegisterDetailsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditRegisterSheet = false
    
    var register: Register
    
    private func editButton(action: @escaping() -> Void) -> some View {
        Button(action: {action() }) {
            Text("Editar")
        }
    }
    
    var body: some View {
        
        Form {
            Section(header: Text("Produtos")){
                Text(register.title)
                
            }
            Section(header: Text("Fornecedor")) {
                Text(register.fornecedor)
                Text("\(register.phone)")
            }
            
        }
        .navigationTitle(register.title)
        .navigationBarItems(trailing: editButton {
            self.presentEditRegisterSheet.toggle()
        })
        .onAppear(){
            print("RegisterDetailsView.onAppear() for \(self.register.title)")
        }
        .onDisappear(){
            print("RegisterDetailsView.onDisappear()")
        }
        .sheet(isPresented: self.$presentEditRegisterSheet) {
            RegisterEditView(viewModel:
                                RegisterViewModel(
                                    register: register),
                             mode: .edit) { result in
                if case .success(let action) = result, action == .delete {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
    struct RegisterDetailsView_Previews: PreviewProvider {
        static var previews: some View {
            let register = Register(title: "Cadastros", fornecedor: "Fornecedor", phone: "62-996046531", image: "https://imgnike-a.akamaihd.net/1300x1300/013635ID.jpg")
            //return
            NavigationView{
                RegisterDetailsView(register: register)
            }
        }
    }
}
