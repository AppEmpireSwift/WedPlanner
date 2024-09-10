import Foundation
import RealmSwift

protocol EventRepositoryProtocol: AnyObject {
    func addEvent(_ event: Event) throws
    func readBy(id: UUID) throws -> Event?
    func updateEvent(_ event: Event) throws
    func deleteBy(id: UUID) throws
    func fetchAll() throws -> [Event]
    func deleteAll() throws
}

final class EventRepositoryService: EventRepositoryProtocol {
    private let database: DBManagerProtocol
    
    init(database: DBManagerProtocol = DataBaseManager()) {
        self.database = database
    }
    
    // Добавляем новое событие
    func addEvent(_ event: Event) throws {
        try database.addObject(EventObject(event))
    }
    
    // Получаем событие по ID
    func readBy(id: UUID) throws -> Event? {
        if let object = try database.readBy(EventObject.self, id: id) {
            return Event(object)
        } else {
            return nil
        }
    }
    
    // Обновляем данные события
    func updateEvent(_ event: Event) throws {
        try database.updateObject(EventObject(event))
    }
    
    // Удаляем событие по ID
    func deleteBy(id: UUID) throws {
        try database.deleteBy(EventObject.self, key: id)
    }
    
    // Получаем все события
    func fetchAll() throws -> [Event] {
        try database
            .fetchAll(EventObject.self)
            .compactMap { Event($0) }
    }
    
    // Удаляем все события из базы данных
    func deleteAll() throws {
        try database.deleteAll()
    }
}
