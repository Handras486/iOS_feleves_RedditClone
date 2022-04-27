//
//  Post.swift
//  RedditClone
//
//  Created by administrator on 2022. 04. 21..
//  Copyright © 2022. administrator. All rights reserved.
//

import Foundation
import UIKit

struct Post : Codable {
    let title : String
    let author : String
    let description : String?
    var image : URL?
    var video : URL?
    let comments : [Comment]?
    
    init(title: String, author: String, description: String? = nil, image: URL? = nil, video : URL? = nil, comments: [Comment] = []) {
        self.title = title
        self.author = author
        self.description = description
        self.image = image
        self.video = video
        self.comments = comments
    }
    
}
