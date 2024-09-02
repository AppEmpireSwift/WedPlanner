import SwiftUI
import RealmSwift

enum WPTaskSelecteionViewType {
    case standart
    case withFields
}

struct WPTaskSelecteionView: View {
    @ObservedObject var model: WeddingTaskModel
    @State private var isSelected: Bool

    init(model: WeddingTaskModel) {
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
        let realm = try? Realm()
        try? realm?.write {
            model.isSelected = isSelected
        }
    }

    private func updateSpendText(_ newText: String) {
        let realm = try? Realm()
        try? realm?.write {
            model.spendText = newText
        }
    }

    private func updateTotalText(_ newText: String) {
        let realm = try? Realm()
        try? realm?.write {
            model.totalText = newText
        }
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
