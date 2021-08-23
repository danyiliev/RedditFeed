//
//  FeedRequest.swift
//  RedditFeed
//
//  Created by Danny on 8/20/21.
//

import Foundation
import Alamofire

struct FeedRequest {
    let path = URL(string: "\(Environment.shared.apiEndpoint)/.json")!
    var method      : HTTPMethod { return .get }
    
    var afterLink: String?
    
    var headers: HTTPHeaders? = nil
    
    var params: [String: AnyHashable] {
        var params: [String: AnyHashable] = [:]
        
        params["after"] = afterLink
        
        return params
    }
    
    init(after: String? = nil) {
        self.afterLink = after
    }
}
