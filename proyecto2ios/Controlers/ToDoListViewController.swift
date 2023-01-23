//
//  ToDoListViewController.swift
//  proyecto2ios
//
//  Created by Abdiel Mg on 28/12/22.
//

import UIKit

class ToDoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var toDoListTable: UITableView!
    let context = (UIApplication.shared.delegate! as! AppDelegate).persistentContainer.viewContext
    var currentTask : Task?
    var dataManager : TaskDataManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toDoListTable.delegate = self
        toDoListTable.dataSource = self

        dataManager = TaskDataManager(context: context)
        dataManager!.fecth()
    }
    
    
    @IBAction func unWindFromDetail(segue: UIStoryboardSegue){
        let source = segue.source as! TaskDetailViewController
        currentTask = source.toDoDetailTask
            do{
                try context.save()
            }
            catch{
                print("Error al salvar", error)
            }
        dataManager?.fecth()
        self.toDoListTable.reloadData()
    }
    
    private func loadListElements(with predicate: String = "") {
      if predicate.isEmpty {
        dataManager?.fecth()
      } else {
        dataManager?.fecthWithPredicate(searchValue: predicate)
      }
        toDoListTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataManager?.countTask())!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoTaskCell", for: indexPath) as! ToDoTaskViewCell
        cell.taskTitle.text = dataManager?.getTask(at: indexPath.row).title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "taskSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        dataManager?.delete(at: indexPath.row)
        loadListElements()
      }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "taskSegue" {
            let destination = segue.destination as! TaskDetailViewController
            destination.toDoDetailTask = dataManager?.getTask(at: toDoListTable.indexPathForSelectedRow!.row )
        }
    }
}
