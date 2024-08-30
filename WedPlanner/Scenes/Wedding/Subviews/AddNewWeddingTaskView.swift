import SwiftUI

struct AddNewWeddingTaskView: View {
    @StateObject private var viewModel = WeddingViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBG.ignoresSafeArea()
            
            VStack {
                SubNavBarView(
                    type: .backTitleTitledButton,
                    title: "Add Wedding",
                    rightBtnTitle: "Add Task",
                    isRightBtnEnabled: true) {
                        
                    }
                
                LineSeparaterView()
                
                VStack {
                    WPTextView(
                        text: "Wedding Tasks",
                        color: .standartDarkText,
                        size: 20,
                        weight: .semibold
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if !viewModel.isWedTasksClosed {
                        NoticeBubbleView(
                            text: "You can pick from these essential wedding planning tasks to get started, or create new ones that fit your needs. Note that tasks marked with ($) require a budget."
                        ) {
                            viewModel.closeWeddingTasks()
                        }
                    }
                }
                .padding(.horizontal, hPaddings)
                .padding(.vertical)
            }
        }
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(.container, edges: .bottom)
        .animation(.easeInOut(duration: 0.5), value: viewModel.isWedTasksClosed)
        .dismissKeyboardOnTap()
    }
}

#Preview {
    AddNewWeddingTaskView()
}
