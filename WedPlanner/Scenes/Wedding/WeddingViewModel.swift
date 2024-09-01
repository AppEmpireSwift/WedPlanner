import SwiftUI

struct WeddingViewModelStates {
    var isDataEmpty: Bool = true
}

final class WeddingViewModel: ObservableObject {
    @AppStorage("wedding_Details") var isWedDetailsClosed = false
    @AppStorage("wedding_Tasks") var isWedTasksClosed = false
    @Published var states = WeddingViewModelStates()
    
    func closeWeddingDetails() {
        isWedDetailsClosed = true
    }
    
    func closeWeddingTasks() {
        isWedTasksClosed = true
    }
    
    
}
