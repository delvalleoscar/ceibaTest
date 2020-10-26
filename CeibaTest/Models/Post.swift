//
//  Post.swift
//  CeibaTest
//
//  Created by Oscar del Valle Ruiz on 25/10/20.
//

import Foundation
import RealmSwift

class Post: Object, Codable {
    @objc dynamic var userId: Int = -1
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""
    
    static func getPosts(userId: Int, completionHandler: @escaping(Result<[Post], NetworkError>) -> Void) {
        
        let posts = Array(Storage.realm.objects(Post.self).filter("userId == \(userId)"))
        if !posts.isEmpty {
            completionHandler(.success(posts))
        } else {
            let path = String(format: "https://jsonplaceholder.typicode.com/posts?userId=%d", userId)
            Networking.get(with: path) { (result: Result<[Post], NetworkError>) in
                switch result {
                case .success(let posts):
                    do {
                        try Storage.realm.write({
                            Storage.realm.add(posts)
                        })
                    } catch {
                        fatalError("Internal error on DB")
                    }
                case .failure(_):
                    return
                }
                completionHandler(result)
            }
        }
    }
}
