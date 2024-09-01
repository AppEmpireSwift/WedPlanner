import SwiftUI

struct WeddingViewModelStates {
    var isDataEmpty: Bool = true
    var tasks: [WedTaskType] = []
}

final class WeddingViewModel: ObservableObject {
    @AppStorage("wedding_Details") var isWedDetailsClosed = false
    @AppStorage("wedding_Tasks") var isWedTasksClosed = false
    @Published var states = WeddingViewModelStates()
    
    private var coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = CoreDataManager()) {
        self.coreDataManager = coreDataManager
        self.states.tasks = coreDataManager.existingTasks
    }
    
    // MARK: - AddNewWedding Section
    
    func closeWeddingDetails() {
        isWedDetailsClosed = true
    }
    
    // MARK: - AddWeddingTasks Section
    
    func fetchTasks() {
        coreDataManager.fetchTasks()
        self.states.tasks = coreDataManager.existingTasks
    }
    
    func closeWeddingTasks() {
        isWedTasksClosed = true
    }
    
    func addNewTask(name: String, isStandartType: Bool) {
        coreDataManager.addTask(name: name, isStandartType: isStandartType)
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
