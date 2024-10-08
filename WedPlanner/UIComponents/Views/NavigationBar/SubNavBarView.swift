import SwiftUI

enum SubNavBarViewType {
    case backTitleTitledButton
    case backAndTitle
    case backTitleImageBtn (rtBtnType: WPImagedButtonViewType)
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
                
                WPTextView(
                    text: title,
                    color: .standartDarkText,
                    size: 17,
                    weight: .semibold
                )
                .frame(maxWidth: .infinity)
                
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
        case .backAndTitle:
            HStack {
                WPImagedButtonView(type: .arrowBack, action: dismiss.callAsFunction)
                                
                WPTextView(
                    text: title,
                    color: .standartDarkText,
                    size: 17,
                    weight: .semibold
                )
                .hSpacing(.center)
                
                Spacer()
            }
            .padding(.horizontal)
        case .backTitleImageBtn (let rtBtnType):
            HStack {
                WPImagedButtonView(type: .arrowBack, action: dismiss.callAsFunction)
                                
                WPTextView(
                    text: title,
                    color: .standartDarkText,
                    size: 17,
                    weight: .semibold
                )
                .frame(maxWidth: .infinity)
                
                WPImagedButtonView(type: rtBtnType) {
                    rightBtnAction?()
                }
                
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    SubNavBarView(type: .backTitleTitledButton)
}
