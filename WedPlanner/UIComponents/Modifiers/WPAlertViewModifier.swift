import SwiftUI

struct WPAlertViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    @State private var taskName: String = ""
    @State private var isBudgetIncluded: Bool = false
    @StateObject private var viewModel = WeddingViewModel()
    
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
                            text: "Add a New Task",
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
                            WPTextView(
                                text: "Name of the Task",
                                color: .standartDarkText,
                                size: 15,
                                weight: .regular
                            )
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            WPTextField(
                                text: $taskName,
                                type: .simple,
                                placeholder: "New Task"
                            )
                        }
                        
                        HStack {
                            WPTextView(
                                text: "Include Budget",
                                color: .standartDarkText,
                                size: 15,
                                weight: .regular
                            )
                            
                            Spacer()
                            
                            Toggle(isOn: $isBudgetIncluded, label: {
                            })
                            .tint(.accentColor)
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.addNewTaskWith(name: taskName, isStandartType: !isBudgetIncluded)
                        withAnimation(.easeInOut(duration: 0.3)) {
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
                .frame(width: 270, height: 245)
                .background(Color.white.cornerRadius(14))
                .transition(.scale(scale: 0.8, anchor: .center))
                .padding()
                .animation(.easeInOut(duration: 0.3), value: isPresented)
            }
        }
    }
}
