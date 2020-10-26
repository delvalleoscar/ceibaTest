//
//  User.swift
//  CeibaTest
//
//  Created by Oscar del Valle Ruiz on 25/10/20.
//

import Foundation
import RealmSwift

class User: Object, Codable {
    @objc dynamic var id: Int = -1
    @objc dynamic var name: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var phone: String = ""
    
    static func getUsers(completionHandler: @escaping(Result<[User], NetworkError>) -> Void) {
        let users = Storage.getData(of: User.self)
        if users.count > 0 {
            completionHandler(.success(users))
        } else {
            Networking.get(with: "https://jsonplaceholder.typicode.com/users") { (result: Result<[User], NetworkError>) in
                switch result {
                case .success(let users):
                    Storage.saveData(users)
                case .failure(_):
                    return
                }
                completionHandler(result)
            }
        }
    }
}
