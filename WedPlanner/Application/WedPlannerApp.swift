import SwiftUI

@main
struct WedPlannerApp: App {
    @StateObject private var dataManager: CoreDataManager = CoreDataManager()
    
    var body: some Scene {
        WindowGroup {
            InitialView()
                .environmentObject(dataManager)
                .environment(\.managedObjectContext, dataManager.container.viewContext)
        }
    }
}
