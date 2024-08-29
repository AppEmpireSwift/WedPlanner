import SwiftUI

enum WPImagedButtonViewType {
    case notification
    case plusInCircle
    /// Используется на Wedding экране при пустой data, в левом верхнем углу
    case itemList
    case arrowBack
    case threeDotsInCircle
    case micro
    case pen
    case filter
    case like
    case minusInCircle
    /// Крестик для закрытия, с цветом и повернутый
    case close
    
}

struct WPImagedButtonView: View {
    let type: WPImagedButtonViewType
    var disabled: Bool = false
    var hasSomeNotifications: Bool = false
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            switch type {
            case .notification:
                Image(hasSomeNotifications ? "Notification" : "NotififcationEmpty")
                    .foregroundColor(disabled ? Color.lbQuaternary : Color.standartDarkText)
            case .plusInCircle:
                Image("NavBarAdd")
            case .itemList:
                Image("LeftSideMenu")
                    .foregroundColor(disabled ? Color.lbQuaternary : Color.standartDarkText)
            case .arrowBack:
                Image("NavArrowBack")
            case .threeDotsInCircle:
                Image("ThreeDots")
            case .micro:
                Image(systemName: "mic.fill")
                    .foregroundStyle(Color.standartDarkText)
            case .pen:
                Image(systemName: "applepencil")
                    .foregroundStyle(Color.standartDarkText)
            case .filter:
                Image("filterIcon")
            case .like:
                Image("NavLike")
                    .foregroundColor(disabled ? Color.lbQuaternary : Color.redBG)
            case .minusInCircle:
                Image("minusInCircle")
            case .close:
                Image("CloseXMark")
            }
        })
    }
}

#Preview {
    WPImagedButtonView(type: .notification, action: {})
}
