//import SwiftUI
//
//struct IdeaDetailView: View {
//    @State private var currentImgIndex: Int = 1
//    
//    var model: IdeaModel
//    
//    private var images: [UIImage] {
//        return getUIImageArray(from: model.mediaData)
//    }
//    
//    private var coverImgSize: CGSize {
//        if  isiPhone {
//            return CGSize(
//                width: UIScreen.main.bounds.width,
//                height: UIScreen.main.bounds.height / 1.56
//            )
//        } else {
//            return CGSize(
//                width: UIScreen.main.bounds.width - 170,
//                height: UIScreen.main.bounds.height / 2.186
//            )
//        }
//    }
//    
//    var body: some View {
//        ZStack(alignment: .top) {
//            Color.mainBG
//            
//            VStack {
//                ImageContentView(currentImgIndex: currentImgIndex, imagesArray: images)
//                    .ignoresSafeArea(.container, edges: .top)
//                    .overlay {
//                        VStack {
//                            SubNavBarView(type: .backTitleTitledButton, title: "Details", rightBtnTitle: "Edit") {
//                                
//                            }
//                            .padding(.top, 65)
//                            
//                            Spacer()
//                            
//                            VStack(spacing: 25) {
//                                HStack(spacing: 50) {
//                                    Button(action: {
//                                        chevronLeftAction()
//                                    }, label: {
//                                        Image(systemName: "chevron.left")
//                                            .resizable()
//                                            .frame(width: 40, height: 50)
//                                    })
//                                    .opacity(currentImgIndex == 1 ? 1 : 0)
//                                    
//                                    Button(action: {
//                                        chevronRightAction()
//                                    }, label: {
//                                        Image(systemName: "chevron.right")
//                                            .resizable()
//                                            .frame(width: 40, height: 50)
//                                    })
//                                    .opacity(currentImgIndex == images.count ? 1 : 0)
//                                }
//                                .foregroundColor(images.count <= 1 ? .clear : .mainBG.opacity(0.5))
//                                
//                                imageCounterView(current: currentImgIndex, total: images.count)
//                                    .frame(maxWidth: .infinity, alignment: .trailing)
//                                    .padding(.bottom)
//                                    .padding(.trailing)
//                                    .opacity(images.isEmpty ? 0 : 1)
//                            }
//                            
//                            textContentView()
//                        }
//                    }
//            }
//        }
//        .ignoresSafeArea()
//        .animation(.snappy, value: currentImgIndex)
//    }
//    
//    @ViewBuilder
//    private func imageCounterView(current: Int, total: Int) -> some View {
//        WPTextView(
//            text: "\(current)/\(total)",
//            color: .accentColor,
//            size: 16,
//            weight: .semibold
//        )
//        .padding(.vertical, 8)
//        .padding(.horizontal, 12)
//        .background(
//            Color.searchFieldBG.cornerRadius(12, corners: .allCorners)
//        )
//    }
//    
//    @ViewBuilder
//    private func textContentView() -> some View {
//        VStack {
//            HStack {
//                WPTextView(
//                    text: model.title,
//                    color: .standartDarkText,
//                    size: 20,
//                    weight: .semibold
//                )
//                .frame(maxWidth: .infinity, alignment: .leading)
//                
//                Button(action: {
//                    //TODO: - добавить смену состояния лайка
//                }, label: {
//                    Image(model.isFavorite ? "NavLike" : "NavLikeUnactive")
//                })
//            }
//            
//            Text(model.descriptionText)
//                .font(.system(size: 17, weight: .regular))
//                .foregroundColor(.standartDarkText)
//                .multilineTextAlignment(.leading)
//                .lineLimit(0)
//        }
//        .padding(.horizontal, hPaddings)
//        .padding(.vertical)
//    }
//    
//    private func chevronLeftAction() {
//        if currentImgIndex > 1 {
//            currentImgIndex -= 1
//        }
//    }
//    
//    private func chevronRightAction() {
//        if currentImgIndex < images.count {
//            currentImgIndex += 1
//        }
//    }
//}
//
//fileprivate struct ImageContentView: View {
//    let currentImgIndex: Int
//    let imagesArray: [UIImage]
//    
//    private var isThereImages: Bool {
//        !imagesArray.isEmpty
//    }
//    
//    private var displayedImage: UIImage {
//        if isThereImages {
//            return imagesArray[currentImgIndex - 1]
//        } else {
//            return UIImage(named: "EmptyCoverImg")!
//        }
//    }
//    
//    var body: some View {
//        Image(uiImage: displayedImage)
//        .resizable()
//        .cornerRadius(isiPhone ? 0 : 12, corners: .allCorners)
//        .frame(maxWidth: .infinity, maxHeight: 546)
//    }
//}
//
//#Preview {
//    IdeaDetailView(model: IdeaModel())
//}


import SwiftUI

struct IdeaDetailView: View {
    @State private var currentImgIndex: Int = 1
    
    var model: IdeaModel
    
    private var images: [UIImage] {
        return getUIImageArray(from: model.mediaData)
    }
    
    private var coverImgSize: CGSize {
        if isiPhone {
            return CGSize(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height / 1.56
            )
        } else {
            return CGSize(
                width: UIScreen.main.bounds.width - 170,
                height: UIScreen.main.bounds.height / 2.186
            )
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBG.ignoresSafeArea()
            
            ScrollView {
                VStack {
                    ImageContentView(currentImgIndex: currentImgIndex, imagesArray: images)
                        .frame(height: 546)
                        .ignoresSafeArea(.container, edges: .top)
                        .overlay {
                            VStack {
                                Spacer()
                                
                                VStack(spacing: 25) {
                                    HStack(spacing: 50) {
                                        Button(action: {
                                            chevronLeftAction()
                                        }, label: {
                                            Image(systemName: "chevron.left")
                                                .resizable()
                                                .frame(width: 40, height: 50)
                                        })
                                        .opacity(currentImgIndex == 1 ? 1 : 0)
                                        
                                        Button(action: {
                                            chevronRightAction()
                                        }, label: {
                                            Image(systemName: "chevron.right")
                                                .resizable()
                                                .frame(width: 40, height: 50)
                                        })
                                        .opacity(currentImgIndex == images.count ? 1 : 0)
                                    }
                                    .foregroundColor(images.count <= 1 ? .clear : .mainBG.opacity(0.5))
                                    
                                    imageCounterView(current: currentImgIndex, total: images.count)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .padding(.bottom)
                                        .padding(.trailing)
                                        .opacity(images.isEmpty ? 0 : 1)
                                }
                            }
                        }
                    
                    textContentView()
                }
            }
            
            SubNavBarView(type: .backTitleTitledButton, title: "Details", rightBtnTitle: "Edit") {
                // Handle edit action
            }
            .padding(.top, 65)
        }
        .ignoresSafeArea()
        .animation(.snappy, value: currentImgIndex)
    }
    
    @ViewBuilder
    private func imageCounterView(current: Int, total: Int) -> some View {
        WPTextView(
            text: "\(current)/\(total)",
            color: .accentColor,
            size: 16,
            weight: .semibold
        )
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(
            Color.searchFieldBG.cornerRadius(12, corners: .allCorners)
        )
    }
    
    @ViewBuilder
    private func textContentView() -> some View {
        VStack {
            HStack {
                WPTextView(
                    text: model.title,
                    color: .standartDarkText,
                    size: 20,
                    weight: .semibold
                )
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Button(action: {
                    // TODO: - добавить смену состояния лайка
                }, label: {
                    Image(model.isFavorite ? "NavLike" : "NavLikeUnactive")
                })
            }
            
            Text(model.descriptionText)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.standartDarkText)
                .multilineTextAlignment(.leading)
                .lineLimit(0)
        }
        .padding(.horizontal, hPaddings)
        .padding(.vertical)
    }
    
    private func chevronLeftAction() {
        if currentImgIndex > 1 {
            currentImgIndex -= 1
        }
    }
    
    private func chevronRightAction() {
        if currentImgIndex < images.count {
            currentImgIndex += 1
        }
    }
}

fileprivate struct ImageContentView: View {
    let currentImgIndex: Int
    let imagesArray: [UIImage]
    
    private var isThereImages: Bool {
        !imagesArray.isEmpty
    }
    
    private var displayedImage: UIImage {
        if isThereImages {
            return imagesArray[currentImgIndex - 1]
        } else {
            return UIImage(named: "EmptyCoverImg")!
        }
    }
    
    var body: some View {
        Image(uiImage: displayedImage)
            .resizable()
            .cornerRadius(isiPhone ? 0 : 12, corners: .allCorners)
            .frame(maxWidth: .infinity, maxHeight: 546)
    }
}

#Preview {
    IdeaDetailView(model: IdeaModel())
}
