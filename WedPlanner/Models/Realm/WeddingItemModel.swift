import Foundation
import RealmSwift

final class WeddingItemModel: Object, ObjectKeyIdentifiable {
    @objc dynamic var _id = ObjectId.generate()
    @objc dynamic var title: String = ""
    @objc dynamic var date: Date = Date()
    @objc dynamic var location: String = ""
    @objc dynamic var budget: String = ""
    @objc dynamic var coverPhoto: Data = Data()
    @objc dynamic var notes: String = ""
    
    var tasks = List<WeddingTaskModel>()
    
    override class func primaryKey() -> String? {
        "_id"
    }
}
