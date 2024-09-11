import SwiftUI
import Combine

final class WeddingTasksViewModel: ObservableObject {
    @Published var tasks: [WeddingTask] = []
    
    private let repository: WeddingTaskRepositoryProtocol
    
    init(repository: WeddingTaskRepositoryProtocol = WeddingTaskRepositoryService()) {
        self.repository = repository
        fetchAllTasks()
    }
    
    func fetchAllTasks() {
        do {
            tasks = try repository.fetchAll()
            // Проверяем, если tasks пустой, добавляем дефолтные задачи
            if tasks.isEmpty {
                addDefaultTasks()
            }
        } catch {
            print("Ошибка при получении задач: \(error.localizedDescription)")
        }
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
        
        // Обновляем список задач после добавления дефолтных
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
    
    // Метод для получения всех выбранных задач
    func fetchSelectedTasks() -> [WeddingTask] {
        return tasks.filter { $0.isSelected }
    }
    
    // Метод для сброса всех задач (установить isSelected в false)
    func deselectAllTasks() {
        let allTasks = tasks
        let updatedTasks = allTasks.map { task -> WeddingTask in
            var updatedTask = task
            updatedTask.isSelected = false
            updatedTask.spendText = ""
            updatedTask.totalText = ""
            return updatedTask
        }
        
        // Обновляем все задачи в репозитории
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
