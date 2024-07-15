//
//  DemoApp.swift
//  Demo
//
//  Created by Srivastava, Abhisht on 11/06/24.
//

import SwiftUI
import SwiftData

@main
struct DemoApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    @StateObject private var bookViewModel = BookViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomePageView()
                .environmentObject(bookViewModel)
        }
        .modelContainer(sharedModelContainer)
    }
}
