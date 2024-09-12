import SwiftUI

struct WeddingDetailView: View {
    @EnvironmentObject var weddingItemViewModel: WeddingItemsViewModel
    @EnvironmentObject var weddingTaskViewModel: WeddingTasksViewModel
    
    @State private var isEditShown: Bool = false
    
    @Binding var weddingModel: WeddingItem
    
    private var totalSpended: Double {
        let tasksWithValues = weddingModel.tasks.filter {$0.isTaskTypeStandart == false}
        return tasksWithValues.reduce(0) { (result, task) in
            Double(task.spendText) ?? 0
        }
    }
    
    private var totalAmount: Double {
        let tasksWithValues = weddingModel.tasks.filter {$0.isTaskTypeStandart == false}
        return tasksWithValues.reduce(0) { (result, task) in
            Double(task.totalText) ?? 0
        }
    }
    
    private var calculatePercentage: String {
        guard totalAmount != 0 else {
            return "0%"
        }
        
        let percentage = (totalSpended / totalAmount) * 100
        return String(format: "%.0f%%", percentage)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBG.ignoresSafeArea()
            
            VStack {
                SubNavBarView(
                    type: .backTitleTitledButton,
                    title: "Wedding Details",
                    rightBtnTitle: "Edit",
                    isRightBtnEnabled: true) {
                        withAnimation(.snappy) {
                            isEditShown.toggle()
                        }
                    }
                
                LineSeparaterView()
                
                VStack(alignment: .leading, spacing: 12) {
                    WPTextView(
                        text: weddingModel.title,
                        color: .standartDarkText,
                        size: 28,
                        weight: .bold
                    )
                    
                    Color.fieldsBG
                        .overlay {
                            if let coverPhoto = UIImage(data: weddingModel.coverPhoto) {
                                Image(uiImage: coverPhoto)
                                    .resizable()
                            }
                        }
                        .cornerRadius(12, corners: .allCorners)
                        .frame(maxWidth: .infinity, maxHeight: 200)
                    
                    ScrollView(showsIndicators: false) {
                        firstLineHStackView()
                        weddingExpensesView()
                        lastLineStackView()
                        includesTasksList()
                            .padding(.top)
                    }
                }
                .padding(.top, 24)
                .padding(.horizontal, hPaddings)
            }
        }
        .navigationBarBackButtonHidden()
        .fullScreenCover(isPresented: $isEditShown, content: {
            UpdateWeddingView(weddingItem: weddingModel)
                .environmentObject(weddingItemViewModel)
                .environmentObject(weddingTaskViewModel)
        })
    }
    
    private func firstLineHStackView() -> some View {
        HStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 65)
                .foregroundColor(.bejeBG)
                .overlay {
                    VStack(alignment: .leading, spacing: 4) {
                        WPTextView(
                            text: weddingModel.date.stringFormateDateWith(),
                            color: .standartDarkText,
                            size: isiPhone ? 16 : 20,
                            weight: .regular
                        )
                        
                        WPTextView(
                            text: weddingModel.location,
                            color: .neutralBege,
                            size: 13,
                            weight: .semibold
                        )
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                }
            NavigationLink {
                GuestListView(weddingModel: $weddingModel)
                    .environmentObject(weddingItemViewModel)
            } label: {
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 65)
                .foregroundColor(.lightBejie)
                .overlay {
                    HStack {
                        VStack(alignment: .leading ,spacing: 0) {
                            WPTextView(
                                text: String(weddingModel.guests.count),
                                color: .standartDarkText,
                                size: 25,
                                weight: .semibold
                            )
                            
                            WPTextView(
                                text: "Guests",
                                color: .mainBG,
                                size: 15,
                                weight: .semibold
                            )
                        }
                        
                        Spacer()
                        
                        Image("ChevRight")
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                }
            }
        }
    }
    
    @ViewBuilder
    private func weddingExpensesView() -> some View {
        RoundedRectangle(cornerRadius: 12)
            .frame(height: 102)
            .foregroundColor(.bejeBG)
            .overlay {
                HStack {
                    VStack(alignment: .leading, spacing: 14) {
                        HStack(spacing: 10) {
                            WPTextView(
                                text: "$",
                                color: .standartDarkText,
                                size: 34,
                                weight: .bold
                            )
                            
                            WPTextView(
                                text: String(totalSpended.rounded()),
                                color: .standartDarkText,
                                size: 34,
                                weight: .bold
                            )
                            
                            WPTextView(
                                text: "/ \(totalAmount)",
                                color: .neutralBege,
                                size: 22,
                                weight: .regular
                            )
                        }
                        
                        WPTextView(
                            text: "Totale Wedding Expenses",
                            color: .neutralBege,
                            size: 17,
                            weight: .semibold
                        )
                    }
                    
                    Spacer()
                    
                    progressView()
                        .frame(width: 70, height: 70)
                }
                .padding(.horizontal, 12)
                .padding(.vertical)
            }
    }
    
    @ViewBuilder
    private func progressView() -> some View {
        let progress = totalAmount > 0 ? totalSpended / totalAmount : 0
        
        ZStack {
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round))
                .foregroundColor(.mainBG)
            
            Circle()
                .trim(from: 0, to: CGFloat(progress))
                .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round))
                .foregroundColor(.standartDarkText)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut, value: progress)
        }
        .frame(width: 70, height: 70)
    }
    
    private func lastLineStackView() -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 147)
                .foregroundColor(.bejeBG)
                .overlay {
                    VStack(alignment: .leading) {
                        WPTextView(
                            text: weddingModel.date.daysUntil(),
                            color: .standartDarkText,
                            size: 76,
                            weight: .semibold
                        )
                        
                        Text("Days until the\nwedding")
                            .foregroundStyle(.neutralBege)
                            .font(.system(size: 15, weight: .regular))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                }
            
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 147)
                .foregroundColor(.bejeBG)
                .overlay {
                    VStack(alignment: .leading, spacing: 7) {
                        WPTextView(
                            text: "Progress",
                            color: .neutralBege,
                            size: 17,
                            weight: .semibold
                        )
                        
                        WPTextView(
                            text: calculatePercentage,
                            color: .standartDarkText,
                            size: 64,
                            weight: .bold
                        )
                        
                        ProgressView(value: totalSpended, total: totalAmount)
                            .progressViewStyle(CustomProgressViewStyle())
                            .frame(height: 12)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical)
                }
        }
    }
    
    private func includesTasksList() -> some View {
        VStack(alignment: .leading, spacing: 17) {
            WPTextView(
                text: "Wedding Tasks",
                color: .standartDarkText,
                size: 20,
                weight: .semibold
            )
            
            VStack {
                ForEach(weddingModel.tasks) { taskModel in
                    WPTaskSelectionView(model: taskModel)
                        .disabled(true)
                }
            }
        }
    }
}
