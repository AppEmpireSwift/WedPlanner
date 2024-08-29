import SwiftUI

enum SubNavBarViewType {
    case backTitleTitledButton
}

struct SubNavBarView: View {
    @Environment(\.dismiss) var dismiss
    let type: SubNavBarViewType
    var title: String = ""
    var rightBtnTitle: String = ""
    var isRightBtnEnabled: Bool = true
    
    var rightBtnAction: (() -> Void)?
    
    var body: some View {
        switch type {
        case .backTitleTitledButton:
            HStack {
                WPImagedButtonView(type: .arrowBack, action: dismiss.callAsFunction)
                
                Spacer()
                
                WPTextView(
                    text: title,
                    color: .standartDarkText,
                    size: 17,
                    weight: .semibold
                )
                
                Spacer()
                
                Button(action: {
                    rightBtnAction?()
                }, label: {
                    WPTextView(
                        text: rightBtnTitle,
                        color: isRightBtnEnabled ? Color.tbSelected : Color.tbUnselected,
                        size: 17,
                        weight: .regular
                    )
                })
                .disabled(!isRightBtnEnabled)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    SubNavBarView(type: .backTitleTitledButton)
}
