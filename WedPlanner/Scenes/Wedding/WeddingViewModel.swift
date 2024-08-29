import SwiftUI

struct WeddingViewModelStates {
    var isDataEmpty: Bool = true
}

final class WeddingViewModel: ObservableObject {
    @AppStorage("wedding_Details") var isWedDetailsClosed = false
    @Published var states = WeddingViewModelStates()
    
    func closeWeddingDetails() {
        isWedDetailsClosed = true
    }
}
