import SwiftUI

struct WPGuestAlertViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var guestName: String
    @Binding var guestNote: String
    
    let addAction: (()->Void)?

    func body(content: Content) -> some View {
        ZStack {
            content
                .blur(radius: isPresented ? 3 : 0)
                .disabled(isPresented)
            
            if isPresented {
                Color.alertBG
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isPresented = false
                        }
                    }
                
                VStack(spacing: 16) {
                    HStack {
                        Spacer()
                        
                        WPTextView(
                            text: "New Guest",
                            color: .standartDarkText,
                            size: 17,
                            weight: .medium
                        )
                        
                        Spacer()
                        
                        WPImagedButtonView(type: .close) {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                isPresented = false
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    VStack(spacing: 16) {
                        VStack(spacing: 7) {
                            WPTextField(
                                text: $guestName,
                                type: .simple,
                                placeholder: "Full name"
                            )
                        }
                        
                        WPTextView(
                            text: "Guest note",
                            color: .standartDarkText,
                            size: 15,
                            weight: .regular
                        )
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        WPTextField(
                            text: $guestNote,
                            type: .simple,
                            placeholder: "Your notes"
                        )
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            addAction?()
                            isPresented = false
                        }
                    }, label: {
                        Rectangle()
                            .frame(maxWidth: .infinity, maxHeight: 54)
                            .foregroundColor(.accentColor)
                            .overlay {
                                WPTextView(
                                    text: "Add",
                                    color: .mainBG,
                                    size: 17,
                                    weight: .medium
                                )
                            }
                    })
                    .cornerRadius(14, corners: [.bottomLeft, .bottomRight])
                }
                .frame(width: 270, height: 266)
                .background(Color.white.cornerRadius(14))
                .transition(.scale(scale: 0.8, anchor: .center))
                .padding()
                .animation(.easeInOut(duration: 0.3), value: isPresented)
            }
        }
    }
}
