//
//  GIDSingInManager.swift
//  YoutubeaApp
//
//  Created by Marcin Dytko on 21/05/2023.
//

import Foundation
import GoogleSignIn

class GoogleSignInManager: NSObject, ObservableObject, GIDSignInDelegate {
    
    @Published var signedIn = false
    var accessToken = ""
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard let error else {
            accessToken = user.authentication.accessToken
            signedIn = true
            return
        }
        
        if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
            print("The user has not signed in before")
        } else {
            print("\(error.localizedDescription)")
        }
        
    }
    
}
