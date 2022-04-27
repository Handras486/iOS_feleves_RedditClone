//
//  PostDetailViewController.swift
//  RedditClone
//
//  Created by administrator on 2022. 04. 22..
//  Copyright © 2022. administrator. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class PostDetailViewController: UIViewController {
    
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postDescription: UITextView!
    
    var post : Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //nem tölti be a videókat
        //playVideo()

        loadImage()
        postTitle.text = post?.title
        postDescription.text = post?.description

    }
    
    func playVideo() {
        if(post?.video != nil) {
            let player = AVPlayer(url: (post?.video)!)
            let playerVC = AVPlayerViewController()
            playerVC.player = player
            
            self.present(playerVC, animated: true) { playerVC.player!.play() }
        }
    }

    func loadImage(){
        if (post?.image != nil) {
            let imageData = try! Data(contentsOf: (post?.image)!)
            DispatchQueue.main.async {
            self.postImage.image = UIImage(data: imageData)
            }
        }
    }
    
}

extension PostDetailViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post?.comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = post?.comments?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
        
        cell.setComment(comment: comment!)
        
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
}
