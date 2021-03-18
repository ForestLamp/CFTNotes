//
//  TableViewController.swift
//  CFTNotes
//
//  Created by a_sid on 16.03.2021.
//

import UIKit
import RealmSwift

class TableViewController: UITableViewController {

    var notes: Results<Notes>!
    
    @IBAction func addNewNotes(_ sender: UIBarButtonItem) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        notes = realm.objects(Notes.self)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.isEmpty ? 0 : notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.name

        return cell
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let note = notes[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (_, _) in
            StorageManager.deleteObject(note)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return [deleteAction]
    }


    // MARK: - Navigation
   
// Передаем объект выбранной ячейки на NotesVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let note = notes[indexPath.row]
            let newNoteVC = segue.destination as! NotesViewController
            newNoteVC.currentNote = note
        }
    }

    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let notesVC = segue.source as? NotesViewController else {return}
        notesVC.saveNote()
 
        tableView.reloadData()
        }
}
