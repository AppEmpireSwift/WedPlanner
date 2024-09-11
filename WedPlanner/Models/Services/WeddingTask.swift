import Foundation
import RealmSwift

struct WeddingTask {
    let id: UUID
    var name: String
    var isSelected: Bool
    var isTaskCanBeDeleted: Bool
    var isTaskTypeStandart: Bool
    var spendText: String
    var totalText: String
    
    init(id: UUID = UUID(), name: String, isSelected: Bool = false, isTaskCanBeDeleted: Bool = false, isTaskTypeStandart: Bool = true, spendText: String = "", totalText: String = "") {
        self.id = id
        self.name = name
        self.isSelected = isSelected
        self.isTaskCanBeDeleted = isTaskCanBeDeleted
        self.isTaskTypeStandart = isTaskTypeStandart
        self.spendText = spendText
        self.totalText = totalText
    }
    
    init(_ object: WeddingTaskObject) {
        self.id = object.id
        self.name = object.name
        self.isSelected = object.isSelected
        self.isTaskCanBeDeleted = object.isTaskCanBeDeleted
        self.isTaskTypeStandart = object.isTaskTypeStandart
        self.spendText = object.spendText
        self.totalText = object.totalText
    }
}

class WeddingTaskObject: Object, Identifiable {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var name: String
    @Persisted var isSelected: Bool
    @Persisted var isTaskCanBeDeleted: Bool
    @Persisted var isTaskTypeStandart: Bool
    @Persisted var spendText: String
    @Persisted var totalText: String
}

extension WeddingTaskObject {
    convenience init(_ task: WeddingTask) {
        self.init()
        self.id = task.id
        self.name = task.name
        self.isSelected = task.isSelected
        self.isTaskCanBeDeleted = task.isTaskCanBeDeleted
        self.isTaskTypeStandart = task.isTaskTypeStandart
        self.spendText = task.spendText
        self.totalText = task.totalText
    }
}
