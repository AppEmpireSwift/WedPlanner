import SwiftUI

struct CalendarView: View {
    @State var selectedDate: Date = Date()
    @StateObject var viewModel = EventsViewModel()

    var body: some View {
        let eventsForSelectedDate = viewModel.events(for: selectedDate)
        
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
                    .onChange(of: selectedDate) { _ in
                        withAnimation(.snappy) {
                        }
                    }
                    
                    LineSeparaterView()
                    
                    if eventsForSelectedDate.isEmpty {
                        emptyEventView()
                            .vSpacing(.center)
                            .transition(.opacity)
                    } else {
                        List {
                            ForEach(eventsForSelectedDate, id: \.id) { event in
                                NavigationLink {
                                    EventDetailView(model: event)
                                        .navigationBarBackButtonHidden()
                                        .environmentObject(viewModel)
                                        .onAppear {
                                            hiddenTabBar()
                                        }
                                } label: {
                                    CalendarEventCellItemView(model: event)
                                        .environmentObject(viewModel)
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
                        .transition(.opacity)
                    }
                }
                .padding(.horizontal, hPaddings)
                .animation(.snappy, value: selectedDate)
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
                EventAddOrEditView(type: .add)
                    .navigationBarBackButtonHidden()
                    .environmentObject(viewModel)
                    .onAppear {
                        hiddenTabBar()
                    }
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
                EventAddOrEditView(type: .add)
                    .navigationBarBackButtonHidden()
                    .environmentObject(viewModel)
                    .onAppear {
                        hiddenTabBar()
                    }
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
        .environmentObject(EventsViewModel())
}
