//
//  RegisterEditView.swift
//  Project Register Unipar
//
//  Created by Celio Ferreira on 19/09/22.
//

import SwiftUI

enum Mode {
    case new
    case edit
}

enum Action {
    case delete
    case done
    case cancel
}

struct RegisterEditView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
    
    @ObservedObject var viewModel = RegisterViewModel()
    var mode: Mode = .new
    var completionHandler: ( (Result<Action, Error>) -> Void)?
    
    var cancelButton: some View {
        Button(action: {self.handleDoneTapped() }) {
            Text("Cancelar")
        }
    }
    var saveButton: some View {
        Button(action: {self.handleDoneTapped()}) {
            Text(mode == .new ? "Cadastrar" : "Salvar")
        }
        .disabled(!viewModel.modified)
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Produtos")){
                    TextField("Produto", text: $viewModel.register.title)
                    
                }
                Section(header: Text("Fornecedor")){
                    TextField("Fornecedor", text: $viewModel.register.fornecedor)
                    TextField("Telefone", text: $viewModel.register.phone)
                }
                Section(header: Text("Foto do Produto")) {
                   // TextField("Imagem do Produto", text: $viewModel.register.image)
                }
                if mode == .edit {
                    TextField("Image", text: $viewModel.register.image)
                }
                if mode == .edit {
                    Section {
                        Button("Delete") {self.presentActionSheet.toggle() }
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle(mode == .new ?
                             "Novo Registro" : viewModel.register.title)
            .navigationBarTitleDisplayMode(
                mode == .new ?
                    .inline : .large)
            .navigationBarItems(
                leading: cancelButton,
                trailing: saveButton
            )
            .actionSheet(isPresented: $presentActionSheet) {
                ActionSheet(title: Text("Tem certeza disso"),
                            buttons: [
                                .destructive(Text("Deletar"),
                                             action: {self.handleDeleteTapped()
                                                 
                                             }),
                                .cancel()
                            ])
            }
        }
    }

    func handleCancelTapped(){
        self.dismiss()
    }
    
    func handleDoneTapped(){
        self.viewModel.handleDoneTapped()
        self.dismiss()
        self.completionHandler?(.success(.delete))
    }
    
    func handleDeleteTapped(){
        viewModel.handleDeleteTapped()
        self.dismiss()
        self.completionHandler? (.success(.delete))
    }
    
    func dismiss(){
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct RegisterEditView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterEditView()
    }
}
