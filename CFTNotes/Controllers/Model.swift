//
//  Model.swift
//  CFTNotes
//
//  Created by a_sid on 17.03.2021.
//

import RealmSwift


class Notes: Object {
    
    @objc dynamic var name = ""
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
