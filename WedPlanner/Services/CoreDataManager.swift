import Foundation
import CoreData

final class CoreDataManager: NSObject, ObservableObject {
    @Published var existingTasks: [WedTaskType] = []
    
    let container: NSPersistentContainer
    
    override init() {
        container = NSPersistentContainer(name: "Model")
        super.init()
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading Core Data: \(error)")
            } else {
                self.fetchTasks()
                self.checkAndAddDefaultTasks()
            }
        }
    }
    
    // MARK: - CRUD Methods
    
    private func checkAndAddDefaultTasks() {
        if existingTasks.isEmpty {
            addDefaultTasks()
        }
    }
    
    private func addDefaultTasks() {
        let context = container.viewContext
        
        let defaultTasks = [
            ("Define a Wedding Budget", false, false, true, "", ""),
            ("Book a Wedding Venue", false, false, true, "", ""),
            ("Make a Guest List for the Bride's Side", false, true, true, "", ""),
            ("Make a Guest List for the Groom's Side", false, true, true, "", ""),
            ("Send Save-the-Dates and Invitations", false, true, true, "", ""),
            ("Create a Wedding Timeline", false, true, true, "", ""),
            ("Plan the Ceremony", false, true, true, "", ""),
            ("Hire a Caterer", false, false, true, "", ""),
            ("Purchase Wedding Attire", false, false, true, "", ""),
            ("Hire a Photographer/Videographer", false, false, true, "", ""),
            ("Arrange Entertainment", false, false, true, "", ""),
            ("Order Invitations and Stationery", false, false, true, "", ""),
            ("Book Transportation", false, false, true, "", ""),
            ("Order Wedding Cake", false, false, true, "", ""),
            ("Decorations and Flowers", false, false, true, "", ""),
            ("Coordinate with Wedding Party", false, true, true, "", ""),
            ("Plan the Reception Program", false, true, true, "", ""),
            ("Create a Seating Chart", false, true, true, "", ""),
            ("Write Thank You Notes", false, true, true, "", ""),
            ("Plan Pre-Wedding Events", false, true, true, "", "")
        ]
        
        for task in defaultTasks {
            let newTask = WedTaskType(context: context)
            newTask.id = UUID()
            newTask.name = task.0
            newTask.isSelected = task.1
            newTask.isStandartType = task.2
            newTask.isTaskDefault = task.3
            newTask.spendText = task.4
            newTask.totalText = task.5
        }
        
        saveContext()
        fetchTasks()
    }
    
    func fetchTasks() {
        let request: NSFetchRequest<WedTaskType> = WedTaskType.fetchRequest()
        
        do {
            existingTasks = try container.viewContext.fetch(request)
        } catch {
            print("Error fetching tasks: \(error)")
        }
    }
    
    func addTask(name: String, isStandartType: Bool) {
        let context = container.viewContext
        
        let newTask = WedTaskType(context: context)
        newTask.id = UUID()
        newTask.name = name
        newTask.isSelected = false
        newTask.isStandartType = isStandartType
        newTask.isTaskDefault = false
        newTask.spendText = ""
        newTask.totalText = ""
        
        saveContext()
        fetchTasks()
    }
    
    func updateTask(task: WedTaskType, name: String, isSelected: Bool, isStandartType: Bool, isTaskDefault: Bool, spendText: String, totalText: String) {
        task.name = name
        task.isSelected = isSelected
        task.isStandartType = isStandartType
        task.isTaskDefault = isTaskDefault
        task.spendText = spendText
        task.totalText = totalText
        
        saveContext()
        fetchTasks()
    }
    
    func deleteTask(task: WedTaskType) {
        let context = container.viewContext
        context.delete(task)
        
        saveContext()
        fetchTasks()
    }
    
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving Core Data context: \(error)")
            }
        }
    }
}
