import SwiftUI

struct IdeaCellItemView: View {
    var model: IdeaModel
    
    private var images: [UIImage] {
        return getUIImageArray(from: model.mediaData)
    }
    
    private var image: UIImage {
        return images.first ?? UIImage(named: "EmptyCoverImg")!
    }
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack(alignment: .topTrailing) {
                            Image(uiImage: image)
                                .resizable()
                                .frame(maxWidth: .infinity, maxHeight: 188.5)
                                .cornerRadius(12, corners: .allCorners)
                            
                            Button(action: {
                                // Действие кнопки
                            }) {
                                Image(model.isFavorite ? "NavLike" : "NavLikeUnactive")
                                    .foregroundColor(.black)
                                    .padding(8)
                                    .background(Color.white.opacity(0.7))
                                    .clipShape(Circle())
                            }
                            .padding(.trailing, 12)
                            .padding(.top, 12)
                        }
            
            WPTextView(
                text: model.title,
                color: .standartDarkText,
                size: 17,
                weight: .semibold
            )
            .frame(maxWidth: .infinity, alignment: .leading)
            
            WPTextView(
                text: model.descriptionText,
                color: .lbSecendary,
                size: 15,
                weight: .regular
            )
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.fieldsBG)
        )
    }
}
