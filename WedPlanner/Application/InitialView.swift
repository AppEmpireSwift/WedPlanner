import SwiftUI

struct InitialView: View {
    @AppStorage("onboarding") var isOnboardingDone = false
    
    var body: some View {
        ZStack {
            if !isOnboardingDone {
                OnboardingView()
            } else {
                //TODO: - поменять на TabBarView
                EmptyView()
            }
        }
        .animation(.bouncy, value: isOnboardingDone)
    }
}

#Preview {
    InitialView()
}
