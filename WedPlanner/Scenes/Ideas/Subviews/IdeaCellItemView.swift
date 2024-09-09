import SwiftUI

struct IdeaCellItemView: View {
    @EnvironmentObject var realm: RealmIdeaManager
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
                                likeAction()
                            }) {
                                Image(model.isFavorite ? "IdeaCellActiveLike" : "NavLikeUnactive")
                                    .foregroundColor(.accentColor)
                                    .padding(8)
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
            .multilineTextAlignment(.leading)
            
            Text(model.descriptionText)
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(.lbSecendary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .lineLimit(1)
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.fieldsBG)
        )
    }
    
    func likeAction() {
        realm.updateIdeaLikeStatus(model)
    }
}
