//
//  BookEditView.swift
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

struct BookEditView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
    
    @ObservedObject var viewModel = Book1ViewModel()
    var mode: Mode = .new
    var completionHandler: ( (Result<Action, Error>) -> Void)?
    
    var cancelButton: some View {
        Button(action: {self.handleDoneTapped() }) {
            Text("Cancel")
        }
    }
    var saveButton: some View {
        Button(action: {self.handleDoneTapped()}) {
            Text(mode == .new ? "Done" : "Save")
        }
        .disabled(!viewModel.modified)
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Book")){
                    TextField("Title", text: $viewModel.book.title)
                    TextField("Number of pages", value: $viewModel.book.numberOfPages, formatter: NumberFormatter())
                }
                Section(header: Text("Author")){
                    TextField("Author", text: $viewModel.book.author)
                }
                Section(header: Text("Photo")) {
                    TextField("Image", text: $viewModel.book.image)
                }
                if mode == .edit {
                    TextField("Image", text: $viewModel.book.image)
                }
                if mode == .edit {
                    Section {
                        Button("Delete") {self.presentActionSheet.toggle() }
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle(mode == .new ? "New book" : viewModel		.book.title)
            .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
            .navigationBarItems(
                leading: cancelButton,
                trailing: saveButton
            )
            .actionSheet(isPresented: $presentActionSheet) {
                ActionSheet(title: Text("Tem certeza disso"),
                            buttons: [
                                .destructive(Text("Deletar"),
                                             action: {self.handleDeleteTapped() }),
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

struct BookEditView_Previews: PreviewProvider {
    static var previews: some View {
        BookEditView()
    }
}
