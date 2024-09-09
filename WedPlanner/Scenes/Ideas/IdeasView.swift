import SwiftUI

struct IdeasView: View {
    @State private var isFavoritsSelected: Bool = false
    @State private var searchText: String = ""
    @StateObject private var realm = RealmIdeaManager()
    
    private var filteredIdeas: [IdeaModel] {
        var ideas = realm.ideas
        
        if isFavoritsSelected {
            ideas = ideas.filter { $0.isFavorite }
        }
        
        if !searchText.isEmpty {
            ideas = ideas.filter { $0.title.range(of: searchText, options: .caseInsensitive) != nil }
        }
        
        return ideas
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBG.ignoresSafeArea()
            
            VStack(spacing: 15) {
                navBarView()
                WPSearchField(searchText: $searchText)
                    .padding(.horizontal)
                
                if realm.ideas.isEmpty {
                    WPEmptyDataView(
                        image: "EmptyIdiasImg",
                        title: "Nothing here yet",
                        discr: "Add your Ideas",
                        buttonTitle: "Add Idea",
                        destinationView: IdeaAddOrEditView(type: .addNew)
                            .environmentObject(realm)
                    )
                    .vSpacing(.center)
                } else {
                    if filteredIdeas.isEmpty {
                        emptyListView()
                    } else {
                        List {
                            ForEach(filteredIdeas) { idea in
                                NavigationLink {
                                    IdeaDetailView(model: idea)
                                        .navigationBarBackButtonHidden()
                                        .environmentObject(realm)
                                        .onAppear {
                                            hiddenTabBar()
                                        }
                                } label: {
                                    IdeaCellItemView(model: idea)
                                        .environmentObject(realm)
                                }
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                            }
                        }
                        .listStyle(.plain)
                        .listRowSpacing(12)
                        .background(Color.clear)
                        .transition(.asymmetric(insertion: .move(edge: .bottom).combined(with: .opacity), removal: .move(edge: .top).combined(with: .opacity)))
                        .animation(.snappy, value: filteredIdeas.count)
                    }
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
                    withAnimation(.snappy) {
                        isFavoritsSelected.toggle()
                    }
                }, label: {
                    Image("NavLike")
                        .resizable()
                        .frame(width: 27, height: 22)
                        .foregroundColor(isFavoritsSelected ? .accentColor : .tbUnselected)
                })
                
                NavigationLink(destination: IdeaAddOrEditView(type: .addNew)
                    .navigationBarBackButtonHidden()
                    .onAppear(perform: {
                        hiddenTabBar()
                    })
                    .environmentObject(realm)) {
                   Image("NavBarAdd")
                }
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func emptyListView() -> some View {
        VStack {
            Spacer()
            Text("No ideas found")
                .foregroundColor(.gray)
                .font(.headline)
            Spacer()
        }
        .background(Color.clear)
    }
}
