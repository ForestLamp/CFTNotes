//
//  Model.swift
//  CFTNotes
//
//  Created by a_sid on 17.03.2021.
//

import UIKit


struct Notes {
    
    var name: String
    
    static let testMassive = [
        "Burger Heroes", "Kitchen", "Bonsai", "Дастархан",
        "Индокитай", "X.O", "Балкан Гриль", "Sherlock Holmes",
        "Speak Easy", "Morris Pub", "Вкусные истории",
        "Классик", "Love&Life", "Шок", "Бочка"
    ]
    
    static func getNotes() -> [Notes]{
        
        var notes = [Notes]()
        
        for note in testMassive {
            notes.append(Notes(name: note))
        }
        return notes
    }
}
