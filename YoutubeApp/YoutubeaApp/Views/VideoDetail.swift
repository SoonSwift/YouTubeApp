//
//  VideoDetail.swift
//  YoutubeaApp
//
//  Created by Marcin Dytko on 19/05/2023.
//

import SwiftUI

struct VideoDetail: View {
    var video: Video
    @EnvironmentObject var singInManager: GoogleSignInManager
    var date: String {
        //format date
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        return df.string(from: video.published)
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text(video.title)
                .bold()
            
            Text(date)
                .foregroundColor(.gray)
            
            YoutubeVideoPlayer(video: video)
                .aspectRatio(CGSize(width: 1280, height: 720), contentMode: .fit)
            
            if singInManager.signedIn {
                LikeAndSubscribe(vide: video, accessToken: singInManager.accessToken)
                // Set fade on insert
                    .transition(.opacity)
                    .animation(.default)
            }
            ScrollView {
                Text(video.description)
            }
            
        }
        .padding(8)
        .font(.system(size: 19))
        .padding(.top, 40)
        .background(backgroundColor)
        
    }
}

struct VideoDetail_Previews: PreviewProvider {
    static var previews: some View {
        VideoDetail(video: Video())
            .environmentObject(GoogleSignInManager())
    }
}
