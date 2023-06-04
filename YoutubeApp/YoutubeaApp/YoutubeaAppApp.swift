//
//  YoutubeaAppApp.swift
//  YoutubeaApp
//
//  Created by Marcin Dytko on 18/05/2023.
//

import SwiftUI
import GoogleSignIn

@main
struct YoutubeaAppApp: App {
    
    // Create a google manager
    let singInManager = GoogleSignInManager()
    
    init() {
        // Set id and delegate
        GIDSignIn.sharedInstance()?.clientID = Constants.googleSingInId
        GIDSignIn.sharedInstance()?.delegate = singInManager
        // Specify that we need authenticate users for yt access
        GIDSignIn.sharedInstance()?.scopes.append(Constants.youtubeAuthScope)
    }
    
    var body: some Scene {
        WindowGroup {
            Home()
                .environmentObject(singInManager)
        }
    }
}
