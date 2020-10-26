//
//  UserTableViewCell.swift
//  CeibaTest
//
//  Created by Oscar del Valle Ruiz on 25/10/20.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    
    var seePostClosure: (() -> Void)?
    
    @IBAction func postsButtonTouchUpInside(_ sender: Any) {
        seePostClosure?()
    }
    
    func configureCell(with user: User) {
        name.text = user.name
        phone.text = user.phone
        email.text = user.email
    }

}
