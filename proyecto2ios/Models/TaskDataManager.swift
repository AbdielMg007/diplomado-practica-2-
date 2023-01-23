//
//  TaskDataManager.swift
//  proyecto2ios
//
//  Created by Abdiel Mg on 28/12/22.
//

import Foundation

import Foundation
import CoreData

class TaskDataManager{
    
    private var tasks : [Task] = []
    private var context : NSManagedObjectContext
    
    init(context : NSManagedObjectContext){
        self.context = context
    }
    
    func fecth() {
        do{
            self.tasks = try self.context.fetch(Task.fetchRequest())
        }
        catch{
            print("Error:", error)
        }
    }
    
    func delete(at index: Int) {
      fecth()
      context.delete(tasks[index])
      saveContext(with: context)
    }
    
    func fecthWithPredicate(searchValue : String) {
        
        do{
            let fetchRequestWP = NSFetchRequest<Task>(entityName: "Task")
            fetchRequestWP.predicate = NSPredicate(format: "title = %@", searchValue)
            print(fetchRequestWP)
            self.tasks = try self.context.fetch(fetchRequestWP)
            print(tasks)
        }
        catch{
            print("Error:", error)
        }
    }
    
    //Compount
    func fecthWithCompountPredicate(title : String = "", notes: String = ""  ) {
        var predicates : [NSPredicate] = []
        
        if !(title.isEmpty) {
            predicates.append(NSPredicate(format: "title LIKE %@", title))
        }
        if !(notes.isEmpty) {
            predicates.append(NSPredicate(format: "notes LIKE %@", notes))
        }
        
        let compountPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
        
        do{
            let fetchRequestWCP = NSFetchRequest<Task>(entityName: "Task")
            fetchRequestWCP.predicate = compountPredicate
            print(fetchRequestWCP)
            self.tasks = try self.context.fetch(fetchRequestWCP)
            print(tasks)
        }
        catch{
            print("Error:", error)
        }
    }
    
    func getTask(at index : Int) -> Task {
        return tasks[index]
    }
    
    func countTask() -> Int {
        return tasks.count
    }
    
    func pushTask(newtask : Task){
        tasks.append(newtask)
    }
    
    func saveContext(with context: NSManagedObjectContext) {
      do {
        try context.save()
      } catch {
        print ("Error saving context: \(error)")
      }
    }
    
}

