//
//  PostsTableViewCell.swift
//  CeibaTest
//
//  Created by Oscar del Valle Ruiz on 25/10/20.
//

import UIKit

class PostsTableViewCell: UITableViewCell {

    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postBody: UILabel!
    
    func configureCell(with post: Post) {
        postTitle.text = post.title
        postBody.text = post.body
    }
    
}
