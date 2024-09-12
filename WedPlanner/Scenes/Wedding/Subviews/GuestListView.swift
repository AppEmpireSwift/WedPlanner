import SwiftUI

struct GuestListView: View {
    @EnvironmentObject var weddingViewModel: WeddingItemsViewModel
    @State private var searchText: String = ""
    @State private var isAddPresented: Bool = false
    @State private var isNowEditing: Bool = false
    @State private var newGuestName: String = ""
    @State private var newGuestRole: String = ""
    @State private var isContextMenuVisible: Bool = false

    var weddingModel: WeddingItem

    var filteredGuests: [WeddingGuest] {
        var guests = weddingModel.guests
        if !searchText.isEmpty {
            guests = guests.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
        return guests
    }

    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBG.ignoresSafeArea()
            
            VStack(spacing: 11) {
                VStack {
                    SubNavBarView(
                        type: .backTitleImageBtn(rtBtnType: .threeDotsInCircle),
                        title: "Guest List",
                        isRightBtnEnabled: true) {
                            withAnimation {
                                isContextMenuVisible.toggle()
                            }
                        }
                    
                    WPSearchField(searchText: $searchText)
                        .padding(.horizontal, hPaddings)
                        .padding(.vertical, 4)
                    
                    LineSeparaterView()
                }
                .dismissKeyboardOnTap()
                
               
                if filteredGuests.isEmpty {
                    emptyListView()
                } else {
                    List {
                        ForEach(filteredGuests, id: \.id) { guest in
                            guestItemView(for: guest)
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                        }
                        .onDelete(perform: deleteGuest)
                        .onMove(perform: moveItems)
                    }
                    .environment(\.editMode, .constant(self.isNowEditing ? EditMode.active : EditMode.inactive))
                    .listStyle(PlainListStyle())
                    .background(Color.clear)
                    .padding(.horizontal, hPaddings)
                }
            }
            
            if isContextMenuVisible {
                GeometryReader { geometry in
                    let screenWidth = geometry.size.width
                    
                    WPContextMenu(style: .editAndAddContact) {
                        withAnimation {
                            isNowEditing.toggle()
                            isContextMenuVisible.toggle()
                        }
                    } onAddGuestAction: {
                        withAnimation {
                            isAddPresented.toggle()
                            isContextMenuVisible.toggle()
                        }
                    }
                    .frame(width: 250, height: 94)
                    .background(Color.white.cornerRadius(12))
                    .shadow(radius: 10)
                    .position(
                        x: screenWidth - 250 / 2 - 18,
                        y: isiPhone ? 134 : 100
                    )
                }
                .ignoresSafeArea()
            }
        }
        .navigationBarBackButtonHidden()

        .wpGuestAlert(isPresented: $isAddPresented, guestName: $newGuestName, guestNote: $newGuestRole) {
            addNewGuest()
        }
        
        .onAppear {
            weddingViewModel.fetchAllWeddingItems()
        }
        
        .onChange(of: isAddPresented) { _ in
            weddingViewModel.fetchAllWeddingItems()
        }
    }

    @ViewBuilder
    private func guestItemView(for model: WeddingGuest) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            WPTextView(
                text: model.name,
                color: .standartDarkText,
                size: 20,
                weight: .regular
            )
            .frame(maxWidth: .infinity, alignment: .leading)
            
            WPTextView(
                text: model.role,
                color: .tbSelected,
                size: 13,
                weight: .regular
            )
            .padding(11)
            .background(
                Color.fieldsBG.cornerRadius(6)
            )
        }
    }

    private func deleteGuest(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        let guestToDelete = filteredGuests[index]
        weddingViewModel.removeGuest(guestToDelete, from: weddingModel)
        weddingViewModel.fetchAllWeddingItems()
    }

    private func moveItems(from source: IndexSet, to destination: Int) {
        var updatedGuests = filteredGuests
        updatedGuests.move(fromOffsets: source, toOffset: destination)
        weddingViewModel.updateGuestsOrder(in: weddingModel, with: updatedGuests)
        weddingViewModel.fetchAllWeddingItems()
    }

    private func addNewGuest() {
        guard !newGuestName.isEmpty else { return }
        
        let newGuest = WeddingGuest(
            name: newGuestName,
            role: newGuestRole,
            order: weddingModel.guests.count + 1
        )
        weddingViewModel.addGuest(newGuest, to: weddingModel)
        weddingViewModel.fetchAllWeddingItems()
        
        newGuestName = ""
        newGuestRole = ""
    }

    @ViewBuilder
    private func emptyListView() -> some View {
        VStack {
            Spacer()
            Text("No guests found")
                .foregroundColor(.gray)
                .font(.headline)
            Spacer()
        }
    }
}
