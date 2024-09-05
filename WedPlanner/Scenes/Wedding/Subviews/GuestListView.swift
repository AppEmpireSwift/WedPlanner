//import SwiftUI
//
//struct GuestListView: View {
//    @State private var searchText: String = ""
//    var weddingModel: WeddingItemModel
//    
//    var body: some View {
//        ZStack(alignment: .top) {
//            Color.mainBG.ignoresSafeArea()
//            
//            VStack(spacing: 11) {
//                SubNavBarView(
//                    type: .backTitleImageBtn(rtBtnType: .threeDotsInCircle),
//                    title: "Guest List",
//                    isRightBtnEnabled: true) {
//                        
//                    }
//                
//                WPSearchField(searchText: $searchText)
//                    .padding(.horizontal, hPaddings)
//                    .padding(.vertical, 4)
//                
//                LineSeparaterView()
//                
//                List {
//                    ForEach(weddingModel.guests) { guest in
//                        guestItemView(for: guest)
//                            .listRowBackground(Color.clear)
//                            .listRowSeparator(.hidden)
//                    }
//                }
//                .listStyle(.plain)
//                .background(Color.clear)
//                .padding(.horizontal, hPaddings)
//               
//            }
//        }
//        .navigationBarBackButtonHidden()
//        .dismissKeyboardOnTap()
//    }
//    
//    @ViewBuilder
//    private func guestItemView(for model: WeddingGestListModel) -> some View {
//        VStack(alignment: .leading, spacing: 14) {
//            WPTextView(
//                text: model.name,
//                color: .standartDarkText,
//                size: 20,
//                weight: .regular
//            )
//            
//            WPTextView(
//                text: model.role,
//                color: .tbSelected,
//                size: 13,
//                weight: .regular
//            )
//            .padding(11)
//            .background(
//                Color.fieldsBG.cornerRadius(6)
//            )
//        }
//    }
//}
//
//#Preview {
//    GuestListView(weddingModel: WeddingItemModel())
//}

import SwiftUI

struct GuestListView: View {
    @State private var searchText: String = ""
    var weddingModel: WeddingItemModel
    
    @State private var isContextMenuVisible: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBG.ignoresSafeArea()
            
            VStack(spacing: 11) {
                SubNavBarView(
                    type: .backTitleImageBtn(rtBtnType: .threeDotsInCircle),
                    title: "Guest List",
                    isRightBtnEnabled: true) {
                        withAnimation {
                            isContextMenuVisible.toggle() // Показать/скрыть контекстное меню
                        }
                    }
                
                WPSearchField(searchText: $searchText)
                    .padding(.horizontal, hPaddings)
                    .padding(.vertical, 4)
                
                LineSeparaterView()
                
                List {
                    ForEach(weddingModel.guests) { guest in
                        guestItemView(for: guest)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
                .background(Color.clear)
                .padding(.horizontal, hPaddings)
            }
            
            // Контекстное меню
//            if isContextMenuVisible {
//                contextMenuView(
//                    onEditAction: {
//                        print("Edit tapped")
//                        // Ваше действие при нажатии на Edit
//                    },
//                    onAddGuestAction: {
//                        print("Add New Guest tapped")
//                        // Ваше действие при нажатии на Add New Guest
//                    }
//                )
//                .frame(width: 250, height: 94)
//                .background(Color.white.cornerRadius(12))
//                .shadow(radius: 10)
//               // .offset(x: UIScreen.main.bounds.width - 340, y: 40) // Позиционирование в правом углу с отступом 18
//            }
            if isContextMenuVisible {
                GeometryReader { geometry in
                    let screenWidth = geometry.size.width
                    
                    contextMenuView(
                        onEditAction: {
                            print("Edit tapped")
                            // Ваше действие при нажатии на Edit
                        },
                        onAddGuestAction: {
                            print("Add New Guest tapped")
                            // Ваше действие при нажатии на Add New Guest
                        }
                    )
                    .frame(width: 250, height: 94)
                    .background(Color.white.cornerRadius(12))
                    .shadow(radius: 10)
                    .position(
                        x: screenWidth - 250 / 2 - 18,
                        y: isiPhone ? 134 : 100) // Позиционирование с правым отступом 18
                }
                .ignoresSafeArea()
            }
        }
        .navigationBarBackButtonHidden()
        .dismissKeyboardOnTap()
    }
    
    @ViewBuilder
    private func guestItemView(for model: WeddingGestListModel) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            WPTextView(
                text: model.name,
                color: .standartDarkText,
                size: 20,
                weight: .regular
            )
            
            WPTextView(
                text: model.role,
                color: .tbSelected,
                size: 13,
                weight: .regular
            )
            .padding(11)
            .background(
                Color.fieldsBG.cornerRadius(6)
            )
        }
    }
    
    // Контекстное меню
    @ViewBuilder
    private func contextMenuView(onEditAction: @escaping () -> Void, onAddGuestAction: @escaping () -> Void) -> some View {
        VStack(spacing: 0) {
            Button(action: onEditAction) {
                HStack {
                    Text("Edit")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Image(systemName: "pencil")
                        .foregroundColor(.black)
                }
                .padding()
            }
            Divider()
            Button(action: onAddGuestAction) {
                HStack {
                    Text("Add New Guest")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Image("PlusInCircle")
                        .foregroundColor(.black)
                }
                .padding()
            }
        }
        .frame(width: 250, height: 94)
        .background(Color.white.cornerRadius(12))
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    GuestListView(weddingModel: WeddingItemModel())
}
