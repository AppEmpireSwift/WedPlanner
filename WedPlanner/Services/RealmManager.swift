import Foundation
import RealmSwift

final class RealmManager: ObservableObject {
    @Published var weddingTasks: [WeddingTaskModel] = []
    @Published var weddings: [WeddingItemModel] = []
    var realm: Realm?

    init() {
        let realm = try? Realm()
        self.realm = realm
        
        fetchTasksData()
        fetchWeddingsData()
    }
    
    // MARK: - Wedding Tasks Section CRUD
    
    // R - Read
    private func fetchTasksData() {
        guard let realm = realm else { return }
        
        if weddingTasks.isEmpty {
            initializeDefaultTasks()
        }
        
        let results = realm.objects(WeddingTaskModel.self)
        
        self.weddingTasks = results.compactMap({ (wedTask) -> WeddingTaskModel? in
            return wedTask
        })
    }
    
    private func initializeDefaultTasks() {
        guard let realm = realm else { return }

        let existingTasks = realm.objects(WeddingTaskModel.self)
        if existingTasks.isEmpty {
            let defaultTasks = [
                ("Define a Wedding Budget", false, false, "", ""),
                ("Book a Wedding Venue", false, false, "", ""),
                ("Make a Guest List for the Bride's Side", false, true, "", ""),
                ("Make a Guest List for the Groom's Side", false, true, "", ""),
                ("Send Save-the-Dates and Invitations", false, true, "", ""),
                ("Create a Wedding Timeline", false, true, "", ""),
                ("Plan the Ceremony", false, true, "", ""),
                ("Hire a Caterer", false, false, "", ""),
                ("Purchase Wedding Attire", false, false, "", ""),
                ("Hire a Photographer/Videographer", false, false, "", ""),
                ("Arrange Entertainment", false, false, "", ""),
                ("Order Invitations and Stationery", false, false, "", ""),
                ("Book Transportation", false, false, "", ""),
                ("Order Wedding Cake", false, false, "", ""),
                ("Decorations and Flowers", false, false, "", ""),
                ("Coordinate with Wedding Party", false, true, "", ""),
                ("Plan the Reception Program", false, true, "", ""),
                ("Create a Seating Chart", false, true, "", ""),
                ("Write Thank You Notes", false, true, "", ""),
                ("Plan Pre-Wedding Events", false, true, "", "")
            ]

            do {
                try realm.write {
                    for task in defaultTasks {
                        let weddingTask = WeddingTaskModel()
                        weddingTask.name = task.0
                        weddingTask.isSelected = task.1
                        weddingTask.isTaskCanBeDeleted = false
                        weddingTask.isTaskTypeStandart = task.2
                        weddingTask.spendText = task.3
                        weddingTask.totalText = task.4
                        realm.add(weddingTask)
                        
                        fetchTasksData()
                    }
                }
            } catch {
                print("Ошибка при добавлении задач по умолчанию: \(error.localizedDescription)")
            }
        }
    }
    
    private func getSelectedTasks() -> List<WeddingTaskModel> {
        guard let realm = realm else { return List<WeddingTaskModel>() }
        
        let results = realm.objects(WeddingTaskModel.self).filter("isSelected == true")
        
        let selectedTasksList = List<WeddingTaskModel>()
        for task in results {
            selectedTasksList.append(task)
        }
        return selectedTasksList
    }
    
    //C - Create
    func addTaskWith(name: String, isStandartType: Bool, isTaskCanBeDeleted: Bool = false) {
        guard let realm = realm else { return }
        
        let newTask = WeddingTaskModel()
        newTask.name = name
        newTask.isSelected = false
        newTask.isTaskCanBeDeleted = isTaskCanBeDeleted
        newTask.isTaskTypeStandart = isStandartType
        newTask.spendText = ""
        newTask.totalText = ""
        
        do {
            try realm.write {
                realm.add(newTask)
                fetchTasksData()
            }
        } catch {
            print("Ошибка при добавлении задачи: \(error.localizedDescription)")
        }
    }
    
    //D - Delete
    func deleteTask(object: WeddingTaskModel) {
        guard let realm = realm else { return }
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("Ошибка при удалении задачи: \(error.localizedDescription)")
            return
        }
        fetchTasksData()
    }
    
    //U - Update
    func resetAllTasks() {
        guard let realm = realm else { return }
        do {
            let allTasks = realm.objects(WeddingTaskModel.self)
            try realm.write {
                allTasks.forEach { task in
                    task.isSelected = false
                    task.spendText = ""
                    task.totalText = ""
                }
                
                fetchTasksData()
            }
        } catch {
            print("Ошибка при сбросе задач: \(error.localizedDescription)")
        }
    }
    
    // MARK: - WeddingItem Scetion CRUD
    
    //C - Create
    func addWeddingWith(title: String, date: Date, location: String, budget: String, coverPhoto: Data, notes: String) {
        guard let realm = realm else { return }
        
        let newWedding = WeddingItemModel()
        newWedding.title = title
        newWedding.date = date
        newWedding.location = location
        newWedding.budget = budget
        newWedding.coverPhoto = coverPhoto
        newWedding.notes = notes
        newWedding.tasks = getSelectedTasks()
        
        do {
            try realm.write {
                realm.add(newWedding)
                fetchWeddingsData()
            }
        } catch {
            print("Ошибка при добавлении задачи: \(error.localizedDescription)")
        }
    }
    
    // R - Read
    private func fetchWeddingsData() {
        guard let realm = realm else { return }
        
        let results = realm.objects(WeddingItemModel.self)
        
        self.weddings = results.compactMap({ (wedTask) -> WeddingItemModel? in
            return wedTask
        })
    }
}
