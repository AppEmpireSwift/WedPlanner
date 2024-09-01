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
            ("Define a Wedding Budget", true, true, true, "", ""),
            ("Book a Wedding Venue", true, true, true, "", ""),
            ("Make a Guest List for the Bride's Side", true, true, true, "", ""),
            ("Make a Guest List for the Groom's Side", true, true, true, "", ""),
            ("Send Save-the-Dates and Invitations", true, true, true, "", ""),
            ("Create a Wedding Timeline", true, true, true, "", ""),
            ("Plan the Ceremony", true, true, true, "", ""),
            ("Hire a Caterer", true, true, true, "", ""),
            ("Purchase Wedding Attire", true, true, true, "", ""),
            ("Hire a Photographer/Videographer", true, true, true, "", ""),
            ("Arrange Entertainment", true, true, true, "", ""),
            ("Order Invitations and Stationery", true, true, true, "", ""),
            ("Book Transportation", true, true, true, "", ""),
            ("Order Wedding Cake", true, true, true, "", ""),
            ("Decorations and Flowers", true, true, true, "", ""),
            ("Coordinate with Wedding Party", true, true, true, "", ""),
            ("Plan the Reception Program", true, true, true, "", ""),
            ("Create a Seating Chart", true, true, true, "", ""),
            ("Write Thank You Notes", true, true, true, "", ""),
            ("Plan Pre-Wedding Events", true, true, true, "", "")
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
