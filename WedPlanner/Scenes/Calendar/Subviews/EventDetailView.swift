import SwiftUI

struct EventDetailView: View {
    @Environment(\.dismiss) var dismiss
    var model: EventModel
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBG.ignoresSafeArea()
            
            VStack {
                navView()
                LineSeparaterView()
                
                VStack(alignment: .leading,spacing: 12) {
                    WPTextView(
                        text: model.title,
                        color: .standartDarkText,
                        size: 22,
                        weight: .bold
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 12)
                    
                    Text("DATE:")
                        .underline()
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.lbSecendary)
                    +
                    Text(" \(model.date.stringFormateDateWith())")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.lbSecendary)
                    
                    Text("TIME:")
                        .underline()
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.lbSecendary)
                    +
                    Text(" \(model.date.stringFormateDateWith("h:mm a"))")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.lbSecendary)
                    
                    WPTextEditor(text: .constant(model.descriptionText), placeholder: "Description is empty")
                }
                .padding(.horizontal, hPaddings)
            }
        }
    }
    
    @ViewBuilder
    private func navView() -> some View {
        HStack {
            WPImagedButtonView(type: .arrowBack) {
                dismiss.callAsFunction()
            }
            
            WPTextView(
                text: "Event Details",
                color: .standartDarkText,
                size: 17,
                weight: .semibold
            )
            .frame(maxWidth: .infinity, alignment: .center)
            
            NavigationLink {
                //TODO: - прокинуть навигацию на редактирование
            } label: {
                WPTextView(
                    text: "Edit",
                    color: .accentColor,
                    size: 17,
                    weight: .regular
                )
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    EventDetailView(model: EventModel())
}
