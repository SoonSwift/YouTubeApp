//
//  YoutubeRequest.swift
//  YoutubeaApp
//
//  Created by Marcin Dytko on 21/05/2023.
//

import Foundation
import Alamofire


extension Session {
    
    // Sends an authenicated request to data
    func requestYoutube(
        relativeUrl: String,
        method: HTTPMethod ,
        json: Bool = false ,
        parameters: Parameters? = nil ,
        accessToken: String,
        completion: ((AFDataResponse<Any>) -> Void)? = nil
    ) {
        
        // Crate URL form path
        guard let url = URL(string: "\(Constants.apiUrl)/\(relativeUrl)") else {print("Couldnt get url")
            return}
        // Crate the AF request
        AF.request(
            url,
            method: method,
            parameters: parameters,
            encoding: json ? JSONEncoding.default : URLEncoding.default,
            headers: ["Authorization": "Bearer \(accessToken)", "Accept": "application/json"]
        )
        .validate()
        .responseJSON { response in
            
            // Check status of request
            switch response.result {
            case .success:
                break
            case .failure(let error):
                print(error)
                return
            }
            // call the completion handler
            if let completion = completion {
                completion(response)
            }
        }
        
        
    }
}
