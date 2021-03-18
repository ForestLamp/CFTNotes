//
//  TableViewController.swift
//  CFTNotes
//
//  Created by a_sid on 16.03.2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    @IBAction func addNewNotes(_ sender: UIBarButtonItem) {
    
    }
    
   // var notes: [String] = []

    
    
    var cftNotes = ["Do", "DODO"]
    
    func getNotes() -> [Notes] {
        var notes = [Notes]()
        
        for note in cftNotes {
            notes.append(Notes(fullPreview: "Полная заметка"))
        }
        return notes
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cftNotes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

     
        return cell
    }


    // MARK: - Navigation

    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {}

}
