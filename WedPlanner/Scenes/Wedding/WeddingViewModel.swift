import SwiftUI
import RealmSwift

struct WeddingViewModelStates {
    var isDataEmpty: Bool = true
}

final class WeddingViewModel: ObservableObject {
    @AppStorage("wedding_Details") var isWedDetailsClosed = false
    @AppStorage("wedding_Tasks") var isWedTasksClosed = false
    @Published var states = WeddingViewModelStates()
    @EnvironmentObject private var realmManager: RealmManager
    
    // MARK: - AddNewWedding Section
    
    func closeWeddingDetails() {
        isWedDetailsClosed = true
    }
    
    // MARK: - AddWeddingTasks Section
    
    func closeWeddingTasks() {
        isWedTasksClosed = true
    }
}
