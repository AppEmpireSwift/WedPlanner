import SwiftUI

struct WeddingTaskItemModel: Identifiable {
    var id = UUID()
    let name: String
    let taskType: WPTaskSelecteionViewType
    var isSelected: Bool = false
    var spendText: String = ""
    var totalText: String = ""
    let isDefaultTask: Bool
}

extension WeddingTaskItemModel {
    static let defaultTasks: [WeddingTaskItemModel] = [
        .init(name: "Define a Wedding Budget", taskType: .withFields, isDefaultTask: true),
        .init(name: "Book a Wedding Venue", taskType: .withFields, isDefaultTask: true),
        .init(name: "Make a Guest List for the Bride's Side", taskType: .standart, isDefaultTask: true),
        .init(name: "Make a Guest List for the Groom's Side", taskType: .standart, isDefaultTask: true),
        .init(name: "Send Save-the-Dates and Invitations", taskType: .standart, isDefaultTask: true),
        .init(name: "Create a Wedding Timeline", taskType: .standart, isDefaultTask: true),
        .init(name: "Plan the Ceremony", taskType: .standart, isDefaultTask: true),
        .init(name: "Hire a Caterer", taskType: .withFields, isDefaultTask: true),
        .init(name: "Purchase Wedding Attire", taskType: .withFields, isDefaultTask: true),
        .init(name: "Hire a Photographer/Videographer", taskType: .withFields, isDefaultTask: true),
        .init(name: "Arrange Entertainment ", taskType: .withFields, isDefaultTask: true),
        .init(name: "Order Invitations and Stationery", taskType: .withFields, isDefaultTask: true),
        .init(name: "Book Transportation", taskType: .withFields, isDefaultTask: true),
        .init(name: "Order Wedding Cake", taskType: .withFields, isDefaultTask: true),
        .init(name: "Decorations and Flowers", taskType: .withFields, isDefaultTask: true),
        .init(name: "Coordinate with Wedding Party", taskType: .standart, isDefaultTask: true),
        .init(name: "Plan the Reception Program", taskType: .standart, isDefaultTask: true),
        .init(name: "Create a Seating Chart", taskType: .standart, isDefaultTask: true),
        .init(name: "Write Thank You Notes", taskType: .standart, isDefaultTask: true),
        .init(name: "Plan Pre-Wedding Events", taskType: .standart, isDefaultTask: true)
    ]
}
