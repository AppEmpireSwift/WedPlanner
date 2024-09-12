import SwiftUI

struct CreateWeddingContentView: View {
    @Binding var titleText: String
    @Binding var locationText: String
    @Binding var budgetText: String
    @Binding var selectedImg: UIImage?
    @Binding var notesText: String
    @Binding var selectedDate: Date
    
    var body: some View {
        VStack(spacing: 12) {
            VStack(spacing: 7) {
                WPTextView(text: "TITTLE", color: .standartDarkText, size: 15, weight: .regular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                WPTextField(text: $titleText, type: .simple, placeholder: "Whose wedding is this?")
            }
            .dismissKeyboardOnTap()
            
            VStack(spacing: 7) {
                WPTextView(text: "DATE", color: .standartDarkText, size: 15, weight: .regular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                WPDatePickerView(selectedDate: $selectedDate)
            }
            
            VStack(spacing: 7) {
                WPTextView(text: "LOCATION", color: .standartDarkText, size: 15, weight: .regular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                WPTextField(text: $locationText, type: .simple, placeholder: "Wedding's Location")
            }
            .dismissKeyboardOnTap()
            
            VStack(spacing: 7) {
                WPTextView(text: "BUDGET", color: .standartDarkText, size: 15, weight: .regular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                WPTextField(text: $budgetText, type: .bujet, placeholder: "Total Budget")
            }
            .dismissKeyboardOnTap()
            
            VStack(spacing: 7) {
                WPTextView(text: "COVER PHOTO", color: .standartDarkText, size: 15, weight: .regular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                WPImagePickerView(selectedImage: $selectedImg)
            }
            
            VStack(spacing: 7) {
                WPTextView(text: "NOTES", color: .standartDarkText, size: 15, weight: .regular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                WPTextEditor(text: $notesText, placeholder: "Enter some text, if needed")
            }
            .dismissKeyboardOnTap()
        }
    }
}
