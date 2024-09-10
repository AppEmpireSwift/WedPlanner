import SwiftUI
import Combine

final class EventsViewModel: ObservableObject {
    @Published var events: [Event] = []
    
    private let repository: EventRepositoryProtocol
    
    init(repository: EventRepositoryProtocol = EventRepositoryService()) {
        self.repository = repository
        fetchAllEvents()
    }
    
    func fetchAllEvents() {
        do {
            events = try repository.fetchAll()
        } catch {
            print("Ошибка при получении событий: \(error.localizedDescription)")
        }
    }
    
    func addEvent(title: String, description: String, date: Date = Date()) {
        let newEvent = Event(title: title, descriptionText: description, date: date)
        do {
            try repository.addEvent(newEvent)
            fetchAllEvents()
        } catch {
            print("Ошибка при добавлении события: \(error.localizedDescription)")
        }
    }
    
    func updateEvent(_ event: Event, title: String, description: String, date: Date) {
        var updatedEvent = event
        updatedEvent.title = title
        updatedEvent.descriptionText = description
        updatedEvent.date = date
        
        do {
            try repository.updateEvent(updatedEvent)
            fetchAllEvents()
        } catch {
            print("Ошибка при обновлении события: \(error.localizedDescription)")
        }
    }
    
    func deleteEvent(_ event: Event) {
        do {
            try repository.deleteBy(id: event.id)
            fetchAllEvents()
        } catch {
            print("Ошибка при удалении события: \(error.localizedDescription)")
        }
    }
    
    func deleteAllEvents() {
        do {
            try repository.deleteAll()
            fetchAllEvents()
        } catch {
            print("Ошибка при удалении всех событий: \(error.localizedDescription)")
        }
    }
    
    func events(for date: Date) -> [Event] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        return events.filter { event in
            event.date >= startOfDay && event.date < endOfDay
        }
    }
}
