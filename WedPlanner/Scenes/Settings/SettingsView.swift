import SwiftUI

fileprivate struct SettingsState {
    var isPrivacyShown: Bool = false
    var isTermsShown: Bool = false
    var isErrorContactAlertShown = false
    var isErrorRateAlertShown: Bool = false
    var isContentShareViewShown: Bool = false
    var isVersionSHown: Bool = false
}

struct SettingsView: View {
    @State private var states = SettingsState()
    
    private var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBG.ignoresSafeArea()
            
            VStack {
                WPTextView(
                    text: "Settings",
                    color: .standartDarkText,
                    size: 34,
                    weight: .bold
                )
                .padding(.horizontal)
                .padding(.top)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 34) {
                    titledView()
                    VStack {
                        ForEach(SettingsCellModel.allCases.prefix(3), content: settingsRowItem)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundColor(.fieldsBG)
                            )
                    }
                    
                    VStack {
                        ForEach(SettingsCellModel.allCases.suffix(from: 3), content: settingsRowItem)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundColor(.fieldsBG)
                            )
                    }
                }
                .padding(.horizontal, hPaddings)
            }
        }
        //TODO: - Поменять ID приложения
        .sheet(isPresented: $states.isContentShareViewShown) {
            WPShareView(activityItems: ["https://apps.apple.com/app/id6535686112"])
        }
        //TODO: - добавить почту разработчика
        .alert(
            "Unable to open the mail application",
            isPresented: $states.isErrorContactAlertShown,
            actions: {},
            message: {
                WPTextView(
                    text: "To avoid this error, you can change the default application in your device settings for sending emails. Or contact us at this email address: ",
                    color: .standartDarkText,
                    size: 12,
                    weight: .regular
                )
            }
        )
        //TODO: - добавить почту разработчика
        .alert("Oops, there was an failure", isPresented: $states.isErrorRateAlertShown, actions: {}) {
            Text("Errors occurred when trying to navigate to the application page. Please try again later. In case of repeated errors, please contact us at: ")
        }
        .alert("Application version", isPresented: $states.isVersionSHown) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Current version: \(appVersion)")
        }
        .sheet(isPresented: $states.isPrivacyShown) {
            LicenseTextView(isPresented: $states.isPrivacyShown, type: .policy)
        }
        .sheet(isPresented: $states.isTermsShown) {
            LicenseTextView(isPresented: $states.isTermsShown, type: .terms)
        }
    }
    
    private func titledView() -> some View {
        Rectangle()
            .frame(maxHeight: 119)
            .cornerRadius(12, corners: [.topLeft, .bottomRight])
            .foregroundColor(.bejeBG)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .padding()
                    .foregroundColor(.lightBejie)
                    .overlay {
                        VStack(alignment: .leading) {
                            HStack {
                                WPTextView(
                                    text: "Wed",
                                    color: .mainBG,
                                    size: 34,
                                    weight: .bold
                                )
                                
                                WPTextView(
                                    text: "Planner",
                                    color: .standartDarkText,
                                    size: 34,
                                    weight: .semibold
                                )
                                Spacer()
                            }
                            
                            WPTextView(
                                text: "Where Every Wedding Becomes a Fairytale.",
                                color: .mainBG,
                                size: 14,
                                weight: .regular
                            )
                        }
                        .padding(.horizontal, 20)
                    }
            }
    }
    
    @ViewBuilder
    private func settingsRowItem(for model: SettingsCellModel) -> some View {
        SettingsCellView(
            model: model,
            action: {settingsButtonAction(buttonType: model)}
        )
    }
    
    private func settingsButtonAction(buttonType: SettingsCellModel) {
        switch buttonType {
        case .contact:
            helpAction()
        case .rate:
            rateAction()
        case .share:
            states.isContentShareViewShown.toggle()
        case .privacyPolicy:
            states.isPrivacyShown.toggle()
        case .termsOfUse:
            states.isTermsShown.toggle()
        case .version:
            states.isVersionSHown.toggle()
        }
    }
    
    //TODO: - добавить почту разработчика
    private func helpAction() {
        if let url = URL(string: "mailto: "),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            states.isErrorContactAlertShown.toggle()
        }
    }
    
    private func rateAction() {
        let AppID = 6621260599
        let link = "https://apps.apple.com/app/id\(AppID)?action=write-review"
        if let url = URL(string: link) {
            UIApplication.shared.open(url, options: [:], completionHandler: { success in
                if !success {
                    states.isErrorRateAlertShown = true
                }
            })
        }
    }
}

fileprivate struct SettingsCellView: View {
    let model: SettingsCellModel
    let action: () -> Void
    
    private var image: String {
        switch model {
        case .contact:
            "ContactUsIcon"
        case .rate:
            "RateIcon"
        case .share:
            "ShareIcon"
        case .privacyPolicy:
            "PrivacyPoliceIcon"
        case .termsOfUse:
            "TermsIcon"
        case .version:
            "VersionIcon"
        }
    }
    
    var body: some View {
        Button(action: action, label: {
            HStack(spacing: 20) {
                Image(image)
                    .resizable()
                    .frame(width: 24, height: 24)
                
                Text(model.rawValue)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.standartDarkText)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.standartDarkText)
            }
            .padding(.vertical, 11)
            .padding(.horizontal)
        })
    }
}


#Preview {
    SettingsView()
}
