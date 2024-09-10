import SwiftUI
import Combine

final class IdeasViewModel: ObservableObject {
    @Published var ideas: [Idea] = []
    
    private let repository: IdeaRepositoryService
    
    init(repository: IdeaRepositoryService) {
        self.repository = repository
        fetchAllIdeas()
    }
    
    func fetchAllIdeas() {
        do {
            ideas = try repository.fetchAll()
        } catch {
            print("Ошибка при получении идей: \(error.localizedDescription)")
        }
    }
    
    func addIdea(title: String, description: String, mediaData: Data) {
        let newIdea = Idea(title: title, descriptionText: description, mediaData: mediaData)
        do {
            try repository.addIdea(newIdea)
            fetchAllIdeas()
        } catch {
            print("Ошибка при добавлении идеи: \(error.localizedDescription)")
        }
    }
    
    func updateIdea(_ idea: Idea, title: String, description: String, mediaData: Data) {
        var updatedIdea = idea
        updatedIdea.title = title
        updatedIdea.descriptionText = description
        updatedIdea.mediaData = mediaData
        
        do {
            try repository.updateIdea(updatedIdea)
            fetchAllIdeas()
        } catch {
            print("Ошибка при обновлении идеи: \(error.localizedDescription)")
        }
    }
    
    func deleteIdea(_ idea: Idea) {
        do {
            try repository.deleteBy(id: idea.id)
            fetchAllIdeas()
        } catch {
            print("Ошибка при удалении идеи: \(error.localizedDescription)")
        }
    }
    
    func toggleFavorite(_ idea: Idea) {
        var updatedIdea = idea
        updatedIdea.isFavorite.toggle()
        
        do {
            try repository.updateIdea(updatedIdea)
            fetchAllIdeas()
        } catch {
            print("Ошибка при изменении статуса избранного: \(error.localizedDescription)")
        }
    }
}
