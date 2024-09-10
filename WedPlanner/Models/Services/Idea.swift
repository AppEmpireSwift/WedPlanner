import Foundation
import RealmSwift

struct Idea {
    let id: UUID
    var title: String
    var descriptionText: String
    var mediaData: Data
    var isFavorite: Bool
    
    init(id: UUID = UUID(), title: String, descriptionText: String, mediaData: Data = Data(), isFavorite: Bool = false) {
        self.id = id
        self.title = title
        self.descriptionText = descriptionText
        self.mediaData = mediaData
        self.isFavorite = isFavorite
    }
    
    init(_ object: IdeaObject) {
        self.id = object.id
        self.title = object.title
        self.descriptionText = object.descriptionText
        self.mediaData = object.mediaData
        self.isFavorite = object.isFavorite
    }
}

class IdeaObject: Object, Identifiable {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var title: String
    @Persisted var descriptionText: String
    @Persisted var mediaData: Data
    @Persisted var isFavorite: Bool
}

extension IdeaObject {
    convenience init(_ idea: Idea) {
        self.init()
        self.id = idea.id
        self.title = idea.title
        self.descriptionText = idea.descriptionText
        self.mediaData = idea.mediaData
        self.isFavorite = idea.isFavorite
    }
}
