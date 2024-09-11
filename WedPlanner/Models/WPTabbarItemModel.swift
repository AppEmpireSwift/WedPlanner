import SwiftUI

enum WPTabbarItemModel: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case wed = "Wedding"
    case cont = "Contacts"
    case cal = "Calendar"
    case ide = "Ideas"
    case set = "Settings"
    
    @ViewBuilder
    func view(selection: Binding<WPTabbarItemModel>? = nil) -> some View {
        switch self {
        case .wed:
            WPNavBarView {
                WeddingView()
            }
        case .cont:
            WPNavBarView {
                ContactsView(selection: selection!)
            }
        case .cal:
            WPNavBarView {
                CalendarView()
            }
        case .ide:
            WPNavBarView {
                IdeasView()
            }
        case .set:
            WPNavBarView {
                SettingsView()
            }
        }
    }
}
