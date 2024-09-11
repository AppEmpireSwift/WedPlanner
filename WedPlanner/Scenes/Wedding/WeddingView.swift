import SwiftUI

struct WeddingViewStates {
    var isNowEdditing: Bool = false
}

struct WeddingView: View {
    @StateObject var viewModel = WeddingViewModel()
    @State private var states = WeddingViewStates()
    @StateObject private var weddingItemViewModel = WeddingItemsViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBG.ignoresSafeArea()
            
            VStack {
                NavView(
                    isNowEditing: $states.isNowEdditing,
                    isDataEmpty: weddingItemViewModel.weddingItems.isEmpty
                ) {
                    
                }
                .environmentObject(viewModel)
                .environmentObject(weddingItemViewModel)
                
                if weddingItemViewModel.weddingItems.isEmpty {
                    WPEmptyDataView(
                        image: "EmptyDataRingImg",
                        title: "Nothing here yet",
                        discr: "Add your Wedding",
                        buttonTitle: "Add Wedding",
                        destinationView: AddNewWeddingView()
                            .environmentObject(viewModel)
                            .environmentObject(weddingItemViewModel)
                    )
                    .vSpacing(.center)
                } else {
                    List {
                        ForEach(weddingItemViewModel.weddingItems) { wedModel in
                            Group {
                                NavigationLink {
                                    WeddingDetailView(weddingModel: wedModel)
                                        .environmentObject(weddingItemViewModel)
                                        .onAppear {
                                            hiddenTabBar()
                                        }
                                } label: {
                                    WeddingItemCellView(model: wedModel)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .padding(.top, 12)
                        }
                        .onDelete(perform: deleteItems)
                        .onMove(perform: moveItems)
                    }
                    .listStyle(.plain)
                    .listRowSpacing(12)
                    .background(Color.clear)
                    .environment(\.editMode, .constant(self.states.isNowEdditing ? EditMode.active : EditMode.inactive))
                }
            }
        }
        .animation(.snappy, value: viewModel.states.isDataEmpty)
        .animation(.snappy, value: states.isNowEdditing)
    }
    
    private func deleteItems(at offsets: IndexSet) {
//        let weddingsToDelete = offsets.map { realmManager.weddings[$0] }
//        
//        for wedding in weddingsToDelete {
//            realmManager.deleteWedding(wedding)
//        }
    }
    
    private func moveItems(from source: IndexSet, to destination: Int) {
//        realmManager.weddings.move(fromOffsets: source, toOffset: destination)
//        realmManager.updateWeddingsOrder(realmManager.weddings)
    }
}

fileprivate struct NavView: View {
    @EnvironmentObject var viewModel: WeddingViewModel
    @EnvironmentObject var weddingItemViewModel: WeddingItemsViewModel
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
                                    .environmentObject(weddingItemViewModel)
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
