import SwiftUI

struct EventDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: EventsViewModel 
    @State private var isEditViewShown: Bool = false
    var model: Event
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBG.ignoresSafeArea()
            
            VStack {
                navView()
                LineSeparaterView()
                
                VStack(alignment: .leading, spacing: 12) {
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
        .fullScreenCover(isPresented: $isEditViewShown) {
            EventAddOrEditView(type: .edit(model))
                .environmentObject(viewModel)
                .navigationBarBackButtonHidden()
        }
        .dismissKeyboardOnTap()
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
            
            Button {
                dismiss.callAsFunction()
                isEditViewShown.toggle()
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
    EventDetailView(model: Event(title: "Sample", descriptionText: "Description", date: Date()))
}
