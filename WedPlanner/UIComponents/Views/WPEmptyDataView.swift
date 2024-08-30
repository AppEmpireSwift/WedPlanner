import SwiftUI

struct WPEmptyDataView<Content>: View where Content : View {
    let image: String
    let title: String
    let discr: String
    let buttonTitle: String
    let destinationView: Content
    
    private var hPaddings: CGFloat {
        if isiPhone {
            54
        } else {
            128
        }
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Image(image)
                .resizable()
                .frame(width: 140, height: 130.9)
            
            WPTextView(
                text: title,
                color: .accentColor,
                size: 17,
                weight: .bold
            )
            
            WPTextView(
                text: discr,
                color: .standartDarkText,
                size: 14,
                weight: .regular
            )
            
            WPButtonView(title: buttonTitle, action: {})
                .overlay {
                    NavigationLink(destination: destinationView
                        .navigationBarBackButtonHidden()
                        .onAppear(perform: {
                            hiddenTabBar()
                        })
                    ) {
                        Color.clear
                    }
                }
                .padding(.top, 4)
        }
        .padding(.horizontal, hPaddings)
    }
}
