import SwiftUI

struct AddNewWeddingView: View {
    @StateObject var viewModel = WeddingViewModel()
    @EnvironmentObject var weddingItemViewModel: WeddingItemsViewModel
    @EnvironmentObject var weddingTasksViewModel: WeddingTasksViewModel
    
    private var isContinueEnabled: Bool {
        if viewModel.firstAddStates.titleText.isEmpty || viewModel.firstAddStates.locationText.isEmpty || viewModel.firstAddStates.budgetText.isEmpty {
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
                        CreateWeddingContentView(
                            titleText: $viewModel.firstAddStates.titleText,
                            locationText: $viewModel.firstAddStates.locationText,
                            budgetText: $viewModel.firstAddStates.budgetText,
                            selectedImg: $viewModel.firstAddStates.selectedCoverImage,
                            notesText: $viewModel.firstAddStates.notesText,
                            selectedDate: $viewModel.firstAddStates.weddingDate
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
                        .environmentObject(weddingItemViewModel)
                        .environmentObject(weddingTasksViewModel)
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
    }
}

#Preview {
    AddNewWeddingView(viewModel: WeddingViewModel())
}
