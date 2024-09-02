import SwiftUI
import RealmSwift

struct WeddingViewModelStates {
    var isDataEmpty: Bool = true
}

final class WeddingViewModel: ObservableObject {
    @AppStorage("wedding_Details") var isWedDetailsClosed = false
    @AppStorage("wedding_Tasks") var isWedTasksClosed = false
    @Published var states = WeddingViewModelStates()
    @ObservedResults(WeddingTaskModel.self) var existingTasks
    private let realmManager = RealmManager()
    
    // MARK: - AddNewWedding Section
    
    func closeWeddingDetails() {
        isWedDetailsClosed = true
    }
    
    // MARK: - AddWeddingTasks Section
    
    func closeWeddingTasks() {
        isWedTasksClosed = true
    }
    
    func addNewTaskWith(name: String, isStandartType: Bool) {
        realmManager.addTaskWith(name: name, isStandartType: isStandartType, isTaskCanBeDeleted: true)
    }
    
    func deleteWeddingTask(for objcID: ObjectId) {
        realmManager.deleteTask(by: objcID)
    }
}
