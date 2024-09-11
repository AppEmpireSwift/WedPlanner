import Foundation

// Протокол для взаимодействия с репозиторием WeddingTask
protocol WeddingTaskRepositoryProtocol: AnyObject {
    func addTask(_ task: WeddingTask) throws
    func readBy(id: UUID) throws -> WeddingTask?
    func updateTask(_ task: WeddingTask) throws
    func deleteBy(id: UUID) throws
    func fetchAll() throws -> [WeddingTask]
    func deleteAll() throws
}

// Сервис для управления WeddingTask
final class WeddingTaskRepositoryService: WeddingTaskRepositoryProtocol {
    private let database: DBManagerProtocol
    
    init(database: DBManagerProtocol = DataBaseManager()) {
        self.database = database
    }
    
    // Добавляем новую задачу
    func addTask(_ task: WeddingTask) throws {
        try database.addObject(WeddingTaskObject(task))
    }
    
    // Получаем задачу по ID
    func readBy(id: UUID) throws -> WeddingTask? {
        if let object = try database.readBy(WeddingTaskObject.self, id: id) {
            return WeddingTask(object)
        } else {
            return nil
        }
    }
    
    // Обновляем данные задачи
    func updateTask(_ task: WeddingTask) throws {
        try database.updateObject(WeddingTaskObject(task))
    }
    
    // Удаляем задачу по ID
    func deleteBy(id: UUID) throws {
        try database.deleteBy(WeddingTaskObject.self, key: id)
    }
    
    // Получаем все задачи
    func fetchAll() throws -> [WeddingTask] {
        try database
            .fetchAll(WeddingTaskObject.self)
            .compactMap { WeddingTask($0) }
    }
    
    // Удаляем все задачи из базы данных
    func deleteAll() throws {
        try database.deleteAll()
    }
}
