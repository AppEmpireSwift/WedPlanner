import SwiftUI

struct OnboardingView: View {
    @StateObject var viewModel = OnboardingViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBG.ignoresSafeArea()
            
            VStack {
                switch viewModel.currentTabSelection {
                case .first:
                    OBContentView(itemModel: .first) {
                        viewModel.currentTabSelection = .second
                    }
                case .second:
                    OBContentView(itemModel: .second) {
                        viewModel.currentTabSelection = .third
                    }
                case .third:
                    OBContentView(itemModel: .third) {
                        viewModel.currentTabSelection = .fourth
                    }
                case .fourth:
                    OBContentView(itemModel: .fourth) {
                        viewModel.finishOnboarding()
                    }
                }
                
                OBFooterView(
                    isPolicyShown: $viewModel.isPolicyShown,
                    isTermsShown: $viewModel.isTermsShown
                )
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .onChange(of: viewModel.currentTabSelection, perform: { value in
            if viewModel.currentTabSelection == .third {
                requestReview()
            }
        })
        .sheet(isPresented: $viewModel.isPolicyShown, content: {
            LicenseTextView(isPresented: $viewModel.isPolicyShown, type: .policy)
        })
        .sheet(isPresented: $viewModel.isTermsShown, content: {
            LicenseTextView(isPresented: $viewModel.isTermsShown, type: .terms)
        })
        .animation(.linear(duration: 0.2), value: viewModel.currentTabSelection)
    }
}

fileprivate struct OBContentView: View {
    var itemModel: OnboardinItemModel
    let action: () -> Void
    
    private var btnPaddings: CGFloat {
        if isiPhone {
            16
        } else {
            85
        }
    }
    
    var body: some View {
        VStack {
            Image(itemModel.image)
                .resizable()
            
            currentPage
            
            WPTextView(
                text: itemModel.titleBlack,
                color: .standartDarkText,
                size: 34,
                weight: .bold
            )
            
            WPTextView(
                text: itemModel.titleColored,
                color: .accentColor,
                size: 30,
                weight: .bold
            )
            
            WPTextView(
                text: itemModel.description,
                color: .sGray,
                size: 14,
                weight: .medium
            )
            .padding(.top, 10)
            
            WPButtonView(title: itemModel.buttonTitle) {
                action()
            }
            .padding(.horizontal, btnPaddings)
            .padding(.top, 20)
        }
    }
    
    private var currentPage: some View {
        HStack {
            ForEach(1..<4) { index in
                if itemModel.indicator == index {
                    RoundedRectangle(cornerRadius: 50)
                        .foregroundColor(.accentColor)
                        .frame(width: 14, height: 7)
                } else {
                    Circle()
                        .foregroundColor(Color.obUnactiveCircle)
                        .frame(width: 7, height: 7)
                }
            }
        }
    }
}

fileprivate struct OBFooterView: View {
    @Binding var isPolicyShown: Bool
    @Binding var isTermsShown: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            Button(action: {
                isPolicyShown.toggle()
            }, label: {
                WPTextView(
                    text: "Privacy Policy",
                    color: .sGray,
                    size: 12,
                    weight: .regular,
                    isUnderlined: true,
                    underlineColor: .sGray
                )
            })
            
            Button(action: {
                isTermsShown.toggle()
            }, label: {
                WPTextView(
                    text: "Terms of Use",
                    color: .sGray,
                    size: 12,
                    weight: .regular,
                    isUnderlined: true,
                    underlineColor: .sGray
                )
            })
        }
        .frame(maxWidth: .infinity ,maxHeight: 40)
        .padding(.bottom, 25)
    }
}

#Preview {
    OnboardingView()
}
