import SwiftUI
import Combine

final class WeddingItemsViewModel: ObservableObject {
    @Published var weddingItems: [WeddingItem] = []
    
    private let repository: WeddingItemRepositoryProtocol
    
    init(repository: WeddingItemRepositoryProtocol = WeddingItemRepositoryService()) {
        self.repository = repository
        fetchAllWeddingItems()
    }
    
    func fetchAllWeddingItems() {
        do {
            weddingItems = try repository.fetchAll()
        } catch {
            print("Ошибка при получении элементов свадьбы: \(error.localizedDescription)")
        }
    }
    
    func addWeddingItem(title: String, date: Date, location: String, budget: String, coverPhoto: Data, notes: String, order: Int) {
        let newWeddingItem = WeddingItem(title: title, date: date, location: location, budget: budget, coverPhoto: coverPhoto, notes: notes, order: order)
        do {
            try repository.addWeddingItem(newWeddingItem)
            fetchAllWeddingItems()
        } catch {
            print("Ошибка при добавлении элемента свадьбы: \(error.localizedDescription)")
        }
    }
    
    func updateWeddingItem(_ weddingItem: WeddingItem, title: String, date: Date, location: String, budget: String, coverPhoto: Data, notes: String, order: Int) {
        var updatedWeddingItem = weddingItem
        updatedWeddingItem.title = title
        updatedWeddingItem.date = date
        updatedWeddingItem.location = location
        updatedWeddingItem.budget = budget
        updatedWeddingItem.coverPhoto = coverPhoto
        updatedWeddingItem.notes = notes
        updatedWeddingItem.order = order
        
        do {
            try repository.updateWeddingItem(updatedWeddingItem)
            fetchAllWeddingItems()
        } catch {
            print("Ошибка при обновлении элемента свадьбы: \(error.localizedDescription)")
        }
    }
    
    func deleteWeddingItem(_ weddingItem: WeddingItem) {
        do {
            try repository.deleteBy(id: weddingItem.id)
            fetchAllWeddingItems()
        } catch {
            print("Ошибка при удалении элемента свадьбы: \(error.localizedDescription)")
        }
    }
    
    func reorderWeddingItems(from source: IndexSet, to destination: Int) {
        weddingItems.move(fromOffsets: source, toOffset: destination)
        do {
            for (index, item) in weddingItems.enumerated() {
                var updatedItem = item
                updatedItem.order = index
                try repository.updateWeddingItem(updatedItem)
            }
        } catch {
            print("Ошибка при изменении порядка элементов свадьбы: \(error.localizedDescription)")
        }
    }
    
    // Методы для управления гостями
    func addGuest(_ guest: WeddingGuest, to weddingItem: WeddingItem) {
        do {
            try repository.addGuest(guest, to: weddingItem)
            fetchAllWeddingItems()
        } catch {
            print("Ошибка при добавлении гостя: \(error.localizedDescription)")
        }
    }
    
    func removeGuest(_ guest: WeddingGuest, from weddingItem: WeddingItem) {
        do {
            try repository.removeGuest(guest, from: weddingItem)
            fetchAllWeddingItems()
        } catch {
            print("Ошибка при удалении гостя: \(error.localizedDescription)")
        }
    }
    
    func updateGuest(_ guest: WeddingGuest, in weddingItem: WeddingItem) {
        do {
            try repository.updateGuest(guest, in: weddingItem)
            fetchAllWeddingItems()
        } catch {
            print("Ошибка при обновлении гостя: \(error.localizedDescription)")
        }
    }
    
    // Методы для управления контактами
    func addContact(_ contact: WeddingContact, to weddingItem: WeddingItem) {
        do {
            try repository.addContact(contact, to: weddingItem)
            fetchAllWeddingItems()
        } catch {
            print("Ошибка при добавлении контакта: \(error.localizedDescription)")
        }
    }
    
    func removeContact(_ contact: WeddingContact, from weddingItem: WeddingItem) {
        do {
            try repository.removeContact(contact, from: weddingItem)
            fetchAllWeddingItems()
        } catch {
            print("Ошибка при удалении контакта: \(error.localizedDescription)")
        }
    }
    
    func updateContact(_ contact: WeddingContact, in weddingItem: WeddingItem) {
        do {
            try repository.updateContact(contact, in: weddingItem)
            fetchAllWeddingItems()
        } catch {
            print("Ошибка при обновлении контакта: \(error.localizedDescription)")
        }
    }
}
