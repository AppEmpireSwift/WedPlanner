import Foundation
import RealmSwift

struct WeddingContact: Identifiable {
    let id: UUID
    var name: String
    var phoneNum: String
    var email: String
    var address: String
    var birthDay: String
    var notes: String
    var order: Int
    
    init(id: UUID = UUID(),
         name: String,
         phoneNum: String,
         email: String,
         address: String,
         birthDay: String,
         notes: String,
         order: Int) {
        self.id = id
        self.name = name
        self.phoneNum = phoneNum
        self.email = email
        self.address = address
        self.birthDay = birthDay
        self.notes = notes
        self.order = order
    }
    
    init(_ object: WeddingContactObject) {
        self.id = object.id
        self.name = object.name
        self.phoneNum = object.phoneNum
        self.email = object.email
        self.address = object.address
        self.birthDay = object.birthDay
        self.notes = object.notes
        self.order = object.order
    }
}

class WeddingContactObject: Object, Identifiable {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var name: String
    @Persisted var phoneNum: String
    @Persisted var email: String
    @Persisted var address: String
    @Persisted var birthDay: String
    @Persisted var notes: String
    @Persisted var order: Int
    
    convenience init(_ weddingContact: WeddingContact) {
        self.init()
        self.id = weddingContact.id
        self.name = weddingContact.name
        self.phoneNum = weddingContact.phoneNum
        self.email = weddingContact.email
        self.address = weddingContact.address
        self.birthDay = weddingContact.birthDay
        self.notes = weddingContact.notes
        self.order = weddingContact.order
    }
}
