import SwiftUI

struct GuestListView: View {
    @EnvironmentObject var realmManager: RealmManager
    @State private var searchText: String = ""
    @State private var isAddPresented: Bool = false
    @State private var isNowEdditing: Bool = false
    @State private var newGuestName: String = ""
    @State private var newGuestRole: String = ""
    
    var weddingModel: WeddingItemModel
    
    @State private var isContextMenuVisible: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBG.ignoresSafeArea()
            
            VStack(spacing: 11) {
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
                
                List {
                    ForEach(weddingModel.guests) { guest in
                        guestItemView(for: guest)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                    }
                    .onDelete(perform: deleteItems)
                    .onMove(perform: moveItems)
                }
                .environment(\.editMode, .constant(self.isNowEdditing ? EditMode.active : EditMode.inactive))
                .listStyle(.plain)
                .background(Color.clear)
                .padding(.horizontal, hPaddings)
            }
            
            if isContextMenuVisible {
                GeometryReader { geometry in
                    let screenWidth = geometry.size.width
                    
                    WPContextMenu(style: .editAndAddContact) {
                        withAnimation {
                            isNowEdditing.toggle()
                        }
                    } onAddGuestAction: {
                        withAnimation {
                            isAddPresented.toggle()
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
        .dismissKeyboardOnTap()
        .wpGuestAlert(isPresented: $isAddPresented, guestName: $newGuestName, guestNote: $newGuestRole) {
            addNewGuest()
        }
    }
    
    @ViewBuilder
    private func guestItemView(for model: WeddingGestListModel) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            WPTextView(
                text: model.name,
                color: .standartDarkText,
                size: 20,
                weight: .regular
            )
            
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
    
    private func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let guest = weddingModel.guests[index]
            realmManager.deleteGuest(guest, from: weddingModel)
        }
    }

    private func moveItems(from source: IndexSet, to destination: Int) {
        var reorderedGuests = Array(weddingModel.guests)
        reorderedGuests.move(fromOffsets: source, toOffset: destination)
        realmManager.updateGuestsOrder(in: weddingModel, with: reorderedGuests)
    }
    
    private func addNewGuest() {
        if !newGuestName.isEmpty && !newGuestRole.isEmpty {
            realmManager.addGuest(name: newGuestName, role: newGuestRole, to: weddingModel) 
            newGuestName = ""
            newGuestRole = ""
        }
    }
}

#Preview {
    GuestListView(weddingModel: WeddingItemModel())
}
