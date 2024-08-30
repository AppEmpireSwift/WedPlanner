import SwiftUI

struct WPTextEditor: View {
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.tbUnselected)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 7, leading: 4, bottom: 4, trailing: 7))
            }
            
            TextEditor(text: $text)
                .frame(maxHeight: .infinity)
                .transparentScrolling()
                .background(Color.clear)
        }
        .frame(height: 80)
        .padding(.horizontal)
        .padding(.vertical, 11)
        .onAppear {
            UITextView.appearance().backgroundColor = .clear
        }
        .background(
            Color.fieldsBG
                .cornerRadius(12)
        )
    }
}
