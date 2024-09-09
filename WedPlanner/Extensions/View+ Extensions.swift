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
    
    /// Модификатор кастомного алерта по добавлению Гостей
    func wpGuestAlert(isPresented: Binding<Bool>, guestName: Binding<String>, guestNote: Binding<String>, addAction: @escaping () -> Void) -> some View {
        self.modifier(WPGuestAlertViewModifier(isPresented: isPresented, guestName: guestName, guestNote: guestNote, addAction: addAction))
    }
    
    /// Модификатор, который позволяет закруглять выбранные углы
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    func getUIImageArray(from data: Data) -> [UIImage] {
        do {
            if let imageDataArray = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, NSData.self], from: data) as? [Data] {
                return imageDataArray.compactMap { UIImage(data: $0) }
            }
        } catch {
            print("Failed to deserialize image data: \(error)")
        }
        return []
    }
}
