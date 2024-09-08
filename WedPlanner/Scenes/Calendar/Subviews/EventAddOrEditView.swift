import SwiftUI

enum EventAddOrEditViewType {
    case add
    case edit(EventModel)
}

struct EventAddOrEditViewStates {
    var titleText: String = ""
    var discrText: String = ""
    var date: Date = Date()
}

struct EventAddOrEditView: View {
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
                case .edit(_):
                    SubNavBarView(type: .backTitleTitledButton, title: "Edit Event", rightBtnTitle: "Delete") {
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
                            text: "TITTLE",
                            color: .standartDarkText,
                            size: 15,
                            weight: .regular
                        )
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        WPTextField(text: $states.titleText, type: .simple, placeholder: "Title")
                    }
                    
                    VStack(spacing: 7) {
                        WPTextView(
                            text: "DATE",
                            color: .standartDarkText,
                            size: 15,
                            weight: .regular
                        )
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        WPDatePickerView(selectedDate: $states.date)
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
                    }
                    
                    WPButtonView(title: buttonTitle) {
                        
                    }
                    .vSpacing(.bottom)
                    .disabled(isBtnDisabled)
                }
                .padding(.horizontal, hPaddings)
            }
        }
        .animation(.snappy, value: isBtnDisabled)
        .dismissKeyboardOnTap()
        .onAppear(perform: {
            loadDataFromModelToStates()
        })
    }
    
    private func loadDataFromModelToStates() {
        switch type {
        case .add:
            break
        case .edit(let eventModel):
            states.date = eventModel.date
            states.titleText = eventModel.title
            states.discrText = eventModel.descriptionText
        }
    }
}
    
    #Preview {
        EventAddOrEditView(type: .add)
    }
