import SwiftUI

struct WPTextView: View {
    let text: String
    let color: Color
    let size: CGFloat
    let weight: Font.Weight
    var isUnderlined: Bool = false
    var underlineColor: Color = .white
    var alignment: TextAlignment = .center
    
    var body: some View {
        Text(text)
            .foregroundColor(color)
            .font(.system(size: size, weight: weight))
            .underline(isUnderlined, color: underlineColor)
            .multilineTextAlignment(alignment)
    }
}

#Preview {
    WPTextView(text: "fddf", color: .bejeBG, size: 14, weight: .regular)
}
