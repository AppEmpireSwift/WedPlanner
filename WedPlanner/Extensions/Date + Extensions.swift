import Foundation

extension Date {
    
    // MARK: - Extensions to help bind the Date components to Picker selections
    var hour: Int {
        get {
            Calendar.current.component(.hour, from: self) % 12 == 0 ? 12 : Calendar.current.component(.hour, from: self) % 12
        }
        set {
            let current = Calendar.current.dateComponents([.minute, .second, .day, .month, .year], from: self)
            var components = DateComponents()
            components.hour = newValue + (ampm == "PM" ? 12 : 0)
            components.minute = current.minute
            components.second = current.second
            components.day = current.day
            components.month = current.month
            components.year = current.year
            if let newDate = Calendar.current.date(from: components) {
                self = newDate
            }
        }
    }
    
    var minute: Int {
        get {
            Calendar.current.component(.minute, from: self)
        }
        set {
            let current = Calendar.current.dateComponents([.hour, .second, .day, .month, .year], from: self)
            var components = DateComponents()
            components.hour = current.hour
            components.minute = newValue
            components.second = current.second
            components.day = current.day
            components.month = current.month
            components.year = current.year
            if let newDate = Calendar.current.date(from: components) {
                self = newDate
            }
        }
    }
    
    var ampm: String {
        get {
            Calendar.current.component(.hour, from: self) < 12 ? "AM" : "PM"
        }
        set {
            let hourOffset = newValue == "AM" ? 0 : 12
            var hour = Calendar.current.component(.hour, from: self)
            hour = hour % 12 + hourOffset
            let current = Calendar.current.dateComponents([.minute, .second, .day, .month, .year], from: self)
            var components = DateComponents()
            components.hour = hour
            components.minute = current.minute
            components.second = current.second
            components.day = current.day
            components.month = current.month
            components.year = current.year
            if let newDate = Calendar.current.date(from: components) {
                self = newDate
            }
        }
    }
}
