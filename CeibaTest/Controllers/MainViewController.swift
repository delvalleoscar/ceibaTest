//
//  MainViewController.swift
//  CeibaTest
//
//  Created by Oscar del Valle Ruiz on 25/10/20.
//

import UIKit
import KRProgressHUD

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var users: [User]? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        poblateUsers()
    }
    
    private func poblateUsers() {
        KRProgressHUD.show()
        User.getUsers(completionHandler: { [weak self] (result) in
            switch result {
            case .success(let users):
                self?.users = users
                DispatchQueue.main.async {
                    KRProgressHUD.showSuccess()
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    KRProgressHUD.showError(withMessage: error.description)
                }
                print(error.localizedDescription)
            }
        })
    }

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserTableViewCell,
              let user = users?[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.configureCell(with: user)
        cell.seePostClosure = {
            let postViewController = PostsViewController.instantiate(user: user)
            self.navigationController?.pushViewController(postViewController, animated: true)
        }
        return cell
    }
    
}
