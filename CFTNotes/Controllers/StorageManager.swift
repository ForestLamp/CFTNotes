//
//  StorageManager.swift
//  CFTNotes
//
//  Created by a_sid on 18.03.2021.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    static func saveObject(_ note: Notes){
        try! realm.write{
            realm.add(note)
        }
    }
    
    static func deleteObject (_ note: Notes) {
        try! realm.write {
            realm.delete(note)
        }
    }
}
