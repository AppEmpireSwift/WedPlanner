import SwiftUI

enum WPContextMenuStyle {
    case editAndAddContact
}

struct WPContextMenu: View {
    let style: WPContextMenuStyle
    let onEditAction: (() -> Void)?
    let onAddGuestAction: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 0) {
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
        }
        .frame(width: 250, height: 94)
        .background(Color.white.cornerRadius(12))
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}


#Preview {
    WPContextMenu(style: .editAndAddContact, onEditAction: {}, onAddGuestAction: {})
}
