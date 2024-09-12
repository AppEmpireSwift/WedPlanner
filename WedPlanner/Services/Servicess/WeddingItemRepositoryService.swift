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
    
    // Методы для работы с задачами
    func addTask(_ task: WeddingTask, to weddingItem: WeddingItem) throws
    func removeTask(_ task: WeddingTask, from weddingItem: WeddingItem) throws
    func updateTask(_ task: WeddingTask, in weddingItem: WeddingItem) throws
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

//    // Добавление задачи в свадьбу
//    func addTask(_ task: WeddingTask, to weddingItem: WeddingItem) throws {
//        guard var item = try readBy(id: weddingItem.id) else { return }
//        item.tasks.append(task)
//        try updateWeddingItem(item)
//    }
//    
//    // Удаление задачи из свадьбы
//    func removeTask(_ task: WeddingTask, from weddingItem: WeddingItem) throws {
//        guard var item = try readBy(id: weddingItem.id) else { return }
//        item.tasks.removeAll { $0.id == task.id }
//        try updateWeddingItem(item)
//    }
//    
//    // Обновление задачи в свадьбе
//    func updateTask(_ task: WeddingTask, in weddingItem: WeddingItem) throws {
//        guard var item = try readBy(id: weddingItem.id) else { return }
//        if let index = item.tasks.firstIndex(where: { $0.id == task.id }) {
//            item.tasks[index] = task
//            try updateWeddingItem(item)
//        }
//    }
    
    func addTask(_ task: WeddingTask, to weddingItem: WeddingItem) throws {
            guard var item = try readBy(id: weddingItem.id) else { return }
            
            // Десериализуем существующие задачи
            var tasks = deserializeTasks(from: item.tasksData) ?? []
            
            // Добавляем новую задачу
            tasks.append(task)
            
            // Сериализуем обратно и обновляем объект
            item.tasksData = serializeTasks(tasks) ?? Data()
            try updateWeddingItem(item)
        }
        
        // Удаление задачи из свадьбы
        func removeTask(_ task: WeddingTask, from weddingItem: WeddingItem) throws {
            guard var item = try readBy(id: weddingItem.id) else { return }
            
            // Десериализуем существующие задачи
            var tasks = deserializeTasks(from: item.tasksData) ?? []
            
            // Удаляем задачу по ID
            tasks.removeAll { $0.id == task.id }
            
            // Сериализуем обратно и обновляем объект
            item.tasksData = serializeTasks(tasks) ?? Data()
            try updateWeddingItem(item)
        }
        
        // Обновление задачи в свадьбе
        func updateTask(_ task: WeddingTask, in weddingItem: WeddingItem) throws {
            guard var item = try readBy(id: weddingItem.id) else { return }
            
            // Десериализуем существующие задачи
            var tasks = deserializeTasks(from: item.tasksData) ?? []
            
            // Находим индекс задачи и обновляем её
            if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                tasks[index] = task
            }
            
            // Сериализуем обратно и обновляем объект
            item.tasksData = serializeTasks(tasks) ?? Data()
            try updateWeddingItem(item)
        }
    
    func serializeTasks(_ tasks: [WeddingTask]) -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(tasks)
    }

    // Функция для десериализации Data обратно в массив WeddingTask
    func deserializeTasks(from data: Data) -> [WeddingTask]? {
        let decoder = JSONDecoder()
        return try? decoder.decode([WeddingTask].self, from: data)
    }
}
