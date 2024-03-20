//
//  SignInEmailView.swift
//  cion
//
//  Created by Rahul K M on 05/03/24.
//

import SwiftUI
@MainActor
final class SignInEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func SignUp() async throws{
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
            try await AuthenticationManager.shared.createUser(email: email, password: password)
        }

    func SignIn() async throws{
    guard !email.isEmpty, !password.isEmpty else {
        print("No email or password found")
        return
    }
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
}

struct SignInEmailView: View {
   
    @StateObject private var viewModel = SignInEmailViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View{
        VStack{
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(.gray.opacity(0.4))
                .cornerRadius(10)
            
            Button{
                Task{
                    do{
                        try await viewModel.SignUp()
                        showSignInView = false
                    }catch{
                        print(error)
                    }
                    
                    do{
                        try await viewModel.SignIn()
                        showSignInView = false
                    }catch{
                        print(error)
                    }
                    
                }
            }label: {
                Text("Sign in")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height:40)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Sign In with Email")
    }
    
}

struct SignInEmailView_Previews: PreviewProvider{
    static var previews: some View{
        NavigationStack{
            SignInEmailView(showSignInView: .constant(false))
        }
    }
}
