import SwiftUI

enum WPTextFieldType {
    case simple
    case bujet
}

struct WPTextField: View {
    @Binding var text: String
    let type: WPTextFieldType
    let placeholder: String
    
    var body: some View {
        switch type {
        case .simple:
            TextField(
                text: $text,
                prompt: Text(placeholder)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(Color.tbUnselected)
            ) {}
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(Color.standartDarkText)
                .padding(.horizontal)
                .padding(.vertical, 11)
                .background {
                    Color.fieldsBG.cornerRadius(12)
                }
        case .bujet:
            HStack(spacing: 4) {
                Image("DollarIcon")
                
                TextField(
                    text: $text,
                    prompt: Text(placeholder)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(Color.tbUnselected)
                ) {}
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(Color.standartDarkText)
                    .padding(.vertical, 11)
                    .keyboardType(.decimalPad)
            }
            .padding(.horizontal)
            .background {
                Color.fieldsBG.cornerRadius(12)
            }
        }
    }
}

#Preview {
    WPTextField(text: .constant(""), type: .bujet, placeholder: "dfdfddfdf")
}
