//
//  IntExtension.swift
//  RedditFeed
//
//  Created by Danny on 8/21/21.
//

import Foundation

extension Int {
    func short() -> String {
        if self < 1000 {
            return "\(self)"
        } else if self < 1000000 {
            return "\((Double(self)/1000).clean)K"
        } else if self < 1000000000 {
            return "\((Double(self)/1000000).clean)M"
        } else {
            return "\((Double(self)/1000000000).clean)B"
        }
    }
}
