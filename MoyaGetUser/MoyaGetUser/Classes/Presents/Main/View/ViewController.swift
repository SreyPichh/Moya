//
//  ViewController.swift
//  MoyaGetUser
//
//  Created by ken.phanith on 2018/09/18.
//  Copyright © 2018 Pich. All rights reserved.
//

import UIKit
import Moya

class ViewController: UIViewController {
    
    private var subview: ViewControllerSubview = ViewControllerSubview()
    
    var postProvider = MoyaProvider<PostService>()
    private var posts = [PostModel]()
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(self.subview.header)
        self.view.addSubview(self.subview.label)
        self.view.addSubview(self.subview.addBtn)
        self.view.addSubview(self.subview.list)
        
        self.subview.list.delegate = self
        self.subview.list.dataSource = self
        
//        self.reactor.action.onNext(Reactor.Action.didLoad)
        
        
        self.postProvider.request(.readPost) { (result) in
            switch result{
            case .success(let response):
//                let json = try! JSONSerialization.jsonObject(with: response.data, options: [])
                let posts = try! JSONDecoder().decode([PostModel].self, from: response.data)
                self.posts = posts
                self.subview.list.reloadData()
                
                print("!!!!!!")
//                print(json)

            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        self.subview.updateContraint()
    }
    
    @IBAction func didTapAdd(){
        let posts = PostModel(userId: 11, id: 101, title: "KIT News", body: "Hot news from KIT, Kirirom Institute of Technology provide full scholarship to 100 students!")
        postProvider.request(.createPost(userId: posts.userId, title: posts.title)) { (result) in
            switch result {
            case .success(let response):
                let newPost = try! JSONDecoder().decode(PostModel.self, from: response.data)
                self.posts.insert(newPost, at: 0)
                self.subview.list.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(posts.count)
        return posts.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let post = posts[indexPath.row]
        cell.textLabel?.text = post.title
        return cell
        

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        postProvider.request(.updatePost(id: post.id, title: "[Modified] " + post.title)){ (result) in
            switch result {
            case .success(let response):
                let modifiedPost = try! JSONDecoder().decode(PostModel.self, from: response.data)
                self.posts[indexPath.row] = modifiedPost
                self.subview.list.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
        print(post)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let post = posts[indexPath.row]
        
        postProvider.request(.deletePost(id: post.id)) { (result) in
            switch result {
            case .success(let response):
                print("Delete: \(response)")
                self.posts.remove(at: indexPath.row)
                self.subview.list.deleteRows(at: [indexPath], with: .automatic)
            case .failure(let error):
                print(error)
            }
        }
        print(post)
        
    }

}

