//
//  NotesViewController.swift
//  CFTNotes
//
//  Created by a_sid on 17.03.2021.
//

import UIKit

class NotesViewController: UIViewController {
    
    var newNote: Notes?

// MARK: Outlets & Actions
    
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
 
//Отключение кнопки Save если заметка не набиралась
    // saveButton.isEnabled = false

        fullNotesField.font = UIFont(name: "Avenir-Book", size: 20)
        fullNotesField.backgroundColor = view.self.backgroundColor
        fullNotesField.layer.cornerRadius = 15
    
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
    
    func saveNewNote() {
        newNote = Notes(name: fullNotesField.text)
    }
    

}

// MARK: UITextFieldDelegate

extension NotesViewController: UITextFieldDelegate, UITextViewDelegate{
    
// Скрываем клавиатуру по нажанию на Done в заголовке (Временно не используем)
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
    
   
// Меняем бэкграунд в зависимости от ситуации (редактируем текст или нет)
  
    func textViewDidBeginEditing(_ textView: UITextView) {
        fullNotesField.backgroundColor = .white
        fullNotesField.textColor = .gray
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        fullNotesField.backgroundColor = self.view.backgroundColor
        fullNotesField.textColor = .black
    }
    
// Отключим кнопку сохранения если текст заметки не вводился
//    @objc private func textFieldChanged() {
//        if fullNotesField.text?.isEmpty == false {
//            saveButton.isEnabled = true
//        } else {
//            saveButton.isEnabled = false
//        }
//    }
}

    
