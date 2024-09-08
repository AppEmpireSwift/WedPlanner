import SwiftUI

struct CalendarEventCellItemView: View {
    var model: EventModel
    
    var body: some View {
        HStack(spacing: 8) {
            Rectangle()
                .frame(width: 4, height: 24)
                .foregroundColor(.accentColor)
            
            WPTextView(
                text: model.title,
                color: .standartDarkText,
                size: 15,
                weight: .regular
            )
            .frame(maxWidth: .infinity, alignment: .leading)
            
            WPTextView(
                text: model.date.stringFormateDateWith("h:mm a"),
                color: .standartDarkText,
                size: 15,
                weight: .regular
            )
        }
    }
}

#Preview {
    CalendarEventCellItemView(model: EventModel())
}
