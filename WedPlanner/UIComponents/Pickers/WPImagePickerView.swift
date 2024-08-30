import Foundation
import PhotosUI
import SwiftUI

struct WPImagePickerView: View {
    @Binding var selectedImage: UIImage?
    @State private var isPickerShown: Bool = false
    @State private var isAccessErrorShown: Bool = false
    
    private var height: CGFloat {
        if isiPhone {
            180
        } else {
            275
        }
    }
    
    var body: some View {
        ZStack {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: height)
                    .clipped()
            } else {
                Color.fieldsBG
                    .frame(height: height)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay {
            Button(action: {
                requestPhotoLibraryPermission()
            }, label: {
                Image("NavBarAdd")
                    .resizable()
            })
            .frame(width: 50, height: 50)
            .opacity(0.5)
        }
        .sheet(isPresented: $isPickerShown, content: {
            ImagePicker(selectedImage: $selectedImage)
        })
        .alert(
            "Oops, there's a problem",
            isPresented: $isAccessErrorShown) {
                
            } message: {
                WPTextView(
                    text: "Most likely, you have blocked or limited WedPlanner's access to the file library. Change the access rights in your device settings and try again!",
                    color: .standartDarkText,
                    size: 10,
                    weight: .regular
                )
            }
    }
    
    private func requestPhotoLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { newStatus in
                if newStatus == .authorized || newStatus == .limited {
                    isPickerShown.toggle()
                } else {
                    isAccessErrorShown.toggle()
                }
            }
        case .authorized, .limited:
            isPickerShown.toggle()
        case .denied, .restricted:
            isAccessErrorShown.toggle()
        @unknown default:
            break
        }
    }
}


struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            guard let result = results.first else {
                self.parent.presentationMode.wrappedValue.dismiss()
                return
            }
            
            let provider = result.itemProvider
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    DispatchQueue.main.async {
                        if let image = image as? UIImage {
                            self.parent.selectedImage = image
                        }
                        self.parent.presentationMode.wrappedValue.dismiss()
                    }
                }
            } else {
                self.parent.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

#Preview {
    WPImagePickerView(selectedImage: .constant(nil))
}
