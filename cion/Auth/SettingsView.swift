//
//  SettingsView.swift
//  cion
//
//  Created by Rahul K M on 05/03/24.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject{
    
    @Published var authProviders: [AuthProviderOption]=[]
    
    func loadAuthProviders(){
        if let providers = try? AuthenticationManager.shared.getProviders(){
            authProviders = providers
        }
            
    }
    
    func signOut() throws{
        try AuthenticationManager.shared.signOut()
    }
    
    func resetPassword() async throws{
        
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
}

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    var body: some View {
                List{
                    Button("Logout"){
                        Task{
                            do{
                                try viewModel.signOut()
                                showSignInView = true
                            }catch{
                                print(error)
                            }
                        }
                    }
                    
                    Button("Reset Password"){
                        Task{
                            do{
                                try await viewModel.resetPassword()
                                print("Password Reset")
                            }catch{
                                print(error)
                            }
                        }
//                    if viewModel.authProviders.contains(.email){
//                        emailSection
                    }
                    
                }
                .onAppear(){
                    viewModel.loadAuthProviders()
                }
                .navigationBarTitle("Settings")
    }
}
    
struct SettingsView_Previews: PreviewProvider{
    static var previews: some View{
        NavigationStack{
            SettingsView(showSignInView: .constant(false))
        }
    }
}
