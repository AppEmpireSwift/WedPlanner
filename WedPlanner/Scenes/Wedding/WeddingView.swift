import SwiftUI

struct WeddingView: View {
    @StateObject var viewModel = WeddingViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBG.ignoresSafeArea()
            
            VStack {
                NavView(isDataEmpty: viewModel.states.isDataEmpty)
                
                if viewModel.states.isDataEmpty {
                    WPEmptyDataView(
                        image: "EmptyDataRingImg",
                        title: "Nothing here yet",
                        discr: "Add your Wedding",
                        buttonTitle: "Add Wedding",
                        destinationView: AddNewWeddingView()
                    )
                        .vSpacing(.center)
                }
            }
        }
        .animation(.snappy, value: viewModel.states.isDataEmpty)
    }
    
    private func showAddView() -> some View {
        NavigationLink(destination: AddNewWeddingView()) {
            
        }
    }
}

fileprivate struct NavView: View {
    let isDataEmpty: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                WPImagedButtonView(
                    type: .itemList,
                    disabled: true
                ) {
                    
                }
                
                Spacer()
                
                HStack(spacing: 18) {
                    WPImagedButtonView(
                        type: .notification,
                        disabled: true,
                        hasSomeNotifications: false) {
                            
                        }
                    
                    WPImagedButtonView(type: .plusInCircle) {}
                        .overlay {
                            NavigationLink(
                                destination: AddNewWeddingView()
                                    .navigationBarBackButtonHidden()
                                    .onAppear {
                                        hiddenTabBar()
                                    }
                            ) {
                                    Color.clear
                                }
                        }
                }
            }
            
            WPTextView(
                text: "Wedding",
                color: .standartDarkText,
                size: 34,
                weight: .bold
            )
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
    }
}

#Preview {
    WeddingView()
}
