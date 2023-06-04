//
//  YoutubeVideoPlayer.swift
//  YoutubeaApp
//
//  Created by Marcin Dytko on 19/05/2023.
//

import SwiftUI
import WebKit

struct YoutubeVideoPlayer: UIViewRepresentable {
    var video: Video
    
    func makeUIView(context: Context) -> some UIView {
            
            // create web view
            let view = WKWebView()
            
            view.backgroundColor = UIColor(backgroundColor)
            // create the url
            let embedUrlString = Constants.youtubeEmbedUrl + video.videoId
            
            // load the video
            let url = URL(string: embedUrlString)
            let request = URLRequest(url: url!)
            view.load(request)
            
            //return web view
            return view
        
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct YoutubeVideoPlayer_Previews: PreviewProvider {
    static var previews: some View {
        YoutubeVideoPlayer(video: Video())
    }
}
