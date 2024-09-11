import Foundation
import RealmSwift

// Модель Swift
struct WeddingGuest {
    let id: UUID
    var name: String
    var role: String
    var order: Int
    
    init(id: UUID = UUID(), name: String, role: String, order: Int = 0) {
        self.id = id
        self.name = name
        self.role = role
        self.order = order
    }
    
    init(_ object: WeddingGuestObject) {
        self.id = object.id
        self.name = object.name
        self.role = object.role
        self.order = object.order
    }
}

class WeddingGuestObject: Object, Identifiable {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var name: String
    @Persisted var role: String
    @Persisted var order: Int
    
    convenience init(_ guest: WeddingGuest) {
        self.init()
        self.id = guest.id
        self.name = guest.name
        self.role = guest.role
        self.order = guest.order
    }
}
