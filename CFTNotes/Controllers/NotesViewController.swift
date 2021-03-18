//
//  NotesViewController.swift
//  CFTNotes
//
//  Created by a_sid on 17.03.2021.
//

import UIKit

class NotesViewController: UIViewController {
    
    var currentNote: Notes?
    
    
// TextView
    @IBOutlet weak var fullNotesField: UITextView!
// SaveButton
    @IBOutlet weak var saveButton: UIBarButtonItem!
// Кнопка Cancel
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fullNotesField.delegate = self
 
        fullNotesField.font = UIFont(name: "Avenir-Book", size: 20)
        fullNotesField.backgroundColor = view.self.backgroundColor
        fullNotesField.layer.cornerRadius = 15
 
        // Плейсхолдер
        fullNotesField.text = "Placeholder"
        fullNotesField.textColor = UIColor.lightGray
        fullNotesField.returnKeyType = .default
        fullNotesField.delegate = self
    
// Наблюдатель начало редактирования
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTextView(notification:)),
                                               name: UIApplication.keyboardWillChangeFrameNotification, object: nil)
// Наблюдатель конец редактирования
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTextView(notification:)),
                                               name: UIApplication.keyboardWillHideNotification, object: nil)
        
// Плейсхолдер для TextView (надо допилить, не удаляется)
        //        fullNotesField.text = "Placeholder"
        //        fullNotesField.textColor = UIColor.lightGray
        
        setupEditScreen()
        
    }

//Поднимаем контент Text Field при появлении клавиатуры на высоту клавиатуры
    @objc func updateTextView(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: AnyObject],
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        
        else {
            return
        }
        
        if notification.name == UIApplication.keyboardWillHideNotification {
            fullNotesField.contentInset = UIEdgeInsets.zero
        } else {
            fullNotesField.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
            fullNotesField.scrollIndicatorInsets = fullNotesField.contentInset
        }
        fullNotesField.scrollRangeToVisible(fullNotesField.selectedRange)
    }
    
// Скрываем клавиатуру только для Text View
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        fullNotesField.resignFirstResponder()
    }

// Сохраняем данные
    
    func saveNote() {

        let newNote = Notes(name: fullNotesField.text!)
        if currentNote != nil {
            try! realm.write {
                currentNote?.name = newNote.name
            }
        } else {
            StorageManager.saveObject(newNote)
        }
    }

// Проверим содержимое
    private func setupEditScreen (){
        if currentNote != nil {
            
            setupNavigationBar()
            fullNotesField.text = currentNote?.name
        }
    }
    
    private func setupNavigationBar() {
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        navigationItem.leftBarButtonItem = nil
        title = "Редактирование"
        saveButton.isEnabled = true
    }
    
}

// MARK: UITextViewDelegate

extension NotesViewController: UITextViewDelegate {
    
// Меняем бэкграунд в зависимости от ситуации (редактируем текст или нет)
  
    func textViewDidBeginEditing(_ textView: UITextView) {
        fullNotesField.backgroundColor = .white
        fullNotesField.textColor = .gray
        
// Плейсхолдер
        if textView.text == "Placeholder" {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if text == "\n" {
//            textView.resignFirstResponder()
//        }
//        return true
//    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        fullNotesField.backgroundColor = self.view.backgroundColor
        fullNotesField.textColor = .black
// Плейсхолдер
        if textView.text == "" {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }

    }
    
// Отключим кнопку сохранения если текст заметки не вводился
    @objc private func textFieldChanged() {
        if fullNotesField.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}

    
