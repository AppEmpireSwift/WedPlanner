import SwiftUI
import PhotosUI

enum IdeaAddOrEditViewType {
    case addNew
    case editExisting(IdeaModel)
}

struct IdeaAddOrEditViewStates {
    var titleText: String = ""
    var descrText: String = ""
    var mediaImages: [UIImage] = []
    var isImagePickerPresented = false
    var selectedImage: UIImage? = nil
    var showDeleteAlert: Bool = false
    var imageToDeleteIndex: Int? = nil
}

struct IdeaAddOrEditView: View {
    let type: IdeaAddOrEditViewType
    @State private var states = IdeaAddOrEditViewStates()
    
    private var isSaveDisabled: Bool {
        states.titleText.isEmpty || states.descrText.isEmpty
    }
    
    private var btnTitle: String {
        switch type {
        case .addNew:
            return "Save"
        case .editExisting:
            return "Update"
        }
    }
    
    private var navTitle: String {
        switch type {
        case .addNew:
            return "Add Idea"
        case .editExisting:
            return "Edit Idea"
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBG.ignoresSafeArea()
            
            VStack(spacing: 16) {
                SubNavBarView(
                    type: .backAndTitle,
                    title: navTitle
                )
                
                LineSeparaterView()
                
                VStack(spacing: 7) {
                    WPTextView(
                        text: "TITLE",
                        color: .standartDarkText,
                        size: 15,
                        weight: .regular
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    WPTextField(
                        text: $states.titleText,
                        type: .simple,
                        placeholder: "What is this?"
                    )
                    
                    WPTextView(
                        text: "DESCRIPTION",
                        color: .standartDarkText,
                        size: 15,
                        weight: .regular
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 5)
                    
                    WPTextEditor(text: $states.descrText, placeholder: "What is this for?")
                    
                    WPTextView(
                        text: "MEDIA",
                        color: .standartDarkText,
                        size: 15,
                        weight: .regular
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 5)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        ScrollViewReader { proxy in
                            HStack(spacing: 12) {
                                ForEach(states.mediaImages.indices, id: \.self) { index in
                                    Button(action: {
                                        states.showDeleteAlert.toggle()
                                        states.imageToDeleteIndex = index
                                    }, label: {
                                        Image(uiImage: states.mediaImages[index])
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 174.5, height: 180)
                                            .cornerRadius(12)
                                            .id(index)
                                    })
                                }
                                
                                Button(action: {
                                    states.isImagePickerPresented.toggle()
                                }, label: {
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.tbUnselected ,lineWidth: 1)
                                        .background(Color.fieldsBG)
                                        .overlay {
                                            VStack(spacing: 12) {
                                                Image("PlusInCircle")
                                                    .foregroundColor(.tbUnselected)
                                                
                                                WPTextView(
                                                    text: "Add a Media",
                                                    color: .tbUnselected,
                                                    size: 17,
                                                    weight: .regular
                                                )
                                            }
                                        }
                                })
                                .frame(width: states.mediaImages.isEmpty ? UIScreen.main.bounds.width - hPaddings : 174.5, height: 180)
                                .id("addButton")
                                .sheet(isPresented: $states.isImagePickerPresented) {
                                    ImagePicker(selectedImage: $states.selectedImage)
                                }
                                .onChange(of: states.selectedImage) { newImage in
                                    if let newImage = newImage {
                                        withAnimation {
                                            states.mediaImages.append(newImage)
                                            states.selectedImage = nil
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            withAnimation {
                                                proxy.scrollTo("addButton", anchor: .trailing)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, -8)
                    
                    WPButtonView(title: btnTitle) {
                        
                    }
                    .disabled(isSaveDisabled)
                    .padding(.bottom, 12)
                    .vSpacing(.bottom)
                }
                .padding(.horizontal, hPaddings)
                .onAppear {
                    loadDataForType()
                }
            }
        }
        .alert(isPresented: $states.showDeleteAlert) {
            Alert(
                title: Text("Delete Image"),
                message: Text("Do you really want to delete this image?"),
                primaryButton: .destructive(Text("Yes, Delete")) {
                    if let index = states.imageToDeleteIndex {
                        withAnimation {
                            states.mediaImages.remove(at: index)
                            states.imageToDeleteIndex = nil
                        }
                    }
                },
                secondaryButton: .cancel {
                    states.imageToDeleteIndex = nil
                }
            )
        }
    }
    
    private func loadDataForType() {
        if case let .editExisting(idea) = type {
            states.titleText = idea.title
            states.descrText = idea.descriptionText
            
            states.mediaImages = getUIImageArray(from: idea.mediaData)
        }
    }
}

#Preview {
    IdeaAddOrEditView(type: .addNew)
}
