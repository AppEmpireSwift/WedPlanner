//import SwiftUI
//
//struct IdeasView: View {
//    @EnvironmentObject var realmManager: RealmManager
//    @State private var isFavoritsSelected: Bool = false
//    @State private var searchText: String = ""
//    
//    var body: some View {
//        ZStack(alignment: .top) {
//            Color.mainBG.ignoresSafeArea()
//            
//            VStack(spacing: 15) {
//                navBarView()
//                WPSearchField(searchText: $searchText)
//                    .padding(.horizontal)
//                
//                if realmManager.ideas.isEmpty {
//                    WPEmptyDataView(
//                        image: "EmptyIdiasImg",
//                        title: "Nothing here yet",
//                        discr: "Add your Ideas",
//                        buttonTitle: "Add Idea",
//                        destinationView: EmptyView()
//                    )
//                    .vSpacing(.center)
//                } else {
//                    
//                }
//            }
//        }
//    }
//    
//    @ViewBuilder
//    private func navBarView() -> some View {
//        HStack {
//            WPTextView(
//                text: "Ideas",
//                color: .standartDarkText,
//                size: 34,
//                weight: .bold
//            )
//            
//            Spacer()
//            
//            HStack(spacing: 16) {
//                Button(action: {
//                    withAnimation(.easeIn) {
//                        isFavoritsSelected.toggle()
//                    }
//                }, label: {
//                    Image("NavLike")
//                        .resizable()
//                        .frame(width: 27, height: 22)
//                        .foregroundColor(isFavoritsSelected ? .accentColor : .tbUnselected)
//                })
//                
//                NavigationLink(destination: EmptyView()) {
//                   Image("NavBarAdd")
//                }
//            }
//        }
//        .padding(.horizontal)
//    }
//}
//
//#Preview {
//    IdeasView()
//}

import SwiftUI

struct IdeasView: View {
    @EnvironmentObject var realmManager: RealmManager
    @State private var isFavoritsSelected: Bool = false
    @State private var searchText: String = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBG.ignoresSafeArea()
            
            VStack(spacing: 15) {
                navBarView()
                WPSearchField(searchText: $searchText)
                    .padding(.horizontal)
                
                if realmManager.ideas.isEmpty {
                    WPEmptyDataView(
                        image: "EmptyIdiasImg",
                        title: "Nothing here yet",
                        discr: "Add your Ideas",
                        buttonTitle: "Add Idea",
                        destinationView: EmptyView()
                    )
                    .vSpacing(.center)
                } else {
                    ideasGridView()
                        .padding(.horizontal)
                }
            }
        }
    }
    
    @ViewBuilder
    private func navBarView() -> some View {
        HStack {
            WPTextView(
                text: "Ideas",
                color: .standartDarkText,
                size: 34,
                weight: .bold
            )
            
            Spacer()
            
            HStack(spacing: 16) {
                Button(action: {
                    withAnimation(.easeIn) {
                        isFavoritsSelected.toggle()
                    }
                }, label: {
                    Image("NavLike")
                        .resizable()
                        .frame(width: 27, height: 22)
                        .foregroundColor(isFavoritsSelected ? .accentColor : .tbUnselected)
                })
                
                NavigationLink(destination: EmptyView()) {
                   Image("NavBarAdd")
                }
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func ideasGridView() -> some View {
        ScrollView {
            LazyVGrid(columns: generateGridColumns(), spacing: 12) {
                ForEach(realmManager.ideas.indices, id: \.self) { index in
                    IdeaCellItemView(model: realmManager.ideas[index])
                        .frame(height: heightForItem(at: index))
                }
            }
        }
    }
    
    private func generateGridColumns() -> [GridItem] {
        var gridColumns: [GridItem] = []
        
        for index in realmManager.ideas.indices {
            if index % 3 == 1 {
                gridColumns.append(GridItem(.flexible(), spacing: 12))
                gridColumns.append(GridItem(.flexible(), spacing: 12))
            } else if index % 3 == 2 {
                gridColumns.append(GridItem(.flexible(), spacing: 0))
            }
        }
        
        return gridColumns
    }
    
    private func heightForItem(at index: Int) -> CGFloat {
        return index % 3 == 1 ? 188.5 : 188.5 * 2 + 12
    }
}

#Preview {
    IdeasView()
}
