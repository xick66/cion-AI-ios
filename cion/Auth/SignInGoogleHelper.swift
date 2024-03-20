//
//  SignInGoogleHelper.swift
//  cion
//
//  Created by Rahul K M on 05/03/24.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

struct GoogleSignInResultModel {
    let idToken:String
    let accessToken: String
    let name: String?
    let email: String?
}

final class SignInGoogleHelper{
    
    @MainActor
    func SignIn() async throws -> GoogleSignInResultModel{
        guard let topVC = Utilities.shared.topViewController() else{
            throw URLError(.cannotFindHost)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken = gidSignInResult.user.idToken?.tokenString else{
            throw URLError(.badServerResponse)
        }
        let accessToken: String = gidSignInResult.user.accessToken.tokenString
        let name: String = gidSignInResult.user.profile!.name
        let email: String = gidSignInResult.user.profile!.email
        
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken, name: name, email: email)
        return tokens
    }
}
