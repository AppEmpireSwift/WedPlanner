import SwiftUI

struct AddNewWeddingTaskView: View {
    @StateObject private var viewModel = WeddingViewModel()
    @State private var isSelected: Bool = false
    @State private var isAddAlertShown: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBG.ignoresSafeArea()
            
            VStack {
                SubNavBarView(
                    type: .backTitleTitledButton,
                    title: "Add Wedding",
                    rightBtnTitle: "Add Task",
                    isRightBtnEnabled: true) {
                        withAnimation {
                            isAddAlertShown.toggle()
                        }
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
                    
                    List {
                        ForEach(viewModel.states.tasks) { taskItem in
                            WPTaskSelecteionView(model: taskItem)
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    if !taskItem.isTaskDefault {
                                        Button(role: .destructive) {
                                            withAnimation {
                                                viewModel.deleteTask(task: taskItem)
                                            }
                                        } label: {
                                            Image(systemName: "trash")
                                                .foregroundColor(.white)
                                            
                                        }
                                        .tint(Color.redBG)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    }
                                }
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                        }
                    }
                    .listStyle(.plain)
                    .background(Color.clear)
                    
                    WPButtonView(title: "Save") {
        
                    }
                    .padding(.bottom)
                }
                .padding(.horizontal, hPaddings)
                .padding(.vertical)
            }
        }
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(.container, edges: .bottom)
        .animation(.easeInOut(duration: 0.5), value: viewModel.isWedTasksClosed)
        .dismissKeyboardOnTap()
        .wpAlert(
            isPresented: $isAddAlertShown
        )
    }
}

#Preview {
    AddNewWeddingTaskView()
}
