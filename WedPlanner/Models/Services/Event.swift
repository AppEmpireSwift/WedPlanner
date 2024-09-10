import Foundation
import RealmSwift

// Структура для данных события
struct Event {
    let id: UUID
    var title: String
    var descriptionText: String
    var date: Date
    
    init(id: UUID = UUID(), title: String, descriptionText: String, date: Date = Date()) {
        self.id = id
        self.title = title
        self.descriptionText = descriptionText
        self.date = date
    }
    
    init(_ object: EventObject) {
        self.id = object.id
        self.title = object.title
        self.descriptionText = object.descriptionText
        self.date = object.date
    }
}

// Realm Object для хранения событий
class EventObject: Object, Identifiable {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var title: String
    @Persisted var descriptionText: String
    @Persisted var date: Date
}

extension EventObject {
    convenience init(_ event: Event) {
        self.init()
        self.id = event.id
        self.title = event.title
        self.descriptionText = event.descriptionText
        self.date = event.date
    }
}
