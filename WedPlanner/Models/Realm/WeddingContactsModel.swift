import Foundation
import RealmSwift

final class WeddingContactsModel: Object, ObjectKeyIdentifiable {
    @objc dynamic var id: ObjectId = ObjectId.generate()
    @objc dynamic var name: String = ""
    @objc dynamic var phoneNum: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var adress: String = ""
    @objc dynamic var birthDay: String = ""
    @objc dynamic var notes: String = ""
    @objc dynamic var order: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
