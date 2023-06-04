//
//  RatingModel.swift
//  YoutubeaApp
//
//  Created by Marcin Dytko on 21/05/2023.
//

import Foundation
import Alamofire

class RatingModel: ObservableObject {
    
    var video: Video
    var accessToken: String
    var subscriptionId: String?
    
    @Published var isLiked = false
    @Published var isSubscirbed = false
    
    init(video: Video, accessToken: String) {
        self.video = video
        self.accessToken = accessToken
        
        // set the status for UI
        getRating()
        getSubscriptionSatus()
    }
}

// Support for reading and updt like status

extension RatingModel {
    // gets reating
    func getRating() {
        AF.requestYoutube(relativeUrl: "videos/getRating",
                          method: .get,
                          parameters: ["id": video.videoId, "key": Constants.apiKey],
                          accessToken: accessToken) { response in
            
            // Get Rating from json
            if let json = response.value as? [String: Any],
               let items = json["items"] as? [[String:String]] ,
               let rating = items.first?["rating"] {
                // Update UI
                DispatchQueue.main.async {
                    self.isLiked = rating == "like"
                }
            } else {
                print("ERORR")
            }
            
        }
    }
    
    /// Changes the current user rating for viedo
    func toogleLike() {
        
        let rating = isLiked ? "none" : "like"
        
        AF.requestYoutube(relativeUrl: "videos/rate",
                          method: .post,
                          parameters: ["id": video.videoId , "rating": rating, "key": Constants.apiKey],
                          accessToken: accessToken) { response in
            // Filp value in the UI
            DispatchQueue.main.async {
                self.isLiked.toggle()
            }
            
        }
    }
}

// Support for subscripitons

extension RatingModel {
    /// Gets status for channel
    func getSubscriptionSatus() {
        
        AF.requestYoutube(relativeUrl: "subscriptions",
                          method: .get,
                          parameters: ["part": "id", "forChannelId" : Constants.channelId, "mine": true, "key": Constants.apiKey],
                          accessToken: accessToken) { response in
            // Get response
            if let json = response.value as? [String: Any],
               let items = json["items"] as? [Any]
            {
                // try to get subscription id
                if let item = items.first as? [String: String],
                   let id = item["id"] {
                    self.subscriptionId = id
                }
                DispatchQueue.main.async {
                    self.isSubscirbed = !items.isEmpty
                }
            }
            
        }
    }
    
    // change usres sub status for channel
    func toogleSubscribed() {
        if isSubscirbed {
            unsubscribe()
        } else {
            subscribe()
        }
    }
    
    // Subsribes to channel
    func subscribe() {
        
        // HTTP body
        let body: [String: Any] = ["snippet" : [
            "resourceId" :
                ["channelId": Constants.channelId,
                 "kind" : "youtube#channel"
                ]
            ]
        ]
        
        AF.requestYoutube(relativeUrl: "subscriptions?part=snippet&key=\(Constants.apiKey)",
                          method: .post,
                          json: true,
                          parameters: body,
                          accessToken: accessToken) { response in
            // GET ID from response
            if let json = response.value as? [String: Any],
               let id = json["id"] as? String {
                // Update subscription id
                self.subscriptionId = id
                
                // Update ui
                DispatchQueue.main.async {
                    self.isSubscirbed = true
                }
            } else {
                print("can not sub")
            }
            
        }
    }
    
    /// Unsubscribe method
    func unsubscribe() {
        // we must have sub id to unsub
        guard let subscriptionId = subscriptionId else {
            print("no id")
            return
        }
        
        AF.requestYoutube(relativeUrl: "subscriptions",
                          method: .delete,
                          parameters: ["id": subscriptionId, "key" : Constants.apiKey],
                          accessToken: accessToken) { response in
            // clear the current ID
            self.subscriptionId = nil
            
            // update UI
            DispatchQueue.main.async {
                self.isSubscirbed = false
            }
        }
        
    }
}
