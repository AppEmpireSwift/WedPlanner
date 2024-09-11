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
        } catch {
            print("Ошибка при получении задач: \(error.localizedDescription)")
        }
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
}
