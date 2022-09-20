//
//  ContentView.swift
//  Project Register Unipar
//
//  Created by Celio Ferreira on 16/09/22.
//

import SwiftUI
import CoreData
import Firebase

struct ContentView: View {
    
    @StateObject var viewModel = BooksViewModel()
    @State var presentAddBookSheet = false
    
    private var addButton: some View {
        Button(action: {self.presentAddBookSheet.toggle()}) {
            Image(systemName: "plus")
        }
    }
    private func bookRowView(book: Book) -> some View {
        NavigationLink(destination: BookDetailsView(book: book)) {
            VStack(alignment: .leading){
                HStack{
//                    AnimatedImage(url: URL(string: book.image)!).resizable().frame(width: 65, heigth: 65).clipShape(Circle())
                    VStack(alignment: .leading) {
                        Text(book.title)
                            .fontWeight(.bold)
                        Text(book.author)
                    }
                }
            }
        }
    }
    
    
    var body: some View{
        NavigationView{
            List{
                ForEach(viewModel.books) {
                    book in bookRowView(book: book)
                    
                }
            }
            .navigationBarTitle("Books")
            .navigationBarItems(trailing: addButton)
            .onAppear() {
                print("BooksListeView appears. Subscribing to data updates.")
                self.viewModel.subscribe()
            }
            .sheet(isPresented: self.$presentAddBookSheet){
                BookEditView()
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
