import Foundation

struct LicenseTextModel: Identifiable {
    var id = UUID()
    let title: String
    let text: String
}

extension LicenseTextModel {
    static let privacyPolice: [LicenseTextModel] = [
        .init(
            title: "Privacy Policy",
            text: "This privacy policy applies to the WedPlanner app (hereby referred to as 'Application') for mobile devices that was created by ismaellotan (hereby referred to as 'Service Provider') as a Freemium service. This service is intended for use 'AS IS'."
        ),
        .init(
            title: "Information Collection and Use",
            text: "The Application collects information when you download and use it. This information may include information such as: \n\n - Your device's Internet Protocol address (e.g. IP address) \n\n - The pages of the Application that you visit, the time and date of your visit, the time spent on those pages \n\n - The time spent on the Application \n\n - The operating system you use on your mobile device \n\n The Application does not gather precise information about the location of your mobile device.\n\n The Service Provider may use the information you provided to contact you from time to time to provide you with important information, required notices and marketing promotions.\n\n For a better experience, while using the Application, the Service Provider may require you to provide us with certain personally identifiable information. The information that the Service Provider request will be retained by them and used as described in this privacy policy. "
        ),
        .init(
            title: "Third Party Access",
            text: "Only aggregated, anonymized data is periodically transmitted to external services to aid the Service Provider in improving the Application and their service. The Service Provider may share your information with third parties in the ways that are described in this privacy statement.\n\n The Service Provider may disclose User Provided and Automatically Collected Information:\n\n - as required by law, such as to comply with a subpoena, or similar legal process;\n\n - when they believe in good faith that disclosure is necessary to protect their rights, protect your safety or the safety of others, investigate fraud, or respond to a government request;\n\n - with their trusted services providers who work on their behalf, do not have an independent use of the information we disclose to them, and have agreed to adhere to the rules set forth in this privacy statement."
        ),
        .init(
            title: "Opt-Out Rights",
            text: "You can stop all collection of information by the Application easily by uninstalling it. You may use the standard uninstall processes as may be available as part of your mobile device or via the mobile application marketplace or network."
        ),
        .init(
            title: "Data Retention Policy",
            text: "The Service Provider will retain User Provided data for as long as you use the Application and for a reasonable time thereafter. If you'd like them to delete User Provided Data that you have provided via the Application, please contact them at ismaellotan31@outlook.com and they will respond in a reasonable time."
        ),
        .init(
            title: "Children",
            text: "The Service Provider does not use the Application to knowingly solicit data from or market to children under the age of 13.\n\n The Service Provider does not knowingly collect personally identifiable information from children. The Service Provider encourages all children to never submit any personally identifiable information through the Application and/or Services. The Service Provider encourage parents and legal guardians to monitor their children's Internet usage and to help enforce this Policy by instructing their children never to provide personally identifiable information through the Application and/or Services without their permission. If you have reason to believe that a child has provided personally identifiable information to the Service Provider through the Application and/or Services, please contact the Service Provider (ismaellotan31@outlook.com) so that they will be able to take the necessary actions. You must also be at least 16 years of age to consent to the processing of your personally identifiable information in your country (in some countries we may allow your parent or guardian to do so on your behalf)."
        ),
        .init(
            title: "Security",
            text: "The Service Provider is concerned about safeguarding the confidentiality of your information. The Service Provider provides physical, electronic, and procedural safeguards to protect information the Service Provider processes and maintains."
        ),
        .init(
            title: "Changes",
            text: "This Privacy Policy may be updated from time to time for any reason. The Service Provider will notify you of any changes to the Privacy Policy by updating this page with the new Privacy Policy. You are advised to consult this Privacy Policy regularly for any changes, as continued use is deemed approval of all changes.\n\nThis privacy policy is effective as of 2024-10-15"
        ),
        .init(
            title: "Your Consent",
            text: "By using the Application, you are consenting to the processing of your information as set forth in this Privacy Policy now and as amended by us."
        ),
        .init(
            title: "Contact Us",
            text: "If you have any questions regarding privacy while using the Application, or have questions about the practices, please contact the Service Provider via email at ismaellotan31@outlook.com."
        )
    ]
    
    static let termsDataArray: [LicenseTextModel] = [
        .init(
            title: "Terms & Conditions",
            text: "These terms and conditions applies to the WedPlanner app (hereby referred to as 'Application') for mobile devices that was created by ismaellotan (hereby referred to as 'Service Provider') as a Freemium service.\n\nUpon downloading or utilizing the Application, you are automatically agreeing to the following terms. It is strongly advised that you thoroughly read and understand these terms prior to using the Application. Unauthorized copying, modification of the Application, any part of the Application, or our trademarks is strictly prohibited. Any attempts to extract the source code of the Application, translate the Application into other languages, or create derivative versions are not permitted. All trademarks, copyrights, database rights, and other intellectual property rights related to the Application remain the property of the Service Provider.\n\nThe Service Provider is dedicated to ensuring that the Application is as beneficial and efficient as possible. As such, they reserve the right to modify the Application or charge for their services at any time and for any reason. The Service Provider assures you that any charges for the Application or its services will be clearly communicated to you.\n\nThe Application stores and processes personal data that you have provided to the Service Provider in order to provide the Service. It is your responsibility to maintain the security of your phone and access to the Application. The Service Provider strongly advise against jailbreaking or rooting your phone, which involves removing software restrictions and limitations imposed by the official operating system of your device. Such actions could expose your phone to malware, viruses, malicious programs, compromise your phone's security features, and may result in the Application not functioning correctly or at all.\n\nPlease be aware that the Service Provider does not assume responsibility for certain aspects. Some functions of the Application require an active internet connection, which can be Wi-Fi or provided by your mobile network provider. The Service Provider cannot be held responsible if the Application does not function at full capacity due to lack of access to Wi-Fi or if you have exhausted your data allowance.\n\nIf you are using the application outside of a Wi-Fi area, please be aware that your mobile network provider's agreement terms still apply. Consequently, you may incur charges from your mobile provider for data usage during the connection to the application, or other third-party charges. By using the application, you accept responsibility for any such charges, including roaming data charges if you use the application outside of your home territory (i.e., region or country) without disabling data roaming. If you are not the bill payer for the device on which you are using the application, they assume that you have obtained permission from the bill payer.\n\nSimilarly, the Service Provider cannot always assume responsibility for your usage of the application. For instance, it is your responsibility to ensure that your device remains charged. If your device runs out of battery and you are unable to access the Service, the Service Provider cannot be held responsible.\n\nIn terms of the Service Provider's responsibility for your use of the application, it is important to note that while they strive to ensure that it is updated and accurate at all times, they do rely on third parties to provide information to them so that they can make it available to you. The Service Provider accepts no liability for any loss, direct or indirect, that you experience as a result of relying entirely on this functionality of the application.\n\nThe Service Provider may wish to update the application at some point. The application is currently available as per the requirements for the operating system (and for any additional systems they decide to extend the availability of the application to) may change, and you will need to download the updates if you want to continue using the application. The Service Provider does not guarantee that it will always update the application so that it is relevant to you and/or compatible with the particular operating system version installed on your device. However, you agree to always accept updates to the application when offered to you. The Service Provider may also wish to cease providing the application and may terminate its use at any time without providing termination notice to you. Unless they inform you otherwise, upon any termination, (a) the rights and licenses granted to you in these terms will end; (b) you must cease using the application, and (if necessary) delete it from your device."
        ),
        .init(
            title: "Changes to These Terms and Conditions",
            text: "The Service Provider may periodically update their Terms and Conditions. Therefore, you are advised to review this page regularly for any changes. The Service Provider will notify you of any changes by posting the new Terms and Conditions on this page.\n\nThese terms and conditions are effective as of 2024-10-15"
        ),
        .init(
            title: "Contact Us",
            text: "If you have any questions or suggestions about the Terms and Conditions, please do not hesitate to contact the Service Provider at ismaellotan31@outlook.com."
        )
    ]
}
