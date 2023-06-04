//
//  LikeAndSubscribe.swift
//  YoutubeaApp
//
//  Created by Marcin Dytko on 21/05/2023.
//

import SwiftUI

struct LikeAndSubscribe: View {
    @ObservedObject var ratingModel: RatingModel
    
    init(vide: Video, accessToken: String) {
        self.ratingModel = RatingModel(video: vide, accessToken: accessToken)
    }
    
    var likeText: String {
        ratingModel.isLiked ? "Unlike" : "Like"
    }
    
    var subscribeText: String {
        ratingModel.isSubscirbed ? "Unsubscribe" : "Subscribe"
    }
    
    var body: some View {
        HStack {
            Spacer()
            
            Button(likeText) {
                
                ratingModel.toogleLike()
            }
            Spacer()
            
            Button(subscribeText) {
                ratingModel.toogleSubscribed()
            }
            
            Spacer()
        }
        
    }
}

struct LikeAndSubscribe_Previews: PreviewProvider {
    static var previews: some View {
        LikeAndSubscribe(vide: Video(), accessToken: "")
    }
}
