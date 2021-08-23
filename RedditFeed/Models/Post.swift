//
//  Post.swift
//  RedditFeed
//
//  Created by Danny on 8/20/21.
//

import Foundation
import ObjectMapper


final class Post: Mappable {
    var id: String!
    var name: String!
    var title: String!
    
    private var thumbnail: String?
    var thumbnailUrl: URL? {
        return thumbnail == nil ? nil : URL(string: thumbnail!)
    }
    
    var thumbnailWidth: Int?
    var thumbnailHeight: Int?
    
    var hasThumbnail: Bool {
        return thumbnailUrl != nil && thumbnail != "default" && thumbnailWidth != nil && thumbnailHeight != nil
    }
    
    private var _score: Int?
    var score: Int { return _score ?? 0 }
    
    private var _numComments: Int?
    var numComments: Int { return _numComments ?? 0 }
    
    init?(map: Map) {
        guard
            map.JSON["id"] as? String != nil,
            map.JSON["name"] as? String != nil,
            map.JSON["title"] as? String != nil
        else { return nil }
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        title <- map["title"]
        thumbnail <- map["thumbnail"]
        thumbnailWidth <- map["thumbnail_width"]
        thumbnailHeight <- map["thumbnail_height"]
        _score <- map["score"]
        _numComments <- map["num_comments"]
    }
}
