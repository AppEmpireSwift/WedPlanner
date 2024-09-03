import SwiftUI

//TODO: - Добавить размытие ебаное

struct WeddingItemCellView: View {
    @ObservedObject var model: WeddingItemModel
    
    private var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        return dateFormatter.string(from: model.date)
    }
    
    var body: some View {
        ZStack {
            Color.lightBejie
            
            HStack {
                VStack(alignment: .leading,spacing: 5) {
                    WPTextView(
                        text: model.title,
                        color: .mainBG,
                        size: 28, weight: .semibold
                    )
                    
                    WPTextView(
                        text: "Wedding",
                        color: .mainBG,
                        size: 20,
                        weight: .light
                    )
                    
                    WPTextView(
                        text: formattedDate,
                        color: .standartDarkText,
                        size: 17,
                        weight: .regular
                    )
                    
                    Spacer()
                }
                .padding(.horizontal, 12)
                .padding(.vertical)
        
                Spacer()
                
                if let coverImg = UIImage(data: model.coverPhoto) {
                    Image(uiImage: coverImg)
                        .resizable()
                        .frame(maxWidth: 139, maxHeight: .infinity)
                        .clipShape(DiagonalCutShape())
                        .overlay {
                            LinearGradient(
                                colors: [
                                    .lightBejie.opacity(0.8),
                                    .clear
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        }
                }
            }
        }
        .cornerRadius(12, corners: .allCorners)
        .frame(maxWidth: .infinity, maxHeight: 104)
    }
}

#Preview {
    WeddingItemCellView(model: WeddingItemModel())
}
