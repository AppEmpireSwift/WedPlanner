import SwiftUI
import RealmSwift

struct AddNewWeddingTaskView: View {
    @EnvironmentObject var viewModel: WeddingViewModel
    @EnvironmentObject var weddingItemViewModel: WeddingItemsViewModel
    @EnvironmentObject var weddingTasksViewModel: WeddingTasksViewModel
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
                        ForEach(weddingTasksViewModel.tasks) { wedTask in
                            WPTaskSelectionView(model: wedTask)
                                .environmentObject(weddingTasksViewModel)
                                .swipeActions {
                                    if wedTask.isTaskCanBeDeleted {
                                        Button(action: {
                                            weddingTasksViewModel.deleteTask(wedTask)
                                        }, label: {
                                            Text("Delete")
                                        })
                                    }
                                }
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                        }
                    }
                    .listStyle(.plain)
                    .background(Color.clear)
                    
                    WPButtonView(title: "Save") {
                        saveAction()
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
    
    private func saveAction() {
        weddingItemViewModel.addWeddingItem(
            title: viewModel.firstAddStates.titleText,
            date: viewModel.firstAddStates.weddingDate,
            location: viewModel.firstAddStates.locationText,
            budget: viewModel.firstAddStates.budgetText,
            coverPhoto: viewModel.convertToData(from: viewModel.firstAddStates.selectedCoverImage),
            notes: viewModel.firstAddStates.notesText,
            order: weddingItemViewModel.weddingItems.count + 1,
            tasks: weddingTasksViewModel.fetchSelectedTasks()
        )
        
        weddingTasksViewModel.deselectAllTasks()
    }
}
