import SwiftUI
import StoreKit

extension View {
    var isiPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
    
    func requestReview() {
        DispatchQueue.main.async {
            if let scene = UIApplication.shared.connectedScenes
                .first(where: { $0.activationState == .foregroundActive })
                as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    }
}
