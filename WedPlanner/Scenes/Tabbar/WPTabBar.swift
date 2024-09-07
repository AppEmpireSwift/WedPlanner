
import SwiftUI

struct WPTabBar: View {
    @State private var selection: WPTabbarItemModel = .wed
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.tbUnselected
    }
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(WPTabbarItemModel.allCases) { tab in
                tab.view(selection: tab == .cont ? $selection : nil)
                    .tabItem {
                        TabBarItemView(itemModel: tab)
                    }
                    .tag(tab)
            }
        }
        .accentColor(.accentColor)
        .onAppear {
            UITabBar.appearance().backgroundColor = UIColor.white
        }
    }
}

fileprivate struct TabBarItemView: View {
    let itemModel: WPTabbarItemModel
    
    var body: some View {
        VStack {
            Image(itemModel.rawValue)
                .resizable()
                .frame(width: 32, height: 32)
            
            WPTextView(
                text: itemModel.rawValue,
                color: .tbUnselected,
                size: 10,
                weight: .medium
            )
        }
    }
}
