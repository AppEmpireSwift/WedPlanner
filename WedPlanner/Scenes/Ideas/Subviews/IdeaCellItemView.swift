import SwiftUI

struct IdeaCellItemView: View {
    @EnvironmentObject var viewModel: IdeasViewModel
    var idea: Idea
    
    private var images: [UIImage] {
        return getUIImageArray(from: idea.mediaData)
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
                    .cornerRadius(12)
            
                Image(idea.isFavorite ? "IdeaCellActiveLike" : "NavLikeUnactive")
                    .foregroundColor(.accentColor)
                    .padding(8)
                .padding(.trailing, 12)
                .padding(.top, 12)
            }
            
            WPTextView(
                text: idea.title,
                color: .standartDarkText,
                size: 17,
                weight: .semibold
            )
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(idea.descriptionText)
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(.lbSecendary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.fieldsBG)
        )
    }
}
