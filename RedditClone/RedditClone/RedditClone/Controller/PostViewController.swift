//
//  PostViewController.swift
//  RedditClone
//
//  Created by administrator on 2022. 04. 21..
//  Copyright © 2022. administrator. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts : [Post] = []
    var mainUrl: URL? = Bundle.main.url(forResource: "data", withExtension: "json")
    var subUrl: URL?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self

        self.title = "RedditClone"
        getPosts()
    }
    
    // MARK: - Régi beolvasás
    /*
     tempposts : [Post] = []
     
     let post1 = Post(title: "Első poszt", author: "Józsi", description: "asd", image: URL(string : "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4d/Cat_November_2010-1a.jpg/1200px-Cat_November_2010-1a.jpg")!)
     let post2 = Post(title: "Második poszt", author: "Józsi", image: URL(string : "https://images.theconversation.com/files/443350/original/file-20220131-15-1ndq1m6.jpg")!)
     let post3 = Post(title: "Harmadik poszt", author: "Józsi", description: "asd", image: URL(string : "https://www.youtube.com/watch?v=O6lDsMi8bMM")!)
     tempposts.append(post1)
     tempposts.append(post2)
     tempposts.append(post3)
     */
    
    func getPosts() {
        
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            subUrl = documentDirectory.appendingPathComponent("data.json")
            loadFile(mainPath: mainUrl!, subPath: subUrl!)
        } catch {
            print(error)
        }
    }
    
    func loadFile(mainPath: URL, subPath: URL){
        if FileManager.default.fileExists(atPath: subPath.path){
            decodeData(pathName: subPath)
            
            if posts.isEmpty{
                decodeData(pathName: mainPath)
            }
            
        }else{
            decodeData(pathName: mainPath)
        }
        
        self.tableView.reloadData()
    }
    
    func decodeData(pathName: URL){
        do{
            let jsonData = try Data(contentsOf: pathName)
            let decoder = JSONDecoder()
            posts = try decoder.decode([Post].self, from: jsonData)
        } catch {}
    }
    

     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        if let detailVC = segue.destination as? PostDetailViewController, let index = tableView.indexPathForSelectedRow?.row {
            detailVC.post = posts[index]
        }
        else if let createVC = segue.destination as? CreatePostViewController {
            createVC.posts = posts
            createVC.subUrl = subUrl
        }
     }

}


extension PostViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        cell.setPost(post: post)
        
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        decodeData(pathName: subUrl!)
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "postDetails", sender: nil)
    }
}
