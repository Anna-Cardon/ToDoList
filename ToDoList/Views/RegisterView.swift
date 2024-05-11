//
//  RegisterView.swift
//  ToDoList
//
//  Created by Anna on 5/12/23.
//

import SwiftUI

struct RegisterView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    /* now make vars to create the new account*/
    @State private var email: String = ""
    @State private var password: String = ""
    
    /* now make a reference to the viewModel*/
    @StateObject private var registerVM = RegisterViewModel()
    
    var body: some View {
        NavigationView{
        VStack{
            Image("todo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Ellipse())
                .padding(.bottom, 20)
            
            TextField("Email", text: $registerVM.email)
                .padding(.bottom, 20)
            
            SecureField("Password", text: $registerVM.password)
            
            Button("Create Account"){
                registerVM.register { //go to registerviewModel func register
                    dismiss() //pass email and password, then dismiss the view
                }
            }
            .padding(.top, 30)
            .buttonStyle(.borderedProminent)
            .tint(.mint)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Register")
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
