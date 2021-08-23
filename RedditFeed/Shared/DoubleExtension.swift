//
//  DoubleExtension.swift
//  RedditFeed
//
//  Created by Danny on 8/21/21.
//

import Foundation

extension Double {    
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1)  == 0 ? String(self) : String(format: "%.1f", self)
    }
}
