//
//  PostCell.swift
//  RedditClone
//
//  Created by administrator on 2022. 04. 21..
//  Copyright © 2022. administrator. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    
    @IBOutlet weak var postThumbnail: UIImageView!
    
    @IBOutlet weak var postTitle: UILabel!
    
    @IBOutlet weak var postAuthor: UILabel!
    
    func setPost(post : Post) {
    
        if (post.image != nil) {
            let imageData = try! Data(contentsOf: post.image!)
            postThumbnail.image = UIImage(data: imageData)
        }

        
        postTitle.text = post.title
        postAuthor.text = post.author
        
    }
}
