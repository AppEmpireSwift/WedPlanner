//import SwiftUI
//
//struct UpdateWeddingView: View {
//    @Environment(\.dismiss) var dismiss
//    @EnvironmentObject var viewModel: WeddingItemsViewModel
//    @EnvironmentObject var taskViewModel: WeddingTasksViewModel
//    var weddingItem: WeddingItem
//    
//    @State private var titleText: String
//    @State private var locationText: String
//    @State private var budgetText: String
//    @State private var selectedImage: UIImage?
//    @State private var notesText: String
//    @State private var selectedDate: Date
//    @State private var allExistingTasks: [WeddingTask] = []
//    
//    init(weddingItem: WeddingItem) {
//        self.weddingItem = weddingItem
//        _titleText = State(initialValue: weddingItem.title)
//        _locationText = State(initialValue: weddingItem.location)
//        _budgetText = State(initialValue: weddingItem.budget)
//        _selectedImage = State(initialValue: UIImage(data: weddingItem.coverPhoto))
//        _notesText = State(initialValue: weddingItem.notes)
//        _selectedDate = State(initialValue: weddingItem.date)
//    }
//    
//    var body: some View {
//        ZStack(alignment: .top) {
//            Color.mainBG.ignoresSafeArea()
//            
//            VStack(spacing: 16) {
//                SubNavBarView(type: .backTitleTitledButton, title: "Update Wedding", rightBtnTitle: "Add Task") {
//                    
//                }
//                
//                LineSeparaterView()
//                
//                VStack(spacing: 16) {
//                    ScrollView(showsIndicators: false) {
//                        VStack {
//                            CreateWeddingContentView(
//                                titleText: $titleText,
//                                locationText: $locationText,
//                                budgetText: $budgetText,
//                                selectedImg: $selectedImage,
//                                notesText: $notesText,
//                                selectedDate: $selectedDate
//                            )
//                        }
//                        .padding(.bottom)
//                        
//                        VStack {
//                            WPTextView(
//                                text: "Wedding Tasks",
//                                color: .standartDarkText,
//                                size: 20,
//                                weight: .semibold
//                            )
//                            .padding(.bottom, 20)
//                            
//                            ForEach(allExistingTasks) { wedTask in
//                                WPTaskSelectionView(model: wedTask)
//                                    .environmentObject(taskViewModel)
//                                    .swipeActions {
//                                        if wedTask.isTaskCanBeDeleted {
//                                            Button(action: {
//                                                taskViewModel.deleteTask(wedTask)
//                                            }, label: {
//                                                Text("Delete")
//                                            })
//                                        }
//                                    }
//                                    .listRowBackground(Color.clear)
//                                    .listRowSeparator(.hidden)
//                            }
//                        }
//                        .padding(.bottom)
//                        
//                        
//                        WPButtonView(title: "Update & Close") {
//                            viewModel.updateWeddingItem(
//                                viewModel.weddingItems.first(where: { dbModel in
//                                    dbModel.id == weddingItem.id
//                                })!,
//                                title: titleText,
//                                date: selectedDate,
//                                location: locationText,
//                                budget: budgetText,
//                                coverPhoto: convertToData(),
//                                notes: notesText,
//                                order: weddingItem.order
//                            )
//                            
//                            dismiss.callAsFunction()
//                        }
//                        .frame(height: 50)
//                        
//                    }
//                    .padding(.horizontal, hPaddings)
//                }
//            }
//        }
//        .onAppear(perform: {
//            getAllTasks()
//        })
//    }
//    
//    private func getAllTasks() {
//        allExistingTasks = taskViewModel.tasks
//    }
//    
//    func convertToData() -> Data {
//        if let img = selectedImage {
//            if let data = img.jpegData(compressionQuality: 1) {
//                return data
//            }
//        }
//        return Data()
//    }
//}
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
                SubNavBarView(type: .backTitleTitledButton, title: "Update Wedding", rightBtnTitle: "Add Task") {
                    // Ваш код для добавления новой задачи
                }
                
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
                            
                            ForEach(allExistingTasks) { wedTask in
                                WPTaskSelectionView(model: wedTask)
                                    .environmentObject(taskViewModel)
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
    }
    
    private func getAllTasks() {
        // Извлекаем все задачи из общего репозитория
        allExistingTasks = taskViewModel.tasks

        // Декодируем сохранённые задачи из tasksData в модели свадьбы
        if let savedTasks = try? JSONDecoder().decode([WeddingTask].self, from: weddingItem.tasksData) {
            // Обновляем задачи в общем списке задач
            for i in 0..<allExistingTasks.count {
                if let savedTask = savedTasks.first(where: { $0.id == allExistingTasks[i].id }) {
                    // Обновляем параметры задачи в общем списке задач
                    allExistingTasks[i].isSelected = savedTask.isSelected
                    allExistingTasks[i].spendText = savedTask.spendText
                    allExistingTasks[i].totalText = savedTask.totalText
                }
            }
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
            tasks: selectedTasks // Сохраняем задачи
        )
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
