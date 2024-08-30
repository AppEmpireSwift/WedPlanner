import SwiftUI

struct WPDatePickerView: View {
    @Binding var selectedDate: Date
    @State private var isDatePickerVisible = false
    @State private var isTimePickerVisible = false
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
    
    private var timePicker: some View {
        VStack {
            GeometryReader { geometry in
                HStack {
                    Picker(selection: $selectedDate.hour, label: Text("Hour")) {
                        ForEach(1..<13) { hour in
                            Text("\(hour)").tag(hour)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: geometry.size.width / 3, height: 170)
                    .clipped()
                    
                    Picker(selection: $selectedDate.minute, label: Text("Minute")) {
                        ForEach(0..<60) { minute in
                            Text(String(format: "%02d", minute)).tag(minute)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: geometry.size.width / 3, height: 170)
                    .clipped()
                    
                    Picker(selection: $selectedDate.ampm, label: Text("AM/PM")) {
                        Text("AM").tag("AM")
                        Text("PM").tag("PM")
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: geometry.size.width / 3, height: 170)
                    .clipped()
                }
                .frame(width: geometry.size.width)
                .background(Color.white)
                .cornerRadius(6)
                .shadow(radius: 5)
            }
            .frame(height: 170)
            .transition(.move(edge: .bottom))
            .animation(.easeInOut, value: isTimePickerVisible)
        }
    }
    
    private var datePicker: some View {
        VStack {
            DatePicker(
                "",
                selection: $selectedDate,
                displayedComponents: .date
            )
            .datePickerStyle(GraphicalDatePickerStyle())
            .background(Color.white)
            .cornerRadius(6)
            .shadow(radius: 5)
            .transition(.move(edge: .bottom))
            .animation(.easeInOut, value: isDatePickerVisible)
        }
        .frame(maxHeight: 400)
    }
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.fieldsBG)
                    .frame(height: 50)
                    .overlay(
                        Text(dateFormatter.string(from: selectedDate))
                            .padding()
                            .foregroundColor(isDatePickerVisible ? .accentColor : .standartDarkText)
                    )
                    .onTapGesture {
                        withAnimation {
                            isDatePickerVisible.toggle()
                            if isTimePickerVisible {
                                isTimePickerVisible = false
                            }
                        }
                    }
                
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.fieldsBG)
                    .frame(height: 50)
                    .overlay(
                        Text(timeFormatter.string(from: selectedDate))
                            .padding()
                            .foregroundColor(isTimePickerVisible ? .accentColor : .standartDarkText)
                    )
                    .onTapGesture {
                        withAnimation {
                            isTimePickerVisible.toggle()
                            if isDatePickerVisible {
                                isDatePickerVisible = false
                            }
                        }
                    }
            }
            
            if isDatePickerVisible {
                datePicker
                    .padding(.horizontal)
            }
            
            if isTimePickerVisible {
                timePicker
                    .padding(.horizontal)
            }
        }
        .padding(.vertical)
        .animation(.easeInOut, value: isTimePickerVisible)
        .animation(.easeInOut, value: isDatePickerVisible)
    }
}

#Preview {
    WPDatePickerView(selectedDate: .constant(Date()))
        .previewLayout(.sizeThatFits)
        .padding()
}
