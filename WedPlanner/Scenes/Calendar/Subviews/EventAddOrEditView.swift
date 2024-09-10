import SwiftUI

enum EventAddOrEditViewType {
    case add
    case edit(Event)
}

struct EventAddOrEditViewStates {
    var titleText: String = ""
    var discrText: String = ""
    var choosenDate: Date = Date()
}

struct EventAddOrEditView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: EventsViewModel
    @State private var states = EventAddOrEditViewStates()
    
    let type: EventAddOrEditViewType
    
    private var buttonTitle: String {
        switch type {
        case .add:
            "Add"
        case .edit(_):
            "Update"
        }
    }
    
    private var isBtnDisabled: Bool {
        states.titleText.isEmpty || states.discrText.isEmpty
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBG.ignoresSafeArea()
            
            VStack(spacing: 16) {
                switch type {
                case .add:
                    SubNavBarView(type: .backAndTitle, title: "Add Event")
                case .edit(let event):
                    SubNavBarView(type: .backTitleTitledButton, title: "Edit Event", rightBtnTitle: "Delete") {
                        dismiss.callAsFunction()
                        viewModel.deleteEvent(event)
                    }
                }
                
                LineSeparaterView()
                
                VStack(spacing: 29) {
                    WPTextView(
                        text: "Event Details",
                        color: .standartDarkText,
                        size: 20,
                        weight: .semibold
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing: 7) {
                        WPTextView(
                            text: "TITLE",
                            color: .standartDarkText,
                            size: 15,
                            weight: .regular
                        )
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        WPTextField(text: $states.titleText, type: .simple, placeholder: "Title")
                            .dismissKeyboardOnTap()
                    }
                    
                    VStack(spacing: 7) {
                        WPTextView(
                            text: "DATE",
                            color: .standartDarkText,
                            size: 15,
                            weight: .regular
                        )
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        WPDatePickerView(selectedDate: $states.choosenDate)
                    }
                    
                    VStack(spacing: 7) {
                        WPTextView(
                            text: "NOTES",
                            color: .standartDarkText,
                            size: 15,
                            weight: .regular
                        )
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        WPTextEditor(text: $states.discrText, placeholder: "Notes")
                            .dismissKeyboardOnTap()
                    }
                    
                    WPButtonView(title: buttonTitle) {
                        buttonAction()
                    }
                    .vSpacing(.bottom)
                    .disabled(isBtnDisabled)
                }
                .padding(.horizontal, hPaddings)
            }
        }
        .animation(.snappy, value: isBtnDisabled)
        .onAppear(perform: {
            loadDataFromModelToStates()
        })
    }
    
    private func loadDataFromModelToStates() {
        switch type {
        case .add:
            break
        case .edit(let event):
            states.choosenDate = event.date
            states.titleText = event.title
            states.discrText = event.descriptionText
        }
    }
    
    private func buttonAction() {
        switch type {
        case .add:
            viewModel.addEvent(title: states.titleText, description: states.discrText, date: states.choosenDate)
        case .edit(let event):
            viewModel.updateEvent(event, title: states.titleText, description: states.discrText, date: states.choosenDate)
        }
        dismiss.callAsFunction()
    }
}
    
#Preview {
    EventAddOrEditView(type: .add)
}
