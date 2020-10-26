//
//  PostsViewController.swift
//  CeibaTest
//
//  Created by Oscar del Valle Ruiz on 25/10/20.
//

import UIKit
import KRProgressHUD

class PostsViewController: UIViewController {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPhone: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var user: User!
    var posts: [Post]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.tableFooterView = UIView()
        
        setupHeader()
        loadUserPosts()
    }
    
    static func instantiate(user: User) -> PostsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let postsViewController = storyboard.instantiateViewController(identifier: "PostsViewController") as? PostsViewController else {
            fatalError("PostsViewController Instantiate Error")
        }
        postsViewController.user = user
        return postsViewController
    }
    
    private func setupHeader() {
        userName.text = user.name
        userPhone.text = user.phone
        userEmail.text = user.email
    }
    
    private func loadUserPosts() {
        KRProgressHUD.show()
        Post.getPosts(userId: user.id) { [weak self](result) in
            switch result {
            case .success(let posts):
                DispatchQueue.main.async {
                    self?.posts = posts
                    KRProgressHUD.showSuccess()
                    self?.tableView.reloadData()
                    self?.tableView.setNeedsDisplay()
                }
            case .failure(let error):
                print(error)
                KRProgressHUD.showError(withMessage: error.description)
            }
        }
    }
    

}

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostsTableViewCell,
              let post = posts?[indexPath.row] else {
            return UITableViewCell()
        }
        DispatchQueue.main.async {
            cell.configureCell(with: post)
        }
        return cell
    }
    
    
}
