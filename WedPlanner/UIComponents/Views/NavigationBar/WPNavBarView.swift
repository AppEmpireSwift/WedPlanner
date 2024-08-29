import SwiftUI

struct WPNavBarView<Content>: View where Content : View {
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        NavigationView {
            content()
                .onAppear {
                    showTabBar()
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden()
                .frame(maxWidth: .infinity)
                .frame(maxHeight: .infinity)
                .background(.mainBG)
        }
        .navigationViewStyle(.stack)
    }
}
