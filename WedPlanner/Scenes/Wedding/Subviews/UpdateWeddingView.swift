import SwiftUI

struct UpdateWeddingView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: WeddingItemsViewModel
    @EnvironmentObject var taskViewModel: WeddingTasksViewModel
    @Binding var weddingItem: WeddingItem
    
    @State private var titleText: String
    @State private var locationText: String
    @State private var budgetText: String
    @State private var selectedImage: UIImage?
    @State private var notesText: String
    @State private var selectedDate: Date
    @State private var allExistingTasks: [WeddingTask] = []
    
    init(weddingItem: Binding<WeddingItem>) {
        _weddingItem = weddingItem
        _titleText = State(initialValue: weddingItem.wrappedValue.title)
        _locationText = State(initialValue: weddingItem.wrappedValue.location)
        _budgetText = State(initialValue: weddingItem.wrappedValue.budget)
        _selectedImage = State(initialValue: UIImage(data: weddingItem.wrappedValue.coverPhoto))
        _notesText = State(initialValue: weddingItem.wrappedValue.notes)
        _selectedDate = State(initialValue: weddingItem.wrappedValue.date)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBG.ignoresSafeArea()
            
            VStack(spacing: 16) {
                SubNavBarView(type: .backAndTitle, title: "Update Wedding")
                
                LineSeparaterView()
                
                VStack(spacing: 16) {
                    ScrollView(showsIndicators: false) {
                        VStack {
                            CreateWeddingContentView(
                                titleText: $titleText,
                                locationText: $locationText,
                                budgetText: $budgetText,
                                selectedImg: $selectedImage,
                                notesText: $notesText,
                                selectedDate: $selectedDate
                            )
                        }
                        .padding(.bottom)
                        
                        VStack {
                            WPTextView(
                                text: "Wedding Tasks",
                                color: .standartDarkText,
                                size: 20,
                                weight: .semibold
                            )
                            .padding(.bottom, 20)
                            
                            ForEach($allExistingTasks) { $wedTask in
                                WPExistingTaskSelectionView(model: $wedTask)
                                    .environmentObject(taskViewModel)
                                    .onChange(of: wedTask.isSelected) { newValue in
                                        if let index = allExistingTasks.firstIndex(where: { $0.id == wedTask.id }) {
                                            allExistingTasks[index].isSelected = newValue
                                        }
                                    }
                                    .onChange(of: wedTask.spendText) { newValue in
                                        if let index = allExistingTasks.firstIndex(where: { $0.id == wedTask.id }) {
                                            allExistingTasks[index].spendText = newValue
                                        }
                                    }
                                    .onChange(of: wedTask.totalText) { newValue in
                                        if let index = allExistingTasks.firstIndex(where: { $0.id == wedTask.id }) {
                                            allExistingTasks[index].totalText = newValue
                                        }
                                    }
                                    .swipeActions {
                                        if wedTask.isTaskCanBeDeleted {
                                            Button(action: {
                                                taskViewModel.deleteTask(wedTask)
                                            }, label: {
                                                Text("Delete")
                                            })
                                        }
                                    }
                                    .listRowBackground(Color.clear)
                                    .listRowSeparator(.hidden)
                            }
                        }
                        .padding(.bottom)
                        
                        WPButtonView(title: "Update & Close") {
                            saveWeddingChanges()
                            dismiss.callAsFunction()
                        }
                        .frame(height: 50)
                        
                    }
                    .padding(.horizontal, hPaddings)
                }
            }
        }
        .onAppear(perform: {
            getAllTasks()
        })
        .onDisappear {
            taskViewModel.deselectAllTasks()
        }
    }
    
    private func getAllTasks() {
        taskViewModel.fetchAllTasks()
        allExistingTasks = taskViewModel.tasks
        
        if let savedTasks = try? JSONDecoder().decode([WeddingTask].self, from: weddingItem.tasksData) {
            for i in 0..<allExistingTasks.count {
                if let savedTask = savedTasks.first(where: { $0.id == allExistingTasks[i].id }) {
                    allExistingTasks[i].isSelected = savedTask.isSelected
                    allExistingTasks[i].spendText = savedTask.spendText
                    allExistingTasks[i].totalText = savedTask.totalText
                }
            }
            taskViewModel.updateNewTaskStorage(with: allExistingTasks)
        }
    }
    
    private func saveWeddingChanges() {
        let selectedTasks = allExistingTasks.filter { $0.isSelected }
        
        viewModel.updateWeddingItem(
            weddingItem,
            title: titleText,
            date: selectedDate,
            location: locationText,
            budget: budgetText,
            coverPhoto: convertToData(),
            notes: notesText,
            order: weddingItem.order,
            guests: weddingItem.guests,
            contacts: weddingItem.contacts,
            tasks: selectedTasks
        )
        
        taskViewModel.deselectAllTasks()
    }
    
    func convertToData() -> Data {
        if let img = selectedImage {
            if let data = img.jpegData(compressionQuality: 1) {
                return data
            }
        }
        return Data()
    }
}

fileprivate struct WPExistingTaskSelectionView: View {
    @Binding var model: WeddingTask
    
    var body: some View {
        VStack(spacing: 14.5) {
            HStack(spacing: 17) {
                Image(model.isSelected ? "SelectedItem" : "UnselectedItem")

                WPTextView(
                    text: model.isTaskTypeStandart ? model.name : "\(model.name) ($)",
                    color: .standartDarkText,
                    size: 15,
                    weight: .regular
                )

                Spacer()
            }
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.5)) {
                    model.isSelected.toggle()
                }
            }

            if !model.isTaskTypeStandart && model.isSelected {
                ContentFieldView(
                    spentText: $model.spendText,
                    totalText: $model.totalText
                )
            }
        }
        .animation(.easeInOut(duration: 0.5), value: model.isSelected)
    }
}

fileprivate struct ContentFieldView: View {
    @Binding var spentText: String
    @Binding var totalText: String

    var body: some View {
        HStack(spacing: 12) {
            vStackView(fieldText: $spentText, placeHolder: "0", titleText: "Amount Spent")
            vStackView(fieldText: $totalText, placeHolder: "1.000", titleText: "Total Budget")
        }
        .padding(.leading, 36)
    }

    @ViewBuilder
    private func vStackView(fieldText: Binding<String>, placeHolder: String, titleText: String) -> some View {
        VStack(spacing: 5) {
            WPTextField(
                text: fieldText,
                type: .bujet,
                placeholder: placeHolder
            )

            WPTextView(
                text: titleText,
                color: .lbSecendary,
                size: 13,
                weight: .regular
            )
            .padding(.leading)
        }
    }
}
