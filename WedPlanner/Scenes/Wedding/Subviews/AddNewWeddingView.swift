import SwiftUI

struct AddNewWeddingViewStates {
    var titleText: String = ""
    var locationText: String = ""
    var budgetText: String = ""
}

struct AddNewWeddingView: View {
    @StateObject private var viewModel = WeddingViewModel()
    @State private var states = AddNewWeddingViewStates()
    
    private var hPaddings: CGFloat {
        if isiPhone {
            16
        } else {
            85
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBG.ignoresSafeArea()
            
            VStack {
                SubNavBarView(
                    type: .backTitleTitledButton,
                    title: "Add Wedding",
                    rightBtnTitle: "Save",
                    isRightBtnEnabled: false) {
                        
                    }
                LineSeparaterView()
                
                VStack {
                    WPTextView(
                        text: "Wedding Details",
                        color: .standartDarkText,
                        size: 20,
                        weight: .semibold
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if !viewModel.isWedDetailsClosed {
                        NoticeBubbleView(
                            text: "Before you start planning your perfect wedding, let's gather some essential details. Upload a beautiful cover photo and fill in key information. Once done, you'll be ready to add tasks to your wedding planning journey!"
                        ) {
                            viewModel.closeWeddingDetails()
                        }
                    }
                    
                    ContentView(
                        titleText: $states.titleText,
                        locationText: $states.locationText, 
                        budgetText: $states.budgetText
                    )
                        .padding(.top, 24)
                    
                }
                .padding(.horizontal, hPaddings)
                .padding(.vertical)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: viewModel.isWedDetailsClosed)
    }
}

fileprivate struct ContentView: View {
    @Binding var titleText: String
    @Binding var locationText: String
    @Binding var budgetText: String
    
    var body: some View {
        VStack(spacing: 12) {
            VStack(spacing: 7) {
                WPTextView(text: "TITTLE", color: .standartDarkText, size: 15, weight: .regular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                WPTextField(text: $titleText, type: .simple, placeholder: "Whose wedding is this?")
            }
            
            VStack(spacing: 7) {
                WPTextView(text: "DATE", color: .standartDarkText, size: 15, weight: .regular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(spacing: 12) {
                    
                }
            }
            
            VStack(spacing: 7) {
                WPTextView(text: "LOCATION", color: .standartDarkText, size: 15, weight: .regular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                WPTextField(text: $locationText, type: .simple, placeholder: "Wedding's Location")
            }
            
            VStack(spacing: 7) {
                WPTextView(text: "BUDGET", color: .standartDarkText, size: 15, weight: .regular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                WPTextField(text: $budgetText, type: .bujet, placeholder: "Total Budget")
            }
        }
    }
}

#Preview {
    AddNewWeddingView()
}
