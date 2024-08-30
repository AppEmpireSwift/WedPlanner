import SwiftUI

struct DismissingKeyboardOnTap: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                UIApplication.shared.dismissKeyboard()
            }
    }
}
