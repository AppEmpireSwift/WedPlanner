import SwiftUI

struct WeddingContactsListView: View {
    @State private var searchText: String = ""
    @State private var isContextMenuVisible: Bool = false
    @State private var isNowEditing: Bool = false
    @State private var isAddContactPresented: Bool = false
    
    var wedding: WeddingItemModel
    
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
                
                if wedding.contacts.isEmpty {
                    WPEmptyDataView(
                        image: "EmptyContactImg",
                        title: "Nothing here yet",
                        discr: "Add your Contacts",
                        buttonTitle: "Add New Contact",
                        destinationView: AddNewContactView(type: .addNew)
                    )
                    .vSpacing(.center)
                } else {
                    List {
                        ForEach(wedding.contacts) { contact in
                            NavigationLink(destination: AddNewContactView(type: .edit(contact))) {
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
            AddNewContactView(type: .addNew)
        })
        .animation(.snappy, value: isNowEditing)
    }
    
    @ViewBuilder
    private func contactRowViewWith(contactModel: WeddingContactsModel) -> some View {
        NavigationLink(destination: AddNewContactView(type: .edit(contactModel))) {
            
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
    }
    
    private func deleteContact(at offsets: IndexSet) {

    }
    
    private func reorderContacts(from source: IndexSet, to destination: Int) {

    }
}

#Preview {
    let test1 = WeddingContactsModel()
    test1.name = "dadasasd"
    test1.phoneNum = "88005553535"
    test1.email = "zalupa@mail.ru"
    
    let wedding = WeddingItemModel()
    wedding.title = "Maks and SPerm"
    wedding.contacts.append(test1)
    
    return WeddingContactsListView(wedding: wedding)
}
