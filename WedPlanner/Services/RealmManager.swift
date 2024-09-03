import Foundation
import RealmSwift

final class RealmManager: ObservableObject {
    @Published var weddingTasks = List<WeddingTaskModel>()
    var realm: Realm?
    
    init() {
        let realm = try? Realm()
        self.realm = realm
        
        initializeDefaultTasks()
        
        if let wedTasks = realm?.objects(WeddingTaskModel.self) {
            self.weddingTasks.append(objectsIn: wedTasks)
        }
    }
    
    // MARK: - Wedding Tasks Section
    
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
                        weddingTasks.append(weddingTask)
                    }
                }
            } catch {
                print("Ошибка при добавлении задач по умолчанию: \(error.localizedDescription)")
            }
        }
    }
    
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
                //weddingTasks.append(newTask)
            }
        } catch {
            print("Ошибка при добавлении задачи: \(error.localizedDescription)")
        }
    }
    
    func deleteTask(by id: ObjectId) {
        guard let realm = realm else { return }
        do {
            if let taskToDelete = realm.object(ofType: WeddingTaskModel.self, forPrimaryKey: id) {
                try realm.write {
                    if let index = weddingTasks.firstIndex(where: { $0._id == id }) {
                        weddingTasks.remove(at: index)
                    }
                    realm.delete(taskToDelete)
                }
            }
        } catch {
            print("Ошибка при удалении задачи: \(error.localizedDescription)")
        }
    }
    
    func deleteTask(at indexSet: IndexSet) {
        guard let realm = realm else { return }
        
        indexSet.forEach { index in
            let task = weddingTasks[index]
            if task.isTaskCanBeDeleted {
                do {
                    try realm.write {
                        weddingTasks.remove(at: index)
                        realm.delete(task)
                    }
                } catch {
                    print("Ошибка при удалении задачи по индексу: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func updateTask(by id: ObjectId, name: String, isSelected: Bool, isTaskCanBeDeleted: Bool, isTaskTypeStandart: Bool, spendText: String, totalText: String) {
        guard let realm = realm else { return }
        do {
            if let taskToUpdate = realm.object(ofType: WeddingTaskModel.self, forPrimaryKey: id) {
                try realm.write {
                    taskToUpdate.name = name
                    taskToUpdate.isSelected = isSelected
                    taskToUpdate.isTaskCanBeDeleted = isTaskCanBeDeleted
                    taskToUpdate.isTaskTypeStandart = isTaskTypeStandart
                    taskToUpdate.spendText = spendText
                    taskToUpdate.totalText = totalText
                }
            }
        } catch {
            print("Ошибка при обновлении задачи: \(error.localizedDescription)")
        }
    }
    
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
            }
        } catch {
            print("Ошибка при сбросе задач: \(error.localizedDescription)")
        }
    }
}
