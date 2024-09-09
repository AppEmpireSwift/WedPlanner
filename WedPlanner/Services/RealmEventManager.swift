import Foundation
import RealmSwift

final class RealmEventManager: ObservableObject {
    @Published var events: [EventModel] = []
    
    private var realm: Realm?
    private var notificationToken: NotificationToken?
    
    init() {
        setupRealm()
        observeEvents()
    }
    
    private func setupRealm() {
        do {
            realm = try Realm()
        } catch {
            print("Error initializing Realm: \(error)")
        }
    }
    
    private func observeEvents() {
        guard let realm = realm else { return }
        
        let eventsResults = realm.objects(EventModel.self)
        
        notificationToken = eventsResults.observe { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial(let collection):
                self?.events = Array(collection)
            case .update(let collection, _, _, _):
                self?.events = Array(collection)
            case .error(let error):
                print("Error updating events: \(error)")
            }
        }
    }
    
    // MARK: - CRUD Методы
    
    func addEvent(title: String, description: String, date: Date = Date()) {
        guard let realm = realm else { return }
        
        let newEvent = EventModel()
        newEvent.title = title
        newEvent.descriptionText = description
        newEvent.date = date
        
        do {
            try realm.write {
                realm.add(newEvent)
            }
            observeEvents()
        } catch {
            print("Error adding new event: \(error)")
        }
    }
    
    func events(for date: Date) -> [EventModel] {
         guard let realm = realm else { return [] }
         
         let startOfDay = Calendar.current.startOfDay(for: date)
         let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
         
         let filteredEvents = realm.objects(EventModel.self).filter("date >= %@ AND date < %@", startOfDay, endOfDay)
         return Array(filteredEvents)
     }
    
    func deleteEvent(_ event: EventModel) {
        guard let realm = realm else { return }
        
        do {
            try realm.write {
                realm.delete(event)
            }
            observeEvents()
        } catch {
            print("Error deleting event: \(error)")
        }
    }
    
    func updateEvent(_ event: EventModel, title: String, description: String, date: Date) {
        guard let realm = realm else { return }
        
        do {
            try realm.write {
                event.title = title
                event.descriptionText = description
                event.date = date
            }
            observeEvents()
        } catch {
            print("Error updating event: \(error)")
        }
    }
    
    func deleteAllEvents() {
        guard let realm = realm else { return }
        
        let allEvents = realm.objects(EventModel.self)
        do {
            try realm.write {
                realm.delete(allEvents)
            }
            observeEvents()
        } catch {
            print("Error deleting all events: \(error)")
        }
    }
    
    deinit {
        notificationToken?.invalidate()
    }
}
