import SwiftUI

struct ContactsView: View {
    @State private var searchText: String = ""
    @EnvironmentObject private var weddingItemViewModel: WeddingItemsViewModel
    @Binding var selection: WPTabbarItemModel
    
    var filteredWeddings: [WeddingItem] {
        withAnimation(.snappy) {
            if searchText.isEmpty {
                return weddingItemViewModel.weddingItems
            } else {
                return weddingItemViewModel.weddingItems.filter { wedding in
                    wedding.title.lowercased().contains(searchText.lowercased())
                }
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBG.ignoresSafeArea()
            
            VStack {
                VStack(spacing: 16) {
                    WPTextView(
                        text: "Contacts",
                        color: .standartDarkText,
                        size: 34,
                        weight: .bold
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    WPSearchField(searchText: $searchText)
                }
                .dismissKeyboardOnTap()
                .padding()
                
                if filteredWeddings.isEmpty {
                    if searchText.isEmpty {
                        emptyDataButtonView(action: {
                            withAnimation(.snappy) {
                                selection = .wed
                            }
                        })
                        .vSpacing(.center)
                    } else {
                        noResultsView
                            .vSpacing(.center)
                    }
                } else {
                    List {
                        ForEach(filteredWeddings) { wedding in
                            NavigationLink(
                                destination: WeddingContactsListView(wedding: wedding)
                                    .environmentObject(weddingItemViewModel)
                                    .navigationBarBackButtonHidden()
                                    .onAppear(perform: {
                                        hiddenTabBar()
                                    })
                            ) {
                                WPTextView(
                                    text: wedding.title,
                                    color: .standartDarkText,
                                    size: 20,
                                    weight: .semibold
                                )
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                        }
                    }
                    .listStyle(.plain)
                    .listRowSpacing(12)
                    .background(Color.clear)
                    .padding(.horizontal, hPaddings)
                    .animation(.snappy, value: filteredWeddings)
                    .transition(.opacity)
                }
            }
        }
        .animation(.snappy, value: filteredWeddings.isEmpty)
        .navigationBarBackButtonHidden()
    }
    
    @ViewBuilder
    private func emptyDataButtonView(action: @escaping () -> Void) -> some View {
        VStack(spacing: 8) {
            Image("EmptyContactImg")
                .resizable()
                .frame(width: 140, height: 130.9)
            
            WPTextView(
                text: "Nothing here yet",
                color: .accentColor,
                size: 17,
                weight: .bold
            )
            
            WPTextView(
                text: "Add your Wedding first",
                color: .standartDarkText,
                size: 14,
                weight: .regular
            )
            
            WPButtonView(title: "Add Wedding", action: {
                action()
            })
            .padding(.horizontal, 54)
        }
        .padding(.horizontal, hPaddings)
        .transition(.opacity)
    }
    
    private var noResultsView: some View {
        VStack(spacing: 8) {
            WPTextView(
                text: "No results for '\(searchText)'",
                color: .standartDarkText,
                size: 17,
                weight: .bold
            )
        }
        .padding(.horizontal, hPaddings)
        .transition(.opacity)
    }
}

#Preview {
    ContactsView(selection: .constant(.cont))
}
