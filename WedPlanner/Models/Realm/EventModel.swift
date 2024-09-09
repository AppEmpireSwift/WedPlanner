import RealmSwift
import Foundation

final class EventModel: Object, ObjectKeyIdentifiable {
    @objc dynamic var id: ObjectId = ObjectId.generate()
    @objc dynamic var title: String = ""
    @objc dynamic var descriptionText: String = ""
    @objc dynamic var date: Date = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
