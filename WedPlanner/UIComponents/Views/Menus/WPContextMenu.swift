import SwiftUI

enum WPContextMenuStyle {
    case editAndAddContact
    case editFilterAddNewContact
}

struct WPContextMenu: View {
    let style: WPContextMenuStyle
    let onEditAction: (() -> Void)?
    let onAddGuestAction: (() -> Void)?
    var onFilterAction: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            switch style {
            case .editAndAddContact:
                Button(action: {
                    onEditAction?()
                }) {
                    HStack {
                        Text("Edit")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Image(systemName: "pencil")
                            .foregroundColor(.black)
                    }
                    .padding()
                }
                
                Divider()
                
                Button(action: {
                    onAddGuestAction?()
                }) {
                    HStack {
                        WPTextView(
                            text: "Add New Guest",
                            color: .tbSelected,
                            size: 17,
                            weight: .regular
                        )
                        
                        Spacer()
                        
                        Image("PlusInCircle")
                            .foregroundColor(.tbSelected)
                    }
                    .padding()
                }

            case .editFilterAddNewContact:
                Button(action: {
                    onFilterAction?()
                }) {
                    HStack {
                        Text("Filter by Alphabet")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Image("filterIcon")
                            .foregroundColor(.black)
                    }
                    .padding()
                }
                
                Divider()
                
                Button(action: {
                    onEditAction?()
                }) {
                    HStack {
                        Text("Edit")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Image(systemName: "pencil")
                            .foregroundColor(.black)
                    }
                    .padding()
                }
                
                Divider()
                
                Button(action: {
                    onAddGuestAction?()
                }) {
                    HStack {
                        WPTextView(
                            text: "Add New Contact",
                            color: .tbSelected,
                            size: 17,
                            weight: .regular
                        )
                        
                        Spacer()
                        
                        Image("PlusInCircle")
                            .foregroundColor(.tbSelected)
                    }
                    .padding()
                }
            }
        }
        .frame(width: 250, height: style == .editAndAddContact ? 94 : 140)
        .background(Color.white.cornerRadius(12))
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}


#Preview {
    VStack {
        WPContextMenu(style: .editAndAddContact, onEditAction: {}, onAddGuestAction: {})
        WPContextMenu(style: .editFilterAddNewContact, onEditAction: {}, onAddGuestAction: {}, onFilterAction: {})
    }
    .padding()
}
