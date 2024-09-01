import SwiftUI

struct WeddingViewModelStates {
    var isDataEmpty: Bool = true
    var tasks: [WedTaskType] = []
}

final class WeddingViewModel: ObservableObject {
    @AppStorage("wedding_Details") var isWedDetailsClosed = false
    @AppStorage("wedding_Tasks") var isWedTasksClosed = false
    @Published var states = WeddingViewModelStates()
    
    private var coreDataManager: CoreDataManager = CoreDataManager()
    
    init() {
        self.states.tasks = coreDataManager.existingTasks
    }
    
    // MARK: - AddNewWedding Section
    
    func closeWeddingDetails() {
        isWedDetailsClosed = true
    }
    
    
    // MARK: - AddWeddingTasks Section
    
    private func fetchTasks() {
        coreDataManager.fetchTasks()
        self.states.tasks = coreDataManager.existingTasks
    }
    
    func closeWeddingTasks() {
        isWedTasksClosed = true
    }
    
    func convertTaskModel(from old: WedTaskType) -> WeddingTaskItemModel {
        WeddingTaskItemModel(
            id: old.id!,
            name: old.name!,
            taskType: old.isStandartType ? .standart : .withFields,
            isSelected: old.isSelected,
            spendText: old.spendText!,
            totalText: old.totalText!,
            isDefaultTask: old.isTaskDefault
        )
    }
    
    func addNewTaskType(name: String, isStandartType: Bool) {
        let newTask = WedTaskType(context: coreDataManager.container.viewContext)
        newTask.id = UUID()
        newTask.name = name
        newTask.isSelected = false
        newTask.isStandartType = isStandartType
        newTask.isTaskDefault = false
        newTask.spendText = ""
        newTask.totalText = ""
        
        fetchTasks()
    }
    
    func updateTask(task: WedTaskType, name: String, isSelected: Bool, isStandartType: Bool, isTaskDefault: Bool, spendText: String, totalText: String) {
        coreDataManager.updateTask(task: task, name: name, isSelected: isSelected, isStandartType: isStandartType, isTaskDefault: isTaskDefault, spendText: spendText, totalText: totalText)
        fetchTasks()
    }

    func deleteTask(task: WedTaskType) {
        coreDataManager.deleteTask(task: task)
        fetchTasks()
    }
    
}
