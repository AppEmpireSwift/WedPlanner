import SwiftUI

enum LicenseTextViewType {
    case policy
    case terms
}

struct LicenseTextView: View {
    @Binding var isPresented: Bool
    let type: LicenseTextViewType
    
    private var contentTextArray: [LicenseTextModel] {
        switch type {
        case .policy:
            LicenseTextModel.privacyPolice
        case .terms:
            LicenseTextModel.termsDataArray
        }
    }
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                ForEach(contentTextArray) { chap in
                    TextContentView(title: chap.title, message: chap.text)
                }
            }
            
            WPButtonView(title: "Close") {
                isPresented.toggle()
            }
            .padding(.vertical)
            .padding(.horizontal, isiPhone ? 16 : 85)
        }
    }
}

fileprivate struct TextContentView: View {
    let title: String
    let message: String
    
    var body: some View {
        VStack(spacing: 10) {
            WPTextView(
                text: title,
                color: .standartDarkText,
                size: 25,
                weight: .bold,
                isUnderlined: true,
                underlineColor: .accentColor,
                alignment: .center
            )
            .frame(maxWidth: UIScreen.main.bounds.width - 40)
            
            WPTextView(text: message, color: .lbSecendary, size: 16, weight: .regular, alignment: .leading)
        }
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 10))
    }
}
