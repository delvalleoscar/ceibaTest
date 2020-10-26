//
//  Storage.swift
//  CeibaTest
//
//  Created by Oscar del Valle Ruiz on 25/10/20.
//

import RealmSwift

struct Storage {
    static let realm = try! Realm()
    
    func saveData<T>(data: [T]) where T: Object {
        do {
            try Storage.realm.write({
                Storage.realm.add(data)
            })
        } catch {
            fatalError("Internal error on DB")
        }
    }
    
    func getData<T>(of type: T.Type, filter: String?) -> Array<T> where T: Object {
        if let dbFilter = filter {
            return Array(Storage.realm.objects(type).filter(dbFilter))
        } else {
            return Array(Storage.realm.objects(type))
        }
    }
}
