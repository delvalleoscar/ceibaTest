//
//  Storage.swift
//  CeibaTest
//
//  Created by Oscar del Valle Ruiz on 25/10/20.
//

import RealmSwift

struct Storage {
    
    static func saveData<T>(_ data: [T]) where T: Object {
        do {
            let realm = try Realm()
            try realm.write({
                realm.add(data)
            })
        } catch {
            fatalError("Internal error on DB")
        }
    }
    
    static func getData<T>(of type: T.Type, filter: String? = nil) -> Array<T> where T: Object {
        do {
            let realm = try Realm()
            if let dbFilter = filter {
                return Array(realm.objects(type).filter(dbFilter))
            } else {
                return Array(realm.objects(type))
            }
        } catch {
            fatalError("Internal error on DB")
        }
    }
}
