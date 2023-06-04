//
//  GoogleSingInButton.swift
//  YoutubeaApp
//
//  Created by Marcin Dytko on 21/05/2023.
//

import SwiftUI
import GoogleSignIn


struct GoogleSingInButton: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        // Create view
        let view = GIDSignInButton()
        
        
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct GoogleSingInButton_Previews: PreviewProvider {
    static var previews: some View {
        GoogleSingInButton()
    }
}
