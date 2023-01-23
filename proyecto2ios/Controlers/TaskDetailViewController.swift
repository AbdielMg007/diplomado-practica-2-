//
//  TaskDetailViewController.swift
//  proyecto2ios
//
//  Created by Abdiel Mg on 28/12/22.
//

import UIKit
import CoreData.NSManagedObjectContext

final class TaskDetailViewController: UITableViewController {
    

    @IBOutlet var taskTitle: UITextField!
    @IBOutlet var taskDate: UIDatePicker!
    @IBOutlet var taskNotes: UITextView!
    @IBOutlet var taskCancelButton: UIBarButtonItem!
    @IBOutlet var taskSaveButton: UIBarButtonItem!
    
    let context = (UIApplication.shared.delegate! as! AppDelegate).persistentContainer.viewContext
    
    var toDoDetailTask : Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTapGesture()
        setupAccessibleTextSize()
        tasks()

    }
    
    @objc private func tasks() {
        if toDoDetailTask != nil{
            taskTitle.text = toDoDetailTask?.title
            taskDate.date = (toDoDetailTask?.date)!
            taskNotes.text = toDoDetailTask?.notes
        }
        else{
            toDoDetailTask = Task(context: context)
            taskTitle.text = ""
        }
    }
    
    private func setupTapGesture() {
      let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
      tapGesture.cancelsTouchesInView = false
      self.view.addGestureRecognizer(tapGesture)
    }
    
    private func setupAccessibleTextSize() {
      taskNotes.adjustsFontForContentSizeCategory = true
      taskTitle.adjustsFontForContentSizeCategory = true
    }
    
    
    private func showAlert(alertTitle: String, message: String, actionTitle: String, vc: UIViewController) {
      let alert: UIAlertController = UIAlertController(
        title: NSLocalizedString(alertTitle, comment: ""),
        message: NSLocalizedString(message, comment: ""),
        preferredStyle: .alert)
      let alertAction: UIAlertAction = UIAlertAction(
        title: NSLocalizedString(actionTitle, comment: ""),
        style: .default) { _ in
          alert.dismiss(animated: true)
        }
      
      alert.addAction(alertAction)
      present(alert, animated: true)
    }
    
    @IBAction func taskCancelButtonPressed(_ sender: UIBarButtonItem) {
        if self.presentingViewController is UINavigationController {
          self.dismiss(animated: true)
        } else {
          navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func hideKeyboard() {
      self.view.endEditing(true)
    }

    // MARK: - Segue-related methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ToDoListViewController
        
        toDoDetailTask?.title = taskTitle.text ?? ""
        toDoDetailTask?.date = taskDate.date
        toDoDetailTask?.notes = taskNotes.text
        
        destination.currentTask = toDoDetailTask!
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if validateText(text: taskTitle.text) {
          return true
        } else {
          showAlert(alertTitle: Localizables.dvAlertTitle.rawValue,
                    message: Localizables.dvAlertMessage.rawValue,
                    actionTitle: Localizables.dvAlertActionTitle.rawValue,
                    vc: self)
        }
        return false
    }
    
}

extension TaskDetailViewController {
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 0: return NSLocalizedString(Localizables.dvTitleLabelText.rawValue, comment: "")
    case 1: return NSLocalizedString(Localizables.dvDateLabelText.rawValue, comment: "")
    case 2: return NSLocalizedString(Localizables.dvAdditionalNoteLabelText.rawValue, comment: "")
    default: return ""
    }
  }
}
