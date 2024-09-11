import Foundation

protocol WeddingItemRepositoryProtocol: AnyObject {
    func addWeddingItem(_ weddingItem: WeddingItem) throws
    func readBy(id: UUID) throws -> WeddingItem?
    func updateWeddingItem(_ weddingItem: WeddingItem) throws
    func deleteBy(id: UUID) throws
    func fetchAll() throws -> [WeddingItem]
    func deleteAll() throws
    
    // Методы для работы с гостями
    func addGuest(_ guest: WeddingGuest, to weddingItem: WeddingItem) throws
    func removeGuest(_ guest: WeddingGuest, from weddingItem: WeddingItem) throws
    func updateGuest(_ guest: WeddingGuest, in weddingItem: WeddingItem) throws

    // Методы для работы с контактами
    func addContact(_ contact: WeddingContact, to weddingItem: WeddingItem) throws
    func removeContact(_ contact: WeddingContact, from weddingItem: WeddingItem) throws
    func updateContact(_ contact: WeddingContact, in weddingItem: WeddingItem) throws
}

final class WeddingItemRepositoryService: WeddingItemRepositoryProtocol {
    private let database: DBManagerProtocol
    
    init(database: DBManagerProtocol = DataBaseManager()) {
        self.database = database
    }
    
    func addWeddingItem(_ weddingItem: WeddingItem) throws {
        try database.addObject(WeddingItemObject(weddingItem))
    }
    
    func readBy(id: UUID) throws -> WeddingItem? {
        if let object = try database.readBy(WeddingItemObject.self, id: id) {
            return WeddingItem(object)
        } else {
            return nil
        }
    }
    
    func updateWeddingItem(_ weddingItem: WeddingItem) throws {
        try database.updateObject(WeddingItemObject(weddingItem))
    }
    
    func deleteBy(id: UUID) throws {
        try database.deleteBy(WeddingItemObject.self, key: id)
    }
    
    func fetchAll() throws -> [WeddingItem] {
        try database
            .fetchAll(WeddingItemObject.self)
            .compactMap { WeddingItem($0) }
    }
    
    func deleteAll() throws {
        try database.deleteAll()
    }
    
    // Добавление гостя в свадьбу
    func addGuest(_ guest: WeddingGuest, to weddingItem: WeddingItem) throws {
        guard var item = try readBy(id: weddingItem.id) else { return }
        item.guests.append(guest)
        try updateWeddingItem(item)
    }
    
    // Удаление гостя из свадьбы
    func removeGuest(_ guest: WeddingGuest, from weddingItem: WeddingItem) throws {
        guard var item = try readBy(id: weddingItem.id) else { return }
        item.guests.removeAll { $0.id == guest.id }
        try updateWeddingItem(item)
    }
    
    // Обновление гостя в свадьбе
    func updateGuest(_ guest: WeddingGuest, in weddingItem: WeddingItem) throws {
        guard var item = try readBy(id: weddingItem.id) else { return }
        if let index = item.guests.firstIndex(where: { $0.id == guest.id }) {
            item.guests[index] = guest
            try updateWeddingItem(item)
        }
    }
    
    // Добавление контакта в свадьбу
    func addContact(_ contact: WeddingContact, to weddingItem: WeddingItem) throws {
        guard var item = try readBy(id: weddingItem.id) else { return }
        item.contacts.append(contact)
        try updateWeddingItem(item)
    }
    
    // Удаление контакта из свадьбы
    func removeContact(_ contact: WeddingContact, from weddingItem: WeddingItem) throws {
        guard var item = try readBy(id: weddingItem.id) else { return }
        item.contacts.removeAll { $0.id == contact.id }
        try updateWeddingItem(item)
    }
    
    // Обновление контакта в свадьбе
    func updateContact(_ contact: WeddingContact, in weddingItem: WeddingItem) throws {
        guard var item = try readBy(id: weddingItem.id) else { return }
        if let index = item.contacts.firstIndex(where: { $0.id == contact.id }) {
            item.contacts[index] = contact
            try updateWeddingItem(item)
        }
    }
}
