//
//  VideoRow.swift
//  YoutubeaApp
//
//  Created by Marcin Dytko on 19/05/2023.
//

import SwiftUI

struct VideoRow: View {
    @ObservedObject var videoPreview: VideoPreview
    @State private var isPresenting = false
    @State private var imageHeight: CGFloat = 0
    
    var body: some View {
        Button(action: {
            isPresenting = true
        }) {
            VStack(alignment: .leading, spacing: 10) {
                
                GeometryReader { geo in
                    
                    // image for the video previews data
                    Image(uiImage: UIImage(data: videoPreview.thumbnailData) ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.width * 9/16 )
                        .clipped()
                        .onAppear {
                            // Update height of inage
                            imageHeight = geo.size.width * 9/16
                        }
                }
                // set height explicitly
                .frame(height: imageHeight)
                
                Text(videoPreview.title)
                    .bold()
                
                Text(videoPreview.date)
                    .foregroundColor(.gray)
                
            }
            .font(.system(size: 19))
        }
        .sheet(isPresented: $isPresenting) {
            // Display the detail view
            VideoDetail(video: videoPreview.video)
        }
    }
}

struct VideoRow_Previews: PreviewProvider {
    static var previews: some View {
        VideoRow(videoPreview: VideoPreview(video: Video()))
    }
}
