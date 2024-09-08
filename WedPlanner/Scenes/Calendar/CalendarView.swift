import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var realmManager: RealmManager
    @State var selectedDate: Date = Date()
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBG.ignoresSafeArea()
            
            VStack {
                navBarView()
                
                VStack(spacing: 16) {
                    DatePicker(
                        "",
                        selection: $selectedDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .background(Color.white)
                    
                    LineSeparaterView()
                    
                    if realmManager.events.isEmpty {
                        emptyEventView()
                            .vSpacing(.center)
                    } else {
                        List {
                            ForEach(realmManager.events) { event in
                                NavigationLink {
                                    //TODO: Прокинуть навигацию на дитеилс
                                } label: {
                                    CalendarEventCellItemView(model: event)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .padding(.top, 12)
                            }
                        }
                        .listStyle(.plain)
                        .listRowSpacing(12)
                        .background(Color.clear)
                    }
                }
                .padding(.horizontal, hPaddings)
            }
        }
    }
    
    @ViewBuilder
    private func navBarView() -> some View {
        HStack {
            WPTextView(
                text: "Calendar",
                color: .standartDarkText,
                size: 34,
                weight: .bold
            )
            
            Spacer()
            
            NavigationLink {
                EmptyView()
            } label: {
                WPTextView(
                    text: "Add",
                    color: .accentColor,
                    size: 17,
                    weight: .regular
                )
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private func emptyEventView() -> some View {
        VStack(spacing: 12) {
            WPTextView(
                text: "No Events",
                color: .accentColor,
                size: 17,
                weight: .bold
            )
            
            WPTextView(
                text: "Add an Event",
                color: .standartDarkText,
                size: 14,
                weight: .regular
            )
            
            NavigationLink {
                //TODO: - Прокинуть ссылку
            } label: {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 253, height: 50)
                    .foregroundColor(.accentColor)
                    .overlay {
                        WPTextView(
                            text: "Add Event",
                            color: .mainBG,
                            size: 17,
                            weight: .semibold
                        )
                    }
            }
        }
    }
}

#Preview {
    CalendarView()
        .environmentObject(RealmManager())
}
