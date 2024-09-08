import SwiftUI

struct AddNewWeddingView: View {
    @EnvironmentObject var viewModel: WeddingViewModel
    
    private var isContinueEnabled: Bool {
        if viewModel.states.firstCreationScreen.titleText.isEmpty || viewModel.states.firstCreationScreen.locationText.isEmpty || viewModel.states.firstCreationScreen.budgetText.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBG.ignoresSafeArea()
            
            VStack {
                SubNavBarView(type: .backAndTitle, title: "Add Wedding")
                
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
                    
                    ScrollView(showsIndicators: false) {
                        ContentView(
                            titleText: $viewModel.states.firstCreationScreen.titleText,
                            locationText: $viewModel.states.firstCreationScreen.locationText,
                            budgetText: $viewModel.states.firstCreationScreen.budgetText,
                            selectedImg: $viewModel.states.firstCreationScreen.selectedCoverImage,
                            notesText: $viewModel.states.firstCreationScreen.notesText,
                            selectedDate: $viewModel.states.firstCreationScreen.weddingDate
                        )
                        .padding(.bottom)
                    }
                        .padding(.top, 24)
                }
                .padding(.horizontal, hPaddings)
                .padding(.vertical)
                
                NavigationLink(
                    destination: AddNewWeddingTaskView()
                        .environmentObject(viewModel)
                ) {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 50)
                        .foregroundColor(isContinueEnabled ? Color.accentColor : .fieldsBG)
                        .overlay {
                            WPTextView(
                                text: "Continue",
                                color: isContinueEnabled ? .mainBG : .tbUnselected,
                                size: 17,
                                weight: .regular
                            )
                        }
                }
                .padding(.horizontal, hPaddings)
                .padding(.bottom, 33)
                .disabled(!isContinueEnabled)
            }
        }
        .ignoresSafeArea(.container, edges: .bottom)
        .animation(.easeInOut(duration: 0.5), value: viewModel.isWedDetailsClosed)
        .animation(.easeInOut, value: isContinueEnabled)
        .dismissKeyboardOnTap()
    }
}

fileprivate struct ContentView: View {
    @Binding var titleText: String
    @Binding var locationText: String
    @Binding var budgetText: String
    @Binding var selectedImg: UIImage?
    @Binding var notesText: String
    @Binding var selectedDate: Date
    
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
                
                WPDatePickerView(selectedDate: $selectedDate)
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
            
            VStack(spacing: 7) {
                WPTextView(text: "COVER PHOTO", color: .standartDarkText, size: 15, weight: .regular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                WPImagePickerView(selectedImage: $selectedImg)
            }
            
            VStack(spacing: 7) {
                WPTextView(text: "NOTES", color: .standartDarkText, size: 15, weight: .regular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                WPTextEditor(text: $notesText, placeholder: "Enter some text, if needed")
            }
        }
    }
}

#Preview {
    AddNewWeddingView()
        .environmentObject(WeddingViewModel())
}
