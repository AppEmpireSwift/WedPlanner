import Foundation

protocol IdeaRepositoryProtocol: AnyObject {
    func addIdea(_ idea: Idea) throws
    func readBy(id: UUID) throws -> Idea?
    func updateIdea(_ idea: Idea) throws
    func deleteBy(id: UUID) throws
    func fetchAll() throws -> [Idea]
    func deleteAll() throws
}

final class IdeaRepositoryService: IdeaRepositoryProtocol {
    private let database: DBManagerProtocol
    
    init(database: DBManagerProtocol = DataBaseManager()) {
        self.database = database
    }
    
    // Добавляем новую идею
    func addIdea(_ idea: Idea) throws {
        try database.addObject(IdeaObject(idea))
    }
    
    // Получаем идею по ID
    func readBy(id: UUID) throws -> Idea? {
        if let object = try database.readBy(IdeaObject.self, id: id) {
            return Idea(object)
        } else {
            return nil
        }
    }
    
    // Обновляем данные идеи
    func updateIdea(_ idea: Idea) throws {
        try database.updateObject(IdeaObject(idea))
    }
    
    // Удаляем идею по ID
    func deleteBy(id: UUID) throws {
        try database.deleteBy(IdeaObject.self, key: id)
    }
    
    // Получаем все идеи
    func fetchAll() throws -> [Idea] {
        try database
            .fetchAll(IdeaObject.self)
            .compactMap { Idea($0) }
    }
    
    // Удаляем все идеи из бд
    func deleteAll() throws {
        try database.deleteAll()
    }
}
