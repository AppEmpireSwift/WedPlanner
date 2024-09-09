import SwiftUI
import RealmSwift

struct WeddingViewModelStates {
    var isDataEmpty: Bool = true
}

struct WeddingCreationFirstScreenStates {
    var titleText: String = ""
    var locationText: String = ""
    var budgetText: String = ""
    var selectedCoverImage: UIImage? = nil
    var notesText: String = ""
    var weddingDate: Date = Date()
}

final class WeddingViewModel: ObservableObject {
    @AppStorage("wedding_Details") var isWedDetailsClosed = false
    @AppStorage("wedding_Tasks") var isWedTasksClosed = false
    @Published var states = WeddingViewModelStates()
    @Published var firstAddStates = WeddingCreationFirstScreenStates()
    
    
    func convertToData(from image: UIImage?) -> Data {
        if let img = firstAddStates.selectedCoverImage {
            if let data = img.jpegData(compressionQuality: 1) {
                return data
            }
        }
        return Data()
    }
    
    // MARK: - AddNewWedding Section
    
    func closeWeddingDetails() {
        isWedDetailsClosed = true
    }
    
    // MARK: - AddWeddingTasks Section
    
    func closeWeddingTasks() {
        isWedTasksClosed = true
    }
}
