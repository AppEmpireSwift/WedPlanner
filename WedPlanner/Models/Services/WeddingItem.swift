import Foundation
import RealmSwift

struct WeddingItem: Identifiable {
    let id: UUID
    var title: String
    var date: Date
    var location: String
    var budget: String
    var coverPhoto: Data
    var notes: String
    var order: Int
    var guests: [WeddingGuest] // Массив гостей
    var contacts: [WeddingContact] // Массив контактов

    init(id: UUID = UUID(),
         title: String,
         date: Date = Date(),
         location: String,
         budget: String,
         coverPhoto: Data = Data(),
         notes: String,
         order: Int,
         guests: [WeddingGuest] = [], // Инициализатор с гостями
         contacts: [WeddingContact] = []) { // Инициализатор с контактами
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
        self.guests = object.guests.map { WeddingGuest($0) } // Преобразование гостей
        self.contacts = object.contacts.map { WeddingContact($0) } // Преобразование контактов
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
    @Persisted var guests = List<WeddingGuestObject>() // Список гостей
    @Persisted var contacts = List<WeddingContactObject>() // Список контактов

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
        self.guests.append(objectsIn: weddingItem.guests.map { WeddingGuestObject($0) }) // Преобразование гостей
        self.contacts.append(objectsIn: weddingItem.contacts.map { WeddingContactObject($0) }) // Преобразование контактов
    }
}
