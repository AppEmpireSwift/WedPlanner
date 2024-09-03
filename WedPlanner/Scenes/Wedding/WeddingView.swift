import SwiftUI

struct WeddingViewStates {
    var isNowEdditing: Bool = false
}

struct WeddingView: View {
    @StateObject var viewModel = WeddingViewModel()
    @EnvironmentObject private var realmManager: RealmManager
    @State private var states = WeddingViewStates()
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBG.ignoresSafeArea()
            
            VStack {
                NavView(
                    isNowEditing: $states.isNowEdditing,
                    isDataEmpty: realmManager.weddings.isEmpty
                ) {
                    
                }
                    .environmentObject(viewModel)
                
                if realmManager.weddings.isEmpty {
                    WPEmptyDataView(
                        image: "EmptyDataRingImg",
                        title: "Nothing here yet",
                        discr: "Add your Wedding",
                        buttonTitle: "Add Wedding",
                        destinationView: AddNewWeddingView()
                            .environmentObject(viewModel)
                    )
                        .vSpacing(.center)
                } else {
                    List {
                        ForEach(realmManager.weddings) { wedModel in
                            WeddingItemCellView(model: wedModel)
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .padding(.top, 12)
                        }
                    }
                    .listStyle(.plain)
                    .listRowSpacing(12)
                    .background(Color.clear)
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
    @EnvironmentObject var viewModel: WeddingViewModel
    @Binding var isNowEditing: Bool
    let isDataEmpty: Bool
    let editAction: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Button(action: {
                    editTaped()
                }, label: {
                    WPTextView(
                        text: isNowEditing ? "Done" : "Edit",
                        color: isDataEmpty ? .lbQuaternary : .standartDarkText,
                        size: 17,
                        weight: .regular
                    )
                })
                
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
                                    .environmentObject(viewModel)
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
        .animation(.easeIn, value: isNowEditing)
    }
    
    private func editTaped() {
        isNowEditing.toggle()
        editAction()
    }
}

#Preview {
    WeddingView()
}
