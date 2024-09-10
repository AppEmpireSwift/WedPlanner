import Foundation
import RealmSwift

protocol DBManagerProtocol: AnyObject {
    func addObject<T: Object>(_ object: T) throws
    func readBy<T: Object>(_ objectType: T.Type, id key: UUID) throws -> T?
    func deleteBy<T: Object>(_ objectType: T.Type, key primaryKey: UUID) throws
    func updateObject<T: Object>(_ object: T) throws
    func fetchAll<T: Object>(_ objectType: T.Type) throws -> [T]
    func deleteAll() throws
}

final class DataBaseManager {
    private(set) var localRealm: Realm?
    
    init() {
        openRealm()
    }
    
    // Создаем локальную базу Realm
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = config
            localRealm = try Realm()
        } catch {
            print("Error opening Realm", error)
        }
    }
}

extension DataBaseManager: DBManagerProtocol {
    
    // Добавление объекта в бд
    func addObject<T: Object>(_ object: T) throws {
        guard let localRealm else { return }
        try localRealm.write {
            localRealm.add(object, update: .all)
        }
    }
    
    // Получение объекта по ID
    func readBy<T: Object>(_ objectType: T.Type, id key: UUID) throws -> T? {
        guard let localRealm else { return nil }
        let object = localRealm.object(ofType: objectType, forPrimaryKey: key)
        return object
    }
    
    // Удаление объекта по ID
    func deleteBy<T: Object>(_ objectType: T.Type, key primaryKey: UUID) throws {
        guard let localRealm else { return }
        try localRealm.write {
            guard let object = localRealm.object(ofType: T.self, forPrimaryKey: primaryKey)
            else { return }
            localRealm.delete(object)
        }
    }
     
    // Обновление объекта
    func updateObject<T: Object>(_ object: T) throws {
        guard let localRealm else { return }
        try localRealm.write {
            localRealm.add(object, update: .modified)
        }
    }
    
    // Получаем все объекты из бд
    func fetchAll<T: Object>(_ objectType: T.Type) throws -> [T] {
        guard let localRealm else { return [] }
        let allItems = localRealm.objects(T.self)
        return Array(allItems)
    }
    
    // Удаление всех объектов из бд
    func deleteAll() throws {
        guard let localRealm else { return }
        try localRealm.write {
            localRealm.deleteAll()
        }
    }
}
