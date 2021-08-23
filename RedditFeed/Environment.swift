//
//  Environment.swift
//  RedditFeed
//
//  Created by Danny on 8/20/21.
//

import Foundation

// Environment variables
enum Environment {
    case developement
    case production
    
    #if DEBUG
    static var shared = Environment.developement
    #else
    static var shared = Environment.production
    #endif
}

extension Environment {
    var apiEndpoint: String {
        switch self {
        case .production, .developement:
            return "http://www.reddit.com"
        }
    }
}
