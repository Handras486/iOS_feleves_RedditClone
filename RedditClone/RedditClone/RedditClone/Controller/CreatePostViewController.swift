//
//  CreatePostViewController.swift
//  RedditClone
//
//  Created by administrator on 2022. 04. 23..
//  Copyright © 2022. administrator. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController {

    @IBOutlet weak var postTitle: UITextField!
    @IBOutlet weak var postAuthor: UITextField!
    @IBOutlet weak var postImage: UITextField!
    @IBOutlet weak var postVideo: UITextField!
    @IBOutlet weak var postDescription: UITextView!
    
    var posts : [Post] = []
    var subUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitPost(_ sender: Any) {
        
        postTitle.isUserInteractionEnabled = false
        postAuthor.isUserInteractionEnabled = false
        postImage.isUserInteractionEnabled = false
        postVideo.isUserInteractionEnabled = false
        postDescription.isUserInteractionEnabled = false
    
        if (postTitle.text != "" && postAuthor.text != "") {
            
            let disableButton = sender as? UIButton
            disableButton?.isEnabled = false
            
            var newPost = Post(title: postTitle.text!, author: postAuthor.text!, description: postDescription.text)
            
            if (verifyUrl(urlString: postImage.text)) {
                newPost.image = URL(string : postImage.text!)
            }
            
            if (verifyUrl(urlString: postVideo.text)) {
                newPost.video = URL(string : postVideo.text!)
            }
            if (postVideo.text != "" &&  postImage.text == "") {
                let videoString = postVideo.text?.range(of: "=")
                let videoCode = postVideo.text?[(videoString?.upperBound...)!]
                newPost.image = URL(string : "https://img.youtube.com/vi/" + String(videoCode!) + "/hqdefault.jpg")
            }

            posts.append(newPost)
            writeToFile(location: subUrl!)
        }
    }
    
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = URL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    func writeToFile(location: URL) {
        do{
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let JsonData = try encoder.encode(posts)
            try JsonData.write(to: location)
        }catch{}
    }
}
