import SwiftUI

final class OnboardingViewModel: ObservableObject {
    @AppStorage("onboarding") var isOnboardingDone = false
    @Published var isPolicyShown: Bool = false
    @Published var isTermsShown: Bool = false
    @Published var currentTabSelection: OnboardinItemModel = .first
    
    func finishOnboarding() {
        isOnboardingDone = true
    }
}
