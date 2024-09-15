import SwiftUI

struct WPTaskSelectionView: View {
    @EnvironmentObject var viewModel: WeddingTasksViewModel
    @State private var isSelected: Bool
    var model: WeddingTask

    init(model: WeddingTask) {
        self.model = model
        _isSelected = State(initialValue: model.isSelected)
    }

    var body: some View {
        VStack(spacing: 14.5) {
            HStack(spacing: 17) {
                Image(isSelected ? "SelectedItem" : "UnselectedItem")

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
                    toggleSelection()
                }
            }

            if !model.isTaskTypeStandart && isSelected {
                ContentFieldView(
                    spentText: Binding<String>(
                        get: { model.spendText },
                        set: { newText in
                            updateSpendText(newText)
                        }
                    ),
                    totalText: Binding<String>(
                        get: { model.totalText },
                        set: { newText in
                            updateTotalText(newText)
                        }
                    )
                )
            }
        }
        .animation(.easeInOut(duration: 0.5), value: isSelected)
    }

    private func toggleSelection() {
        isSelected.toggle()
        viewModel.updateTask(model,
                             name: model.name,
                             isSelected: isSelected,
                             isTaskCanBeDeleted: model.isTaskCanBeDeleted,
                             isTaskTypeStandart: model.isTaskTypeStandart,
                             spendText: model.spendText,
                             totalText: model.totalText)
    }

    private func updateSpendText(_ newText: String) {
        viewModel.updateTask(model,
                             name: model.name,
                             isSelected: isSelected,
                             isTaskCanBeDeleted: model.isTaskCanBeDeleted,
                             isTaskTypeStandart: model.isTaskTypeStandart,
                             spendText: newText,
                             totalText: model.totalText)
    }

    private func updateTotalText(_ newText: String) {
        viewModel.updateTask(model,
                             name: model.name,
                             isSelected: isSelected,
                             isTaskCanBeDeleted: model.isTaskCanBeDeleted,
                             isTaskTypeStandart: model.isTaskTypeStandart,
                             spendText: model.spendText,
                             totalText: newText)
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
