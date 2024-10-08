import SwiftUI
import Combine

final class WeddingTasksViewModel: ObservableObject {
    @Published var tasks: [WeddingTask] = []
    @Published var newTaskStorage: [WeddingTask] = []
    
    private let repository: WeddingTaskRepositoryProtocol
    
    init(repository: WeddingTaskRepositoryProtocol = WeddingTaskRepositoryService()) {
        self.repository = repository
        fetchAllTasks()
        fetchNewTaskStorage()
    }
    
    func fetchAllTasks() {
        do {
            tasks = try repository.fetchAll()
            if tasks.isEmpty {
                addDefaultTasks()
            }
        } catch {
            print("Ошибка при получении задач: \(error.localizedDescription)")
        }
    }
    
    func fetchNewTaskStorage() {
        newTaskStorage = tasks
    }
    
    private func addDefaultTasks() {
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
        
        for task in defaultTasks {
            let (name, isTaskCanBeDeleted, isTaskTypeStandart, spendText, totalText) = task
            let newTask = WeddingTask(
                name: name,
                isSelected: false,
                isTaskCanBeDeleted: isTaskCanBeDeleted,
                isTaskTypeStandart: isTaskTypeStandart,
                spendText: spendText,
                totalText: totalText
            )
            do {
                try repository.addTask(newTask)
            } catch {
                print("Ошибка при добавлении дефолтных задач: \(error.localizedDescription)")
            }
        }
        fetchAllTasks()
    }
    
    func addTask(name: String, isSelected: Bool = false, isTaskCanBeDeleted: Bool = false, isTaskTypeStandart: Bool = true, spendText: String = "", totalText: String = "") {
        let newTask = WeddingTask(name: name, isSelected: isSelected, isTaskCanBeDeleted: isTaskCanBeDeleted, isTaskTypeStandart: isTaskTypeStandart, spendText: spendText, totalText: totalText)
        do {
            try repository.addTask(newTask)
            fetchAllTasks()
        } catch {
            print("Ошибка при добавлении задачи: \(error.localizedDescription)")
        }
    }
    
    func updateTask(_ task: WeddingTask, name: String, isSelected: Bool, isTaskCanBeDeleted: Bool, isTaskTypeStandart: Bool, spendText: String, totalText: String) {
        var updatedTask = task
        updatedTask.name = name
        updatedTask.isSelected = isSelected
        updatedTask.isTaskCanBeDeleted = isTaskCanBeDeleted
        updatedTask.isTaskTypeStandart = isTaskTypeStandart
        updatedTask.spendText = spendText
        updatedTask.totalText = totalText
        
        do {
            try repository.updateTask(updatedTask)
            fetchAllTasks()
        } catch {
            print("Ошибка при обновлении задачи: \(error.localizedDescription)")
        }
    }
    
    func updateTask(_ task: WeddingTask) {
        do {
            if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                tasks[index] = task
                try repository.updateTask(task)
            }
            fetchNewTaskStorage()
        } catch {
            print("Ошибка при обновлении задачи: \(error.localizedDescription)")
        }
    }
    
    func updateNewTaskStorage(with tasks: [WeddingTask]) {
         newTaskStorage = tasks
     }
    
    func deleteTask(_ task: WeddingTask) {
        do {
            try repository.deleteBy(id: task.id)
            fetchAllTasks()
        } catch {
            print("Ошибка при удалении задачи: \(error.localizedDescription)")
        }
    }
    
    func toggleTaskSelection(_ task: WeddingTask) {
        var updatedTask = task
        updatedTask.isSelected.toggle()
        
        do {
            try repository.updateTask(updatedTask)
            fetchAllTasks()
        } catch {
            print("Ошибка при изменении статуса задачи: \(error.localizedDescription)")
        }
    }
    
    func fetchSelectedTasks() -> [WeddingTask] {
        return tasks.filter { $0.isSelected }
    }
    
    func deselectAllTasks() {
        let allTasks = tasks
        let updatedTasks = allTasks.map { task -> WeddingTask in
            var updatedTask = task
            updatedTask.isSelected = false
            updatedTask.spendText = ""
            updatedTask.totalText = ""
            return updatedTask
        }
        
        for task in updatedTasks {
            do {
                try repository.updateTask(task)
            } catch {
                print("Ошибка при обновлении задачи: \(error.localizedDescription)")
            }
        }
        fetchAllTasks()
    }
}
