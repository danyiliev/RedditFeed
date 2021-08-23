//
//  APIClient.swift
//  RedditFeed
//
//  Created by Danny on 8/20/21.
//

import Foundation
import Alamofire
import ObjectMapper

protocol RedditAPI {
    func fetchFeed(request: FeedRequest,
                   success: @escaping ([Post]) -> Void,
                   failure: @escaping (Error) -> Void)
}

class APIClient: RedditAPI {
    static var shared = APIClient()
    
    func fetchFeed(request: FeedRequest,
                        success: @escaping ([Post]) -> Void,
                        failure: @escaping (Error) -> Void) {
        let afRequest = AF.request(
            request.path,
            method: request.method,
            parameters: request.params,
            encoding: request.method == .get ? URLEncoding.default : JSONEncoding.default,
            headers: request.headers
        )
        
        
        afRequest.responseJSON { (response) in
            if let error = response.error {
                failure(error)
                
                return
            }
            
            guard let value = response.value else {
                failure(APIError.invalidResponse)
                return
            }
            
            
            
            let mapper = Mapper<FeedResponse>()
            
            guard let json = value as? [String:Any], let response = mapper.map(JSON: json) else {
                failure(APIError.invalidResponse)
                return
            }
            
            success(response.children?.compactMap({$0.post}) ?? [])
        }
    }
}
