import Foundation
import RealmSwift

final class WeddingItemModel: Object, ObjectKeyIdentifiable {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var title: String = ""
    @objc dynamic var date: Date = Date()
    @objc dynamic var location: String = ""
    @objc dynamic var budget: String = ""
    @objc dynamic var coverPhoto: Data = Data()
    @objc dynamic var notes: String = ""
    @objc dynamic var order: Int = 0
    
    var tasks = List<WeddingTaskModel>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
