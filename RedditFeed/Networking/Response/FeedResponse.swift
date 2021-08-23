//
//  FeedResponse.swift
//  RedditFeed
//
//  Created by Danny on 8/20/21.
//

import Foundation
import ObjectMapper

final class FeedResponse: Mappable {
    var children: [PostData]?
    var kind: String!
    
    init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        kind <- map["kind"]
        children <- map["data.children"]
    }
}

final class PostData: Mappable {
    var kind: String!
    var post: Post?
    
    init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        kind <- map["kind"]
        post <- map["data"]
    }
}
