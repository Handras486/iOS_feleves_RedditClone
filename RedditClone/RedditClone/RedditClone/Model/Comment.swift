//
//  Comment.swift
//  RedditClone
//
//  Created by administrator on 2022. 04. 21..
//  Copyright © 2022. administrator. All rights reserved.
//

import Foundation

struct Comment : Codable {
    let author : String
    let content : String
    
    init(author: String, content: String) {
        self.author = author
        self.content = content
    }
}
