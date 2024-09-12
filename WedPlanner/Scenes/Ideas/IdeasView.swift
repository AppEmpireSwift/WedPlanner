import SwiftUI

struct IdeasView: View {
    @State private var isFavoritsSelected: Bool = false
    @State private var searchText: String = ""
    @StateObject private var viewModel = IdeasViewModel(repository: IdeaRepositoryService())
    
    private var filteredIdeas: [Idea] {
        var ideas = viewModel.ideas
        
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
                
                if viewModel.ideas.isEmpty {
                    WPEmptyDataView(
                        image: "EmptyIdiasImg",
                        title: "Nothing here yet",
                        discr: "Add your Ideas",
                        buttonTitle: "Add Idea",
                        destinationView: IdeaAddOrEditView(type: .addNew)
                            .environmentObject(viewModel)
                    )
                    .vSpacing(.center)
                } else {
                    if filteredIdeas.isEmpty {
                        emptyListView()
                    } else {
                        List {
                            ForEach(filteredIdeas, id: \.id) { idea in
                                ZStack {
                                    IdeaCellItemView(idea: idea)
                                        .environmentObject(viewModel)
                                    
                                    NavigationLink {
                                        IdeaDetailView(model: idea)
                                            .navigationBarBackButtonHidden()
                                            .environmentObject(viewModel)
                                            .onAppear {
                                                hiddenTabBar()
                                            }
                                    } label: {}
                                        .opacity(0)

                                }
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                            }
                        }
                        .listStyle(.plain)
                        .background(Color.clear)
                    }
                }
            }
        }
        .animation(.snappy, value: filteredIdeas)
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
                    withAnimation {
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
                    .environmentObject(viewModel)) {
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
    }
}
