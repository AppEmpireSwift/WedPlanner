import Foundation
import RealmSwift

final class WeddingTaskModel: Object, ObjectKeyIdentifiable {
    @objc dynamic var _id = ObjectId.generate()
    @objc dynamic var name: String = ""
    @objc dynamic var isSelected: Bool = false
    @objc dynamic var isTaskCanBeDeleted: Bool = false
    @objc dynamic var isTaskTypeStandart: Bool = true
    @objc dynamic var spendText: String = ""
    @objc dynamic var totalText: String = ""
    
    override class func primaryKey() -> String? {
        "_id"
    }
}
