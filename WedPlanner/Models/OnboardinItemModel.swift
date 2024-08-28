import UIKit

enum OnboardinItemModel: String, CaseIterable, Identifiable {
    var id: Self { self }
    case first
    case second
    case third
    case fourth
}

extension OnboardinItemModel {
    private var isiPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
    
    var indicator: Int {
        return switch self {
        case .first:
            1
        case .second:
            2
        case .third:
            2
        case .fourth:
            3
        }
    }
    
    var image: String {
        switch self {
        case .first:
            "OB1"
        case .second:
            "OB2"
        case .third:
            "OB2"
        case .fourth:
            "OB3"
        }
    }
   
    var titleBlack: String {
        switch self {
        case .first:
            "Welcome to"
        case .second:
            "We value"
        case .third:
            "We value"
        case .fourth:
            "Use"
        }
    }
    
    var titleColored: String {
        switch self {
        case .first:
            "Planner for Wedding"
        case .second:
            "your feedback"
        case .third:
            "your feedback"
        case .fourth:
            "WedPlanner"
        }
    }
    
    var description: String {
        switch self {
        case .first:
            "The ultimate tool for seamlessly planning\n your dream wedding"
        case .second:
            "Please share your opinion about our app\n WedPlanner"
        case .third:
            "Please share your opinion about our app\n WedPlanner"
        case .fourth:
            "Organize your dream wedding with our\n budget tracker, guest list manager, and more"
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .fourth:
            "Finish"
        default:
            "Continue"
        }
    }
}
