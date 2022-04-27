//
//  CommentCell.swift
//  RedditClone
//
//  Created by administrator on 2022. 04. 22..
//  Copyright © 2022. administrator. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var commentContent: UITextView!
    
    func setComment(comment : Comment) {
        commentContent.text = comment.content
    }
}
