import Foundation
import RealmSwift
import Combine

final class RealmIdeaManager: ObservableObject {
    @Published var ideas: [IdeaModel] = []
    
    private var realm: Realm?
    private var notificationToken: NotificationToken?
    
    init() {
        setupRealm()
        observeIdeas()
    }
    
    private func setupRealm() {
        do {
            realm = try Realm()
        } catch {
            print("Error initializing Realm: \(error)")
        }
    }
    
    private func observeIdeas() {
        guard let realm = realm else { return }
        
        let ideasResults = realm.objects(IdeaModel.self)
        
        notificationToken = ideasResults.observe { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial(let collection):
                self?.ideas = Array(collection)
            case .update(let collection, _, _, _):
                self?.ideas = Array(collection)
            case .error(let error):
                print("Error updating ideas: \(error)")
            }
        }
    }
    
    // MARK: - CRUD Методы
    
    func addIdea(title: String, description: String, mediaData: Data = Data()) {
        guard let realm = realm else { return }
        
        let newIdea = IdeaModel()
        newIdea.title = title
        newIdea.descriptionText = description
        newIdea.mediaData = mediaData
        
        do {
            try realm.write {
                realm.add(newIdea)
            }
            observeIdeas()
        } catch {
            print("Error adding new idea: \(error)")
        }
    }
    
    func deleteIdea(_ idea: IdeaModel) {
        guard let realm = realm else { return }
        
        do {
            try realm.write {
                realm.delete(idea)
            }
            observeIdeas()
        } catch {
            print("Error deleting idea: \(error)")
        }
    }
    
    func updateIdea(_ idea: IdeaModel, title: String, description: String, mediaData: Data? = nil, isFavorite: Bool? = nil) {
        guard let realm = realm else { return }
        
        do {
            try realm.write {
                idea.title = title
                idea.descriptionText = description
                if let mediaData = mediaData {
                    idea.mediaData = mediaData
                }
                if let isFavorite = isFavorite {
                    idea.isFavorite = isFavorite
                }
            }
            observeIdeas()
        } catch {
            print("Error updating idea: \(error)")
        }
    }
    
    func updateIdeaLikeStatus(_ idea: IdeaModel) {
        guard let realm = realm else {return}
        
        do {
            try realm.write {
                idea.isFavorite.toggle()
            }
            observeIdeas()
        }
        catch {
            print("Error updating like status: \(error)")
        }
    }
    
    func deleteAllIdeas() {
        guard let realm = realm else { return }
        
        let allIdeas = realm.objects(IdeaModel.self)
        do {
            try realm.write {
                realm.delete(allIdeas)
            }
            observeIdeas()
        } catch {
            print("Error deleting all ideas: \(error)")
        }
    }
    
    deinit {
        notificationToken?.invalidate()
    }
}
