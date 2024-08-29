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
    
    func showTabBar() {
        TabBarModifier.showTabBar()
    }
    
    func hiddenTabBar() {
        TabBarModifier.hideTabBar()
    }
    
    @ViewBuilder
    func hSpacing(_ alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    
    @ViewBuilder
    func vSpacing(_ alignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
}
