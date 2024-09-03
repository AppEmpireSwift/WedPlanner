import SwiftUI
import RealmSwift

struct AddNewWeddingTaskView: View {
    @StateObject private var viewModel = WeddingViewModel()
    @State private var isSelected: Bool = false
    @State private var isAddAlertShown: Bool = false
    @EnvironmentObject private var realmManager: RealmManager
    
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
                        ForEach(realmManager.weddingTasks) { wedTask in
                            WPTaskSelecteionView(model: wedTask)
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                        }
                        .onDelete(perform: deleteTask)
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
    
    private func deleteTask(at offsets: IndexSet) {
        realmManager.deleteTask(at: offsets)
    }
}
