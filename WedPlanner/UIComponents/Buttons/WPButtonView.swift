import SwiftUI

struct WPButtonView: View {
    let title: String
    var isDeleteStyle: Bool = false
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            RoundedRectangle(cornerRadius: 12)
                .frame(maxHeight: 50)
                .overlay {
                    WPTextView(
                        text: title,
                        color: .mainBG,
                        size: 17,
                        weight: .medium
                    )
                }
        })
    }
}

#Preview {
    WPButtonView(title: "Continue", action: {})
}
