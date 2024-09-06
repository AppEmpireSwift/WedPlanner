import Foundation

enum SettingsCellModel: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case share = "Share this app"
    case rate = "Rate this app"
    case contact = "Help & support"

    case version = "Version"
    case privacyPolicy = "Privacy Policy"
    case termsOfUse = "Terms of use"
}
