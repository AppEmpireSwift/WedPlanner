import SwiftUI

struct InitialView: View {
    @AppStorage("onboarding") var isOnboardingDone = false
    
    var body: some View {
        ZStack {
            if !isOnboardingDone {
                OnboardingView()
            } else {
                WPTabBar()
            }
        }
        .animation(.bouncy, value: isOnboardingDone)
    }
}

#Preview {
    InitialView()
}
