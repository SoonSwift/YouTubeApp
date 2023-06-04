//
//  Home.swift
//  YoutubeaApp
//
//  Created by Marcin Dytko on 19/05/2023.
//
import GoogleSignIn
import SwiftUI

let backgroundColor = Color(red: 31/255, green: 33/255 , blue: 36/255)
struct Home: View {
    @StateObject var model = VideoModel()
    @EnvironmentObject var singInManager: GoogleSignInManager
    var body: some View {
        VStack {
            if !singInManager.signedIn {
                GoogleSingInButton()
                    .padding([.top, .bottom], 16)
                    .frame(height: 60)
                    .transition(.move(edge: .top))
                    .onOpenURL { url in
                        GIDSignIn.sharedInstance().handle(url)
                    }
            }
            
            ScrollView {
                LazyVStack {
                    ForEach(model.videos, id: \.videoId) { video in
                        VideoRow(videoPreview: VideoPreview(video: video))
                            .padding()
                    }
                }
                .padding(.top, 20)
            }
            
            // Singed outbutton
            if singInManager.signedIn {
                Button("Sing out") {
                    GIDSignIn.sharedInstance()?.signOut()
                    singInManager.signedIn = false
                }
                .padding()
            }
        }
        .foregroundColor(.white)
        .background(backgroundColor)
        .edgesIgnoringSafeArea(.bottom)
        .animation(.easeOut)
        .onAppear {
            GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(GoogleSignInManager())
    }
}
