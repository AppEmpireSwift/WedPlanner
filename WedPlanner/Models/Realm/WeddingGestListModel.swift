import Foundation
import RealmSwift

final class WeddingGestListModel: Object, ObjectKeyIdentifiable {
    @objc dynamic var id: ObjectId = ObjectId.generate()
    @objc dynamic var name: String = ""
    @objc dynamic var role: String = ""
    @objc dynamic var order: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
