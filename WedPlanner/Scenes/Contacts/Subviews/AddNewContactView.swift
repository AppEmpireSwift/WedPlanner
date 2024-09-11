import SwiftUI

struct AddNewContactViewStates {
    var nameText: String = ""
    var phoneText: String = ""
    var email: String = ""
    var adress: String = ""
    var birthDay: String = ""
    var notes: String = ""
}

enum AddNewContactViewMode {
    case addNew
    case edit(WeddingContact)
}

struct AddNewContactView: View {
    @EnvironmentObject var viewModel: WeddingItemsViewModel
    @State private var states = AddNewContactViewStates()
    let type: AddNewContactViewMode
    var weddingItem: WeddingItem?
    
    private var isSaveDisabled: Bool {
        states.nameText.isEmpty || states.phoneText.isEmpty || states.email.isEmpty
    }
    
    init(type: AddNewContactViewMode, weddingItem: WeddingItem? = nil) {
        _states = State(initialValue: {
            switch type {
            case .addNew:
                return AddNewContactViewStates()
            case .edit(let contact):
                return AddNewContactViewStates(
                    nameText: contact.name,
                    phoneText: contact.phoneNum,
                    email: contact.email,
                    adress: contact.address,
                    birthDay: contact.birthDay,
                    notes: contact.notes
                )
            }
        }())
        
        self.type = type
        self.weddingItem = weddingItem
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBG.ignoresSafeArea()
            
            VStack {
                SubNavBarView(type: .backAndTitle, title: "New Contact")
                
                ZStack(alignment: .top) {
                    Color.fieldsBG
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 12){
                            headerBubbleView()
                            adressBubbleView()
                            notesBubbleView()
                        }
                        .padding(.vertical)
                    }
                    .padding(.horizontal, hPaddings)
                    .padding(.top)
                }
                
                WPButtonView(title: "Save") {
                    buttonAction()
                }
                .disabled(isSaveDisabled)
                .padding(.horizontal, hPaddings)
            }
        }
        .navigationBarBackButtonHidden()
        .dismissKeyboardOnTap()
        .animation(.snappy, value: isSaveDisabled)
    }
    
    @ViewBuilder
    private func headerBubbleView() -> some View {
        VStack(spacing: 12) {
            VStack(spacing: 7) {
                WPTextView(text: "NAME*", color: .standartDarkText, size: 15, weight: .regular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                WPTextField(text: $states.nameText, type: .simple, placeholder: "Full name")
            }
            
            VStack(spacing: 7) {
                WPTextView(text: "BIRTHDAY", color: .standartDarkText, size: 15, weight: .regular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                WPTextField(text: $states.birthDay, type: .simple, placeholder: "01.01.1900")
                    .keyboardType(.numbersAndPunctuation)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.mainBG)
        )
    }
    
    @ViewBuilder
    private func adressBubbleView() -> some View {
        VStack(spacing: 12) {
            VStack(spacing: 7) {
                WPTextView(text: "EMAIL*", color: .standartDarkText, size: 15, weight: .regular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                WPTextField(text: $states.email, type: .simple, placeholder: "mail@mail.com")
                    .keyboardType(.emailAddress)
            }
            
            VStack(spacing: 7) {
                WPTextView(text: "PHONE NUMBER*", color: .standartDarkText, size: 15, weight: .regular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                WPTextField(text: $states.phoneText, type: .simple, placeholder: "+1234567890")
                    .keyboardType(.numbersAndPunctuation)
            }
            
            VStack(spacing: 7) {
                WPTextView(text: "ADDRESS", color: .standartDarkText, size: 15, weight: .regular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                WPTextField(text: $states.adress, type: .simple, placeholder: "Paris, France")
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.mainBG)
        )
    }
    
    @ViewBuilder
    private func notesBubbleView() -> some View {
        VStack(spacing: 7) {
            WPTextView(text: "NOTES", color: .standartDarkText, size: 15, weight: .regular)
                .frame(maxWidth: .infinity, alignment: .leading)
            WPTextEditor(text: $states.notes, placeholder: "Here You can enter some notes")
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.mainBG)
        )
    }
    
    private func buttonAction() {
        switch type {
        case .addNew:
            if let wedding = weddingItem {
                viewModel.addContact(WeddingContact(
                    name: states.nameText,
                    phoneNum: states.phoneText,
                    email: states.email,
                    address: states.adress,
                    birthDay: states.birthDay,
                    notes: states.notes,
                    order: wedding.contacts.count + 1),
                                     to: wedding
                )
            }
        case .edit(let weddingContact):
            if let wedding = weddingItem {
                viewModel.updateContact(
                    WeddingContact(
                        name: states.nameText,
                        phoneNum: states.phoneText,
                        email: states.email,
                        address: states.adress,
                        birthDay: states.birthDay,
                        notes: states.notes,
                        order: weddingContact.order
                    ), in: wedding
                )
            }
        }
    }
}

#Preview {
    AddNewContactView(type: .addNew)
}
