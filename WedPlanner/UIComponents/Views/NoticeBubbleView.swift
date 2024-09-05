import SwiftUI

struct NoticeBubbleView: View {
    let text: String
    let closeAction: () -> Void
    
    var body: some View {
        HStack(alignment: .top ,spacing: 16) {
            WPTextView(
                text: text,
                color: .standartDarkText,
                size: 15,
                weight: .regular,
                alignment: .leading
            )
            
            WPImagedButtonView(type: .close, action: closeAction)
        }
        .padding()
        .background(
            Color.bejeBG.cornerRadius(16)
        )
    }
}

#Preview {
    NoticeBubbleView(text: "Before you start planning your perfect wedding, let's gather some essential details. Upload a beautiful cover photo and fill in key information. Once done, you'll be ready to add tasks to your wedding planning journey!", closeAction: {})
}
