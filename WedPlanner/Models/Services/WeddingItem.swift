import Foundation
import RealmSwift

struct WeddingItem: Identifiable, Equatable {
    let id: UUID
    var title: String
    var date: Date
    var location: String
    var budget: String
    var coverPhoto: Data
    var notes: String
    var order: Int
    var guests: [WeddingGuest]
    var contacts: [WeddingContact]
    var tasksData: Data // Изменено с [WeddingTask] на Data

    static func == (lhs: WeddingItem, rhs: WeddingItem) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title
    }

    init(id: UUID = UUID(),
         title: String,
         date: Date = Date(),
         location: String,
         budget: String,
         coverPhoto: Data = Data(),
         notes: String,
         order: Int,
         guests: [WeddingGuest] = [],
         contacts: [WeddingContact] = [],
         tasksData: Data = Data()) { // Инициализатор с Data для задач
        self.id = id
        self.title = title
        self.date = date
        self.location = location
        self.budget = budget
        self.coverPhoto = coverPhoto
        self.notes = notes
        self.order = order
        self.guests = guests
        self.contacts = contacts
        self.tasksData = tasksData
    }

    init(_ object: WeddingItemObject) {
        self.id = object.id
        self.title = object.title
        self.date = object.date
        self.location = object.location
        self.budget = object.budget
        self.coverPhoto = object.coverPhoto
        self.notes = object.notes
        self.order = object.order
        self.guests = object.guests.map { WeddingGuest($0) }
        self.contacts = object.contacts.map { WeddingContact($0) }
        self.tasksData = object.tasksData // Преобразование задач из Data
    }
}


class WeddingItemObject: Object, Identifiable {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var title: String
    @Persisted var date: Date
    @Persisted var location: String
    @Persisted var budget: String
    @Persisted var coverPhoto: Data
    @Persisted var notes: String
    @Persisted var order: Int
    @Persisted var guests = List<WeddingGuestObject>()
    @Persisted var contacts = List<WeddingContactObject>()
    @Persisted var tasksData: Data = Data() // Хранение задач как Data

    convenience init(_ weddingItem: WeddingItem) {
        self.init()
        self.id = weddingItem.id
        self.title = weddingItem.title
        self.date = weddingItem.date
        self.location = weddingItem.location
        self.budget = weddingItem.budget
        self.coverPhoto = weddingItem.coverPhoto
        self.notes = weddingItem.notes
        self.order = weddingItem.order
        self.guests.append(objectsIn: weddingItem.guests.map { WeddingGuestObject($0) })
        self.contacts.append(objectsIn: weddingItem.contacts.map { WeddingContactObject($0) })
        self.tasksData = weddingItem.tasksData // Сохранение задач как Data
    }
}

