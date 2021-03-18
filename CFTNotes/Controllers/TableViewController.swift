//
//  TableViewController.swift
//  CFTNotes
//
//  Created by a_sid on 16.03.2021.
//

import UIKit

class TableViewController: UITableViewController {

    var notes = Notes.getNotes()
    
    
    @IBAction func addNewNotes(_ sender: UIBarButtonItem) {
    
    }
    
   // var notes: [String] = []


    override func viewDidLoad() {
        super.viewDidLoad()


    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  notes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.name
     
        return cell
    }


    // MARK: - Navigation

    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let notesVC = segue.source as? NotesViewController else {return}
        notesVC.saveNewNote()
        notes.append(notesVC.newNote!)
        tableView.reloadData()
        }

}
