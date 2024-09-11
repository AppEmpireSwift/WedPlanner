import SwiftUI

struct WeddingContactsListView: View {
    @EnvironmentObject var viewModel: WeddingItemsViewModel
    @State private var searchText: String = ""
    @State private var isContextMenuVisible: Bool = false
    @State private var isNowEditing: Bool = false {
        didSet {
            if !isNowEditing {
                saveChanges()
            }
        }
    }
    @State private var isAddContactPresented: Bool = false
    @State private var localContacts: [WeddingContact]

    var wedding: WeddingItem
    
    init(wedding: WeddingItem) {
        self.wedding = wedding
        _localContacts = State(initialValue: wedding.contacts)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBG.ignoresSafeArea()
            
            VStack(spacing: 15) {
                SubNavBarView(
                    type: .backTitleImageBtn(rtBtnType: .threeDotsInCircle),
                    title: wedding.title) {
                        withAnimation {
                            isContextMenuVisible.toggle()
                        }
                    }
                
                WPSearchField(searchText: $searchText)
                    .padding(.horizontal)
                
                if localContacts.isEmpty {
                    WPEmptyDataView(
                        image: "EmptyContactImg",
                        title: "Nothing here yet",
                        discr: "Add your Contacts",
                        buttonTitle: "Add New Contact",
                        destinationView: AddNewContactView(type: .addNew, weddingItem: wedding)
                            .environmentObject(viewModel)
                    )
                    .vSpacing(.center)
                } else {
                    List {
                        ForEach(localContacts) { contact in
                            NavigationLink {
                                AddNewContactView(type: .edit(contact), weddingItem: wedding)
                                    .environmentObject(viewModel)
                            } label: {
                                contactRowViewWith(contactModel: contact)
                            }
                        }
                        .onDelete(perform: deleteContact)
                        .onMove(perform: reorderContacts)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .environment(\.editMode, .constant(self.isNowEditing ? EditMode.active : EditMode.inactive))
                    .background(Color.clear)
                    .padding(.horizontal, hPaddings)
                }
            }
            
            if isContextMenuVisible {
                GeometryReader { geometry in
                    let screenWidth = geometry.size.width
                    
                    WPContextMenu(
                        style: .editFilterAddNewContact,
                        onEditAction: {
                            withAnimation {
                                isContextMenuVisible.toggle()
                                isNowEditing.toggle()
                            }
                        },
                        onAddGuestAction: {
                            withAnimation {
                                isContextMenuVisible.toggle()
                                isAddContactPresented.toggle()
                            }
                        },
                        onFilterAction: {
                            isContextMenuVisible.toggle()
                            // Добавьте здесь логику для фильтрации контактов по алфавиту
                        }
                    )
                    .frame(width: 250)
                    .background(Color.white.cornerRadius(12))
                    .shadow(radius: 10)
                    .position(
                        x: screenWidth - 250 / 2 - 18,
                        y: isiPhone ? 156 : 120
                    )
                }
                .ignoresSafeArea()
            }
        }
        .navigationBarBackButtonHidden()
        .dismissKeyboardOnTap()
        .fullScreenCover(isPresented: $isAddContactPresented, content: {
            AddNewContactView(type: .addNew, weddingItem: wedding)
                .environmentObject(viewModel)
        })
        .animation(.snappy, value: isNowEditing)
    }
    
    @ViewBuilder
    private func contactRowViewWith(contactModel: WeddingContact) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            WPTextView(
                text: contactModel.name,
                color: .standartDarkText,
                size: 17,
                weight: .regular
            )
            
            WPTextView(
                text: contactModel.phoneNum,
                color: .lbSecendary,
                size: 15,
                weight: .regular
            )
            
            WPTextView(
                text: contactModel.email,
                color: .lbSecendary,
                size: 15,
                weight: .regular
            )
        }
    }
    
    private func deleteContact(at offsets: IndexSet) {
        let contactsToDelete = offsets.map { localContacts[$0] }
        
        contactsToDelete.forEach { contact in
            viewModel.removeContact(contact, from: wedding)
        }
        localContacts.remove(atOffsets: offsets)
    }
    
    private func reorderContacts(from source: IndexSet, to destination: Int) {
        localContacts.move(fromOffsets: source, toOffset: destination)
        saveChanges()
    }
    
    private func saveChanges() {
        viewModel.updateContactsOrder(in: wedding, with: localContacts)
    }
    
    private func updateContacts() {
        localContacts = wedding.contacts
    }
}
