//
//  ContentView.swift
//  Project Register Unipar
//
//  Created by Celio Ferreira on 16/09/22.
//

import SwiftUI
import CoreData
import Firebase
import SDWebImageSwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ConfigViewModel()
    @State var presentAddRegisterSheet = false
    
    private var addButton: some View {
        Button(action: {self.presentAddRegisterSheet.toggle()}) {
            Image(systemName: "plus")
        }
        
    }
    private func registerRowView(register: Register) -> some View {
        NavigationLink(destination: RegisterDetailsView(register: register)) {
            VStack(alignment: .leading){
                HStack{
                    AnimatedImage(url: URL(string: register.image)).resizable().frame(width: 65, height: 65).clipShape(Circle())
                    VStack(alignment: .leading) {
                        Text(register.title)
                            .fontWeight(.bold)
                        Text(register.fornecedor)
                    }
                }
            }
        }
    }
    
    
    var body: some View{
        NavigationView{
            List{
                ForEach(viewModel.registers) {
                    register in registerRowView(register: register)
                    
                }
            }
            .navigationBarTitle("Cadastros")
            .navigationBarItems(trailing: addButton)
            .onAppear() {
                print("BooksListeView appears. Subscribing to data updates.")
                self.viewModel.subscribe()
            }
            .sheet(isPresented: self.$presentAddRegisterSheet){
                RegisterEditView()
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
