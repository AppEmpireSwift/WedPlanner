import SwiftUI

enum WPTaskSelecteionViewType {
    case standart
    case withFields
}

struct WPTaskSelecteionView: View {
    var model: WeddingTaskItemModel
    @Binding var spendText: String
    @Binding var totalText: String
    let tapAction: () -> Void
    
    var body: some View {
        VStack(spacing: 14.5) {
            HStack(spacing: 17) {
                Image(model.isSelected ? "SelectedItem" : "UnselectedItem")
                
                WPTextView(
                    text: model.taskType == .standart ? model.name : "\(model.name) ($)",
                    color: .standartDarkText,
                    size: 15,
                    weight: .regular
                )
                
                Spacer()
            }
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.5)) {
                    tapAction()
                }
            }
            
            if model.taskType == .withFields && model.isSelected {
                ContentFieldView(spentText: $spendText, totalText: $totalText)
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

