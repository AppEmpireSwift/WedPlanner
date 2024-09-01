import SwiftUI
import StoreKit

extension View {
    var isiPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
    
    var hPaddings: CGFloat {
        if isiPhone {
            16
        } else {
            85
        }
    }
    
    func requestReview() {
        DispatchQueue.main.async {
            if let scene = UIApplication.shared.connectedScenes
                .first(where: { $0.activationState == .foregroundActive })
                as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    }
    
    func showTabBar() {
        TabBarModifier.showTabBar()
    }
    
    func hiddenTabBar() {
        TabBarModifier.hideTabBar()
    }
    
    @ViewBuilder
    func hSpacing(_ alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
    func vSpacing(_ alignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    
    /// Модификатор для того, чтобы убрать цвет фона у сложных элементов
    func transparentScrolling() -> some View {
        if #available(iOS 16.0, *) {
            return scrollContentBackground(.hidden)
        } else {
            return onAppear {
                UITextView.appearance().backgroundColor = .clear
            }
        }
    }
    
    ///Модификатор для скрытия клавиатуры / resignFirstResponder у всех филдов
    func dismissKeyboardOnTap() -> some View {
        modifier(DismissingKeyboardOnTap())
    }
    
    /// Модификатор кастомного алерта по добавлению Task
    func wpAlert(isPresented: Binding<Bool>) -> some View {
        self.modifier(WPAlertViewModifier(isPresented: isPresented))
    }
    
    /// Модификатор, который позволяет закруглять выбранные углы
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
