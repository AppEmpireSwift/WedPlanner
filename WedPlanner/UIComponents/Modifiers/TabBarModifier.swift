import UIKit

struct TabBarModifier {
    static func showTabBar() {
        guard let tabBar = UIApplication.shared.key?.allSubviews().first(where: { $0 is UITabBar }) as? UITabBar else { return }
        
        if !tabBar.isHidden {
            return
        }
        
        UIView.animate(withDuration: 0.3) {
            tabBar.alpha = 1.0
            tabBar.isHidden = false
        }
    }
    
    static func hideTabBar() {
        guard let tabBar = UIApplication.shared.key?.allSubviews().first(where: { $0 is UITabBar }) as? UITabBar else { return }
        
        if tabBar.isHidden {
            return
        }
        
        UIView.animate(withDuration: 0.3) {
            tabBar.alpha = 0.0
        } completion: { _ in
            tabBar.isHidden = true
        }
    }
}
